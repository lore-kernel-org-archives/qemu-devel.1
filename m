Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7F7C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 01:09:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0AD420739
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 01:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0AD420739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtL3w-0002GJ-T2
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 21:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jtL3N-0001ns-7i
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 21:08:45 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:60240)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jtL3K-0004aE-1m
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 21:08:43 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 1CF7C74594E;
 Thu,  9 Jul 2020 03:08:32 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8EBDD745712; Thu,  9 Jul 2020 03:08:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8D49F7456F8;
 Thu,  9 Jul 2020 03:08:31 +0200 (CEST)
Date: Thu, 9 Jul 2020 03:08:31 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] ossaudio: fix out of bounds write
In-Reply-To: <4591613b-067d-ac5d-99d0-d8b7a3cf0ce1@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2007090257410.84890@zero.eik.bme.hu>
References: <20200707180836.5435-1-vr_qemu@t-online.de>
 <4591613b-067d-ac5d-99d0-d8b7a3cf0ce1@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-284666008-1594256911=:84890"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 21:08:32
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?ISO-8859-2?Q?Zolt=E1n_K=F5v=E1g=F3?= <dirty.ice.hu@gmail.com>,
 =?ISO-8859-15?Q?Volker_R=FCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-284666008-1594256911=:84890
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 8 Jul 2020, Philippe Mathieu-Daudé wrote:
> On 7/7/20 8:08 PM, Volker Rümelin wrote:
>> In function oss_read() a read error currently does not exit the
>> read loop. With no data to read the variable pos will quickly
>> underflow and a subsequent successful read overwrites memory
>> outside the buffer. This patch adds the missing break statement
>> to the error path of the function.
>
> Correct, but ...
>
>>
>> To reproduce start qemu with -audiodev oss,id=audio0 and in the
>> guest start audio recording. After some time this will trigger
>> an exception.
>>
>> Fixes: 3ba4066d08 "ossaudio: port to the new audio backend api"
>>
>> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
>> ---
>>  audio/ossaudio.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/audio/ossaudio.c b/audio/ossaudio.c
>> index f88d076ec2..a7dcaa31ad 100644
>> --- a/audio/ossaudio.c
>> +++ b/audio/ossaudio.c
>> @@ -691,6 +691,7 @@ static size_t oss_read(HWVoiceIn *hw, void *buf, size_t len)
>>                             len, dst);
>>                  break;
>>              }
>> +            break;

Maybe it would be less confusing if you converted the switch(errno) to an 
if then you wouldn't have two senses of break; in close proximity. I was 
thinking something like

if (nread == -1) {
     if (errno != EINTR && errno != EAGAIN) {
         logerr();
     }
     break; /* from while, which is now clear */
}

>>          }
>>
>>          pos += nread;
>
> ... now pos += -1, then the size returned misses the last byte.

Don't you break from loop in if () above this so -1 is never added to pos 
after this patch? What happens for EINTR and EAGAIN? Now we break from the 
loop for those too, should it be continue; instead?

Regards,
BALATON Zoltan
--3866299591-284666008-1594256911=:84890--

