Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F40C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:58:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E056721473
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E056721473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43875 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTRlM-0006pB-Sy
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 09:58:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTRkN-0006Kf-TU
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTRkM-0008Lc-O2
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:57:35 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:42059)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hTRkM-0008L2-ET; Wed, 22 May 2019 09:57:34 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MrPVJ-1gpAxe1rKJ-00oXuT; Wed, 22 May 2019 15:57:09 +0200
To: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>
References: <20190503082728.16485-1-ao2@ao2.it>
	<20190503082728.16485-3-ao2@ao2.it>
	<541bfc5c-0e45-58e6-f0b1-81e9b0c8881d@redhat.com>
	<CAFEAcA8An-KWOc3gOz2=45eCHCmUJEJw_bTrrCW6bYO23H8TPw@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a5f95284-2883-e6c0-54ad-d0ff018f68d7@vivier.eu>
Date: Wed, 22 May 2019 15:57:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8An-KWOc3gOz2=45eCHCmUJEJw_bTrrCW6bYO23H8TPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:7mnKqv+mccePQYCbVgI0nG/6TExsTjtBiFk/mNSC+UJjIA8xttw
	tf4kdcxX+QIHk4tyDt4AkbwwBywjoJbC/uBcccj/yR0iRN3vlEy9FMuyAD0P1WZZa6IdzK+
	u6VrvBuz66ArioGGoUj5HqTtAECHhhKLsowecB4LhChW+fReoihV/lsZvT7ujUWKMDoVLrl
	pJzaHE1rvlIHxZiwayGEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4IV3NIeEpoU=:qBD0hJzLMjnlrG0weM8J5P
	pEkZoDcF6iqLlNh24j16i1zGdOxYhQb4dUuFIad2L8K3lg27ufjkylo05hFHyYErI/lWVZ+RV
	6hCTFPDkdVwRLuQ9tN9oC5ljLzjnxemVjkA5hBaAXYjKV6v9DHr3lzFaAixtGrXObjvISENF3
	nXdfEiHDsev3SwWJttRsrk88N3Ix/9UlBLaetjg99icCwONiVfCWbLKB94cjbsBYC0ObbqB+8
	u96W93Sm42I7JzPNh3S324ujjZ6Q+sSRJNos/11Plou4YMZPl55MJGbIprgGXe3Mg/b5K23FV
	y9wb13ot6le9cPjNJksIpr2MRoce+d+9cPMYUeVpsLhOtsCLBBkSXFul3pzhEsuZyEqNjxv1g
	2IqMwu2B5PEgIfjjqqTLDDqOW3jpLgMist9L/Pu06QrcPWvOtNUGnhjg00MeZP104SgPJZdFM
	1FpqR/XDkZLrowWrxknpYnhyrNJOOLmx1J4igugAfKrQVFwYXRpaUf4q7cYp4os4mtCwTKrxf
	Rn+N6nnDLJpeeY+iGsqES2oyyGobTQB395HZORzEQpHbsToOa6RhB6vRHq3j1JVM5JuCbgF8V
	traokJ1OUDIOLMRvZXMLeXVXO662bDBo9Xtz+SrSD7mC3ZG2zdos0KwYMVEaQ62Ja2Xfwn/ya
	i+Y20z52G+uSCyMcGTHoXn85nlnTNhbE9CB7o816N94Lepb9Pd61is89hVhIabJx7Pm6hU1/5
	WohX4UOih+dcmBa1fhQ1DCplFzfpB1EcsDNx61dU8VUVi7b5JmevXTfGxNY=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
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
	Antonio Ospite <antonio.ospite@collabora.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/05/2019 16:42, Peter Maydell wrote:
> On Mon, 6 May 2019 at 18:27, Eric Blake <eblake@redhat.com> wrote:
>>
>> On 5/3/19 3:27 AM, Antonio Ospite wrote:
>>> From: Antonio Ospite <antonio.ospite@collabora.com>
>>>
>>> The configure script breaks when the qemu source directory is in a path
>>> containing white spaces, in particular the list of targets is not
>>> correctly generated when calling "./configure --help" because of how the
>>> default_target_list variable is built.
>>>
>>> In addition to that, *building* qemu from a directory with spaces breaks
>>> some assumptions in the Makefiles, even if the original source path does
>>> not contain spaces like in the case of an out-of-tree build, or when
>>> symlinks are involved.
>>>
>>> To avoid these issues, refuse to run the configure script and the
>>> Makefile if there are spaces or colons in the source path or the build
>>> path, taking as inspiration what the kbuild system in linux does.
>>>
>>> Buglink: https://bugs.launchpad.net/qemu/+bug/1817345
>>>
>>> Signed-off-by: Antonio Ospite <antonio.ospite@collabora.com>
>>> ---
>>>   Makefile  | 4 ++++
>>>   configure | 6 ++++++
>>>   2 files changed, 10 insertions(+)
>>>
>>
>>> +++ b/Makefile
>>> @@ -1,5 +1,9 @@
>>>   # Makefile for QEMU.
>>>
>>> +ifneq ($(words $(subst :, ,$(CURDIR))), 1)
>>> +  $(error main directory cannot contain spaces nor colons)
>>> +endif
>>> +
>>>   # Always point to the root of the build tree (needs GNU make).
>>>   BUILD_DIR=$(CURDIR)
>>>
>>> diff --git a/configure b/configure
>>> index 9832cbca5c..f7ad4381bd 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -279,6 +279,12 @@ ld_has() {
>>>   # make source path absolute
>>>   source_path=$(cd "$(dirname -- "$0")"; pwd)
>>>
>>> +if printf "%s\n" "$source_path" | grep -q "[[:space:]:]" ||
>>> +  printf "%s\n" "$PWD" | grep -q "[[:space:]:]";
>>
>> For less typing and fewer processes, you could shorten this to:
>>
>> if printf %s\\n "$source_path" "$PWD" | grep -q "[[:space:]:]";
>>
>> but that's trivial enough for a maintainer to fold in if desired.
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> What tree is this going to go in via? I suggest the
> -trivial tree.


Applied (unchanged) to my trivial-patches branch.

Thanks,
Laurent


