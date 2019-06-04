Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC38FC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 18:53:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 886522075C
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 18:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 886522075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56504 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYEZE-0000cM-PX
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 14:53:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hYEYM-0000GJ-Ps
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 14:53:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hYEYL-00012f-9v
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 14:52:58 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:54770
	helo=mail.default.ilande.uk0.bigv.io)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hYEYB-0000BH-0y; Tue, 04 Jun 2019 14:52:50 -0400
Received: from host81-158-188-206.range81-158.btcentralplus.com
	([81.158.188.206] helo=[192.168.1.65])
	by mail.default.ilande.uk0.bigv.io with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	(envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hYETV-0000zo-DU; Tue, 04 Jun 2019 19:47:59 +0100
To: qemu-devel@nongnu.org, no-reply@patchew.org
References: <155955891012.32260.9064081470614985823@ce79690b2cb9>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Openpgp: preference=signencrypt
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
Message-ID: <5c9a9f70-304b-8f19-361c-9951dfa854db@ilande.co.uk>
Date: Tue, 4 Jun 2019 19:48:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <155955891012.32260.9064081470614985823@ce79690b2cb9>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 81.158.188.206
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: Re: [Qemu-devel] [PATCH v2 00/15] target/ppc: remove
 getVSR()/putVSR() and further tidy-up
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
Cc: gkurz@kaod.org, david@gibson.dropbear.id.au, qemu-ppc@nongnu.org,
	rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/06/2019 11:48, no-reply@patchew.org wrote:

> Patchew URL: https://patchew.org/QEMU/20190602110903.3431-1-mark.cave-ayland@ilande.co.uk/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Subject: [Qemu-devel] [PATCH v2 00/15] target/ppc: remove getVSR()/putVSR() and further tidy-up
> Type: series
> Message-id: 20190602110903.3431-1-mark.cave-ayland@ilande.co.uk
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> === TEST SCRIPT END ===
> 
> From https://github.com/patchew-project/qemu
>    60905286cb..ad88e4252f  master     -> master
> From https://github.com/patchew-project/qemu
>  * [new tag]               patchew/20190602110903.3431-1-mark.cave-ayland@ilande.co.uk -> patchew/20190602110903.3431-1-mark.cave-ayland@ilande.co.uk
> Switched to a new branch 'test'
> 868f640501 target/ppc: improve VSX_FMADD with new GEN_VSX_HELPER_VSX_MADD macro
> 11658435f9 target/ppc: decode target register in VSX_EXTRACT_INSERT at translation time
> e9e52e3f0a target/ppc: decode target register in VSX_VECTOR_LOAD_STORE_LENGTH at translation time
> 239e07a0cf target/ppc: introduce GEN_VSX_HELPER_R2_AB macro to fpu_helper.c
> 6aeb8a2e36 target/ppc: introduce GEN_VSX_HELPER_R2 macro to fpu_helper.c
> b43836d4e8 target/ppc: introduce GEN_VSX_HELPER_R3 macro to fpu_helper.c
> 241920056a target/ppc: introduce GEN_VSX_HELPER_X1 macro to fpu_helper.c
> 959261a074 target/ppc: introduce GEN_VSX_HELPER_X2_AB macro to fpu_helper.c
> ecd519b86e target/ppc: introduce GEN_VSX_HELPER_X2 macro to fpu_helper.c
> 62b466770b target/ppc: introduce separate generator and helper for xscvqpdp
> d8a5beec33 target/ppc: introduce GEN_VSX_HELPER_X3 macro to fpu_helper.c
> b2de1761e5 target/ppc: introduce separate VSX_CMP macro for xvcmp* instructions
> 895b953f81 target/ppc: remove getVSR()/putVSR() from int_helper.c
> ca941ffe9e target/ppc: remove getVSR()/putVSR() from mem_helper.c
> eae59c79c5 target/ppc: remove getVSR()/putVSR() from fpu_helper.c
> 
> === OUTPUT BEGIN ===
> 1/15 Checking commit eae59c79c5ea (target/ppc: remove getVSR()/putVSR() from fpu_helper.c)
> 2/15 Checking commit ca941ffe9eaf (target/ppc: remove getVSR()/putVSR() from mem_helper.c)
> 3/15 Checking commit 895b953f8175 (target/ppc: remove getVSR()/putVSR() from int_helper.c)
> 4/15 Checking commit b2de1761e581 (target/ppc: introduce separate VSX_CMP macro for xvcmp* instructions)
> 5/15 Checking commit d8a5beec33bd (target/ppc: introduce GEN_VSX_HELPER_X3 macro to fpu_helper.c)
> 6/15 Checking commit 62b466770baa (target/ppc: introduce separate generator and helper for xscvqpdp)
> 7/15 Checking commit ecd519b86eec (target/ppc: introduce GEN_VSX_HELPER_X2 macro to fpu_helper.c)
> 8/15 Checking commit 959261a07480 (target/ppc: introduce GEN_VSX_HELPER_X2_AB macro to fpu_helper.c)
> 9/15 Checking commit 241920056ab0 (target/ppc: introduce GEN_VSX_HELPER_X1 macro to fpu_helper.c)
> 10/15 Checking commit b43836d4e8bb (target/ppc: introduce GEN_VSX_HELPER_R3 macro to fpu_helper.c)
> 11/15 Checking commit 6aeb8a2e36c7 (target/ppc: introduce GEN_VSX_HELPER_R2 macro to fpu_helper.c)
> 12/15 Checking commit 239e07a0cffa (target/ppc: introduce GEN_VSX_HELPER_R2_AB macro to fpu_helper.c)
> 13/15 Checking commit e9e52e3f0a39 (target/ppc: decode target register in VSX_VECTOR_LOAD_STORE_LENGTH at translation time)
> 14/15 Checking commit 11658435f9ff (target/ppc: decode target register in VSX_EXTRACT_INSERT at translation time)
> 15/15 Checking commit 868f6405015c (target/ppc: improve VSX_FMADD with new GEN_VSX_HELPER_VSX_MADD macro)
> WARNING: Block comments use a leading /* on a separate line
> #278: FILE: target/ppc/translate/vsx-impl.inc.c:1311:
> +        /*                                                                    \

It looks like checkpatch is getting confused here because the comment is part of a
macro definition with the '\' continuation marker at the end of the line.

> WARNING: Block comments use a leading /* on a separate line
> #284: FILE: target/ppc/translate/vsx-impl.inc.c:1317:
> +        /*                                                                    \
> 
> ERROR: Macros with complex values should be enclosed in parenthesis
> #325: FILE: target/ppc/translate/vsx-ops.inc.c:66:
> +#define GEN_XX3FORM_NAME(name, opcname, opc2, opc3, fl2)               \
> +GEN_HANDLER2_E(name, opcname, 0x3C, opc2 | 0, opc3, 0, PPC_NONE, fl2), \
> +GEN_HANDLER2_E(name, opcname, 0x3C, opc2 | 1, opc3, 0, PPC_NONE, fl2), \
> +GEN_HANDLER2_E(name, opcname, 0x3C, opc2 | 2, opc3, 0, PPC_NONE, fl2), \
> +GEN_HANDLER2_E(name, opcname, 0x3C, opc2 | 3, opc3, 0, PPC_NONE, fl2)
> 
> total: 1 errors, 2 warnings, 377 lines checked

And this is just another "macro of macros" in the same style as all the others within
the file so I'm not convinced that this is relevant here either.

> Patch 15/15 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> The full log is available at
> http://patchew.org/logs/20190602110903.3431-1-mark.cave-ayland@ilande.co.uk/testing.checkpatch/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com


ATB,

Mark.

