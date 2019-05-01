Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA9EC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 09:48:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5895921670
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 09:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5895921670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49077 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLlqc-0001rL-Jj
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 05:48:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hLloy-0000rQ-FJ
	for qemu-devel@nongnu.org; Wed, 01 May 2019 05:46:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hLlou-0001fy-ON
	for qemu-devel@nongnu.org; Wed, 01 May 2019 05:46:36 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:50793)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hLlom-0001bd-JW; Wed, 01 May 2019 05:46:24 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MG9c2-1hXqdI3ciK-00GXkf; Wed, 01 May 2019 11:46:09 +0200
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>
References: <cover.1556666645.git.alistair.francis@wdc.com>
	<14aab381eaa678eca875d0b8bd456feb22a21bd8.1556666645.git.alistair.francis@wdc.com>
	<503a1f5f-7dad-1e4e-e1b1-aaeeeac9739f@vivier.eu>
	<20190501094452.GQ29808@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
	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
Message-ID: <aad5f010-75c5-9b45-b830-3719cec77b9d@vivier.eu>
Date: Wed, 1 May 2019 11:46:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190501094452.GQ29808@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:eDKHq6AkMEvZU9I818+jWlx08ICXPQuJMv3IHzdn4WlP0UEYule
	eKEvq/5eC26OZYJgTFg8OKn7OLUn4pdRDQ22q90y5XsP3l5NKA22+AkBrlPi+XqsulLzB1l
	FOSstk/sESGSlWUZbv+IOaC9/rgohr/v6892GZhnzIXiZsfe72s/MTaN2huTjDs8gno0+1j
	eUx4NghsJAWyme9N4Q2Ng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nkkJ/0lf6Os=:wC2EiOJgMO7xKeSIEngYjC
	Rrs0az743OFftD7hgyQfDmt9x/iCaWZxppduoaBWl+YAN0UzKiPGIf+6Ydwv0cW8pA2xY8taZ
	oBcEuZW/Iqsh1OW3i80UJ9EaMAy/OomfiM7G3o6nkLATADNQ235iFLakzocsRXDMXz6rxEPNh
	++UgUuO+7vXf5nvs8fgDvu83mYwtxvBrziul9WDG8Z7Dk1sJfG+6Ax4a08Lx2gKu98IPM1dck
	CLyoNnGoFnnXRoV2DybATGn3/Ry2kIG9OcOxAk/CloSpRqJk5UGQ9k5nG2zQS8U3wdBL3vRQc
	SzaG4fCHe+ADaWE5FJ0njmVhPaSjPygYPqIL4v2SXlbbaYc2yAgccpw3GkaygGT6u369T1tp1
	dO74P3S7FLqMXeEoZyST/cx7dczup/txtV+bZPQxBxSoJ6xys65egerqkbiLVsLpTsaOt4ndx
	uhZ84h5+vPNhTHHDTiVQwJUNq0zL5RNMm406hnM5mM3lvX50xXcHcVgy2zwVYU1tlu/V+mAT3
	Vtnn9oIV0I1/t3V4f+kmuzdyHaaNh4eas123wF6nduHdYNiEdeuMgx09nLtoBgNwwKbpR/ehd
	4XJ6d/2K6xesV7r4a77YIq5fKnLu6mSKchoIYUdGnhwLU1cF8qOOh0CIrFxEkFWFJqyUQVnu8
	YCMWqxfgYq+r2l/nQbvGZSevfCd/AUZ29Q+kvqtaoyvoQ3O5lBGQ0VxcQoCsbMwjiI5noWpeU
	qTGh15tI+uVB8GBhigd9eYPeHBouMckuuH+YsFVAqlFOQu+gdnuZ0YE3d/A=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: Re: [Qemu-devel] [PATCH v2 4/5] linux-user/uname: Fix GCC 9 build
 warnings
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
	"riku.voipio@iki.fi" <riku.voipio@iki.fi>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"kraxel@redhat.com" <kraxel@redhat.com>,
	"alistair23@gmail.com" <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501094607.-VnFb7C07ow9Ulw2fGDh-GpKfgGOTxTCNdbow_Izqpo@z>

On 01/05/2019 11:44, Daniel P. Berrangé wrote:
> On Wed, May 01, 2019 at 11:40:13AM +0200, Laurent Vivier wrote:
>> On 01/05/2019 01:28, Alistair Francis wrote:
>>> Fix this warning when building with GCC9 on Fedora 30:
>>> In function ‘strncpy’,
>>>     inlined from ‘sys_uname’ at /home/alistair/qemu/linux-user/uname.c:94:3:
>>> /usr/include/bits/string_fortified.h:106:10: error: ‘__builtin_strncpy’ output may be truncated copying 64 bytes from a string of length 64 [-Werror=stringop-truncation]
>>>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
>>>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>>> ---
>>>  linux-user/uname.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/linux-user/uname.c b/linux-user/uname.c
>>> index 313b79dbad..2fc6096a5b 100644
>>> --- a/linux-user/uname.c
>>> +++ b/linux-user/uname.c
>>> @@ -73,7 +73,7 @@ const char *cpu_to_uname_machine(void *cpu_env)
>>>  #define COPY_UTSNAME_FIELD(dest, src) \
>>>    do { \
>>>        /* __NEW_UTS_LEN doesn't include terminating null */ \
>>> -      (void) strncpy((dest), (src), __NEW_UTS_LEN); \
>>> +      (void) memcpy((dest), (src), MIN(strlen(src), __NEW_UTS_LEN)); \
>>
>> You should use MIN(strlen(src) + 1, __NEW_UTS_LEN) to copy the NUL
>> character if it is present and fit in __NEW_UTS_LEN.
> 
> IMHO we shouldn't use strlen at all. I proposed fixing it using sizeof()
> instead here:
> 
>   https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg02154.html
> 

Yes, it's better.

Thanks,
Laurent

