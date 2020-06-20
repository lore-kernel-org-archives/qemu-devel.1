Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1804C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 12:11:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81BEC2245F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 12:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81BEC2245F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmcKt-0003PI-Ri
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 08:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jmcK9-00025k-JX; Sat, 20 Jun 2020 08:10:17 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:50194
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jmcK7-00084Y-VP; Sat, 20 Jun 2020 08:10:17 -0400
Received: from host86-158-109-79.range86-158.btcentralplus.com
 ([86.158.109.79] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jmcK3-0002bC-8u; Sat, 20 Jun 2020 13:10:16 +0100
To: Finn Thain <fthain@telegraphics.com.au>
References: <20200614142840.10245-1-mark.cave-ayland@ilande.co.uk>
 <alpine.LNX.2.22.394.2006162015310.11@nippy.intranet>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
Message-ID: <4867f0f6-c011-ff3f-9a6b-98daee72e025@ilande.co.uk>
Date: Sat, 20 Jun 2020 13:10:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.22.394.2006162015310.11@nippy.intranet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.158.109.79
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 00/22] ADB: fix autopoll issues and rework mac_via state
 machine
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/06/2020 11:24, Finn Thain wrote:

> Tested-by: Finn Thain <fthain@telegraphics.com.au>
> 
> Thanks for all your work on this.
> 
> I've just noticed a discrepancy between the traces from an ADB bus scan on 
> Laurent's Apple Quadra and an ADB bus scan on your patched QEMU machine.
> 
> Apple Q800:
> 
> [C1f][s   ][Rff-][Rff ][rff-]
> [C2f][s   ][R61 ][R05 ][r00-]
> [C3f][s   ][R79 ][R01 ][r00-]
> [C4f][s   ][Rff-][Rff ][rff-]
> [C5f][s   ][Rff-][Rff ][rff-]
> [C6f][s   ][Rff-][Rff ][rff-]
> [C7f][s   ][Rff-][Rff ][rff-]
> [C8f][s   ][Rff-][Rff ][rff-]
> [C9f][s   ][Rff-][Rff ][rff-]
> [Caf][s   ][Rff-][Rff ][rff-]
> [Cbf][s   ][Rff-][Rff ][rff-]
> [Ccf][s   ][Rff-][Rff ][rff-]
> [Cdf][s   ][Rff-][Rff ][rff-]
> [Cef][s   ][Rff-][Rff ][rff-]
> [Cff][s   ][Rff-][Rff ][rff-]
> 
> QEMU Q800:
> 
> [C1f][s   ][Rff-][Rff ][rff-]
> [C2f][s   ][R02 ][R01 ][r00-]
> [C3f][s   ][R03 ][R02 ][r00-]
> [C4f][s   ][R03-][R02 ][rff-]
> [C5f][s   ][R03-][R02 ][rff-]
> [C6f][s   ][R03-][R02 ][rff-]
> [C7f][s   ][R03-][R02 ][rff-]
> [C8f][s   ][R03-][R02 ][rff-]
> [C9f][s   ][R03-][R02 ][rff-]
> [Caf][s   ][R03-][R02 ][rff-]
> [Cbf][s   ][R03-][R02 ][rff-]
> [Ccf][s   ][R03-][R02 ][rff-]
> [Cdf][s   ][R03-][R02 ][rff-]
> [Cef][s   ][R03-][R02 ][rff-]
> [Cff][s   ][R03-][R02 ][rff-]
> 
> I think this could be easy to fix; it's probably just an uninitialized 
> packet buffer. When you come to submit v2, you may want to look into this.

Thanks for testing again! I think the issue here is simply that I've been doing my
testing on mailine which still has to extra switch to IDLE state before reading the
response.

Can you test with the following patch on top of the series to see if this works for you?


diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index b3fb710f7f..362878ca06 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -745,6 +745,11 @@ static void adb_via_send(MacVIAState *s, int state, uint8_t data)
                                           s->adb_data_out,
                                           s->adb_data_out_index);
         s->adb_data_in_index = 0;
+        if (adb_bus->status & ADB_STATUS_BUSTIMEOUT) {
+            s->adb_data_in[0] = 0xff;
+            s->adb_data_in[1] = 0xff;
+            s->adb_data_in_size = 2;
+        }

         /*
          * If last command is TALK, store it for use by autopoll and adjust
@@ -782,9 +787,6 @@ static void adb_via_receive(MacVIAState *s, int state, uint8_t *data)
             if (adb_bus->status & ADB_STATUS_BUSTIMEOUT) {
                 *data = 0xff;
                 ms->b |= VIA1B_vADBInt;
-                s->adb_data_in[0] = 0xff;
-                s->adb_data_in[1] = 0xff;
-                s->adb_data_in_size = 2;
                 qemu_irq_raise(s->adb_data_ready);
             } else if (s->adb_data_in_size > 0) {
                 adb_bus->status = ADB_STATUS_POLLREPLY;


This should correctly initialise the buffer in both cases. If it works then I'll
squash it into the original patch for v2.


ATB,

Mark.

