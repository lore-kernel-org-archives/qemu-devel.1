Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51367C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:55:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2621821D6C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2621821D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT0yv-0006w5-6M
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 04:55:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iT0xN-000666-6J
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:53:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iT0xM-0007Pq-5B
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:53:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38818)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iT0xL-0007PS-Vx
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:53:28 -0500
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3856012BE
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 09:53:27 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id l8so6532918qtq.9
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 01:53:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=bZx347VZRyK4aQBS4D/7pz8sC5CIt9ekd0nKArF1cdU=;
 b=CvAFDU9BNSmU7w7brvnwxVEsxAKtv/nnEWHe4NyU0dFgeWDfxnNrAYHA4pvMMix10J
 w9baqy3eypvjMupuBdPKxCA77XYVgKFU8ICSA6mApyawV1eo1lI3bZO1cfBmJ4KW+rj0
 CzhASNh3d2MILNawtzLOa3/ae3YNK1LldR7tgtfM4dFZgrXLUdUSPReqii1VVlExzjZn
 o0duu8N1Gt1n3as6hLHL6tS/t73RgB9A6Ejd9JpjUbEYyPIGbOiQ0rT7Y41X2mW0e331
 bBQHnnKdREUuj53+q57BERAJAlVA9gxUd4e3QReD2xBz1FwIAa8tFEIYIrl1+IkXjhMp
 9Xwg==
X-Gm-Message-State: APjAAAWw7GQo2uebRooO/CGAWcPSj9poqapPVSklQ0KBowyRsVEjiydp
 FZ+qo4CrcYgzvaGIZI4SCsm+N6XWGrujdi6KC6zmQfM8ui4JQKtkX1a3T/n4O61uYUbCBXmwYQX
 RFXYGCY7pTl+mSMA=
X-Received: by 2002:a37:9145:: with SMTP id t66mr8107377qkd.332.1573206806534; 
 Fri, 08 Nov 2019 01:53:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqyiuFGdBdUs0m6roCsY4Py6GKJuOYbir4xjsxLVA1tMDWsxe8hE0M5MxSM9747RxuKTjUg0oA==
X-Received: by 2002:a37:9145:: with SMTP id t66mr8107365qkd.332.1573206806321; 
 Fri, 08 Nov 2019 01:53:26 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id x25sm2151445qki.63.2019.11.08.01.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2019 01:53:25 -0800 (PST)
Date: Fri, 8 Nov 2019 04:53:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 0/3] Some memory leak fixes
Message-ID: <20191108045257-mutt-send-email-mst@kernel.org>
References: <20191107192731.17330-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20191107192731.17330-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 07, 2019 at 11:27:28PM +0400, Marc-Andr=E9 Lureau wrote:
> Hi,
>=20
> Another bunch of fixes spotted by ASAN when running check-qtest-x86_64.

So who's merging this?

> Marc-Andr=E9 Lureau (3):
>   virtio-input: fix memory leak on unrealize
>   qtest: fix qtest_qmp_device_add leak
>   cpu-plug-test: fix leaks
>=20
>  hw/input/virtio-input.c | 3 +++
>  tests/cpu-plug-test.c   | 2 ++
>  tests/libqtest.c        | 1 +
>  3 files changed, 6 insertions(+)
>=20
> --=20
> 2.24.0.rc0.20.gd81542e6f3

