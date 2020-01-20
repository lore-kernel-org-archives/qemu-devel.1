Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_YAHOO_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F99C33CAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 02:45:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A25420678
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 02:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="JOI4ElgT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A25420678
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=yahoo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itN4B-0006xq-JT
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 21:45:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liewkj@yahoo.com>) id 1itN3P-0006Rw-Ac
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 21:44:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liewkj@yahoo.com>) id 1itN3N-00071I-V4
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 21:44:38 -0500
Received: from sonic316-21.consmr.mail.ne1.yahoo.com ([66.163.187.147]:44213)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liewkj@yahoo.com>) id 1itN3N-00070T-A3
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 21:44:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1579488274; bh=88xQHsac10/B/z0HyzIFe8G5lh269QiGzPihCI2hXFo=;
 h=Date:From:To:Subject:References:From:Subject;
 b=JOI4ElgTdeVBDHUffj1Y49F9Ta2yeepjbXRn0IhEZ6H4v1w40vIxEqF2jS2KiAciBO72/Gtp6FdORoIY+YID5EL5+78ddC1yCmcdLhwAqOIApNhO8jBDZBzVaP4v7WuwBlH3At6LhWcYH5y8TLIu3+RJptn7RqkFzBNkFSSHOGg6y54XvBB50OjZJA2KsyyvxAlIV4H2NPDIc0WBUHnpgnk1tIMM8gbqxUmLi1LW0gBuzdIJi+U57BOvYdrTSBBkZatbMGJP1WZFvSE0qcAsuLySEginajt1ESzAaS+OqRYVz5VLQQvpDDug+gQilI9E3v5QYeq9gcfpB1XvpCRjMw==
X-YMail-OSG: 7ZPN9x0VM1n7F7vm6S9yG1q6HogReXM7AlRZ2shxirMINCFFImn3Rq.IIpxPfr1
 koOlssc0P21bPFA2A3feU8JkwmYo6hPm7snXC_Cc9C4ZeKYbI7OdjrXGJJBzFEPJwG36aO3tLxWC
 DZQVeiRQStRvZh2y01sD0c5Gxnk5C6Jeg00tyxMKjrJna2l1vtEnBP9rd9wIyTqfAUsPPNVVHmyN
 ZWfsyjLZCcdtgY2ssUz40fweIVLrWaZV1NHkzI0PpAuuG1SKBfs8KSVuwurmdQLG3LbyEzzHpJpc
 TXd0brLgVZOyS9JG2j..v13KWwNgO8NJ0hKpuQx9BK37P6m70DMAlg0e3uyY7II1uxyZgcW9c51g
 jdAy9LX_r0VUPTRZUZzDiKYLE.NYNTeAFb76Z2E3_NJtYT92WpHyUuXncXy6D0_NKgd.di3o7e4c
 p0SgYTwugC2fXiGYrDwUQJlZkI903pWxnhkA3oT1P5vjGyjqVrfspvyD0ipo7pOBkWB791.9PXvS
 Ww.6Xv6VWlhXGM5ulsi0lxFtHrgnvajk6H0HzHiFNKEPFGc4ZbF4CJPBNl.piNABcD4RlPkSC_Ob
 G6bve1Z46UkwJotNt5TRWc9d_UvUOvl0f7_LIUv6B6VUDoCzWKDgBqJ060nCmBf46na6XliFSkht
 eZCvm972IfhORx.vYFSPhzy0FyTawO0wr58NEsFGNlJnb_WucPIYTbQBlkrtqgNtczyYWuO_pVkv
 464iOQYH0E6DhHvs.okah2p1DDx.cTkfjVJBcPv9IovtG9RGSiEjfSV1nyv731HLhWcInvS7C0MF
 OR7eKCt3r.zxQ9btV1xBYR93R9KwWmnIe9LLR7.0uhJoKDNQgUZzyh7MuEpei9fMAmUV8xhuRML6
 IGOospj3_hMifRkTyhtEDUc8n4GLfc0X7dL5uHKFYKPhCyMS4bsu4pSYMF93ZruGvySViojLtVBE
 Xxczmxklvp6t3Ox6BLHElkDkBSWPZ74OqBxHMY3rtrAn9LrAujlIRk6.CTIPEB9UzGSuyOwHJAER
 e0h0ecMAU_EtkT.SP67XVbEMZqp.1enkUCvIO4Pi.IOtkq4QINQNpxg1Zq2Abnzof3dhcTzajm18
 OZlu8j2P_4oylXbR9SKZogN4eAGreFTsPEBfR7uToK1wJFso8N1Zf1n9tV5dmIlNSSXlZkxd74Qd
 sntPOXgXrIx8g7edVlNSmBQigtgEez.X02eAHU2UAXbkYxPShT14VZJ2zB32v.0QA_rtv91jSqQh
 z_07cZoGcaqRvdpxPgZKncmdALF_HRu1KYll31ECL1_u1pkFPOrksA6Icqg2SwXuz1j4NB20qtoW
 tgTRzsfgErdA8Zp_gfEcbvSpV2gPxexSje67KxopH.tEO1SRO3KKsHgzqreV1cA--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic316.consmr.mail.ne1.yahoo.com with HTTP; Mon, 20 Jan 2020 02:44:34 +0000
Received: by smtp424.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 47cdfa335a329bccde23c92ed7b56e4b; 
 Mon, 20 Jan 2020 02:44:33 +0000 (UTC)
Date: Sun, 19 Jan 2020 18:44:22 -0800
From: KJ Liew <liewkj@yahoo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] audio/sdl2: fix unrecognized audio format
Message-ID: <20200120024422.GA686@PC-SEANJYE>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
References: <20200120024422.GA686.ref@PC-SEANJYE>
X-Mailer: WebService/1.1.15077 hermes Apache-HttpAsyncClient/4.1.4
 (Java/1.8.0_181)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 66.163.187.147
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

On Windows/SDL2, SDL_OpenAudio() may obtain audio format different from
requested format.

QEMU trace:
sdl: sdl_open: req.fmt = 0x8010 obt.fmt = 0x8120
sdl: Unrecognized SDL audio format 33056
sdl: SDL_OpenAudio failed

The easiest fix is to force audio format conversion internal to SDL2.

diff -ru ../orig/qemu-4.2.0/audio/sdlaudio.c ../qemu-4.2.0/audio/sdlaudio.c
--- ../orig/qemu-4.2.0/audio/sdlaudio.c	2019-12-12 10:20:47.000000000 -0800
+++ ../qemu-4.2.0/audio/sdlaudio.c	2020-01-15 15:56:25.059841600 -0800
@@ -147,10 +147,11 @@
     }
 #endif
 
-    status = SDL_OpenAudio (req, obt);
+    status = SDL_OpenAudio (req, NULL);
     if (status) {
         sdl_logerr ("SDL_OpenAudio failed\n");
     }
+    memcpy(obt, req, sizeof(SDL_AudioSpec));
 
 #ifndef _WIN32
     err = pthread_sigmask (SIG_SETMASK, &old, NULL);

