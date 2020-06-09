Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB12FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 21:01:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCF9520734
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 21:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF9520734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jilNR-0006AY-RU
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 17:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jilIA-0007qo-SH
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:56:18 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:48042
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jilI8-0006If-VL
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:56:18 -0400
Received: from host109-147-121-67.range109-147.btcentralplus.com
 ([109.147.121.67] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jilI3-0008RW-P5; Tue, 09 Jun 2020 21:56:16 +0100
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200609073214.14079-1-f4bug@amsat.org>
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
Message-ID: <da5851a4-953b-8915-7bc8-37c20a23805f@ilande.co.uk>
Date: Tue, 9 Jun 2020 21:55:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609073214.14079-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 109.147.121.67
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PULL 00/16] SPARC patches for 2020-06-09
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
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/06/2020 08:31, Philippe Mathieu-Daudé wrote:

> Hi Peter,
> 
> These are the latest SPARC patches sent to the list.
> 
> This pull request is with authorization of Artyom and Mark:
> - https://www.mail-archive.com/qemu-devel@nongnu.org/msg710154.html
> - https://www.mail-archive.com/qemu-devel@nongnu.org/msg710156.html
> 
> Frederic doesn't have his GPG key signed:
> - https://www.mail-archive.com/qemu-devel@nongnu.org/msg706509.html
> 
> The following changes since commit 49ee11555262a256afec592dfed7c5902d5eefd2:
> 
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.1-pull-=
> request' into staging (2020-06-08 11:04:57 +0100)
> 
> are available in the Git repository at:
> 
>   https://gitlab.com/philmd/qemu.git tags/sparc-next-20200609
> 
> for you to fetch changes up to 86e8c353f705f14f2f2fd7a6195cefa431aa24d9:
> 
>   target/sparc/int32_helper: Extract and use excp_name_str() (2020-06-09 09:2=
> 1:10 +0200)
> 
> ----------------------------------------------------------------
> SPARC patches
> 
> HW:
> - Use UNIMP device instead of EMPTY_SLOT
> - Make EMPTY_SLOT similar to UNIMP device
> - Map UART devices unconditionally
> - Pair of fixes for AHB PnP
> - Add trace events to AHB PnP
> 
> TCG:
> - Improve exception logging
> 
> CI:
> - https://gitlab.com/philmd/qemu/-/pipelines/154231191
> - https://travis-ci.org/github/philmd/qemu/builds/696321130
> 
> ----------------------------------------------------------------
> 
> Philippe Mathieu-Daud=C3=A9 (16):
>   hw/sparc/sun4m: Use UnimplementedDevice for I/O devices
>   hw/misc/empty_slot: Lower address space priority
>   hw/misc/empty_slot: Convert 'size' field as qdev property
>   hw/misc/empty_slot: Add a 'name' qdev property
>   hw/misc/empty_slot: Convert debug printf() to trace event
>   hw/misc/empty_slot: Move the 'hw/misc' and cover in MAINTAINERS
>   hw/misc/empty_slot: Name the slots when created
>   hw/sparc/leon3: Map the UART device unconditionally
>   hw/sparc64/niagara: Map the UART device unconditionally
>   hw/sparc64/niagara: Remove duplicated NIAGARA_UART_BASE definition
>   hw/misc/grlib_ahb_apb_pnp: Avoid crash when writing to AHB PnP
>     registers
>   hw/misc/grlib_ahb_apb_pnp: Fix AHB PnP 8-bit accesses
>   hw/misc/grlib_ahb_apb_pnp: Add trace events on read accesses
>   hw/timer/grlib_gptimer: Display frequency in decimal
>   target/sparc/int32_helper: Remove DEBUG_PCALL definition
>   target/sparc/int32_helper: Extract and use excp_name_str()
> 
>  include/hw/empty_slot.h        |  9 -------
>  include/hw/misc/empty_slot.h   | 19 ++++++++++++++
>  hw/mips/malta.c                |  4 +--
>  hw/{core =3D> misc}/empty_slot.c | 47 +++++++++++++++++++---------------
>  hw/misc/grlib_ahb_apb_pnp.c    | 24 +++++++++++++++--
>  hw/sparc/leon3.c               | 18 ++++++-------
>  hw/sparc/sun4m.c               | 23 +++++++++++------
>  hw/sparc64/niagara.c           |  7 ++---
>  target/sparc/int32_helper.c    | 23 +++++++++--------
>  MAINTAINERS                    |  7 +++++
>  hw/core/Makefile.objs          |  1 -
>  hw/misc/Makefile.objs          |  1 +
>  hw/misc/trace-events           |  8 ++++++
>  hw/sparc/Kconfig               |  1 +
>  hw/timer/trace-events          |  2 +-
>  15 files changed, 124 insertions(+), 70 deletions(-)
>  delete mode 100644 include/hw/empty_slot.h
>  create mode 100644 include/hw/misc/empty_slot.h
>  rename hw/{core =3D> misc}/empty_slot.c (66%)
> 
> --=20
> 2.21.3

Philippe, thanks so much for handling this - things are really busy here at the
moment, so the help is greatly appreciated :)


ATB,

Mark.

