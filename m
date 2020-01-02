Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807BBC2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 10:02:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AB8821655
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 10:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5MurfWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB8821655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imxIp-0004q5-CT
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 05:02:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1imxHt-00047f-Mq
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 05:01:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1imxHs-00083c-Iz
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 05:01:05 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35107)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1imxHs-00082H-Bx
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 05:01:04 -0500
Received: by mail-wm1-x341.google.com with SMTP id p17so5169130wmb.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 02:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=nlGFmFXCeeyouI9K+jx8ZyRb1E4SG7cNAhsATuXNtLM=;
 b=Y5MurfWrH6BTZzdWXaeNdsxCI7GHn7ipgM14H4l7PYVcP3TlV4YtdQnkKcCvCek5EV
 qEKf64/zlXRfa7X4Gxtn47SctWsBYJnzQ0RpjKFpb2BXgBZimJrHzHKUj3zt63p/TjMl
 rSJGIAiokHcgGTIWJrCvnjYdCdeRpl+ZDtFkm13greR0IQo3xL5EynY6g9B+A1Dpw7vn
 MB06/L+5v6NOK2kk43iCZ12fflRMLgi7Oz6nJcX7u0aj5nXhW7CcCipXCjJyV2wG/1Zp
 sMXIiIsr554nmB2gqOtGMPkl18kSC5S6NDYomb4v3mlDjCwLR/c8Uk/oHpzCjLICLLsN
 tosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nlGFmFXCeeyouI9K+jx8ZyRb1E4SG7cNAhsATuXNtLM=;
 b=ByvuN/zVhrEb2kwwrjYY7+9yyysnjEMwsbnmXxx/ftfjqDJHr6tZ7bDlUro8NW7AGx
 bnzL6UdElILX0rriJkHmJNg4PvyKjTJypW8p9JYUFVbQz4KwFdRKHij43g3o34iQFG0s
 OuEJXuZ+vkDzYFwAA6hMN/SLSENo/8GBXcZl6xPGXSDpHfdYXdvl+D1cT9DFGEkCIzlw
 xcTpX98JhpVTl5A2eJmqh2QRTRX2Oy3+ZeDiEYBEPUAAUNlQCCs5irJWCL4nH8Ajw+ft
 n3VIffjXdWlLiK1bDYexvG3jmQEBWzOdjO/ebIzObOvfmKYUSgaurWzh23+FBPhfChOY
 CyYA==
X-Gm-Message-State: APjAAAWIMmrYpIG/raRewwvg6daygrenvE7u8oqJ0WurWPTwvMy2nJuW
 +wEw+DJ9F1AAxnDjntdseOM=
X-Google-Smtp-Source: APXvYqwoJZJVj3fzc1zHDfZOVP5colMKJ1CXrguGopS5eBbHSeVDpicKeh5llPtxZGhSQgmNjCqkhQ==
X-Received: by 2002:a7b:cbcd:: with SMTP id n13mr13514288wmi.104.1577959262765; 
 Thu, 02 Jan 2020 02:01:02 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id d14sm57308705wru.9.2020.01.02.02.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2020 02:01:01 -0800 (PST)
Date: Thu, 2 Jan 2020 10:00:59 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: John G Johnson <john.g.johnson@oracle.com>
Subject: Re: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
Message-ID: <20200102100059.GD121208@stefanha-x1.localdomain>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <20191210064716.GA6401@flaka>
 <20191213104116.GB1180977@stefanha-x1.localdomain>
 <20191216194655.GA5922@flaka>
 <AFBAD3A1-0E22-4E22-AF22-C56794929D87@nutanix.com>
 <20191217163316.GB1333385@stefanha-x1.localdomain>
 <DDE3DA62-31DD-437B-8392-CAD505253EED@nutanix.com>
 <4a302c6d-e2c8-0c3e-43d2-946e1fafea5d@redhat.com>
 <20191219133650.GE1624084@stefanha-x1.localdomain>
 <D60846D3-5434-4EF8-B25F-7C70F4FA5367@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IDYEmSnFhs3mNXr+"
Content-Disposition: inline
In-Reply-To: <D60846D3-5434-4EF8-B25F-7C70F4FA5367@oracle.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "fam@euphon.net" <fam@euphon.net>, Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "kanth.ghatraju@oracle.com" <kanth.ghatraju@oracle.com>,
 Felipe Franciosi <felipe@nutanix.com>, "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "liran.alon@oracle.com" <liran.alon@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "ross.lagerwall@citrix.com" <ross.lagerwall@citrix.com>,
 "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--IDYEmSnFhs3mNXr+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2019 at 09:15:40AM -0800, John G Johnson wrote:
> > On Dec 19, 2019, at 5:36 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > On Wed, Dec 18, 2019 at 01:00:55AM +0100, Paolo Bonzini wrote:
> >> On 17/12/19 23:57, Felipe Franciosi wrote:
> We don=E2=80=99t pin guest memory; we pass the QEMU file descriptors used=
 to create
> guest memory to the emulation program, and it mmap()s them itself. (ala
> vhost-user).

Does muser really require pinning?  If yes, then it seems like a
limitation that can be removed in the future.

Stefan

--IDYEmSnFhs3mNXr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4Nv1sACgkQnKSrs4Gr
c8iD3Af9Ec9LZ8BtMbSlbljxRWrdCaLLTtvLgZ6i72hj2Hg3vi5PMPvaaTa1giPE
938UZozFz/mEPFu6U92TM9vuPmFky+7IMM5ZyGD/VHpgI3wskli04QH6Iz7gzbFt
a/nSrdK4TymtKvsdLrgDqqdb8JlIqUWwFF9mI8K8tU3VDqCUyKQv5M5P80agYyiv
S3a2zjQFdKokmb2FNMrfKQf4OdPMqoAX2h/OhU8Xy8RtRhiD2ORv8y3uv4dbDmje
YFXhBms45IsbGr0t4Ss2QxeeVXy+A1UVJxpCTiFYBQl91Phlo17JzLoV1xNX+o7c
ntXfLaBSP1AdnzzuWWc3ABLSZDrBzA==
=3Qlq
-----END PGP SIGNATURE-----

--IDYEmSnFhs3mNXr+--

