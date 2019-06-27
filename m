Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B744FC48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 13:22:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4254C2083B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 13:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="b1y37cHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4254C2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgUM1-00008a-5h
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 09:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32925)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lucienmp_antispam@yahoo.com>) id 1hgUJa-0005kh-Bh
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 09:19:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lucienmp_antispam@yahoo.com>) id 1hgUJZ-0007pz-3d
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 09:19:50 -0400
Received: from sonic301-31.consmr.mail.ne1.yahoo.com ([66.163.184.200]:37829)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lucienmp_antispam@yahoo.com>)
 id 1hgUJY-0007no-Tp
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 09:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1561641586; bh=yGXQh0oaSaKBDEnyXL8LNS9EcVhU4wyzkfiAz8porbk=;
 h=Date:From:To:Subject:References:From:Subject;
 b=b1y37cHlXkykag3Oe1y3/Vz/Fh4HSPn0Yewo1YASiScnCfvvICAeWeOqf7h1eHMGRtpawRKEd6rC7engyBWFMBiGmOGLT5mrgC3ER2FqMnVgEr9d6wVdlEbxHZ7sr/wEeddk31HaMXMN+44KKugd2Ted60S+gu5Oyn0L+n5Ox2PIUZeIEV6r9kO9U1wveQiF8EVG4HobF5vUGARgK/m+D3VhDq3Uq+wibPPePTEoZsNRlUCkFSKn3v7sQC0hqyPDqgpvowVh396fPTVLMd+tw2vbEfC+zqJzhTN8bBHaDqQ0Ah0xVYCm0xsrcykSAfCRaY6dWOYNVlYqqGcg/g7wqQ==
X-YMail-OSG: U1PcZ2AVM1nBgufr1RWTEfkwaX.3FhTsfLUj13KiBPgyqrLljmaBUMuMqG.To.1
 qpP9hz3xo8jxoYRiLsQYckcisT6GPN8nbMbdLb_mTUd0sodPHhXc6VRAPywpUWkVGH7ez9ZNtFJk
 yPfekpyUdAMm15jk3Nzt.xDfteXsusfNxpik4TKttPTJZG.onkM.9qjQbfcXaQU_jwNvthtceLsj
 yW6oja2bcBn_qkqIIxFFdSZcJwNchUCk_rfVUisebaHSE32AKCEjfosgOzLD0lVjmpJIHl7jE.QC
 NaDwnOsimHs5zbbdMvnPvmYkbYVQW6zG0CblTDWVkkIHx3wd.DE_F__18sB1r8jTGbgMio_qnE_A
 5PksPqryRxMjPesMM_LarRa_YGUCt1h.REMKZqO1mRdKe77THW5WizXVs0caO9n7RZpbah12k5c.
 sfJj_a4cO4esgLcGQlH5Wu0z5YaZWA_gRKDO6kW.6ICvfXAqBZ1BJTa5dSQkGBvtF.mZ4aXSV.hN
 m2P5SFIa0aCfUwHsYye0W8_6bIRFWTIDSdEFcOmtrdNWGPLrnLZ1fXdVJPXNTjgNhQt22Bmka5f4
 sLj.m61YodVKgXVrr3I7zj3JCSIdGRwFt58NizOJ1fz5itEkyD2SKfdjtMf15nkBDSMm.vwwrnwm
 V1PlyMylzlF9hoYvyeeLTX82MOTH8im_OsBhgoV1A_ns_7dE1FA6lQzyUIL9HOKEwYDexNSrXDwF
 SjAZC0j8_705FQ_sj7iPEr4E8PAQFMLxyaVBzU4J9ilfjj0Q7RrtSusRxMaTR_7ejOPmu4umFMhK
 Fn0s69Lzv8P55YK7htadn4oyGUp.eFrhuJ2jGBiX317DZvFoe.5ctcMxk6ImXROoC1gZBLK5Yypv
 MSeMkGDRNheo415FkRInO8gKW5MAYJPltjTyJO8zUojplpy46Sv7SE.TrFf6OVDVxsALi9GAKjEl
 ToXJs35Ism8_hnfP5NagoGl2tL9BEtEiHbICm.da1jdj6nw71oJuCEePXYB7OmyrJoBpMNbVmLae
 s2O3btiVQNcc5AZ7l6HTbPmdzeXC2DaRZNd0Pj8HbD6_To7jP9f9djSwJQGHdP5ZwKbI6d6n877R
 l2KSqMElE4wFv.ldEshf4ipC6JATRwuOyjcDIyZ8CQkGlhwhggpvMDoPjGVOoUrffA8zpSdrgNvu
 lvUR2cE__UUI2FasEvkt6B4NZRInxE_UMP5yEP8w4Cf3C3kpEfmuGNZG0
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic301.consmr.mail.ne1.yahoo.com with HTTP; Thu, 27 Jun 2019 13:19:46 +0000
Date: Thu, 27 Jun 2019 13:19:43 +0000 (UTC)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
Message-ID: <2136180936.260219.1561641583358@mail.yahoo.com>
MIME-Version: 1.0
References: <2136180936.260219.1561641583358.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.13913 YMailNorrin Mozilla/5.0 (Windows NT 10.0; Win64;
 x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100
 Safari/537.36
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 66.163.184.200
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] RFC: Why does target/m68k RTE insn. use gen_exception
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

Hi folks,
Does anyone have any knowledge why
gen_exception(s, s->base.pc_next, EXCP_RTE);
