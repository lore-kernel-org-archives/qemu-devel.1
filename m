Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10416C04E87
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 20:19:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB1E2183F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 20:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB1E2183F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58970 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTBDv-0003hu-2H
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 16:18:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTBBl-0002Sq-31
	for qemu-devel@nongnu.org; Tue, 21 May 2019 16:16:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTBBh-00033c-57
	for qemu-devel@nongnu.org; Tue, 21 May 2019 16:16:45 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:35327)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hTBBg-00030d-SP
	for qemu-devel@nongnu.org; Tue, 21 May 2019 16:16:41 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MvrVJ-1gcAuu3FRP-00suNA; Tue, 21 May 2019 22:16:07 +0200
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>
References: <1557953433-19663-1-git-send-email-pbonzini@redhat.com>
	<1557953433-19663-19-git-send-email-pbonzini@redhat.com>
	<20190521115259.GK25835@redhat.com>
	<f0d7e267-5f21-927a-ee38-2330fde5a419@redhat.com>
	<20190521125408.GL25835@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <9d0def85-3e5c-71ca-0e25-e07fbc7d90c2@vivier.eu>
Date: Tue, 21 May 2019 22:16:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190521125408.GL25835@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bAMY4SBMqxyPylYSTBroRXIqgVOytJ5bxQArdEWtlYHJHMUv0mG
	gsV1ZMXXcBHKxECSvgaUCil9+R2BRzUGD74ZhIJEkehf3z09TlvV+Od6ffLJ05ksphr8jh3
	vTxUTlZfXhPhNTIytnJ+VDlKKwz9IojOOEar1U0PrQMm+9DLrnOFwpZZ+ltepPVhGVGtN4U
	ID3sXniMDmkMUzzZLpZ1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GQ832xHr7KU=:pceUZi9+yFcE4SdN2qY47j
	wiAbxHpRgjeU2B4A+VKdZwHSZ+nT2j48HEbJmRvN2CL/qvTYwkIFmRTnx8r9ToR3EimLtDv0i
	HVJ0t5DrFUquqsWRn6r/WbkCfb4TKPBq7/kaOS3wrFMjdJSUBowHQdgsgFXSu/aqM4QjS9cJ5
	nllDBGYmM/pY5xQcirR1Vjp2xlnVhIQeLeABkAg7/86DZPSqYYJ4l6gPOzdpeMS3X+AmotsQ7
	lPecXTn1hYB4ZgwpuLGYu5oAVZrBwa3bUhBZbdGMRmE69XRIp3HWmuPDSJ7rpItLBmBclvkx7
	U3uFU+tJo3wI8KWhalO2I7pV9hcoxeQ2kZRTUdIHIYqSmVGXbWKuXKJqE8YKEp3nUvW3vpcMW
	4K6hKaPRL7L+9aSYnN4tLZvpuR6THrrDhRbn9OoYG2ydEJLjhPvtfDx/fWbVsFgFQp0X4THc8
	lGGWctISinBVAcdCHS7TLZHL5Y8dhAfk7rRrCG1qWMipR2gLL2764IdeQw1R3hPHKz6pyJGd/
	4kJuG1FFVMLTy+4fYsMP8vZVCFkOxDjksBdDV5YsOIg5GjMdhiEXBq75jiVbuYZLceF51iwmC
	VrsXiH3cyS+44UQFl3mbMKk1sIzqIK9pbzF26fe6mj4XCoAs2oElvQnW1BeFIcExV1FAIGR2Y
	FTvwfIEYLo9+6Q5J9vboKhpg12ibQ8ZUoATnGdqpduvQdlJqo6jO8IggMmT5P3pYlsQzGGHcb
	v1kZks0BE+4aSFxn9ifk6xHDt0KlTTpqknMQ5wKqnhRcVZA7uNOYIpEm004=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
Subject: Re: [Qemu-devel] [PULL 18/21] build: don't build hardware objects
 with linux-user
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/05/2019 14:54, Daniel P. Berrangé wrote:
> On Tue, May 21, 2019 at 02:52:42PM +0200, Laurent Vivier wrote:
>> On 21/05/2019 13:52, Daniel P. Berrangé wrote:
>>> On Wed, May 15, 2019 at 10:50:30PM +0200, Paolo Bonzini wrote:
>>>> From: Laurent Vivier <lvivier@redhat.com>
>>>>
>>>> Some objects are only needed for system emulation and tools.
>>>> We can ignore them for the user mode case
>>>>
>>>> Update tests to run accordingly: conditionally build some tests
>>>> on CONFIG_BLOCK.
>>>>
>>>> Some tests use components that are only built when softmmu or
>>>> block tools are enabled, not for linux-user. So, if these components
>>>> are not available, disable the tests.
>>>>
>>>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>>>> Message-Id: <20190401141222.30034-6-lvivier@redhat.com>
>>>> ---
>>>>    Makefile               |  4 +++
>>>>    Makefile.objs          | 14 +++++---
>>>>    tests/Makefile.include | 90 +++++++++++++++++++++++++-------------------------
>>>>    3 files changed, 58 insertions(+), 50 deletions(-)
>>>>
>>>> diff --git a/Makefile b/Makefile
>>>> index 1851f8c..155f066 100644
>>>> --- a/Makefile
>>>> +++ b/Makefile
>>>> @@ -87,6 +87,10 @@ endif
>>>>    include $(SRC_PATH)/rules.mak
>>>> +# notempy and lor are defined in rules.mak
>>>> +CONFIG_TOOLS := $(call notempty,$(TOOLS))
>>>> +CONFIG_BLOCK := $(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS))
>>>
>>> IMHO calling this CONFIG_BLOCK is a really poor choice, as
>>> the decision is completely unrelated to block modules. It
>>> made really confused when trying to understand why all the
>>> crypto or auth code had been made conditional on the block
>>> drivers.  The block code is just one part of QEMU that
>>> is used in tools & softmmu.
>>>
>>> It would be better as CONFIG_SOFTMMU_TOOLS, or
>>> CONFIG_NOT_USER, or something else.
>>
>> Do you think it's worth a patch to change the name?
> 
> Personally I'd like to see a patch to give it a better name.

I'm wondering which name to use.

CONFIG_NOT_USER is not correct because the flag can be 'y' with 
CONFIG_USER_ONLY set.
CONFIG_SOFTMMU_TOOLS is too fuzzy.

CONFIG_HW ?
CONFIG_IO ?
CONFIG_DEVICE ?

Thanks,
Laurent

