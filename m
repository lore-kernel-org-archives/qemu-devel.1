Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFBEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:21:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82909235FC
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noGUIWCC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82909235FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpqv9-0003zA-Ql
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 06:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jpquJ-0003WD-TP
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 06:20:59 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33492)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jpquI-0007jE-FS
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 06:20:59 -0400
Received: by mail-wr1-x441.google.com with SMTP id f18so7909953wrs.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 03:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=D5eORhEFT/IzOxlqS7OiER5RHHIG68a7QP0BT4+g8R4=;
 b=noGUIWCCddbePqXaJlpaiOM7Mg89H35Th/qTbjjElDyjwsUSCMpWqu13G3OOxuezjX
 RAkyCSeS5rIMjmX/xn18fL8osruv7EUYQ3IDFTsxx0CmrZcmoVlxqqU3net/bx4GbhsV
 P8V9hnIy00GtqISsavawoiIZPfmGlr9NtcHb5ABvn9fTNbMkpZxF/Mj44vOIneEKqrCl
 kscN3JNHhHIllhsbIjPBDrMCshSn60yl/KdnVm80BQBOCOESK4Tya0TPI9YNhfNJ4Ekk
 g1widJo5IdjQEtHZYNlAZWhGuPronNPy8LlgReay/dmPyuei4XYjhp0tFMt4veXg5u7L
 9gog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=D5eORhEFT/IzOxlqS7OiER5RHHIG68a7QP0BT4+g8R4=;
 b=R7bqSTAfzeeC8P4sICqfRIxsRbCSiv0OWJwJTPHxgQ29GsGed7CNCia4r2IxTwLaKE
 Ah9GNfYYVGH0lfsz2WjZRS6lpmpM8Q/fxAxfKL93jWrDVhBdOo6mvK89Miu0yLL/ruwR
 p172jRSVYsNDQb+ukFfKVu8osDQsgroMLhY5pteKdLMs4k3Kha+fciqw1SHB1Q+XuFkA
 340bMeroBHaJljRhrOCa/r9iAbOZfGoUxw9KC71ORROHwQ7jpsdIgdE+/tf8BYf6Tsac
 pIXo2g6NA/x9CE6Qs/pPZ+bBrCIC7pv64q5xU/j5WeicGztYV2fiI8S5CbGNGecO9FYA
 4WHw==
X-Gm-Message-State: AOAM5311CsCwPCigTG5rNge6Wa8Iq9dJ03G4WfyJUPuKSJjLT1dh1ual
 JZFQIzrWusqpE6R8dLE0S3IQtG6THfc=
X-Google-Smtp-Source: ABdhPJy0PUQVdorAhgSesjPsx1YWXd5m2n6EO+DxOmVneQloBFBwTVSVz231k+ott3bl3X3QQ4HBLQ==
X-Received: by 2002:adf:aad3:: with SMTP id i19mr16482107wrc.359.1593426056877; 
 Mon, 29 Jun 2020 03:20:56 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id 125sm29648757wmc.23.2020.06.29.03.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 03:20:56 -0700 (PDT)
Date: Mon, 29 Jun 2020 11:20:54 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Lin Ma <LMa@suse.com>
Subject: Re: [PATCH v2 1/3] block: Add bdrv_co_get_lba_status
Message-ID: <20200629102054.GE31392@stefanha-x1.localdomain>
References: <AM6PR04MB57820B6AA7FCB70AB82D4EA9C5920@AM6PR04MB5782.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0H629O+sVkh21xTi"
Content-Disposition: inline
In-Reply-To: <AM6PR04MB57820B6AA7FCB70AB82D4EA9C5920@AM6PR04MB5782.eurprd04.prod.outlook.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--0H629O+sVkh21xTi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2020 at 01:07:14PM +0000, Lin Ma wrote:
> On 2020-06-25 20:59, Lin Ma wrote:
> > Please initialize is_deallocated to false at the beginning of the
> > function to avoid accidental uninitialized variable accesses in the
> > caller.
>=20
> It has already been initialized to 0 by 'data =3D g_new0(GetLbaStatusCBDa=
ta, 1);'
> in function scsi_disk_emulate_get_lba_status of patch 3/3, Do I still nee=
d to
> initialize it at the beginning of this function?

It's safer to set output arguments in all code paths. That way callers
don't need to remember to initialize the variable to a specific value
(false in this case).

You can leave this assumptnion but please include it in the doc comment
so it's clear that callers are responsible for setting it to false.

Stefan

--0H629O+sVkh21xTi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl75wIYACgkQnKSrs4Gr
c8hmOgf+I2orgxYuq87bFRJNql1C6YarEfTccLe6KZq2jCC3DQCiaHmm3VT34+dS
9qYkhvpRQRMW2rYRtxHUa1CCiRmduuyt1hVZl85zXQwi7cFgxYuofIy0l+hgESO7
uvYRltc/QDH2yUnBLUrjYw8/rC/lpgfvwCBSrAAZ5i6RiXDP9FYhDDyR59jst1yh
CYYU1sVxY0FJmkekdiEJ3pkaY7y3bchHYEhvcvUcMUkDS6PUFqe/j8M2K0P9x76j
jCl1p2R6la7V4puNC/9XBtnpPM2BrXODWKRfBGfifAkOmLErOUhOBeikGj9ihZte
rLgEXPLUXVVkVn3RTgbuCb3sCvBEmg==
=dDZz
-----END PGP SIGNATURE-----

--0H629O+sVkh21xTi--

