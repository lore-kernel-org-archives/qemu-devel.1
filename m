Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A08C07542
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 03:44:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1990216FD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 03:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="JTaQSS39"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1990216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39469 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hV6Yz-0005dh-RN
	for qemu-devel@archiver.kernel.org; Sun, 26 May 2019 23:44:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lucienmp_antispam@yahoo.com>) id 1hV6Y9-0005KY-Rz
	for qemu-devel@nongnu.org; Sun, 26 May 2019 23:43:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lucienmp_antispam@yahoo.com>) id 1hV6Y7-0004zl-VM
	for qemu-devel@nongnu.org; Sun, 26 May 2019 23:43:49 -0400
Received: from sonic313-10.consmr.mail.ne1.yahoo.com ([66.163.185.33]:43549)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lucienmp_antispam@yahoo.com>)
	id 1hV6Y6-0004yf-1k
	for qemu-devel@nongnu.org; Sun, 26 May 2019 23:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
	t=1558928623; bh=vQ3NV3uhyCuj9s9+MN0RZW0MsLiQPPH6c6V0m6jeEjM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject;
	b=JTaQSS39C0ZHBfKJC/ts6uiIU5+iMAKEI/BOPcQ38rGy5XhM6vOcSk9W6l6Yd5YLaoQNR/CeQOUb2uUsEh4InGttrvrRCjSsuiEJxwQI5cMuy96xhb9Tk4AMkcoPXLYEd+grYrMtY2aBh/pjoKy76QNxPbbPtfjG0pO/WQX0xAvnceelEgW1U8NgNQ70hHpEwBs57meUHVkGV0eIgowk7alybhjz5p7xmRVZuBmckNVEOmIMh5mByagMGMfoIxUy0EmH/5GYc5oCy5xZk1urkcGhFoIXm2+CwT7HhJP4iLOsKjJGtOFwYyFozrPYR7bgMOfz8btaeDmP720dfXxi0w==
X-YMail-OSG: Xa5Ld8cVM1ll.r3B58YfXPIxs4nf6JzNJg_xNbylgDwMJQBgVU0erxr7VvZkwib
	JZtd9pfhtnldaHmk3w9SgZCVD_yDP8jIXTRdAE2fcy3FtDaYYB3qdvHFUc.AQFN6rA5rr3l29LQI
	QBB5U66nALNul0YsDkTNVMW4f7bTx1chW2ScwFb5dZNQ0aOL1SojABS6cNU0IbmQ.KbxE0MWWnkE
	X46fhG516Ixqn2fFGNK8sgwYttGJRG5ZsrTyahyJREVlf5Tk5cJURN_AXMzjrwp3FpR4X1iRpYPR
	OcJ97jjpvxXktl2TyT1Dqh2fksHd7RNhEWGPqTIvTrfE2mHs9LVPzCBSvAAuiPGG6JgXXHlcMnaO
	mlJR.85eovjpnRSk0kE5AMcUwyo56UumBrUngm.Vt.u3CNypopmA3MIR7VW7IYaCa5ugL8upf5JZ
	3OUcrC6AYdBnpes4DckRzLqRFZ2_EEKRDoYEyi2orG66YKqaeeC74Z7agnSnxh1JCQRvhQy3Ec03
	wqzgoepiKEhRRPTD0yMjbGpxz4i6cWYVYnOtuVfZDevO7FTef68aWM5aWaL9lX_3V7Kpgk0n3Dz0
	td6k6UH2Q5e0GAvICNcb2W9DPFBBnZKGTMZn42yFJPc2XQAJ4UBiUpJ0UglGm8THpQQHC6Pdsd4X
	VUvHu8eQ51Z25aFhYaO9fZ1kE8g8hhp.u3ktNYge2Cn51_.FByI.5AZpEm4zhuJG3heROH3Nk3Zx
	PvcgxZ_vU1j1SXFP3f9Km8zp8ibEmmHahMuYs1Ze8OIYQ.TeTAb_HKeNJJ32mo6BaIlDOyhqgVV3
	GtRyCk3859k_4ZNXFm2iEC8Krq4v0krPVN_XVh1CvGmGaFdyElapB4quLs.vNmHo7h_.P9LJOokL
	bmJ_VI.dr0XDds5xkW.RccZwM6pJvT0iFrtp2AUSO8hqBlYJy9W4P1kL0ksDzJWaHZZUhwtOqgLA
	adcirPpkxDjsvh1JTbB4j4BlW5mlx6XhTEOJI3XGO7.L9PDz9fDBvBF96sthfzZ77AX4uVeSkdUD
	PiH5PAGuXHaDgHC7MKJFui8.Vhk0pV13eDEoCKa02qD4jJeskxlSit9JoeILSO1_kOlJEPxejX_7
	n_rY_llHTCFOvtWKTr6n1R2hweZL_hatgME4PnirtQ_SuZIHujh6gI42GDItWdutw35bDI9HeAsH
	aAHLft2hSBHnszbNWgQsM02MfYE1YRd1WDCeCrj6DF1fBd4qxjcoiY_GmaM7H3JIR2Av_Qf0wstD
	VN48LRjcGSv2soaMHtgoNQ.ScFwMUmYfNHznpZmOtmMNqrZufrc42s23NSfmHurvc1oO2_CbHa16
	mePTMYgo-
