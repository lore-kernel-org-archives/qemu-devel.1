Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F008C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:15:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49BD320714
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+o5V7df"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BD320714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0MeG-00005O-JX
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 06:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k0MdS-0007wQ-8N
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 06:15:02 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52516)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k0MdM-0007nU-TL
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 06:15:01 -0400
Received: by mail-wm1-x344.google.com with SMTP id x5so16215085wmi.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 03:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=rISWK7UcsiLy5BuCD8i8FN0MEbzCB7tBIEsOzUU+L04=;
 b=q+o5V7df3RDNtgJJtKyClMmkg5VlnZWMh/jIfRg04ozGzFFzuF//MfVBHaCIYW9QRu
 4viXSh5g8U/iCchsX35V7ryRFFszJJqdVygX4halgHBBPmPOlUcFoWzqSFy2h8yMtMzj
 W7u2HMSnu10FKdQhpdoGDdSbt/qlgb4CDMRZgq3B6y/eIX4h+2nqXkhnkPR3+txp8Zqw
 E1WeAElE4MDyOZEIEOTemoaXhQXI1+/+Q9c4YtoDxveipmPofNvd+qiXr5DSNDLpnuo8
 ZwmZ8xJrEBXKxL9i2iHAncRrQVkqx+FlSagJjcGQVgIUL+aLhqx1IE2iV1GOgDxRTC54
 iZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rISWK7UcsiLy5BuCD8i8FN0MEbzCB7tBIEsOzUU+L04=;
 b=Ku7kJtupwyK+aX2guHgqCpaz3WaZWwtG2KpqqAiMKVuVK/f+XyzSu5U1cdmqRDUVFZ
 67TUwKRU9lvl9Kn8hzBUTLvIERCtsFlH2Jo+QFkEoqahlEEXKeTj6vlGowaBzEePClB5
 rENsts+f4UQe2tKUUtMWgO4pJbGGxBCBzvOgOYj8an4jfBHp5zFkywZW9wSnUVEvYz+y
 24KpxVLdeAOgA4zX/cnJY3CcmMq21Q21Qvr3PFoN8xO5as6U+UXrYHf/UvfNJIh/hTr/
 gOSaHjX/MRWCDGYA3IPJWfJWPbggCNg+C0yVV5gEEPJyBe1AQ2gXYF33tZ7DUUeMq7uf
 WduA==
X-Gm-Message-State: AOAM5300iF2jp5Rnd2prsuyRPfssOEisZb4HNMAmS1o+FeOw8iOnFop1
 T0qo3DRITUoXDW2tEWBHJYA=
X-Google-Smtp-Source: ABdhPJwHiWlbGG3qrzVEVl8FgOPQkP8qtHzXCsaX3t31j4B8vKe2D5+2Ssx4jx6rQx63OLibdHglaA==
X-Received: by 2002:a1c:e304:: with SMTP id a4mr3308267wmh.11.1595931294407;
 Tue, 28 Jul 2020 03:14:54 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id o126sm3696263wma.20.2020.07.28.03.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2020 03:14:53 -0700 (PDT)
Date: Tue, 28 Jul 2020 11:14:52 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH] Makefile: Compute libraries for libqemuutil.a and
 libvhost-user.a
Message-ID: <20200728101452.GB10336@stefanha-x1.localdomain>
References: <20200616161814.891053-1-dinechin@redhat.com>
 <20200623144415.GP36568@stefanha-x1.localdomain>
 <ly1rlvd2en.fsf@redhat.com>
 <be57d624-f3b1-7abf-39fe-6568e95805f8@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline
In-Reply-To: <be57d624-f3b1-7abf-39fe-6568e95805f8@msgid.tls.msk.ru>
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Christophe de Dinechin <dinechin@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 02, 2020 at 04:06:32PM +0300, Michael Tokarev wrote:
> 01.07.2020 12:12, Christophe de Dinechin wrote:
> ..
> >>>  # Build libraries
> >>>
> >>> +libqemuutil.a-libs +=3D $(call extract-libs, $(util-obj-y) $(trace-o=
bj-y) $(stub-obj-y))
> >>> +libvhost-user.a-libs +=3D $(call extract-libs, $(libvhost-user-obj-y=
) $(util-obj-y) $(stub-obj-y))
> ..
> >> Another thing I wonder about: the purpose of the .a files is to compile
> >> all object files and only link those .o files needed by the program
> >> (i.e. a subset of the .a file).
> >=20
> > I believe that what you are saying is that by passing the required libr=
aries
> > automatically, the binaries that use libqemuutil.a will inherit undesir=
ed
> > ldd dependencies. Indeed, a quick experiment shows that if you pass a -l
> > option, the library dependency is recorded even if no symbol in that li=
brary
> > is used. I saw no obvious linker option to address that.
>=20
> There's --as-needed and --no-as-needed ld flag (used with cc as -Wl,--as-=
needed),
> which is designed for this very case.

Nice, sounds like a solution. So -Wl,--as-needed should be at the end of
the command-line followed by $(libqemuutil.a-libs).

Stefan

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8f+psACgkQnKSrs4Gr
c8j3+ggAr+paS2hBMuERteeMuSyh6neYdFpJyC20YwWOVc26AGOyx1w0BToYEPwr
CZwu3EQ4pPBtWhubgNiZiTL2nemSiUlev+fabW7NJy75YcmpvPodHvKYfl1HO/WK
s7ufUnrLmur3qpUhFk+znjQRMioZOxkRDk4BZSyQPsIa4RzcXipDegwq9agH+xtl
HpHHzJxrY3bv1PF2PI29w+2qPQGsnf6yB4t3fqU1Ae06uVFW+SBUO2EjZhv7buOs
9r4Si9YNCeKK5cXxJ1I6ye2wW3+qQv+meqlqAs3EmYqO9nU5oM6PPwVVZ/XU19fa
ses5wUJoBjG1f/tiHImg79NyiEX0DQ==
=oX+k
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--

