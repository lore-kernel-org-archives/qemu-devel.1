Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B0CC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 12:08:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E88A208CA
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 12:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="TpoyuzKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E88A208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhv6X-0003xI-R5
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 08:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52306)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lucienmp_antispam@yahoo.com>) id 1hhv2q-0001PU-UH
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:04:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lucienmp_antispam@yahoo.com>) id 1hhv2a-0001Hd-NH
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:04:20 -0400
Received: from sonic313-56.consmr.mail.ne1.yahoo.com ([66.163.185.31]:45331)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lucienmp_antispam@yahoo.com>)
 id 1hhv2Y-0001D9-Mv
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1561982645; bh=EfK93Uvdwyd+7w4cUb8BfTEhJoi/ktaSkjkIJV4LdFA=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject;
 b=TpoyuzKwRfYQ2htIpnffJTv20aqAn1p3RHm0+hMwmGMr+F+mRJLvQb8EEH8yL8Y/5xHVbPAHAeib08DIgAuthHVWQC/gVJCTksat24UYXUSfp1UnWJBdfq6C4e5veDKYzAhmTvRUIHiuE/PQp/KnkCA304h+eDyE40u4KG/4y2WqUoif/yX1k/eVltLYU450JbgO+LUr49f6QervL019+Zlemmk1lb3EfRi1QulQwV+m11Wqv4+pSargoDfeJlGTYSIc7xDYXt9Ggf0D1y3uj3VbDsbUSGWh9y8LCjGntDrgc2PYwNMtMPJgNwwW6MHyH39wSdOj72YduH5gOFqpjw==
X-YMail-OSG: GGARXrQVM1mvIv4v3zT8GSfvi5DgF9CdiFPV5WgLDUS2ARYarBZg42QmL.5ouiG
 VsKeMug0L9JnOPxlNSXJD8xcTrnB6BBSeFkAfeYM4Ng8ng1_P9ioBdx0Hi5dYh3kp4FpgiuBB2cs
 o_yiKi4Y5GQVN04tcD2ys6zhqUFMjTbnuHieUblWu29ZgY0GvGo.CEGVBIx9mmMz2k1SxhMOY6PD
 qcMju9XBsOMG2XDvVdvtAjMz6GyWJaUOXtwFP1pS1it2bRhx5u2O4ZJAQHXK6U4X20XiuXpP7TED
 Nj3DmwOAdz2REy08k3_R9cgsGo0REyTh6RSLgqoLN6nrS6A700UgUvtqfdSpS51MuIEr85yGTufm
 vpZ_mP1q.kuIqxLmVpxLaDLLvDuv3O6mijIXsxRkCFHcQsWwedyCAJBr1XYw4Ph3BDvyMqfecymc
 g4OwsxTUJJZUyaqbKJI79oFZhSicuJ_cy814qBgZWX7aG2sZhfhWZL_1wdtamurMofYdHBL5oj3O
 X4fffCKRGObpCqHYn8zz3ADtwCSFFxw_LC6kb4GE.YOoU6.lzo93HvJ3AOA.yO31KkLYn2myCW35
 nZ_UvGOFZxe05n6NnoZ1yJmYMxGLwdp7a1Y46p4ftMGpUFTl32NEJHw4KkOaOi1HmblYdEmMoxOw
 CdIc9DePuMX9ZuVEoFvGh7OG.eEerjS3NHZENeoqb1nbTay5IAUSgNsGRPgk1qMWyaiDd8bad.mK
 gYge.RlQ6YXLC0jy96pNdbD_yybWlTYNLLOjFogCZ70FpDlw.NrNk7FgwivGQHyr8s6q7WwpVRwl
 KbHdxgN8Ls8Fpr0Y2tNhkvKur94TbAZIsExx_PsADS.KjxsFcf6PGsV0ZXEDxFDns3MeL1UqY6yE
 4.7JnnGnu9w0xMhhehcj9loVIAmqqK_yLrUvotlHptknbjzHz5ehEqP_tyy6QJSMuQghofbP9EEY
 Vhlj5zjhloftyPigNwP6nPsCHVseW034zd4vLFtIhcKhgdSceCC08YW29XvOUuxEyN7_c_hGzIPS
 ZrAvy78yUMnxbruAOC2jxwtuo4YVgkSAeqXZPpy2yP3bdLq_5o5ymx9AQ.ZU8mpi8D1ZQ7Wkl4Ge
 zoFy4mRsuVGfrkxkoEqcJ5czo.IDl8aNmaBQOwz3Nni_1Haq0TpDE5CalDYIo9rgxcWyvdbZ0zuk
 EqZnIcl8yHmwAUV7nDX7hxyEjm_JoPKI97k3qKouI5f7Oi4dzhLzpnZqeDshAckWqn0HxCIzyRek
 g._IxNQX3JoBfINQ-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 1 Jul 2019 12:04:05 +0000
