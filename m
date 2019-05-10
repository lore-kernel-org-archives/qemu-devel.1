Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D68CC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 14:54:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 164B62177B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 14:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pQtMgqv2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164B62177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44617 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP6uk-0000rg-OC
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 10:54:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP6tv-0000Xo-NC
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:53:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP6tu-0002mI-Lv
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:53:31 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:34781)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hP6tu-0002lU-Do
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:53:30 -0400
Received: by mail-oi1-x22e.google.com with SMTP id v10so4741847oib.1
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 07:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=FHBabkPgWQKHexUWu8zLvp2biJzAILKhyY0S9FkTJoQ=;
	b=pQtMgqv2wgQBt/U2SxyWxaZte5xVbwVJV97sxfEbVDY9Q1m7oSBCLPySq7z3Mm0AeW
	eFALa1B2t19NQe7HDsbYxanMVjHoTdBd7pzneakdXwuFUATwPbXS0dIyi4l1ENyUD2BI
	jqdxYgpzc490SCk39Y2/yNZkNWg0Ybg3c54jw+HIxZsegvafmdUlbvQfV7uNKVDRGEsW
	xxcvdXH56YrrZqb72cm7akHyqhMbbqIM7AIYapNctKyEtkHxZT9KpqcRZugHE2h8xV0e
	zlexrpFpSpqDJ/rqHJr6ASXHMw0fkgBC+m/aLAgo8crcOt0cw/cVKH7sYWIQWmgvS0hG
	U1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=FHBabkPgWQKHexUWu8zLvp2biJzAILKhyY0S9FkTJoQ=;
	b=CgbCckpaPBPh+gVAFNN9UuLywEdynkkf81lk3sLdFym+xDPF7n0wePC0CFx9XqXCI6
	ztQ38k75NCxCg6PXHHf0PYrj/ts9uaJmGBezvqRJm13ruPqr1w3XqdO/D7iFHDijiAKX
	R/EUeV2B+XggxExnkXrI/uc3JDHOY9y9E2CqLc6V9z3qWapmxZwEUXyS3cRz6RicnBga
	1VXncu6Qu1EUJbxPEJUGZtn0Yiyv79K5vw0aEhJjHnHwoHWN7LUwNAQDj/FYzIgnCEtc
	ZWAUwvBZgxPI3jeArkO7Ww5/dr8mqFARHlKBt0FVatIgN69jilHlE5928p5VhDJAQJsz
	swlg==
X-Gm-Message-State: APjAAAW+sZ5u5zAN4E/Bn6jGaUVkz0kCpiOeSrwK1u+ofyCDVxrhpEwS
	wFnwzsw52ldw/8k6VIIRkMBODYhNYA2rzaHODcBu1A==
X-Google-Smtp-Source: APXvYqxzSvI/H5wIc8bGODu8jxdn+c43cHoKW+Qc7rI73KbOliSUbmpnxrUtMYX3VYixGi1udn78xIYGqd5anzrSY4U=
X-Received: by 2002:aca:5785:: with SMTP id l127mr5018651oib.48.1557500009002; 
	Fri, 10 May 2019 07:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190510140103.3834-1-kraxel@redhat.com>
In-Reply-To: <20190510140103.3834-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 May 2019 15:53:18 +0100
Message-ID: <CAFEAcA_1wgkdY4KgTOwf8iS9ZOTVjWg8qc7GBonn9ffp6yyybg@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::22e
Subject: Re: [Qemu-devel] [PULL 0/8] Input 20190510 patches
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 May 2019 at 15:10, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 812b835fb4d23dd108b2f9802158472d50b735=
79:
>
>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2019-05-=
07' into staging (2019-05-09 16:31:12 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/input-20190510-pull-request
>
> for you to fetch changes up to 7fb6e5a839bc625fd64c32d167f231ecd6f2b3e2:
>
>   virtio-input: fix Kconfig dependency and Makefile (2019-05-10 14:54:11 =
+0200)
>
> ----------------------------------------------------------------
> input: add vhost-user-input, virtio-input fixes.
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (2):
>   virtio-input-host-pci: cleanup types
>   virtio-input: fix Kconfig dependency and Makefile
>
> Marc-Andr=C3=A9 Lureau (6):
>   libvhost-user: fix -Waddress-of-packed-member
>   libvhost-user: add PROTOCOL_F_CONFIG if {set, get}_config
>   Add vhost-user-backend
>   Add vhost-user-input-pci
>   util: simplify unix_listen()
>   contrib: add vhost-user-input

Hi; there are some compile failures here I'm afraid:

On ppc64:

/home/pm215/qemu/contrib/libvhost-user/libvhost-user.c: In function
=E2=80=98vu_set_mem_table_exec_postcopy=E2=80=99:
/home/pm215/qemu/contrib/libvhost-user/libvhost-user.c:666:9: error:
format =E2=80=98%llx=E2=80=99 expects argument of type =E2=80=98long long u=
nsigned int=E2=80=99, but
argument 5 has type =E2=80=98__u64=E2=80=99 [-Werror=3Dformat=3D]
         DPRINT("%s: region %d: Registered userfault for %llx + %llx\n",
         ^
/home/pm215/qemu/contrib/libvhost-user/libvhost-user.c:666:9: error:
format =E2=80=98%llx=E2=80=99 expects argument of type =E2=80=98long long u=
nsigned int=E2=80=99, but
argument 6 has type =E2=80=98__u64=E2=80=99 [-Werror=3Dformat=3D]
cc1: all warnings being treated as errors

On arm (and probably any 32-bit host):

/home/peter.maydell/qemu/contrib/libvhost-user/libvhost-user.c: In
function 'vu_set_mem_table_exec_postcopy':
/home/peter.maydell/qemu/contrib/libvhost-user/libvhost-user.c:624:23:
error: cast to pointer from integer of different size
[-Werror=3Dint-to-pointer-cast]
         ret =3D madvise((void *)dev_region->mmap_addr,
                       ^
/home/peter.maydell/qemu/contrib/libvhost-user/libvhost-user.c:636:23:
error: cast to pointer from integer of different size
[-Werror=3Dint-to-pointer-cast]
         ret =3D madvise((void *)dev_region->mmap_addr,
                       ^
/home/peter.maydell/qemu/contrib/libvhost-user/libvhost-user.c:669:22:
error: cast to pointer from integer of different size
[-Werror=3Dint-to-pointer-cast]
         if (mprotect((void *)dev_region->mmap_addr,
                      ^

thanks
-- PMM

