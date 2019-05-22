Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42940C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 15:41:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B3D220881
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 15:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B3D220881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46170 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTTNE-0008UG-5E
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 11:41:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTTL1-0006Ra-Gd
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:39:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTTJL-0001ir-Nr
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:37:48 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:34747)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hTTJJ-0001YH-G9; Wed, 22 May 2019 11:37:45 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MYvPq-1h7O4g3eam-00Unup; Wed, 22 May 2019 17:37:15 +0200
To: Antonio Ospite <antonio.ospite@collabora.com>,
	Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>
References: <20190503082728.16485-1-ao2@ao2.it>
	<20190503082728.16485-3-ao2@ao2.it>
	<541bfc5c-0e45-58e6-f0b1-81e9b0c8881d@redhat.com>
	<CAFEAcA8An-KWOc3gOz2=45eCHCmUJEJw_bTrrCW6bYO23H8TPw@mail.gmail.com>
	<a5f95284-2883-e6c0-54ad-d0ff018f68d7@vivier.eu>
	<9349da74-b4a1-932d-227a-a63df1bb63a5@collabora.com>
	<87d49db7-68c7-7c2e-7464-47e335013e58@vivier.eu>
	<ef62c3b1-c01d-8480-20c0-36dd38bb6c8c@collabora.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <ab8fc3ae-cb39-e032-eccf-e6ffface13dc@vivier.eu>