Received: from sonic.gate.mail.ne1.yahoo.com by
	sonic313.consmr.mail.ne1.yahoo.com with HTTP;
	Mon, 27 May 2019 03:43:43 +0000
Date: Mon, 27 May 2019 03:43:40 +0000 (UTC)
To: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Message-ID: <652107096.7996190.1558928620614@mail.yahoo.com>
In-Reply-To: <b7c64daf-5036-b492-92a5-b25524d8cbde@vivier.eu>
References: <20190526072826.32956-1-lucienmp_antispam@yahoo.com>
	<b7c64daf-5036-b492-92a5-b25524d8cbde@vivier.eu>
MIME-Version: 1.0
X-Mailer: WebService/1.1.13634 YMailNorrin Mozilla/5.0 (Windows NT 10.0; Win64;
	x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169
	Safari/537.36
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 66.163.185.33
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] Incorrect Stack Pointer shadow register
 support on some m68k CPUs
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
From: Lucien Anti-Spam via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Lucien Anti-Spam <lucienmp_antispam@yahoo.com>
Cc: Thomas Huth <huth@tuxfamily.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	"Emilio G . Cota" <cota@braap.org>,
	=?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=20
   > On Sunday, May 26, 2019, 10:10:39 PM GMT+9, Laurent Vivier <laurent@vi=
vier.eu> wrote: > On 26/05/2019 09:28, Lucien Murray-Pitts wrote:
>> On CPU32 and the early 68000 and 68010 the ISP doesnt exist.
>> These CPUs only have SSP/USP.
>>=C2=A0[SNIP]
>> The movec instruction when accessing these shadow registers
>> in some configurations should issue a TRAP.=C2=A0 This patch does not
>> add this funcitonality to the helpers.
>>=C2=A0
>I think it's better to also update movec in the same patch.[LMP] Movec sho=
uld be undefined (coldfire manual) for registers it doesnt know.=C2=A0 The =
MC680X0 manual is less clear.Technically this could be just leaving the ope=
ration of the instruction alone and allowing it to pass back MSP/ISP/USP as=
 it currently does.=C2=A0 My thinking is this is less likely to break anyth=
ing
So I will only add a comment, to state that on 68000/10/CF/CPU32 it should =
be "undefined"
>Could you also update the comment about sp in CPUM68KState structure=20
definition?
[LMP] Done
>And, if possible, could you fix style problem reported by patchew.
[LMP] Done

 =20
