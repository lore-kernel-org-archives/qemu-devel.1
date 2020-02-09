Return-Path: <SRS0=SBSl=35=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699B0C2BA83
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2020 23:03:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 326E9207FF
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2020 23:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+/C01DV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 326E9207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0vcC-0004ck-DL
	for qemu-devel@archiver.kernel.org; Sun, 09 Feb 2020 18:03:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0vbS-00045H-Os
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 18:03:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0vbR-0001JP-MJ
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 18:03:02 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41015)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0vbP-0001Gd-19; Sun, 09 Feb 2020 18:02:59 -0500
Received: by mail-wr1-x441.google.com with SMTP id c9so5278412wrw.8;
 Sun, 09 Feb 2020 15:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JDmv38kMqVo3ehGQD3WcYrPim4urXb2NUkbzU2bTiyY=;
 b=T+/C01DV22IGmzKDY1GAtDSK2Es3eT12TT1DCxbHDImQrXxsXKrilTV63STlu7ypZf
 Yk8iltYvV61gUT9m5kyHWtHfoLJ0xLOrM4bJ7U0MJAeEy/EqbhH8SbDYKzE1LP++oKWq
 iVg/TeTun37zHKfXemWM0d3+OaZyMOqjFBYxDrhyS7PMDN0ovVUyHyL4nTP9cZMumQyW
 T2WvZ9rFSXNV/Q/6j7w1KDAGwXBXIRCCU30Su0ACsf2B1eD56mi+XgUSAbeRAZiK6zdH
 yqvUXYuerNcecPZeVNuppYEmVQNV/kZHCnqikisp1MlUKplmtqWYS5yF3mZcUhq1qTLE
 k6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=JDmv38kMqVo3ehGQD3WcYrPim4urXb2NUkbzU2bTiyY=;
 b=EOW6XX1G8YaworATgc6HYGq0otbN9+dMIjRhTQIlHD911ZYuJAOHhXOrzeyBUjEc1F
 /WU6qrVfLONT9VBgowdvt9A+5K9CPvtaPzKQZ81PfQVUIfVS0x5B6F2gkinlSyu2Fp5n
 LjZ4oq9kWB5nQ2RMB1riggBXCsXp+TrMdDxbLoZep1I90nBhlS1Fuc2T/PDCcvOe4wKG
 ARDfajOI+BOWPaD77g38QZeVFgOxyNNf88112BZje9PXwUl9bT/3kzQDk0ps9FFs3JCy
 S0zvGO8S7qME3ol3Und42PMnmhKNL+HrHMczuVfvnCpXABVqGL/ONcqWOv6B0UWOfNa1
 FHBg==
X-Gm-Message-State: APjAAAV2677kyKXGIL8atVNyLEZXYBtSWSzLkglxWPhkAzNXjvaHHnCV
 iuI0IZgjoTfO8D8c3kho/HM=
X-Google-Smtp-Source: APXvYqzi7OQvq4lx4h6VKv9wt0ybtyPZtObWwlbXzb69g60c6OlssNr7C9oRoSEbRflJ4gW2i4B/rw==
X-Received: by 2002:adf:f3d1:: with SMTP id g17mr12280597wrp.378.1581289377462; 
 Sun, 09 Feb 2020 15:02:57 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id t5sm13460170wrr.35.2020.02.09.15.02.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Feb 2020 15:02:56 -0800 (PST)
Subject: Re: [PATCH v3 02/13] hw/arm/raspi: Correct the board descriptions
To: Niek Linnenbank <nieklinnenbank@gmail.com>
References: <20200208165645.15657-1-f4bug@amsat.org>
 <20200208165645.15657-3-f4bug@amsat.org>
 <CAPan3WoYkSB4ySUfjz-8efH3eaFgjcVC1TQb2Jc9j-cN0fCcoA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <4a04ea28-8d00-bd42-35c5-fdd99ac3a87f@amsat.org>
Date: Mon, 10 Feb 2020 00:02:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAPan3WoYkSB4ySUfjz-8efH3eaFgjcVC1TQb2Jc9j-cN0fCcoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/9/20 11:51 PM, Niek Linnenbank wrote:
> Hi Philippe,
> 
> 
> On Sat, Feb 8, 2020 at 5:57 PM Philippe Mathieu-Daudé <f4bug@amsat.org
> <mailto:f4bug@amsat.org>> wrote:
> 
>     We hardcode the board revision as 0xa21041 for the raspi2, and
>     0xa02082 for the raspi3:
> 
>       166 static void raspi_init(MachineState *machine, int version)
>       167 {
>       ...
>       194     int board_rev = version == 3 ? 0xa02082 : 0xa21041;
> 
>     These revision codes are for the 2B and 3B models, see:
>     https://www.raspberrypi.org/documentation/hardware/raspberrypi/revision-codes/README.md
> 
>     Correct the board description.
> 
>     Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org
>     <mailto:f4bug@amsat.org>>
>     ---
>      hw/arm/raspi.c | 4 ++--
>      1 file changed, 2 insertions(+), 2 deletions(-)
> 
>     diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
>     index f2ccabc662..818146fdbb 100644
>     --- a/hw/arm/raspi.c
>     +++ b/hw/arm/raspi.c
>     @@ -221,7 +221,7 @@ static void raspi2_init(MachineState *machine)
> 
>      static void raspi2_machine_init(MachineClass *mc)
>      {
>     -    mc->desc = "Raspberry Pi 2";
>     +    mc->desc = "Raspberry Pi 2B";
>          mc->init = raspi2_init;
>          mc->block_default_type = IF_SD;
>          mc->no_parallel = 1;
>     @@ -243,7 +243,7 @@ static void raspi3_init(MachineState *machine)
> 
>      static void raspi3_machine_init(MachineClass *mc)
>      {
>     -    mc->desc = "Raspberry Pi 3";
>     +    mc->desc = "Raspberry Pi 3B";
> 
> 
> Could this patch be replaced by patch #11 "hw/arm/raspi: Extract the
> board model from the board revision"?

It has to be changed before patch #8, and while patch #8 is tiny, it is
complex. I prefer to keep #8 as simple as possible, by making this
trivial change first (I don't want to do 2 different changes in the same
patch). If you want I can move this #2 as #7 just before #8, but I'm not
sure this makes things clearer.
> 
>          mc->init = raspi3_init;
>          mc->block_default_type = IF_SD;
>          mc->no_parallel = 1;
>     -- 
>     2.21.1
> 
> 
> 
> -- 
> Niek Linnenbank
> 

