Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C03C388F9
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 00:17:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88E1C20BED
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 00:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="BpPoIR0X";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="BpPoIR0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E1C20BED
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW7FV-0002K0-J3
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 20:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1kW7DK-0008Nr-Qe
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 20:15:20 -0400
Received: from home.keithp.com ([63.227.221.253]:42970 helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1kW7DI-0007ej-IP
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 20:15:18 -0400
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id BDC923F2DD13;
 Fri, 23 Oct 2020 17:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1603498514; bh=7dSDwMftl0c8NIjOsuaz6fMrclsGqYasEYCzNh3jA9A=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=BpPoIR0XauOFWBi5GNomGgTaM+8pp6Jv2rgQ+fyrD12v46dT831tLRGmrTmtBGVeN
 04jpru+HETpEphUjjGt8hjcv1HhHcHLcciEj5x0jYSNIDW7wR2aKh013SnB0tkjTF5
 +EGVwR27q0dcpjqOXQw1Yuh31zasy1e32xMz0+2mBqWyQTREnxxvJKeS0p5Yq0NW6v
 IaCuPupxyA9I5Ath8KCUbWTx6UxWrUC7etudIgdMJcXURsxtERXOKRJm9Q5lR3njg5
 EEWiBgj/ns5gLpmoHG8dRvEGVVb8SQ8d91SK60cub9186FtZs3aoYtIO5m9dHIaKmc
 +HCQaXU0y5rsA==
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 3x2EJjcPl5jL; Fri, 23 Oct 2020 17:15:14 -0700 (PDT)
Received: from keithp.com (koto.keithp.com [10.0.0.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id 77F7D3F2DD0B;
 Fri, 23 Oct 2020 17:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1603498514; bh=7dSDwMftl0c8NIjOsuaz6fMrclsGqYasEYCzNh3jA9A=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=BpPoIR0XauOFWBi5GNomGgTaM+8pp6Jv2rgQ+fyrD12v46dT831tLRGmrTmtBGVeN
 04jpru+HETpEphUjjGt8hjcv1HhHcHLcciEj5x0jYSNIDW7wR2aKh013SnB0tkjTF5
 +EGVwR27q0dcpjqOXQw1Yuh31zasy1e32xMz0+2mBqWyQTREnxxvJKeS0p5Yq0NW6v
 IaCuPupxyA9I5Ath8KCUbWTx6UxWrUC7etudIgdMJcXURsxtERXOKRJm9Q5lR3njg5
 EEWiBgj/ns5gLpmoHG8dRvEGVVb8SQ8d91SK60cub9186FtZs3aoYtIO5m9dHIaKmc
 +HCQaXU0y5rsA==
Received: by keithp.com (Postfix, from userid 1000)
 id 6448F15821A3; Fri, 23 Oct 2020 17:15:14 -0700 (PDT)
To: Alistair Francis <alistair23@gmail.com>
Cc: "qemu-devel\@nongnu.org Developers" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 2/2] riscv: Add sifive test device to sifive_u target
In-Reply-To: <CAKmqyKPtV4fsKhaaiSTwsOgi=w-B3oUP=_93ftLgpqBY6874iA@mail.gmail.com>
References: <20201023214506.917601-1-keithp@keithp.com>
 <20201023214506.917601-3-keithp@keithp.com>
 <CAKmqyKPtV4fsKhaaiSTwsOgi=w-B3oUP=_93ftLgpqBY6874iA@mail.gmail.com>
Date: Fri, 23 Oct 2020 17:15:14 -0700
Message-ID: <87blgs7a3x.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 20:13:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: "Keith Packard" <keithp@keithp.com>
From: "Keith Packard" via <qemu-devel@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Alistair Francis <alistair23@gmail.com> writes:

> I also don't see this in the FU540 memory map.

Same as for the FE310 -- this is a QEMU-only device. In addition,
OpenSBI expects to use this when built for QEMU.

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAl+TchIACgkQ2yIaaQAA
ABFcEQ/+MneO4IxMgAiIwiLhA3FjEClCksnTTGwa4N0EnRCxawbpCztunzJ3GmR9
1q2Vsa++gto39rjHugQB7gwgvsuLepvvTr+lW3tU5jBnxcXrMtIeqghQRudMA8HK
XX1EqHcSJ2p/z6bvDzo88xYI39b/beTLEjCNDpXjisRbTe5uIRqLYoAZDpchh54d
Fn1QQamzV5w3Rutw0JfMZ/yGjCePmTQOwcRzXh2MLhE2rJfDOm0ZU5+u9mykRgM5
TUd46OkSXoVVxMLd9PCDBxscdF1sEjfvnRHzAv/bQkAE4vToQKP7i6ICO6jD3Fll
I8D4tWLrM8KHqPNb8aDFOGSDlGupgLvLhEw1nsWfzLLD5bJzznTWbDkJCT7iOPZe
LtkdBN/qHZy8dnD8cQd+G3ZhJcljzyQyn67t3faHcvEmd+Is6bmlyF4wh7QNiaQW
rqMTa+y2In55QAoDYuw5scOqyCOrXpTa/p8/ekh6BsjkU7xbYF358GeWCCH/MQES
Uzamfj8ktHZS5z21ixzBeJSCvmG24mQxJhDjRoeb3y2tKeawl7UCd1vwoAj6MlGR
KSsiRfiLEQj0XaiceNYxB8lNn8zxffLPYPbiN7AYF1y8zY3RUUDZ5jQCdHjrIcgK
oSTivFXFwu4p9UMnXZY0FniJlr1fblp2sf6ZRYye3uZuFipYP5Y=
=1QKq
-----END PGP SIGNATURE-----
--=-=-=--

