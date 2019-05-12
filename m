Return-Path: <SRS0=55mG=TM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC03C04A6B
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2019 18:22:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 577562084A
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2019 18:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 577562084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46003 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPt7C-0007uN-Ml
	for qemu-devel@archiver.kernel.org; Sun, 12 May 2019 14:22:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hPt6M-0007bf-Ne
	for qemu-devel@nongnu.org; Sun, 12 May 2019 14:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hPt6L-0004gz-Pr
	for qemu-devel@nongnu.org; Sun, 12 May 2019 14:21:34 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41187)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hPt6L-0004fn-LI
	for qemu-devel@nongnu.org; Sun, 12 May 2019 14:21:33 -0400
Received: by mail-qt1-f194.google.com with SMTP id y22so8898549qtn.8
	for <qemu-devel@nongnu.org>; Sun, 12 May 2019 11:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=dQDYnVdjXJMzVbbV69OneudDtsrLlDqsjrxQhAL/Kwk=;
	b=eIaRRJXef5GJ22k/ldCA42KW/iVWld4HIohMoD+jV5PqCrCGQIXbPBzgsrJ6otB8JS
	9z9YFkDKz4OvlBgjXuUwUpCG07kRBeKCuAJ3betn/Ni6K+jOdRIt2dKqv7CJcLrm0BN+
	eNJ8PDDQNZ38cH/oQXxTDp2BrFU3N8JZeE1E5MxpcPgs9bH/cuWDv5OQBDbxofPQxlid
	rEcclWb3keIM+dpQx/x8Z5z/QIj/XZh3dIQ5yKiNfG6xHc51BxOq6ZSjB9UJ1wtstj+c
	FIDun2UzH30DSuR2pv2qUluJlFY6Z3anunAB5Urs7Wi6oSjQJFr3pQI2LmMHzDOSC0J+
	zxqQ==
X-Gm-Message-State: APjAAAWnK7xonhrNgSBz4MnwKQxecSGC1yzzoSsi4Nh0hDmi9++sIxAk
	aGnC+tXZl/TiJNrgSP/DdC+Bwg==
X-Google-Smtp-Source: APXvYqxf2izIesAEwz33iOYGANHfAYm+k5jkHPKYwvPLyf5EAdO2N48JDZbfyGc0t9nAmV1Fi+yHJg==
X-Received: by 2002:ac8:fdd:: with SMTP id f29mr20591525qtk.17.1557685293171; 
	Sun, 12 May 2019 11:21:33 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71])
	by smtp.gmail.com with ESMTPSA id a3sm6154600qti.47.2019.05.12.11.21.31
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Sun, 12 May 2019 11:21:32 -0700 (PDT)
Date: Sun, 12 May 2019 14:21:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Message-ID: <20190512142108-mutt-send-email-mst@kernel.org>
References: <20190510134203.24012-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510134203.24012-1-lvivier@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.194
Subject: Re: [Qemu-devel] [PATCH v3 0/3] rng-builtin: add an RNG backend
 that uses qemu_guest_getrandom()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Amit Shah <amit@kernel.org>, Kashyap Chamarthy <kchamart@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
	"Richard W . M . Jones" <rjones@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 10, 2019 at 03:42:00PM +0200, Laurent Vivier wrote:
> Add a new RNG backend using QEMU builtin getrandom function.
> 
> This patch applies on top of
>     "[PATCH v5 00/24] Add qemu_getrandom and ARMv8.5-RNG etc"
> Based-on: 20190510012458.22706-1-richard.henderson@linaro.org
> 
> v3: Include Kashyap's patch in the series
>     Add a patch to change virtio-rng default backend to rng-builtin
> 
> v2: Update qemu-options.hx
>     describe the new backend and specify virtio-rng uses the
>     rng-random by default
> 
> Kashyap Chamarthy (1):
>   VirtIO-RNG: Update default entropy source to `/dev/urandom`
> 
> Laurent Vivier (2):
>   rng-builtin: add an RNG backend that uses qemu_guest_getrandom()
>   virtio-rng: change default backend to rng-builtin


OK pls address Marku's comment on commit msg and I will merge.

>  backends/Makefile.objs         |  2 +-
>  backends/rng-builtin.c         | 54 ++++++++++++++++++++++++++++++++++
>  backends/rng-random.c          |  2 +-
>  hw/virtio/virtio-rng.c         |  2 +-
>  include/hw/virtio/virtio-rng.h |  4 +--
>  include/sysemu/rng-builtin.h   | 17 +++++++++++
>  qemu-options.hx                |  9 +++++-
>  7 files changed, 84 insertions(+), 6 deletions(-)
>  create mode 100644 backends/rng-builtin.c
>  create mode 100644 include/sysemu/rng-builtin.h
> 
> -- 
> 2.20.1

