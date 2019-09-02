Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755D7C3A59B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 09:42:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4120E21874
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 09:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4HTKRBG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4120E21874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4iqs-0006gc-Fr
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 05:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50647)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1i4iq9-0006Hx-1L
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 05:41:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1i4iq7-0005Qf-Rc
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 05:41:36 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44043)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1i4iq7-0005NH-Kr
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 05:41:35 -0400
Received: by mail-wr1-x443.google.com with SMTP id 30so2349866wrk.11
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2019 02:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=tugLvhIF63Pg+5IoqC7PBL6sDEclYkTdHKAtNGAxEMM=;
 b=O4HTKRBGnVxXKeVadJBLcVjlQFdRySqOr+v838mWSnhFY+m+aRThFps4VHMqSodlYh
 n4Z4SkT1QMD2bGZbj5XBDjLo2MdbchlzYRUeAZOD3VY7PTAhQD0HjeW/+IyL1IAA/bWF
 fX+28N+TjEAmGPx2tiWbaPW8Y8cfah8H/HjsXuue5GAXAYrQOomEZCA6hsDMCVzuuZKY
 ZHA61GPJ7qRDMZL2wF1ClZ/dDmb89SZvfRNxhiwgHJufE7iGTmVAw2EXqSBui9ruiS5E
 7NZapN7i9AoPfo7K7Cf/tHcMS2fW5ap/E/1K8wBpRw2Xft2nosMish5SQA5NfNloAnvi
 ggBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=tugLvhIF63Pg+5IoqC7PBL6sDEclYkTdHKAtNGAxEMM=;
 b=ZHtwW2nYyNp62zV3+CpoP+KtGmPZjVgmVZAIK4P9QU30VXN+dVDWdeSpT7M+CaHYGu
 mxWlPlxJ69SYzAEcW09sKE/Xr3iOcbiXMMeWgzbYy5qvcEDAMgDatqJFUv276NrDoNy8
 FxYEcuIUYXNl8R4eKLiTGnSRCgH4M1WYczDcSTT6D7urpYAjvOnwyBsb9tF3zeMWWzBA
 vLYAktvbKGLMqNdoVSXvC+1m4/jMQg41ulm4oYjIOdFkAPGls+Jp/CUNxnp5J8M/Oxkv
 ssl9GloRuhJuRykWdUMhNnKGd40nzqVYaCmLFdfUhRCqTPXSfyoom7DUmMlP+Kr7bhSC
 /6yA==
X-Gm-Message-State: APjAAAWL3dYXjoc3qhbTQJ/ASr9jV5oV+0GV2xdInxwevv5kYXKxz0Y0
 SiYuRpgPPDYkQD7F6Mxvhx8=
X-Google-Smtp-Source: APXvYqxCaKEVR7SpGJz+6MyRW7fyN6Ow/CZ5xRjQDS3KKgKizTt8n5ZjFMobZ0d025gr44pnoJSYwg==
X-Received: by 2002:adf:f5c5:: with SMTP id k5mr31728265wrp.42.1567417294292; 
 Mon, 02 Sep 2019 02:41:34 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id a7sm27482567wra.43.2019.09.02.02.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2019 02:41:33 -0700 (PDT)
Date: Mon, 2 Sep 2019 10:41:32 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: vandersonmr <vandersonmr2@gmail.com>
Message-ID: <20190902094132.GF9069@stefanha-x1.localdomain>
References: <20190830121903.17585-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/QKKmeG/X/bPShih"
Content-Disposition: inline
In-Reply-To: <20190830121903.17585-1-vandersonmr2@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Integrating qemu to Linux Perf
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--/QKKmeG/X/bPShih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2019 at 09:19:01AM -0300, vandersonmr wrote:
> This patch is part of Google Summer of Code (GSoC) 2019.
> More about the project can be found in:
> https://wiki.qemu.org/Internships/ProjectIdeas/TCGCodeQuality
>=20
> This adds --perf command-line option to dump Linux Perf
> jitdump files. These files are used to enhant Perf report
> and to be able to analyze and dump JITed code with perf.
>=20
> Example of use:
>  perf record -k 1 qemu-x86_64 -perf ./a.out
>  perf inject -j -i perf.data -o perf.data.jitted
>  perf report -i perf.data.jitted

Please include a changelog in the future so reviewers know what to look
out for in this new revision.  For example:

v2:
 * Fix foo in bar() [Bob]

(where Bob is the reviewer who requested the change)

> vandersonmr (2):
>   accel/tcg: adding integration with linux perf
>   tb-stats: adding TBStatistics info into perf dump
>=20
>  accel/tcg/Makefile.objs      |   1 +
>  accel/tcg/perf/Makefile.objs |   1 +
>  accel/tcg/perf/jitdump.c     | 206 +++++++++++++++++++++++++++++++++++
>  accel/tcg/perf/jitdump.h     |  36 ++++++
>  accel/tcg/translate-all.c    |  14 +++
>  include/qemu-common.h        |   3 +
>  linux-user/main.c            |   7 ++
>  os-posix.c                   |   3 +
>  qemu-options.hx              |  11 ++
>  9 files changed, 282 insertions(+)
>  create mode 100644 accel/tcg/perf/Makefile.objs
>  create mode 100644 accel/tcg/perf/jitdump.c
>  create mode 100644 accel/tcg/perf/jitdump.h
>=20
> --=20
> 2.22.0
>=20
>=20

--/QKKmeG/X/bPShih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1s48wACgkQnKSrs4Gr
c8iOpggAsEh3wRTzAU8JO5guJYeDy1v/GAPzDcgEPX83YKwLwUZthDbaF4U7+xxD
F/wxrmUqGBmfCKTpr0pvjUGburhFOyT7nViEbgs+Yqo6qZLbGN2g8B7Fc1ATUonG
/McQ8+9WA2z1k96/e6jtaeHpHaUAoZrSBj2VaH5/3npmVkNmQ1egSzMX/3yMB0qb
ySMBRrBV10yrLlMSNMWql56341+2A1zS4sne66m5gKtqGU04zwPLJ4NuUhWI9IoB
2dwHPdKgHaYiTi3DnWkk8gJ4Lzq6Fs4AP0R3zLE99OYn1DMSKNEAxHlWIdQPQoF1
keuP0IYpz/pS+6gp+9JVQw//3P7hWQ==
=PqoW
-----END PGP SIGNATURE-----

--/QKKmeG/X/bPShih--

