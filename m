Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92C5C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 21:07:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DA0520732
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 21:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="YzyqzFtp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="LIbtVclu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA0520732
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX9ib-0004j0-8u
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 17:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>)
 id 1kX9hI-0003jL-7n; Mon, 26 Oct 2020 17:06:32 -0400
Received: from home.keithp.com ([63.227.221.253]:56978 helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>)
 id 1kX9hC-0005ws-Ab; Mon, 26 Oct 2020 17:06:31 -0400
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 1DE053F2DD61;
 Mon, 26 Oct 2020 14:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1603746381; bh=qCwCp5pS1/Te/2+yBMnqnmlqH7FAnO3igmcgeMGvmSU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=YzyqzFtpPvcANA1bIsOLw4qhy0r4FpVJ4gOTAKHTtDo6buOabtLzu1xR+ymPHVi3n
 gwWooYIS247BdsbziggYiQbtYpJ2uiZqqzUFBd2ZmRrT4x5UiHpX9OFcHeDbcK0CrX
 z/u8i29UvrkTPZy0Qpg+L0i8m2nRAvROX8Re22p4W7j1L25JPUFE2HwgO5CXd6ip87
 STFnoca1WCSRiKthbbd7+wMurZDX8Iw58nmX0Cb0694AfS0I1VIoitHa7O3vnkCyan
 Xo5ibkjxKFsYEgKFVc0j1nT0GuWaTYLQJElTqHR5Y38KW1PT0WRon6h75rXJKKtzH4
 kzl6LzOiaiqeA==
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id y7pLJsBPWu4E; Mon, 26 Oct 2020 14:06:20 -0700 (PDT)
Received: from keithp.com (koto.keithp.com [10.0.0.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id BC9ED3F2DD60;
 Mon, 26 Oct 2020 14:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1603746380; bh=qCwCp5pS1/Te/2+yBMnqnmlqH7FAnO3igmcgeMGvmSU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=LIbtVcluhqpPaOuu7n8rGTHH659LcogZLDu0NaJKbJcSUsmbatMx2Vb10DUXDEVIK
 6ng85DU4V98T0nUZoIj4ZSFCENiQ6v5o55Og6k4V+NDGzno4UeT4JZxqwRNZ1pRHAI
 2CuP//GjxHo7BpiWGxaqrYDrjqwtWUaeClXZQYREUhcPxgSPcpOp0PYTlp0cRAQ0jX
 veCzbVp92p18+SIP806U0rnU7GF1Lw2qmhq5BWt966+87Wpws++PrjRGUrN1VxFKSS
 2W9jLRfGYOTKfG+GuAirm19y/mEunw+SrL8QVBewI+xl+j2t0XFatMRcNuJe0u39NS
 ILj6I7cmOvdGA==
Received: by keithp.com (Postfix, from userid 1000)
 id 98DB01582210; Mon, 26 Oct 2020 14:06:20 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, Alistair Francis
 <alistair23@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Laurent
 Vivier <laurent@vivier.eu>, Palmer Dabbelt <palmer@dabbelt.com>, Alistair
 Francis <Alistair.Francis@wdc.com>, Sagar Karandikar
 <sagark@eecs.berkeley.edu>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>, "open list:RISC-V"
 <qemu-riscv@nongnu.org>
Subject: Re: [PATCH] riscv: Add semihosting support [v8]
In-Reply-To: <32eb3f3a-1256-ac68-c2ad-e887269ee796@linaro.org>
References: <20201023214940.917885-1-keithp@keithp.com>
 <CAKmqyKMzHARF7C9Lo8SYFBbPNa_=ibbWBNnedwFbe8AY=DdXVA@mail.gmail.com>
 <8736246ub3.fsf@keithp.com>
 <CAKmqyKP6CE1YpkfKo6=zghAbdN58oQvYNoafq70dvmR6OHyhtg@mail.gmail.com>
 <32eb3f3a-1256-ac68-c2ad-e887269ee796@linaro.org>
Date: Mon, 26 Oct 2020 14:06:20 -0700
Message-ID: <87a6w8hf3n.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 17:06:21
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

Richard Henderson <richard.henderson@linaro.org> writes:

> This is no different to EXCP_DEBUG, really, which is also internal to qem=
u but
> user-visible in the same way.  Just adjust the logging in riscv_cpu_do_in=
terrupt.

I think that's already handled by the early return in
riscv_cpu_do_interrupt after handling the RISCV_EXCP_SEMIHOST case.

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAl+XOkwACgkQ2yIaaQAA
ABFzEw//dNk30jK+07f3ZviNo7lvIUDRnhyNDtH7cTBE1YLjvhsPAoe9CkAF2Xhz
7iyYsU/gRyWCIwAuCauyDeuGyPrbQKtCurq9QVUqZaebDj9KYT9ViAQSdPvclXEd
xPL6kuOUWQcApdsuLFVi1MT4d+C9TLKorD14dzGU0sS8d8/1wvxnhy6kr8rpMcV+
RUNPobXniJpdhzdUwTykHvzmTdCgpWI0Cunghzq3mLdFUT7FzAxQBHbcjdJB7/zJ
bBmQ78aWQtbItb8yXzyxj9qPOdU6fBM3SvAv8D5s4eXfMsTpF3m6QNsMyGnzxv+Z
S3U0/YqeC9r786FPVJD1zXvn/JcrCfj4Cto9rlzauMxbpr5lK5TE9d7NfwW++MME
4qBx39AsaegJbmIYllZdxWh7Q4gej2k1bWL7XinqvNpbUvn751P8wKvl/Vg/YAoS
p2CqQsR5QnyUEb0OQgcERrZSe18HbiUo5YPQYiQ5eyH1vFSpjHGoS6ghHbJowMTT
Ch/NRO1lci5Zdg9DdZTtuM5G1BtGFb8DEF6VsxUx74mXyHQG5k+OC8EIAlg9hL2G
j8mUdlm9oph9zb/U6+Xc7UAF0G7d278V5MfOJj1y5wp4+J797EOUzUSixMUf3hTz
KHkJ1M8L4VnTS07UL6mqo7uwUc19i2xJR6pwfEH5vgZgGNUQyG0=
=AiRe
-----END PGP SIGNATURE-----
--=-=-=--

