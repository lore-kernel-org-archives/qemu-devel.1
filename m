Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201DFC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:37:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F8B52076C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hcue2f+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F8B52076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHlrj-00052k-It
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 06:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kHlrB-0004Y5-80; Mon, 14 Sep 2020 06:37:09 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:56125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kHlr9-0002C7-Ej; Mon, 14 Sep 2020 06:37:08 -0400
Received: by mail-wm1-x342.google.com with SMTP id d4so4752270wmd.5;
 Mon, 14 Sep 2020 03:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=6kzfVO0PozwpIxwGaSvlw5DV54R7fJ2pTNp2Zd0WnAA=;
 b=Hcue2f+bW3zW+Py4ofigU4sG2FM3rBziX6qzC0c3+PHIxiNlYbqxeTQx1bOo/y1bEK
 /Fr08SVHlbox3rba9qFmBLp8goxal24GbVFiisKspMBYw7F/CmKLXSfRMJTqDrioiY+y
 x7leOuWrDVwTQKluBcu+JFv6HNqf4ORoSdRd1BNqDU0UcFSedtjgHyE6HWcJadbrkYcV
 eDF8+yzw2ksNk4TZOZ5yGLnig7aNTDXy7XO2xg3/k5KtZlz+e8DrN/s19gg6gH0YdvYk
 w14v4K1eGvf0DvHZE9WggppgecLcR+P8uuB9H5vbcEUQHnpoLISge6Dt7vjGXYyj0Vkj
 xRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6kzfVO0PozwpIxwGaSvlw5DV54R7fJ2pTNp2Zd0WnAA=;
 b=EWMzfYncThfi+2NGh/jSPkmw1YJQcJ3z3PSfQ11gsBu1JaJuVfsDJHfNEoiPal7SMK
 0jPlOl0AYUaZw7KzUsG8aXYhLFzneoLg/8ZtR8AJ6XFTkuCfVj4DeB/5DygbqpYEk+yr
 yKiZLue62yXynvLEvk0zbrc1jlQUqPWf2UU+m1Yi+qo3yZR64RBRsZX71hvBG2yCx48x
 a6dB0/Fnm4NXWGF0bnGrEd3V0ZPTGtcfPUHf+mric5Wn5lK6XE24SfL1fE1mFyoTOVne
 08CGvzhGjPbj824GuQLtujYX0yJpwmtsEUMg+fUoUsIdfGOP/lYdnj7r8/Xbd/yJOxZB
 0dQw==
X-Gm-Message-State: AOAM530uRcDRVXRBPB1Cqg+zXqa6R8z9jdHatVddFICwH2X+6XmQfhuE
 CFOXFWBkMGDhBmo6+S0Tg3k=
X-Google-Smtp-Source: ABdhPJx7zJroC4I9//nQortxWfzZybwKPupZ+neQNa5QSrnMYavW8g8a1pRX/l+KRKx/ftlbfR0pQA==
X-Received: by 2002:a1c:a789:: with SMTP id
 q131mr14077538wme.141.1600079825802; 
 Mon, 14 Sep 2020 03:37:05 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id g12sm20216391wro.89.2020.09.14.03.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 03:37:04 -0700 (PDT)
Date: Mon, 14 Sep 2020 11:37:03 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: add Stefan Hajnoczi as block/nvme.c
 maintainer
Message-ID: <20200914103703.GH579094@stefanha-x1.localdomain>
References: <20200907111632.90499-1-stefanha@redhat.com>
 <20491ab5-7d5d-9360-7215-a1a56dbf5ed0@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LZFKeWUZP29EKQNE"
Content-Disposition: inline
In-Reply-To: <20491ab5-7d5d-9360-7215-a1a56dbf5ed0@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--LZFKeWUZP29EKQNE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2020 at 02:51:50PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 9/7/20 1:16 PM, Stefan Hajnoczi wrote:
> > Development of the userspace NVMe block driver picked up again recently.
> > After talking with Fam I am stepping up as block/nvme.c maintainer.
> > Patches will be merged through my 'block' tree.
> >=20
> > Cc: Kevin Wolf <kwolf@redhat.com>
> > Cc: Klaus Jensen <k.jensen@samsung.com>
> > Cc: Fam Zheng <fam@euphon.net>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  MAINTAINERS | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index b233da2a73..a143941551 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2895,10 +2895,12 @@ S: Supported
> >  F: block/null.c
> > =20
> >  NVMe Block Driver
> > -M: Fam Zheng <fam@euphon.net>
> > +M: Stefan Hajnoczi <stefanha@redhat.com>
> > +R: Fam Zheng <fam@euphon.net>
> >  L: qemu-block@nongnu.org
> >  S: Supported
> >  F: block/nvme*
> > +T: git https://github.com/stefanha/qemu.git block
>=20
> As this driver is the only consumer of the 'VFIO helpers',
> maybe we can:
>=20
> - maintains them in the same bucket
> - add another entry (eventually with R: tag for Alex)
>=20
> The 'VFIO helpers' files are:
> - util/vfio-helpers.c
> - include/qemu/vfio-helpers.h
>=20
> What do you think?

I'm happy to include vfio-helpers with the goal of eventually switching
to vfio-common.

Alex: does this sound good?

Stefan

--LZFKeWUZP29EKQNE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9fR88ACgkQnKSrs4Gr
c8hqLAf/e/jIhCwE8BkS/AaZq0n/OkfWrVnJ4lJSl4w+zbwRmKPDlHm+BYL0Bojy
fk8DG5GnARiOFvzqe4+ssrL7SWVthPePRcI4jqFesn/O8iZvMbuqMJbXwMj0s2+I
SDMn53GOQkiTqfrevFpr7KyzVvBZ58ZfBQUZc5kBAgVQRyspGqfRc8GmK7kAVvt1
7cjDeqlbF07O1mjp6AMxDudDfn9uh108B2IqGQ9MCCNDvKBSt1dewlKLHxDcRQCW
IqG/Q60oT/r6fPHWF7KS7NjH1P7XBDTAIHRrG1eNYUfxZCYhh08bUHi4dX6yIGvT
pCUZEBt7y3snO1IMarXO/DOPcRBTpg==
=4lxE
-----END PGP SIGNATURE-----

--LZFKeWUZP29EKQNE--

