Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56C7C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 07:54:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FF09208B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 07:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF09208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqu3e-00019N-Sn
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 03:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1jqu2x-0000I4-63
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 03:54:15 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:49423)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1jqu2u-0002HF-Pd
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 03:54:14 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0E9914000F;
 Thu,  2 Jul 2020 10:54:02 +0300 (MSK)
Received: from [192.168.177.99] (mjt.vpn.tls.msk.ru [192.168.177.99])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8637E6D;
 Thu,  2 Jul 2020 10:54:01 +0300 (MSK)
Subject: Re: [PATCH v3] ati-vga: check address before reading configuration
 bytes (CVE-2020-13791)
To: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200604105524.46158-1-ppandit@redhat.com>
 <20200604074539-mutt-send-email-mst@kernel.org>
 <88d6e41e-c486-4a35-af43-84018491071f@redhat.com>
 <20200604075931-mutt-send-email-mst@kernel.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <1157d3ab-9c97-85a8-7700-4faccfa0941e@msgid.tls.msk.ru>
Date: Thu, 2 Jul 2020 10:54:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200604075931-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:54:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, Yi Ren <c4tren@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Ren Ding <rding@gatech.edu>,
 pbonzini@redhat.com, Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Please excuse me for top-posting, I want to preserve somewhat old context]

So, is this CVE-2020-13791 issue fixed by the fix for CVE-2020-13754,
by this commit:
 https://git.qemu.org/?p=qemu.git;a=commit;h=5d971f9e672507210e77d020d89e0e89165c8fc9

?

Thanks,

/mjt

04.06.2020 15:00, Michael S. Tsirkin wrote:
> On Thu, Jun 04, 2020 at 01:56:45PM +0200, Philippe Mathieu-DaudÃ© wrote:
>> On 6/4/20 1:49 PM, Michael S. Tsirkin wrote:
>>> On Thu, Jun 04, 2020 at 04:25:24PM +0530, P J P wrote:
>>>> From: Prasad J Pandit <pjp@fedoraproject.org>
>>>>
>>>> While reading PCI configuration bytes, a guest may send an
>>>> address towards the end of the configuration space. It may lead
>>>> to an OOB access issue. Add check to ensure 'address + size' is
>>>> within PCI configuration space.
>>>>
>>>> Reported-by: Ren Ding <rding@gatech.edu>
>>>> Reported-by: Hanqing Zhao <hanqing@gatech.edu>
>>>> Reported-by: Yi Ren <c4tren@gmail.com>
>>>> Suggested-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
>>>
>>> BTW, this only happens on unaligned accesses.
>>> And the IO memory region in question does not set valid.unaligned
>>> or .impl.unaligned.
>>>
>>> And the documentation says:
>>>
>>> - .valid.unaligned specifies that the *device being modelled* supports
>>>   unaligned accesses; if false, unaligned accesses will invoke the
>>>   appropriate bus or CPU specific behaviour.
>>>
>>> and
>>>
>>> - .impl.unaligned specifies that the *implementation* supports unaligned
>>>   accesses; if false, unaligned accesses will be emulated by two aligned
>>>   accesses.
>>>
>>> Is this then another case of a memory core bug which should have either
>>> failed the access or split it?
>>
>> Related:
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg695362.html
>> earlier comment:
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg694805.html
> 
> Yea looks like more devices following documentation and memory core
> doing something else instead.
> 
>>>
>>>> ---
>>>>  hw/display/ati.c | 4 +++-
>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> Update v3: avoid modifying 'addr' variable
>>>>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00834.html
>>>>
>>>> diff --git a/hw/display/ati.c b/hw/display/ati.c
>>>> index 67604e68de..b4d0fd88b7 100644
>>>> --- a/hw/display/ati.c
>>>> +++ b/hw/display/ati.c
>>>> @@ -387,7 +387,9 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
>>>>          val = s->regs.crtc_pitch;
>>>>          break;
>>>>      case 0xf00 ... 0xfff:
>>>> -        val = pci_default_read_config(&s->dev, addr - 0xf00, size);
>>>> +        if ((addr - 0xf00) + size <= pci_config_size(&s->dev)) {
>>>> +            val = pci_default_read_config(&s->dev, addr - 0xf00, size);
>>>> +        }
>>>>          break;
>>>>      case CUR_OFFSET:
>>>>          val = s->regs.cur_offset;
>>>> -- 
>>>> 2.26.2
>>>
> 
> 


