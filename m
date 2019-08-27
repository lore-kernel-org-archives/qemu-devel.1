Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B02FC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 19:05:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42F6221881
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 19:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F6221881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2gmI-0003XR-FP
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 15:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34713)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1i2glS-00033O-T0
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 15:04:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1i2glR-0008D5-Bd
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 15:04:22 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:59747)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1i2glR-0008C5-5I
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 15:04:21 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 7D67B74F7D4;
 Tue, 27 Aug 2019 21:04:17 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E7B9E7456B4; Tue, 27 Aug 2019 21:04:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DFC3B74569A;
 Tue, 27 Aug 2019 21:04:16 +0200 (CEST)
Date: Tue, 27 Aug 2019 21:04:16 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <64b614b6-cb05-bd16-dd0b-1ffbdc7db94a@linaro.org>
Message-ID: <alpine.BSF.2.21.9999.1908272102050.12437@zero.eik.bme.hu>
References: <1566898663-25858-1-git-send-email-stefan.brankovic@rt-rk.com>
 <1566898663-25858-2-git-send-email-stefan.brankovic@rt-rk.com>
 <64b614b6-cb05-bd16-dd0b-1ffbdc7db94a@linaro.org>
User-Agent: Alpine 2.21.9999 (BSF 287 2018-06-16)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
Subject: Re: [Qemu-devel] [PATCH v6 1/3] target/ppc: Optimize emulation of
 vpkpx instruction
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
Cc: Stefan Brankovic <stefan.brankovic@rt-rk.com>, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 27 Aug 2019, Richard Henderson wrote:
> On 8/27/19 2:37 AM, Stefan Brankovic wrote:
>> +    for (i = 0; i < 4; i++) {
>> +        switch (i) {
>> +        case 0:
>> +            /*
>> +             * Get high doubleword of vA to perfrom 6-5-5 pack of pixels
>> +             * 1 and 2.
>> +             */
>> +            get_avr64(avr, VA, true);
>> +            tcg_gen_movi_i64(result, 0x0ULL);
>> +            break;
>> +        case 1:
>> +            /*
>> +             * Get low doubleword of vA to perfrom 6-5-5 pack of pixels
>> +             * 3 and 4.
>> +             */
>> +            get_avr64(avr, VA, false);
>> +            break;
>> +        case 2:
>> +            /*
>> +             * Get high doubleword of vB to perfrom 6-5-5 pack of pixels
>> +             * 5 and 6.
>> +             */
>> +            get_avr64(avr, VB, true);
>> +            tcg_gen_movi_i64(result, 0x0ULL);
>> +            break;
>> +        case 3:
>> +            /*
>> +             * Get low doubleword of vB to perfrom 6-5-5 pack of pixels

If this is replaced by Richard's suggested version it does not matter but 
there's a typo in above comments. Probably you've meant perfrom -> perform

Regards,
BALATON Zoltan

