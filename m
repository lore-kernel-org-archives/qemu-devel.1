Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F468C48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 13:24:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A012083B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 13:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DWfkFGjU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A012083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgUOV-000491-EG
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 09:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33712)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lucienmp_antispam@yahoo.com>) id 1hgUMs-0002UX-Ms
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 09:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lucienmp_antispam@yahoo.com>) id 1hgUMq-0001zk-Mq
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 09:23:14 -0400
Received: from sonic316-20.consmr.mail.ne1.yahoo.com ([66.163.187.146]:39617)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lucienmp_antispam@yahoo.com>)
 id 1hgUMm-0001ww-U6
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 09:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1561641786; bh=FlWjMn2oohVzyJn4e5F903zNVL1rrvv9cCbvXYezqho=;
 h=Date:From:To:In-Reply-To:References:Subject:From:Subject;
 b=DWfkFGjUGx0T60lViatRnXHsZqVm4eDgsL1afhXCavWdDHPIc6rCf3FDoKsVmufg6PYWcToL3Bxr9hpkczaV1oVUh21JqeoiEiwdNzzykD6LkRxRz8qaJiXFQCWpid6la+8S72L/2TRj6g8r16gtTBhj8rgfcuuN7xZkCeYwvBa+9zyuUIy5LcPPzsb1NOBTG54hSA9rm/cCyZ+pCvgZJ2sIjDw59ujYgQ2DKGtk3e0KKcFv6x58uA6Wua+8RlkZduqraRUifD4JovFf3GayeCiJkaBAlEP5EB3WqxWwwpr+8BPsfF3OISRhHq+ig2NdCf63dSr3TWFZRm+DxjjNHQ==
X-YMail-OSG: OeS1x9sVM1mxRDHHmfBc8ho6qW8EZVfKqglF3P.Jnb.dku5xxXhQIPn_r1tlWxA
 AXldOnSECWTgMZZUmasQ3G3UHa2khg3ph7e2oR52EEUL1CNc83nrpOF_elaZzQAtR5ls9uOmk5xb
 wxyBs.dEWOjvNl_mCPsQ4Scu4D.fL2bT6Nx7FpCkbicXcETRK3lBNOaj5oV2h65D4DhT0WS5A2Af
 UqunSk_SMReX8q6LldBkSuhK7m7IbSSzzT5kN4HUkN7GrPfYOoX2rwF30_ODtU_vnyjZXrzlPWsp
 Hpv4KOkLdqPeaCjVQb8aOV8sMbU58c_7hSq0RZ64XUfH2c0IWJvYYbGUzyHsW0wcBZG6hWQuJyLR
 Wz1aPHWFz7w8.fr46iuhZ4BuyJwkwoP5_rgEOC_WQQlmgPIioxRTa37upcdL3ALlUDYrGqKJYp77
 QjC09YjMcJvW2Z1HCNufOnCIPN3eCBPbAnbVYgoTViZduWmlH7LdHU0t1qI24SI1ajg1KE2dzRLk
 LqtLbFRmhNW_Vs1bFEqiABhAsFA2jj8DKbwEoGIclr4eU8Qj_W8El5HcdhpLlpb3rCTmbdW3UvOz
 U_c27u4b8RP9oV8P_k7WJ8Hj5a0R9aEiBahUP3GijTHg5c9.zWf1fMGyIY2iOWdnGVKAif6AyPrt
 j84tTcTBzvlsZIw6svVjjbgI0FPb70DWtWYoh.sxfWXzeA8IsiiMKiJQFN6bSWRnx3En_KLBYiKL
 6UkRGsf6zIcedYDT93i5HjEEg7xc86rYKAMtoi5zQbdALU5q6GGLhkCibwOLXUOPtAOPkffgCInu
 ZV5oipU7lzYBN2K97NYswID_h6iCJ2Ke6B7wgB2AuVG.ftg1RZzNtBBQ4TDMUKWg9fHC_MgeO9VI
 6Z5DQutE4edgLdU8p1nQvIq1s6ztw1QAmk8GcdFEp1e1rwv.x0VKAwxOl9tMvsgiBRn2OFRr21dh
 KeNs7KnB_f7uyueE6I1_ZIOkTBFn6.0EnFXVmW2N1sJID8rfEBoo_vHhMl5U5xNCBlfUV0MD4lst
 __YJNaMTkFiTII7Vs3PwvE9Dwc1xks_cPnFSFca6sgDeu7acxRpaYPh.Qu1ON98VwgXO9XDCW5tV
 a7BWoyO_tB5m12j9VE57lGHNLBOQkI95FljI1COozuHndOhqhgw44J2Adr.YyJkUQKaIaiY92czb
 C0xQcFDDwU3Hv5MCiBQ9uIM5EOm0GsrVOdptlKLueitX0fxn1dWQEY1uv
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 27 Jun 2019 13:23:06 +0000
Date: Thu, 27 Jun 2019 13:22:32 +0000 (UTC)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
Message-ID: <1079763171.281101.1561641752988@mail.yahoo.com>
In-Reply-To: <2136180936.260219.1561641583358@mail.yahoo.com>
References: <2136180936.260219.1561641583358.ref@mail.yahoo.com>
 <2136180936.260219.1561641583358@mail.yahoo.com>
MIME-Version: 1.0
X-Mailer: WebService/1.1.13913 YMailNorrin Mozilla/5.0 (Windows NT 10.0; Win64;
 x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100
 Safari/537.36
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 66.163.187.146
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Hi Laurent / Richard,
(resent email )
Does anyone have any knowledge why=C2=A0 =C2=A0 gen_exception(s, s->base.pc=
_next, EXCP_RTE);

is generated for "RTE" instruction, where as the "RTS" goes a gen_jmp?( not=
e see=C2=A0target/m68k/translate.c in functions=C2=A0DISAS_INSN(rte) and=C2=
=A0DISAS_INSN(rts)

Cheers,Luc =20
