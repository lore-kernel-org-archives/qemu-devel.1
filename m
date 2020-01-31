Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A108C33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 08:38:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E4CC20705
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 08:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E4CC20705
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixRoP-000899-GA
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 03:38:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48753)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ixRnf-0007i5-Dh
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 03:37:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ixRne-0003wG-85
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 03:37:15 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:50207)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ixRnd-0003l8-VN
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 03:37:14 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MZjQl-1j21qA2kml-00Wkrc; Fri, 31 Jan 2020 09:37:05 +0100
Subject: Re: [GSoC/Outreachy QEMU proposal] Extend support for ioctls in QEMU
 linux-user mode
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <CAL1e-=j5WJkV=X+KkfBuS3pjf6z3aJrtu4xpYeVbjEUYiWxxTQ@mail.gmail.com>
 <CAL1e-=ghxDLcU3iqkZ8q_sbk_DyR70t2a-jFtoNDVa7iTkMXsQ@mail.gmail.com>
 <3d768689-b69f-02d9-b3b1-0c5a9a68df89@vivier.eu>
 <CAFEAcA8ph4Bt1S7k6NfySYM9O1YARxE54r-izDpDWoWX41z98w@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <94e34d48-aa6f-4c8f-88c8-740cdf406250@vivier.eu>
Date: Fri, 31 Jan 2020 09:37:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8ph4Bt1S7k6NfySYM9O1YARxE54r-izDpDWoWX41z98w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9WY0Y5wrKn/HhhRXadr0zX7AQHG2v+L5TsQW8WUOeWDAkYRzs+N
 Lf1k4VDqJIjBrSWWvoF3ZohSqwP/9Ilfw3rQruQgAQEfnyuOGrCS/EXp/eI79zn//0n0A19
 gHXcXCcxXpxap9ZDBosigVjkxGXG2cIV2knbKiQbYYQzDJmD9ZtZj8w3Gp7C32+H2SXtQYu
 CdaT9paBpctnF6Jj+vIQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nv3HTYD8JsU=:YdWyPR+/yKlTOvd4R6JYSZ
 pf9uRdWCCvILYqe0OtPxH5Qaa6K9j5VQK6UN9VIxKiVBieUat4n0y0n6MA4arw55sXcrhhwP0
 nIL7RYpo1/5u3LKixKfe4oAA23hEhahvEZ56Xgrbm3yIl/mYXhg9zz7uBa0SD1NGNFwj2z5fx
 6W/8F/TqZ+4d09sbEmpb2TCekEAcptP+tq0OgIIcy4f0V/5LMYaEivR7n5G8pfR4ka5dU+gyY
 qjTT1byhrsCG4c58cXoIGEROCQhHzVCa2PT7SxsrFzAyU2UZfMBNEyTQDoFFhyRx22CJCQse4
 Ubt0B0PVxEnZzlDIC8AtNEm4YIF+xuFhKXMpYpRmP/9MVueCi99UKWA/f+RzE/4IZau7Zlfgf
 /k6dWoQgQjTYTv3rVKtboc+k1jyuyB010MQaYFLvdFZCWTabXX42yPwq3tnkIsU3FGK62TucY
 YGTqQhKOJU6TNP6ynX92RaXXpF077x+nS+8GLLNUz/IiwucV6JH/sMh5dgTLHi/3cHR24JuiP
 FEEHqAKA2YCVoTFIpB6T4nuvU5p60LaGlcgPEa6CwUTXVDPyl/ga0d2MypPR8NRKTrvlhee0N
 UjiJdlMRwfntxGBAsRJJ9+u9bBnA4dOfC2YP2qZtfADqddWu4mgSaV5eOiGtHIe1PrSxsBEyF
 igp3M24xmMhe3kZWtYzkym2/i2WHceb1V6dCJGSPTI50VUP0XF1/yZr72Xv+IJ9VIBEL79GJa
 us/DSscALJAoLjv8ax0ola0FhmURNraBpr7qD9xMr2zJwtd8C4dQKc9UcrkeYKUfckGhz3zT5
 FOmNiyosvRweUdDwZjeCfM3tcAqmbGGPPCAVAxYjLNEAvDVogDOiHQo0V7PZ634G7mNzb+3
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
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
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 30/01/2020 à 12:52, Peter Maydell a écrit :
> On Thu, 30 Jan 2020 at 11:20, Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> Le 30/01/2020 à 12:09, Aleksandar Markovic a écrit :
>>> Laurent, all this seems to be dependant on whether you are ready to
>>> mentor the project. Are you?
>>
>> Yes, of course.
>>
>>> The deadline for submitting GSoC/Outreachy projects (within QEMU) is
>>> just around the corner (Feb 1). I leave to Laurent or Peter (should they
>>> give "go" to this proposal) to officially submit the project on our wiki
>>> page created for that purpose, in the form they deem the best.
>>
>> Peter, is it ok for you?
> 
> I don't really have the time to do GSoC mentoring projects;
> if you are willing to do the mentoring then that's great.

No problem. I will. I asked only to be sure you don't see any problem.

Stefan,  I think it's your role to add the project to the wiki page.
Could you?

Thanks,
Laurent


