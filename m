Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42520C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:30:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1125E20775
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFPanDEr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1125E20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0MsW-0007zo-96
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 06:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k0MrL-00079Z-3s; Tue, 28 Jul 2020 06:29:23 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54895)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k0MrJ-0001Vy-57; Tue, 28 Jul 2020 06:29:22 -0400
Received: by mail-wm1-x341.google.com with SMTP id d190so180538wmd.4;
 Tue, 28 Jul 2020 03:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=KKKAwKcpEtwJZucV5CE59QSNf2jOkDHuJEoi0iqMrww=;
 b=KFPanDErnrbCYcxSi4FJg28zqjtNZihKYqux9Z5MdbYaMBl9djx60FNIvYDClSwFQU
 AOf4QEbcicT6biFXkvBLFKtzKjVnnGGN/o4xfAdfaWuYGV66h30wriXflKbRBHNvUagq
 FjucPLKLccO0cLVWGxO2hrRmz/mtR4LBEXrWmeaUeydH9kDXqO5f7k62P+CEiagbxC1G
 o5NIXN+WrBY/77fwnEtSH+UX86g2G8b66g6J3twCYI/98o6bqOBJcWvyr8GdngnP2d7W
 UtLcWkmFwn7BFBYQrSC8+UPWLqNHQ2IkfM1rt1X3aPX/IwC7td6jhgQvqYN/SP0+wQ2W
 Yw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KKKAwKcpEtwJZucV5CE59QSNf2jOkDHuJEoi0iqMrww=;
 b=j75knPpP/d2n3TM+cZAARz560peykFUHSmeJ/cVOyUeX9sT5S/LndLFkg/938J+crY
 SFXQGiU+7km4kNeratjDV5HKjuEoMlGgBR5B2WcQYIMP00ihTlC5TbFXAm+H8U1/+xzM
 lHfeSbZKNo/WjtFScFnxWCbGtrJxGzF/y7MaZRMV85eJxO47o+V6B0N6F65IcfpzRtCe
 1FVytuvynl5RZ8PRv/1DoWhYB06t/ES+gMvDOfDGdGka8eLaoNe13HKIKuMvgTx8xFcr
 Eiz+TOL2qtpHynyv2ZXsEJ9Qpas0EtfnxQCUgSCunpd3xXXXBBFX6t/Dmm76cBqBaY/U
 VzEw==
X-Gm-Message-State: AOAM530jDkBtP+ZL08i0DTrUCNLSBN46i1DYM/k+9lNiwiXeHXXf+mtf
 ugRfihSEcolGs9FQgWITNx0=
X-Google-Smtp-Source: ABdhPJz2LOmZxuCv+ePe86dUm8OEHQijTbLe9Oh16t/aAcls9zEXmYtRY+EUUMinWJpgmFtEe1qF6A==
X-Received: by 2002:a1c:7f91:: with SMTP id a139mr3241884wmd.153.1595932158825; 
 Tue, 28 Jul 2020 03:29:18 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id s205sm3980170wme.7.2020.07.28.03.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2020 03:29:17 -0700 (PDT)
Date: Tue, 28 Jul 2020 11:29:16 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH v5 0/7] Introduce 'yank' oob qmp command to recover from
 hanging qemu
Message-ID: <20200728102916.GC10336@stefanha-x1.localdomain>
References: <cover.1592923201.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Content-Disposition: inline
In-Reply-To: <cover.1592923201.git.lukasstraub2@web.de>
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x341.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 23, 2020 at 04:42:30PM +0200, Lukas Straub wrote:
> In many cases, if qemu has a network connection (qmp, migration, chardev, etc.)
> to some other server and that server dies or hangs, qemu hangs too.
> These patches introduce the new 'yank' out-of-band qmp command to recover from
> these kinds of hangs. The different subsystems register callbacks which get
> executed with the yank command. For example the callback can shutdown() a
> socket. This is intended for the colo use-case, but it can be used for other
> things too of course.

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8f/fwACgkQnKSrs4Gr
c8gnCAf+L5/9FX/d7xocqKUKB6yTx9xuDZ01uU/l1N8JL7HhJfas6O/HGCNNnN+C
M1q1V8sb0zJbXHHX7BkQcDsTOzfNSCAAltl/2kUAvPiL2IDAtgC8v/bn6f9rsHtO
lQ+0aswR/6Mcc+gAgSdrlUMDsq4APZu7TAkKvSi0INVn2bACELxeMwoB0+ZsXLFn
DqiTQXSdD8nxBpYrvvgnE46T//xUDjRwcbWrB0FHh0ljJ/EiPJlSRSsN7QC4/3mE
zM4vZNuyQS/SqFNrl4TGgAzUVdOiJiPna/OsPSR6qfjrAKh+O/hupAsc4BSIg4hO
Rg90R1Z2bYt5B9Oc4xfdw/LvxVJqsQ==
=shZx
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--

