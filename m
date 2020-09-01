Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2367C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 19:53:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7E152071B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 19:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dYkohVEH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E152071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDCL1-0001ZD-Am
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 15:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDCHg-0000id-0d
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 15:49:36 -0400
Received: from mout.gmx.net ([212.227.17.22]:48043)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDCHd-0000HY-PD
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 15:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1598989765;
 bh=IPu8so8amUDeO7cmjNrf37a2fozHbkuU5ycMBFYtAag=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=dYkohVEHSeasBhmvSRv065YXqHQorlHEZZM5+xo3U+TPSq+D2zfpF304w8TEbjpNp
 aipoljzgrgX3BlHO0+bd5pUXsYBVgtZSbVIkA2Esq/NLJ8GfptMfnm69/GXnM0iM9d
 WnP/NTnfiLSEjDclQK2bIMLljI/071OeTdy1egxI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.187.2]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBlxM-1kIfP72Mai-00CDYz; Tue, 01
 Sep 2020 21:49:25 +0200
Subject: Re: [PATCH 0/7] hppa power button support, graphics updates and
 firmware fixes
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200901183452.24967-1-deller@gmx.de>
 <232d08f3-c759-c0b4-1080-1382dda7a81b@amsat.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <492f19e2-ed83-05bd-2e17-fd70eef8c692@gmx.de>
Date: Tue, 1 Sep 2020 21:49:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <232d08f3-c759-c0b4-1080-1382dda7a81b@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XyWOkNWrgYlbY1A5t+4eJsUz936HUDqnBgSm5TXIRCy3vapb62P
 dgSW4PL0twA9fxp9A3BczH/2x8fOO71b/KVGhkcc3s2/2F83njeE6aaGcKrcAnepDvscuuK
 YBceA9GXXyfNGYdq6uC6vyyZ/XzeH9KS6UQymsgDWVANqn4rZ2N59Mmb5HFLzXE7G1Ah1Af
 NamN3ESXXxCZxh6GkgqFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2aMbD1U0g0Y=:H404lfdkO21T4sA1p3q0N+
 JZ0l0Nm1kEkfyw6MgoTBZVnOrFDsPbHljilE9YrfVV7waSBRSWy7DoUPgif7BRN1GJeYZr4Id
 G3/sq91XxCOBz/Ap638FZWZdzP2DtHVEBvEPporcGsX7cCPOw8FZlaOnbF5vJpJZvab3rhMXh
 qNO5kVgonGCZY0sgquWmRMdFgCu4OCPlkWk07Szg9gCn55YSgbr/2qUfI6QGokzxorFL4OnAl
 c/R1unB/06Vc8VJwliAr2JcAAR83CkPO88mZzR0LYk/S5yWIPKgCFr+LjPlBbHEhqtFulSkTP
 90xLTJAGxEzso4s68mVaLbyTU4mDFjze0jiwMDFPfz6IeyPbxr2DqGAubFrKaWxS0kPlB9tPn
 n43cV4HiqM+dc28oZ1PHzYaZdsp+VXqzxRzDqbFQ9Uikvjm7sQ8wAbPyLRgbFNtEa36Csstvr
 B2z3983H/uQg9pu16YLvhFnG/43B3oGGZ+oKThnTjCi1usMn5GTmeCgoeMPTyiAO92hF0X+ZP
 d+Jwdrh2tORjwpiqxXfA1VrofxYdBky+pBhT7KYt0JW19czlB1iBXI+FrfkbWQlPREKlkhCgf
 8H+pZQMGRhkf9wyluwArkQvsSBhX2vHNm/ZIsar/yj5vY6liKZUsKWei9U5Qwh2XsjVCCDz5e
 wsU+gel4oRCY7HdSrlH023BcPSFR++T4pSDSYbDWbeTkF0/BDib65ZfD0LbWfw/tHs1C+hz5r
 0FQTPW+ablpgcLSLyEUdeEzuFovNbFCLz/3r+l9GQGvHefskfEbb7O7T2iY8GZIehq8WqX34k
 pn+9hOtRtQ9+PmBpjUjNiel3v2glESnpbpKK7DRK4HNHQIJM5oOODYLR+0CEP0RGPm+r/FkXF
 +n3KCRpMi3ivRfNkiJV0kDQecVGJjNXJC85bIUjeKcvjYrAXA+O6iFb+Nulc1yk3FjE78QGmT
 8lR9w7wVLkRSgHoiIOa/w9YxPjYtLjUPmcVVPwwagVpCh8947ijo+dfHMtnAnhjhR4w/ngRmn
 hVkX1aL+JbEteuP6A+kYB+sY6y0UTKke6H88PmyV+uXQiumiHaQdMUfuiY2trjI2FZDKowB0S
 nzJGk3yWpFUZ/YUzOeSh15lZgPjA4GBq00DCkFXfUC0eOJu3YFwVjMwa6AeZbVdY1vvcNFbp+
 lYwOiY2FkBmv7327din2gM3Cj2CC5FaoYDH7yho/TYwKKFG235nLPeEKHy4ZkUqF2MScC4ti8
 mnCgRSWI2dQWxjwn6
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 15:49:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, NICE_REPLY_A=-2.13,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On 01.09.20 21:37, Philippe Mathieu-Daud=C3=A9 wrote:
> On 9/1/20 8:34 PM, Helge Deller wrote:
>> Add emulation for a power button on hppa,
>> fix quite some bugs in seabios-hppa firmware for artist graphics card
>> fix boot with old Linux installation CDs.
>
> I started to review the version you sent last week and took few notes,

Thanks!

> are there big changes in this version (is it a REPOST or a v2)?
> (I think you just appended 2 extra patches posted separately).

Yes, it's a v2 version with the two patches appended.
Otherwise no real changes to qemu, but some more fixes in the included Sea=
bios.

Helge

>
> Thanks,
>
> Phil.
>
>>
>> Helge Deller (7):
>>   seabios-hppa: Update SeaBIOS to hppa-qemu-5.2-2 tag
>>   hw/hppa: Make number of TLB and BTLB entries configurable
>>   hw/hppa: Store boot device in fw_cfg section
>>   hw/hppa: Inform SeaBIOS about fw_cfg port address
>>   hw/hppa: Add power button emulation
>>   hw/display/artist: Fix artist screen resolution
>>   target/hppa: Fix boot with old Linux installation CDs
>>
>>  hw/display/artist.c       |  37 +++++++++++++++----------
>>  hw/hppa/hppa_hardware.h   |   3 +-
>>  hw/hppa/machine.c         |  56 +++++++++++++++++++++++++++++++++++++-
>>  pc-bios/hppa-firmware.img | Bin 783192 -> 785696 bytes
>>  roms/seabios-hppa         |   2 +-
>>  target/hppa/cpu.h         |   5 +++-
>>  target/hppa/insns.decode  |  10 +++----
>>  7 files changed, 89 insertions(+), 24 deletions(-)
>>
>> --
>> 2.21.3
>>
>>
>