Date: Wed, 22 May 2019 17:37:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <ef62c3b1-c01d-8480-20c0-36dd38bb6c8c@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gkAdrMjluT1UmBRE/jO+3J9yiMH5oMpkzfRE88nUY/a9conYZec
	pH/ns7NeHQjy87V56mxwn1tBaaVg75htq0vDiHA8ZA/B8efhOpvDdVxvNAs2AZFdAUpdfRU
	QdaV5Hb4OfN7RhBBYHycr3cdeJzqCePeopyI4iT/yRFKSWhpmB3V6LYb65axB/yWVGo7uRf
	ugXGTXjvZfX8iywmlIaAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z4Zy7+03s4Q=:hFWP9u9wIwvVs0yK30Ise1
	i14XWBqVKp87LVamZZULjMh5egXu26zIFa4bIQ12w5aaPLPG+9EuyVEDXPSxvZ9ZZlEbNH+xP
	USYwPGqEzVXtZObhVSEbEKKpHat6uT1TCRv1tyZ6IOHDkZEaWaoFCNe+HlWSup8YjtNT3Xeey
	HpDcs/lhLBeus0Jma3FTgdWwtCenA5zQ4W/3lheaB0XtouqfbO38o5jYJYQLkzVL9QlcQvNJ6
	tSOaFxUquaqZrvIGxygrqGarP46CsOUwDQGSi0SBp6ZzuX7OFQl84gGA2HSFkFxLbRtnOG3A6
	5nckb98UTVAPD3SDyamvYHUIPDLtdjSUHwA0HdrMoPYTAV55+xSKgi3FkFCWW7Zs2upQj4Lpj
	3ruQcV04H5XLe+b3FLJ2K8uguN6nYyyTw7SuDtqYp3Y5E0skIF1i9Vp1MnOT5oX3IV1d2r0b0
	Crhj/QBHxsIsvP5Bb5lrA+2tm5qjiDic15EhiJAEMK42/+3nyLxBonqT9UD2ZeaaYhtXRkK38
	fJm0dpOizkAVoreKvf6QPLELpLjIyYuUZwaokfziFDpCzBPegVZGgzip1UXN6ovBebJMYDfWd
	Q3ffrZveglSFrb6pizQ912uSLfQrdtniGn6xG1OS805vOWBPkD2CbJALhrrYpof9UEx/FNO7W
	7uONUpqBik2YcbaWadgvU6LnSjOkaSKUhs4dLHfrk5gXafVOK8n45KlxCxToqj5vMXlwGY/8+
	k3o0YdEerAWARudbdC+LWQVdc7FOZKXF6d2JeAnxNBj7VTMCBhPic+wocxqK6BJvvwZ4m/ryR
	clHUlbqJKsHz4K42g/PDRz4+00Mfzz+6JESaJuMnmK92RvZnJXqedbjSui9N0jbfi773QXC
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v2 2/2] configure: disallow
 spaces and colons in source path and build path
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Antonio Ospite <ao2@ao2.it>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/05/2019 17:26, Antonio Ospite wrote:
> On 22/05/19 17:21, Laurent Vivier wrote:
>> On 22/05/2019 17:01, Antonio Ospite wrote:
>>> On 22/05/19 15:57, Laurent Vivier wrote:
>>>> On 09/05/2019 16:42, Peter Maydell wrote:
>>>>> On Mon, 6 May 2019 at 18:27, Eric Blake <eblake@redhat.com> wrote:
>>>>>>
>>>>>> On 5/3/19 3:27 AM, Antonio Ospite wrote:
>>>>>>> From: Antonio Ospite <antonio.ospite@collabora.com>
>>>>>>>
>>>>>>> The configure script breaks when the qemu source directory is in 
>>>>>>> a path
>>>>>>> containing white spaces, in particular the list of targets is not
>>>>>>> correctly generated when calling "./configure --help" because of 
>>>>>>> how the
>>>>>>> default_target_list variable is built.
>>>>>>>
>>>>>>> In addition to that, *building* qemu from a directory with spaces 
>>>>>>> breaks
>>>>>>> some assumptions in the Makefiles, even if the original source 
>>>>>>> path does
>>>>>>> not contain spaces like in the case of an out-of-tree build, or when
>>>>>>> symlinks are involved.
>>>>>>>
>>>>>>> To avoid these issues, refuse to run the configure script and the
>>>>>>> Makefile if there are spaces or colons in the source path or the 
>>>>>>> build
>>>>>>> path, taking as inspiration what the kbuild system in linux does.
>>>>>>>
>>>>>>> Buglink: https://bugs.launchpad.net/qemu/+bug/1817345
>>>>>>>
>>>>>>> Signed-off-by: Antonio Ospite <antonio.ospite@collabora.com>
>>>>>>> ---
>>>>>>>   Makefile  | 4 ++++
>>>>>>>   configure | 6 ++++++
>>>>>>>   2 files changed, 10 insertions(+)
>>>>>>>
>>>>>>
>>>>>>> +++ b/Makefile
>>>>>>> @@ -1,5 +1,9 @@
>>>>>>>   # Makefile for QEMU.
>>>>>>>
>>>>>>> +ifneq ($(words $(subst :, ,$(CURDIR))), 1)
>>>>>>> +  $(error main directory cannot contain spaces nor colons)
>>>>>>> +endif
>>>>>>> +
>>>>>>>   # Always point to the root of the build tree (needs GNU make).
>>>>>>>   BUILD_DIR=$(CURDIR)
>>>>>>>
>>>>>>> diff --git a/configure b/configure
>>>>>>> index 9832cbca5c..f7ad4381bd 100755
>>>>>>> --- a/configure
>>>>>>> +++ b/configure
>>>>>>> @@ -279,6 +279,12 @@ ld_has() {
>>>>>>>   # make source path absolute
>>>>>>>   source_path=$(cd "$(dirname -- "$0")"; pwd)
>>>>>>>
>>>>>>> +if printf "%s\n" "$source_path" | grep -q "[[:space:]:]" ||
>>>>>>> +  printf "%s\n" "$PWD" | grep -q "[[:space:]:]";
>>>>>>
>>>>>> For less typing and fewer processes, you could shorten this to:
>>>>>>
>>>>>> if printf %s\\n "$source_path" "$PWD" | grep -q "[[:space:]:]";
>>>>>>
>>>>>> but that's trivial enough for a maintainer to fold in if desired.
>>>>>>
>>>>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>>>>
>>>>> What tree is this going to go in via? I suggest the
>>>>> -trivial tree.
>>>>
>>>>
>>>> Applied (unchanged) to my trivial-patches branch.
>>>>
>>>
>>> Thank you Laurent.
>>>
>>> I'll think about sending a followup patch with the changes proposed 
>>> by Eric and I'll CC you if I do.
>>
>> If you want to send a v3 of this patch to update it, I can wait.
> 
> That works too, I was waiting for the maintainers to decide what to do.
> 
> I'll try to send a v3 before Monday then.

OK, I will queue your v3 in the pull-request of the next week.

Thanks,
Laurent

