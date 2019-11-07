Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB296C5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 18:32:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C522721D6C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 18:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C522721D6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSmZw-00089u-Q8
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 13:32:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iSmTn-0002yt-LH
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:26:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iSmTm-0006fc-9h
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:25:59 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:38753)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iSmTk-0006e5-JZ
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:25:58 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M3UhQ-1iTKhv468Q-000coX; Thu, 07 Nov 2019 19:25:46 +0100
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Eric Blake <eblake@redhat.com>
References: <20191028181643.5143-12-laurent@vivier.eu>
 <20191029232320.12419-1-crosa@redhat.com>
 <19097f6f-28a8-12ee-6761-da0f34735910@redhat.com>
 <1209928652.10986630.1573144690743.JavaMail.zimbra@redhat.com>
 <bb0c5db0-899e-c5a6-caa3-add8bf64f780@vivier.eu>
 <77a6200c-7f53-4305-1aad-4574f0faa904@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 0/2] Acceptance test: update kernel used on m68k/q800 test
Message-ID: <bd03703f-26f9-0d3c-fc8b-ba3c5773606c@vivier.eu>
Date: Thu, 7 Nov 2019 19:25:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <77a6200c-7f53-4305-1aad-4574f0faa904@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:93JZH9HuGJe9P+jp/FqK0B7c8r+3IJkv21WUEWJFOh4LHyRadPu
 Si0r8tcOGUjLKoJx9jojHvk20jUs9jDWslBlW0hU1ZHTHDJPSqBFAsde8KL1GoMnKui9oqV
 /D25LqbPhjEK/xS8xxLhN+idkeTcEqlANlzbUKF8ZQCmxBeTchCX60Of5wdUUsoY6pp/2Zj
 RfjHsRoAugREQhMF2PQ6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M0OxjSNz80A=:gH345uEmf+rYRdUySrmcha
 iCz/TEVH93NiamtJqiG3v43yxTeAOGBa5PY7EpDxq+nE8BWYRpnPGd62cjv8YmqqI+ASp1djX
 fx9r+/5+SPcVeuYdnL8bToUHwgKEmNZYvavA0OkHfDu0pLbrE+h8POrUgZqPZtwBDTMA7KlID
 USK6WjxGz1r65s+8b4AlG8qgPCZIng94S7TwrjFu4vHPgUEj5rJED92u+qou0G1Zz9IEvWMr3
 3HnrtjcySY20Ppj7LRIPBCQahm5XVhDm23kaabSquCK7Ir/MPy21AFHfxcyNed5XYfn3zokMt
 /l4q0ISbAJ6+ILTkCEs1/PvckxpLzIKFALe75HRyqqNMU0qFKeStj5/2JHX774EqHouJWfaZv
 dc66+tRALB9KlkFQ7s6Egv4kltEVoUpFGGDh/sdtDBHsujhCWUdCrYAL+DkVdyFT50BPT5C0q
 FA5mAsSLyvRlguJB65NO6ONKnM4GhDqliVpmgTwh1KAWbQD5v0YgUbTSA618Wa6rbPUnWX3OF
 1eNz8/zGYX4bas8xPz8PKt1OCViWC7WmqhkGmVoKhQTPC/HA/CbaEld2THU9yPsvCRqikDpgP
 4a9YbV3+Srn7DI9lwEqvdBBGnlgaPj6clfngatJM7wRraww6T2XYmwmk+AjZTmKROLCKwu3FQ
 RM/BANcaJtRCDP6nTFXzbxBzwM/Gcs/c5c6zEE2OFPKu3UCH+Ue2bphjrquMG7shVvcJtFvbZ
 ov75BDq+IfEHFVU++XCzXd0L4bcfXb4bASQnuVS9XnUMCvwkEcr+DijewnNu9qgu+MqdleBUw
 U1uBkJ9iRE6C8b2oKi/70PYqNnU9CJSqyjzksYaAxvMsH2WgJDL30/iVmATzivfJAvgcmBq6z
 o0tv86H+gjfGWhqRbq5kl34a6D/D6fJFIYIa3cMfU=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.10
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
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Willian Rampazzo <wrampazz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 07/11/2019 à 19:00, Philippe Mathieu-Daudé a écrit :
> On 11/7/19 6:18 PM, Laurent Vivier wrote:
>> Le 07/11/2019 à 17:38, Cleber Rosa a écrit :
>>> ----- Original Message -----
>>>> From: "Eric Blake" <eblake@redhat.com>
>>>> To: "Cleber Rosa" <crosa@redhat.com>, qemu-devel@nongnu.org
>>>> Cc: "Peter Maydell" <peter.maydell@linaro.org>, "Eduardo Habkost"
>>>> <ehabkost@redhat.com>, "Philippe Mathieu-Daudé"
>>>> <f4bug@amsat.org>, "Wainer dos Santos Moschetta"
>>>> <wainersm@redhat.com>, "Laurent Vivier" <laurent@vivier.eu>,
>>>> "Willian Rampazzo" <wrampazz@redhat.com>, "Philippe Mathieu-Daudé"
>>>> <philmd@redhat.com>
>>>> Sent: Thursday, November 7, 2019 10:43:08 AM
>>>> Subject: Re: [PATCH 0/2] Acceptance test: update kernel used on
>>>> m68k/q800 test
>>>>
>>>> On 10/29/19 6:23 PM, Cleber Rosa wrote:
>>>>> The boot_linux_console.py:BootLinuxConsole.test_m68k_q800 was very
>>>>> recently merged, but between its last review and now, the Kernel
>>>>> package used went missing.
>>>>>
>>>>
>>>> meta-question: Why was this series posted in-reply-to the pull request,
>>>> rather than as a new top-level thread? I nearly missed it because I
>>>> don't expect to see unreviewed patches buried in threading like that.
>>>> My workflow would have been to post the series in isolation, then
>>>> manually reply to the pull request to mention the message-id of the
>>>> related series proposed as a followup.
>>>>
>>>
>>> Hi Eric,
>>>
>>> That was my attempt to signal that it was a fix to something which
>>> had *just*
>>> being merged as part of that pull request (though now caused by it).
>>>
>>> I basically did not know how to act properly, so I thank you for the
>>> workflow
>>> suggestion.  I'll certainly follow it next time.
>>
>> IMHO, you should send your series and then replies to the pull request
>> to tell you have sent your series that fixes the patch in the pull
>> request, or vice-versa.
>>
>> But your series has been queued by Alex, so there is no problem...
> 
> I prepared a different fix around the same time, but closed my laptop
> before the patch was sent and noticed the next day:
> https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg08120.html
> 
> Laurent, are you OK with the new kernel being tested?
> 

I'm fine. We could have problems with 5.4 because the address mapping
has been changed for SWIM (aee6bff1c325 "m68k: mac: Revisit floppy disc
controller base addresses), but this has been fixed by my patch that has
been merged today in QEMU (653901ca2b  "q800: fix I/O memory map").

Thanks,
Laurent


