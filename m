Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB234C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:39:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C08482065F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C08482065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsl0g-00046T-2C
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 06:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jskzU-0002VT-KW; Tue, 07 Jul 2020 06:38:20 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:39371)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jskzS-00069j-LU; Tue, 07 Jul 2020 06:38:20 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MUooJ-1kJOh041dB-00Qo0x; Tue, 07 Jul 2020 12:38:12 +0200
Subject: Re: [PATCH] hw/core/null-machine: Do not initialize unused chardev
 backends
From: Laurent Vivier <laurent@vivier.eu>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, qemu-devel@nongnu.org
References: <20200624105611.1049-1-f4bug@amsat.org>
 <bd458cb8-e005-0ea9-bbaf-bcb541bfdc89@redhat.com>
 <2631a1b9-a501-8633-6dbd-37fce4b116bd@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <acb0a747-148f-c739-e625-d213d23ed40a@vivier.eu>
Date: Tue, 7 Jul 2020 12:38:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <2631a1b9-a501-8633-6dbd-37fce4b116bd@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NFYHeTuEBzgG0ktWmf7fzCoSQyCp4yM0HVUjd/yPS9+VkfAsJN/
 dKIIllf6uu3QqNkidhOTK0WTyeEf7E32lGEGhq/e0XdZyn+GwigMvHvnF8CAjISoXhbMOhA
 6tI2A/ES5CuZKjbmLg7481s6KiF4c7YlosVXw0eirj524TMzSs+Ljvp4RTfA9liiSW9jBqp
 p3Niigy66ACb1Vouub6WQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m5FsKqhW3rg=:8FzTEsq24aeNEpVSQEBGcS
 vaqfCIYZT2Sp8aJDGIbee+BZ0oVOkriDWgP9iaCXO8Fr8XkhU9dGmW4Tq1OyZpTkXoWwdyYqZ
 HL4shYjOPa7u9ILUGZowFGk1+dxrJf7gcuOBy71uANZ50umooidXkggJCEB/tuqs1n/MErAP4
 EBgvPRCRvNk9uC7nBXteCHT/ZUPNyvpHBVgxGJ6jBen/SIPz3KY88hySD/dH0flcDSzBV5MVZ
 AH7NfmfMiB3jp4ZpXhs6KeJMfswwNs5ATPrSi+94IYhctKmPEr1AWx19YxSeCZ1THW+1pBvYj
 +x8/MCrmP5zrhexLze4v0/AneziswgCkfDQ+ycywa3WBVCCvPHbPnJ/3W/0V96v+V3kNMaRpG
 okhsY8XR2pg9fZVWfyrVoAvixwe7nU9vW9Ci+JuoPkDtWApKgLDby//zshgNOw9FMdWocCEyn
 F+IH3mry/WStbch4hxiI60Tjw4k848PijXS8TeEX3AD7z2+GkfcTaYHw4MJalTl1jFeJhV0h/
 NmcTMniLANynhxyRnhkihDBfEP0/mLGoNS3e0NqzemSJiW/Idst5wo2xLwlwmoi6gOgRC84uU
 ZawmOMyq4vXiMVGPonjK66hyWappUvJoG8SgBgAeEGAvxzO61vTmP5r1j0GUtF0d3B2fkM1CE
 vHiSbGkkVjr9lf74/WZ2n2XEDg3YDmAGZur6q9NCAVzdKRpE3ghQKD1WBFBmPD9diqSkzbAqV
 jWGUA87KbHQdMJ/3PMABDl0AEOFzHz2G5+gsB1u+I0DQbudQVZJGIOZQbgjh0Z6p61A6b1zAo
 wwXSnmz6tDVx4Ah40B3au1Dovl3AfeUAtWocfI84inC4DE87uYEEN07e5XqQSD8QwsKGeEM
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 06:38:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 06/07/2020 à 18:24, Laurent Vivier a écrit :
> Le 24/06/2020 à 13:01, Thomas Huth a écrit :
>> On 24/06/2020 12.56, Philippe Mathieu-Daudé wrote:
>>> The MachineClass uses an inverted logic (inherited from the
>>> PC machines [*]) to create the chardev backends for the default
>>> devices (see commits 998bbd74b9d..aa40fc9c964 and ac33f8fad14).
>>>
>>> As the none-machine doesn't have any hardware device, it is
>>> pointless to initialize chardev backends. Fix by setting the
>>> 'no_defaults' bits in its MachineClass.
>>>
>>> Suggested-by: Thomas Huth <thuth@redhat.com>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>>   hw/core/null-machine.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
>>> index cb47d9d4f8..7e693523d7 100644
>>> --- a/hw/core/null-machine.c
>>> +++ b/hw/core/null-machine.c
>>> @@ -50,6 +50,11 @@ static void machine_none_machine_init(MachineClass
>>> *mc)
>>>       mc->max_cpus = 1;
>>>       mc->default_ram_size = 0;
>>>       mc->default_ram_id = "ram";
>>> +    mc->no_serial = 1;
>>> +    mc->no_parallel = 1;
>>> +    mc->no_floppy = 1;
>>> +    mc->no_cdrom = 1;
>>> +    mc->no_sdcard = 1;
>>>   }
>>>     DEFINE_MACHINE("none", machine_none_machine_init)
>>>
>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>
>>
> 
> Applied to my trivial-patches-for-5.1 branch.

Removed as it is in Paolo's PR.

Thanks,
Laurent


