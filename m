Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7D2CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 08:57:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFE50206F5
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 08:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE50206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYnCU-0001ST-UV
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 04:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jYnBu-0000sV-C7; Wed, 13 May 2020 04:56:38 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:59039)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jYnBs-0007rQ-Mi; Wed, 13 May 2020 04:56:38 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MYehP-1jcNpJ3H5H-00VeSN; Wed, 13 May 2020 10:56:26 +0200
To: Tomas Krcka <tomas.krcka@gmail.com>
References: <20200506132114.76406-1-tomas.krcka@gmail.com>
 <5cf6dee4-7bfa-76b2-9f44-14bfc7f3d510@vivier.eu>
 <CAOtnYZPj9h10OLYB0RoPASubNXQNwBfSY415i7FafXs0AgXOrQ@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 1/2] linux-user: add do_setsockopt SOL_CAN_RAW
 CAN_RAW_FILTER support
Message-ID: <515be10e-891a-ff31-fbc3-9ea0518198e9@vivier.eu>
Date: Wed, 13 May 2020 10:56:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAOtnYZPj9h10OLYB0RoPASubNXQNwBfSY415i7FafXs0AgXOrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yJF4MOndoqxzm3YEnh7JVbq/dWHcBSMo2ykDWibLRoX92vfHaI4
 i9VSQetal7UtqKHb+MuzXfYct9kuWK+yc+AmaRktKXR3YQkcrB15LMyBIJ112ja3Sk8IA5K
 7WK5CdgRywtv6mIRP3uShZuq4iPm5CvS3TOrZaQEzRUdDnVeKq5LzQbv4wVA3uDPulu0ZZC
 pGCCJpV2f9n0hnpsejGdA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Foj40oW1CLg=:XyOz7tdTOyBv3X5ckzyhtV
 a35pgAvepRfyISBOHK3KZ9UBdjCZ9XE0JbnDuJmYlzdaAWx85gncbLRtsjnHkL2/SkhvoPobh
 qzfupqZtLlcJ9tqx0l/L2tFbwQ0JzeSodpBT8bAIAO+GArPCFXLvG2r9XK5LqOTSsmFgFYeWA
 +Py5f1KS5jAeKno0PJ2u6YIAWuvJjcsjH9KpWBa+/GdOkk5RIpMnoNBqSDCtu2ywWCq3j4etk
 lGlX2sJnOy9GLwGERt0hi65d0tYTmxJDtVszsK5E8PpaU+WL1k+juC59Rs35TMTf7o7XI7dxE
 Vq3Az6u7t4NiPn7zlPk76zhMozRJSMuEnw3R4Ky0Ae4oNYVc36ZJQLa+DYf0+ixTMagK650Mo
 GVCjNfeftOEE1yTvMR3dCPAIzWLgCshbLzgfp4EUElT8ybXChS/J61IWBQY0I7VCa2yBW/gHK
 juOOID6XBzlfvUeei8N28EBUSZQ5zZlJqMGhtvLgQraMGnGD35hEkvdGisSzzVzT+C8Ji3ob4
 kSeZf9Hrt+ezkEjT1ouneppx7rHO0kVWT+D+72Q3zIF2w3mncL7r68O9bl4xtMGy+ZXh9+aKT
 73DOpcW3Nvyer+ft36ORvj/0yg7Wvzc5nOdJ6sKQpn3RTLMa4nIBQxGkVizCtzw81K5ykrPjW
 5GUe05W+WP2e3T8Nrzfi75xHN19ZBv+NiKFQSDzpAS3Je8lQ7WMzh7K7v9TzelNArRNbKy8gx
 7L3s7ajepRw7OaEVsOhJUAITeetNn50ZwO753Jv7vD1dy3E6BPaASDxtUmnG+9tUCLSSRGAW2
 KXvrE09ImCfR0bYX09EYEGBbHf59fwDa1Uf4C+M84QGlReQppAeFzxjyUZqqZeKuAaa9n58
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 04:56:34
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 12/05/2020 à 23:05, Tomas Krcka a écrit :
> Am Di., 12. Mai 2020 um 22:09 Uhr schrieb Laurent Vivier <laurent@vivier.eu>:
>>
>> Le 06/05/2020 à 15:21, Tomas Krcka a écrit :
>>> Signed-off-by: Tomas Krcka <tomas.krcka@gmail.com>
>>> ---
>>>  linux-user/syscall.c | 34 ++++++++++++++++++++++++++++++++++
>>>  1 file changed, 34 insertions(+)
>>>
>>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>>> index 05f03919ff..88d4c85b70 100644
>>> --- a/linux-user/syscall.c
>>> +++ b/linux-user/syscall.c
>>> @@ -56,6 +56,7 @@
>>>  #include <linux/wireless.h>
>>>  #include <linux/icmp.h>
>>>  #include <linux/icmpv6.h>
>>> +#include <linux/can/raw.h>
>>>  #include <linux/errqueue.h>
>>>  #include <linux/random.h>
>>>  #ifdef CONFIG_TIMERFD
>>> @@ -2111,6 +2112,39 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
>>>              goto unimplemented;
>>>          }
>>>          break;
>>> +    case SOL_CAN_RAW:
>>> +        switch (optname) {
>>> +        case CAN_RAW_FILTER:
>>> +        {
>>> +            if (optlen % sizeof(struct can_filter) != 0) {
>>> +                return -TARGET_EINVAL;
>>> +            }
>>> +
>>> +            struct can_filter  *can_filters = NULL;
>>
>> Move the declaration to the top of the block.
>>
>>> +            if (optlen != 0) {
>>
>> If you check, like in kernel, "optlen > CAN_RAW_FILTER_MAX *
>> sizeof(struct can_filter)", you can exit here (and no need to set
>> can_filters to NULL).
>>
> 
> The optlen can be 0 and then the can_filter shall be NULL, based on
> the socketcan
> documentation.

Yes, you're right I misread the kernel code.

But check optlen is lesser than "CAN_RAW_FILTER_MAX * sizeof(struct
can_filter)" to avoir too big g_new0() allocation.

And in fact "g_new0()" is wrong in your code: optlen is the byte size,
not the number of entries. You should use g_malloc0(optlen).

> And an additional question, shall I check if optlen is 1 and then use
> non-dynamic allocated
> filters, as it's done in kernel?

No, keep the code as simple as possible.

Thanks,
Laurent