Date: Mon, 1 Jul 2019 12:04:00 +0000 (UTC)
To: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Message-ID: <1399218244.1210557.1561982640362@mail.yahoo.com>
In-Reply-To: <CAFEAcA9sfNisAz-zAZAx=ZNFmsEpP0Ec2DeRedtZSd9KQ4fvNA@mail.gmail.com>
References: <2136180936.260219.1561641583358.ref@mail.yahoo.com>
 <2136180936.260219.1561641583358@mail.yahoo.com>
 <1079763171.281101.1561641752988@mail.yahoo.com>
 <e4c1fbc4-3e43-5df4-a17c-527d98d9763c@linaro.org>
 <20190628002713.GA19257@localhost.localdomain>
 <eadb57ae-256d-0bb7-5988-f493662a5caf@linaro.org>
 <20190628155030.GA34320@localhost.localdomain>
 <ea16a81c-5b94-8dd0-8339-2bd82733aed2@linaro.org>
 <20190629163621.GA111724@localhost.localdomain>
 <CAFEAcA9sfNisAz-zAZAx=ZNFmsEpP0Ec2DeRedtZSd9KQ4fvNA@mail.gmail.com>
MIME-Version: 1.0
X-Mailer: WebService/1.1.13913 YMailNorrin Mozilla/5.0 (Windows NT 10.0; Win64;
 x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100
 Safari/537.36
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 66.163.185.31
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] RFC: Why does target/m68k RTE insn. use
 gen_exception
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
From: Lucien Anti-Spam via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Lucien Anti-Spam <lucienmp_antispam@yahoo.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=20

   >On Monday, July 1, 2019, 06:10:55 PM GMT+9, Peter Maydell <peter.maydel=
l@linaro.org> wrote: > > On Sat, 29 Jun 2019 at 17:37, Lucien Murray-Pitts>=
 > <lucienmp.qemu@gmail.com> wrote:
> > However for the m68k the do_transaction_failed function pointer field
> > has not been implemented.>Er, I implemented that in commit e1aaf3a88e95=
ab007. Are
>you working with an out-of-date version of QEMU ?

Sorry not pulled in a long time, you are right that is there now - I dont g=
enerally check the development list outside of replies, and was focused on =
the stepping issue - I will be more careful of that in future.=C2=A0 Thanks=
 for the heads up.
Further to my initial problem I noticed that TRAP #0 also jumps to the hand=
lers +1 instruction.=C2=A0=C2=A0Same behavior can also be seen with ARM "SW=
I #0".=C2=A0 =C2=A0 (PC shows 0x0C vs the expected 0x08)
Putting a "BRA $" / "B $" so that it loops on the first address of the hand=
ler results in the step stopping, of course, at the expected "first instruc=
tion" of the vector handler.
So it would seem this maybe a wider problem than just the m68K.Since I dont=
 really understand the TCG complete execution method,=C2=A0and how it fits =
in with the GNU RSP "s" step command I am going to take some time to work t=
his out.
I appreciate any hints people can provide, but I dont mind plugging away - =
I am learning and surprising myself how much there is to this.
Cheers,Luc

 =20
