Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F699C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 20:24:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F842077A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 20:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F842077A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEfF1-0006ds-1z
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 16:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jEfE8-000637-J9
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:23:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jEfE7-0000fc-CA
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:23:44 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:37813)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jEfE7-0000WR-3P
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:23:43 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MTAS1-1irP3P3bSh-00UdKU; Wed, 18 Mar 2020 21:23:29 +0100
Subject: Re: [PULL v2 00/37] Linux user for 5.0 patches
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200317155116.1227513-1-laurent@vivier.eu>
 <CAFEAcA9Pd6D6xaqN7XfOwRANxm=4uOYmdaBoeQiX4_Z-bXEi9g@mail.gmail.com>
 <610f250b-64b8-1cf4-00fe-5bf2f2eba864@linaro.org>
 <b0055b37-a381-095a-a7c9-8b1327be3cce@vivier.eu>
 <95ebdfda-de48-8a44-ec86-8dd384fc98a3@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b77a5bd0-46b6-3345-d070-a998890efff2@vivier.eu>
Date: Wed, 18 Mar 2020 21:23:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <95ebdfda-de48-8a44-ec86-8dd384fc98a3@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9B7Pp3U8WsA6k0w7M+Yz8vUVqCOTFfQ1aNbXFZK/UduyWy5kw+5
 XI/cy9+nTvgAii2o1cMSdmiQJNGV8mApo6OkHT2ofSpor2DyUbYg/dteEjtYUyaksKGKHBJ
 0VolEU4ylZXqyTS7mkAsq/D4HzBBFTSIgNNo8Em7VFV7Wr7N0K7XLD2G2SCDD5+L/EqST80
 Pd7Vatl0v0eKuuNMMXeHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wyQs85329Qg=:Y+KH8fagW7plFA9snX55wR
 xng8wvT9njMFZ3/16/i2PoguWjD/pkaSagiqyCyvU1K9EdgDPz1IuTdTr1c9a+ccXCxKkguAA
 A4hHHY/JNM5FWaBJrElWvFKulZ/qwtRZzrnarQc4RGEsgbxFzssTRf0dSPcQ0Pji8ZMT4Rn9U
 tqVIfbDvoFHL5ByU8dp0GJSVBL5O1Y35qidulRjHruofm84S4PpCFCuB/5CQC92P/nytwxYlC
 QndEWa9inz4ClEM3jfhDPLg5VZaj6gxB8ZxzSkqeWWO3M+MJ9PepQuFMsm+SfX0gtOq9Ol/Jo
 6QaySb9YL/lwMyb6EE02vOyzZpxwg7aUTm6CsPXad/CIMjZJH/3LjAWA/pa6FZNFzDoZjfBSb
 0Y3zJk5Vvzv7Wpfxt6oe297sIKjbzcZNssdMtI+Atwcpp4GvRVuL4Zzo1e/pD3l3A2s7/CpMo
 uqqBMQjUqQ1MvHH1C7W0tDgbPfUtq/32UgbqBx8ArpcIloBmlGLfS6oeQo/lujjPBSisAvEom
 /7D/j/b/mzUuT2MSD2dnGdsdNzTz7X1iiuVPCi3XyCAsj/v6XoKEqRSB870IlFH1fdACNDPaW
 r5wQHfCtKOCKRVb7ITYadJ8czxzq84X3gX1fN/MaiBRhgunVjEAr9lolBDZ4AGmKZocL6sr4q
 ooLwahzB9Kq/IQLeztL0nJwQHpGw5QGRGVUfVFnTvBod/XE3zKXnL3d8m79po8is99SoeE+c2
 nt5uHwL86D8uo8AFcAEL5FY+WxR2yDMylMBtsNBNT0L/dpWZLIM0R8HtJr+1ASJO0EOuVu45R
 VwMsrtPOf0LiAJIZY/X3U777ugU4oDpHciZQ8x3PrhVrsOneh+I46nQN9TBfCQag3nbQxec
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 18/03/2020 à 21:17, Richard Henderson a écrit :
> On 3/18/20 12:58 PM, Laurent Vivier wrote:
>>> However, from the error message above, it's clear that cpu_loop.o has not been
>>> rebuilt properly.
>>>
>>
>> In the series merged here syscall_nr.h are moved from source directory
>> to build directory.
>>
>> The include path of the files is based on the dependecy files (*.d), and
>> to force the update of this path PATCH 13 removes all the .d files that
>> have a dependecy on the syscall_nr.h file in the source path.
>>
>> This is added in configure:
>>
>> --- a/configure
>> +++ b/configure
>> @@ -1887,6 +1887,17 @@ fi
>>  # Remove old dependency files to make sure that they get properly
>> regenerated
>>  rm -f */config-devices.mak.d
>>
>> +# Remove syscall_nr.h to be sure they will be regenerated in the build
>> +# directory, not in the source directory
>> +for arch in ; do
>> +    # remove the file if it has been generated in the source directory
>> +    rm -f "${source_path}/linux-user/${arch}/syscall_nr.h"
>> +    # remove the dependency files
>> +    find . -name "*.d" \
>> +           -exec grep -q
>> "${source_path}/linux-user/${arch}/syscall_nr.h" {} \; \
>> +           -exec rm {} \;
>> +done
> ...
>> Perhaps it removes a dependency that should trigger the rebuild of
>> cpu_loop.o?
> 
> Ah, yes indeed. It removes *all* dependencies for cpu_loop.o, so unless we
> touch the cpu_loop.c source file, nothing gets done.
> 
> I think you're trying to be too fine grained here, since the *.o file has to go
> away with the *.d file.  Why not just
> 
>   make ${arch}-linux-user/clean
> 
> ?

The idea was to be able to bisect the series as the syscall_nr.h were
added incrementally without rebuilding all the files.

If I remove the loop in the configure where to add the "make
${arch}-linux-user/clean"?

Thanks,
Laurent


