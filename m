Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A72C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:57:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D32172070D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32172070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46907 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP8pU-0000Ll-2w
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 12:57:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hP8ns-0007Ry-4W
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:55:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hP8nq-0001Ox-Tq
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:55:24 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43755)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hP8nq-0001MU-Pk
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:55:22 -0400
Received: by mail-qt1-f195.google.com with SMTP id r3so7337299qtp.10
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 09:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=zBBybsEO/90v9Y7tTC5Cis3b4wxdo55wRnHxYazFoio=;
	b=P2rudfw9cF2f2FY/knLft1HoeUJKOQSCgTRxllxuvyZmzuMLQdRCAHjBrPn50wjY8v
	l8YE7IGPF55zQHSRhbbZvMa1A2VNVFW58HjJl/Y4ziyxmnt4x1QP9DW4UrqdP56Ufdu6
	YbQjYMDYK87iHldsL28Bkv/M/QpO+tggvucaqXfoBEWVI/wLFXsjF6dgoFoCpESfzXtM
	VIntzVRlnStYeXvgC2jWSzcimePnhUbqG8ogmu2pAunYBkWm05SirKUGgJcanz64E7+H
	ed3jwNfyXT7Po2Lb7Oibm1wm/dR0GFkREUysoV6BVEnUhJeqdZeE3uZtojkmzNPPP8NO
	3wtw==
X-Gm-Message-State: APjAAAVXWHyR+pnqgEIL/8Znxetp5AkaTTopSZ5zmn5lhVYEVtQVEGAJ
	papy9JeCkS2fApxGe9nGxHcOZQ==
X-Google-Smtp-Source: APXvYqxh7vqfREnIXLphmIaQkRDCTeGvY71lcU4wUTWumuKAqtNv53nJfsV3XrfXo0TjrMdiVZOgjw==
X-Received: by 2002:ac8:3862:: with SMTP id r31mr10562565qtb.26.1557507321161; 
	Fri, 10 May 2019 09:55:21 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	t63sm2793230qka.33.2019.05.10.09.55.19
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 10 May 2019 09:55:20 -0700 (PDT)
Date: Fri, 10 May 2019 12:55:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190510125323-mutt-send-email-mst@kernel.org>
References: <20190510134203.24012-1-lvivier@redhat.com>
	<20190510134203.24012-2-lvivier@redhat.com>
	<20190510121135-mutt-send-email-mst@kernel.org>
	<20190510161644.GP7671@redhat.com>
	<20190510121939-mutt-send-email-mst@kernel.org>
	<20190510162554.GQ7671@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190510162554.GQ7671@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.195
Subject: Re: [Qemu-devel] [PATCH v3 1/3] VirtIO-RNG: Update default entropy
 source to `/dev/urandom`
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
Cc: Laurent Vivier <lvivier@redhat.com>,
	Kashyap Chamarthy <kchamart@redhat.com>, Amit Shah <amit@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	"Richard W . M . Jones" <rjones@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 10, 2019 at 05:25:54PM +0100, Daniel P. Berrangé wrote:
> On Fri, May 10, 2019 at 12:21:19PM -0400, Michael S. Tsirkin wrote:
> > On Fri, May 10, 2019 at 05:16:44PM +0100, Daniel P. Berrangé wrote:
> > > On Fri, May 10, 2019 at 12:12:41PM -0400, Michael S. Tsirkin wrote:
> > > > On Fri, May 10, 2019 at 03:42:01PM +0200, Laurent Vivier wrote:
> > > > > From: Kashyap Chamarthy <kchamart@redhat.com>
> > > > > 
> > > > > When QEMU exposes a VirtIO-RNG device to the guest, that device needs a
> > > > > source of entropy, and that source needs to be "non-blocking", like
> > > > > `/dev/urandom`.  However, currently QEMU defaults to the problematic
> > > > > `/dev/random`, which is "blocking" (as in, it waits until sufficient
> > > > > entropy is available).
> > > > > 
> > > > > Why prefer `/dev/urandom` over `/dev/random`?
> > > > > ---------------------------------------------
> > > > > 
> > > > > The man pages of urandom(4) and random(4) state:
> > > > > 
> > > > >     "The /dev/random device is a legacy interface which dates back to a
> > > > >     time where the cryptographic primitives used in the implementation
> > > > >     of /dev/urandom were not widely trusted.  It will return random
> > > > >     bytes only within the estimated number of bits of fresh noise in the
> > > > >     entropy pool, blocking if necessary.  /dev/random is suitable for
> > > > >     applications that need high quality randomness, and can afford
> > > > >     indeterminate delays."
> > > > > 
> > > > > Further, the "Usage" section of the said man pages state:
> > > > > 
> > > > >     "The /dev/random interface is considered a legacy interface, and
> > > > >     /dev/urandom is preferred and sufficient in all use cases, with the
> > > > >     exception of applications which require randomness during early boot
> > > > >     time; for these applications, getrandom(2) must be used instead,
> > > > >     because it will block until the entropy pool is initialized.
> > > > 
> > > > So how about just using getrandom then?
> > > 
> > > The 3rd patch in this series addresses that.
> > 
> > It seems to use qemu_guest_getrandom which in turn
> > with patch 1 calls /dev/urandom...
> > Did I miss something?
> 
> qemu_guest_getrandom will preferentially use the crypto library random
> APIs (gnutls, or gcrypt). If both are compiled out that it will use
> getrandom() if supported by the C library and current kernel. If that
> fails then it will try /dev/urandom if it exists, finally /dev/random. 
> On Windows it uses their native crypto API. See this dependant series:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg02237.html
> 
> Regards,
> Daniel

In particular

https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg02238.html


maybe clarify this is just for systems without getrandom then.




> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

