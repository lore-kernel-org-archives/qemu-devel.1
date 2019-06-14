Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7640DC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:46:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50C47205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C47205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54250 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbrDv-0004Vz-Im
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 14:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35837)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hbq6h-0002qS-DQ
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:35:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hbq6g-0001Ga-4v
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:35:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38134)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hbq6f-0001BL-Qv
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:35:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 261188553F
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 17:35:10 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-141.ams2.redhat.com
 [10.36.116.141])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 30B9217DCE;
 Fri, 14 Jun 2019 17:35:07 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20190613175435.6575-1-philmd@redhat.com>
 <7c44bcb6-1c72-e327-9091-394e6abfb51e@redhat.com>
 <c02e3358-f195-51e7-171f-aab2b0314c72@redhat.com>
 <62fae3fa-ba9d-6c38-ac8f-0e453ef396f8@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <5ad8f71b-9266-8cab-f50d-37a992e67d91@redhat.com>
Date: Fri, 14 Jun 2019 19:35:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <62fae3fa-ba9d-6c38-ac8f-0e453ef396f8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 14 Jun 2019 17:35:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] roms/edk2-build.sh: Allow to run
 edk2-build.sh from command line
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/14/19 15:55, Philippe Mathieu-Daud=C3=A9 wrote:
> On 6/14/19 3:29 PM, Eric Blake wrote:
>> On 6/14/19 5:16 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Cc'ing Eric :)
>>>
>>
>>>> When running this script out of 'make', we get:
>>>>
>>>>   $ cd roms
>>>>   $ ./edk2-build.sh aarch64 --arch=3DAARCH64 --platform=3DArmVirtPkg=
/ArmVirtQemu.dsc > /dev/null
>>>>   ./edk2-build.sh: line 46: MAKEFLAGS: unbound variable
>>>>
>>>> Fix this by checking the variable is defined before using it,
>>>> else use a default value.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>> ---
>>>>  roms/edk2-build.sh | 8 +++++++-
>>>>  1 file changed, 7 insertions(+), 1 deletion(-)

(1) "allow to run" is not correct English, to my understanding. This
form of "allow" requires an object. You could reformulate the subject
line as "allow edk2-build.sh to be invoked from the command line".


>>>> diff --git a/roms/edk2-build.sh b/roms/edk2-build.sh
>>>> index 4f46f8a6a2..5390228b4e 100755
>>>> --- a/roms/edk2-build.sh
>>>> +++ b/roms/edk2-build.sh
>>
>> This is running under /bin/bash (hmm - not '/bin/env bash' like other
>> scripts in qemu?), so...
>>
>>>> @@ -43,7 +43,13 @@ fi
>>>>  # any), for the edk2 "build" utility.
>>>>  source ../edk2-funcs.sh
>>>>  edk2_toolchain=3D$(qemu_edk2_get_toolchain "$emulation_target")
>>>> -edk2_thread_count=3D$(qemu_edk2_get_thread_count "$MAKEFLAGS")
>>>> +if [ -v MAKEFLAGS ]; then
>>
>> the non-portable bashism '[ -v' works. However, it's just as easy to
>=20
> Ah, OK.
>=20
>> work around this problem portably for all POSIX shells without needing=
 'if':
>>
>>>> +  edk2_thread_count=3D$(qemu_edk2_get_thread_count "$MAKEFLAGS")
>>>> +else
>>>> +  # We are not running within 'make', let the edk2 "build" utility =
to fetch
>>>> +  # the logical CPU count with Python's multiprocessing.cpu_count()=
 method.
>>>> +  edk2_thread_count=3D0
>>>> +fi

(2) "let" doesn't take the preposition "to". I'd suggest:

  Let the edk2 "build" utility [] fetch ...


>>
>> edk2_thread_count=3D$(qemu_edk2_get_thread_count "${MAKEFLAGS:-0}")

(3) The expression

  edk2_thread_count=3D$(qemu_edk2_get_thread_count "${MAKEFLAGS:-0}")

would pass the string "0" as $1 to the qemu_edk2_get_thread_count()
function. That doesn't seem useful (please see the docs on said shell
function).

We could write

  edk2_thread_count=3D$(qemu_edk2_get_thread_count "${MAKEFLAGS:-}")

instead, to pass "". But that would cause qemu_edk2_get_thread_count()
to print "1", which is not what we want here, AIUI.


I think I prefer the approach with "[ -v". While it's nonportable,
"edk2-build.sh" is already -- consciously -- so: it uses an array
variable, for example.


(4) Phil, did you regression-test this change with plain "make" (i.e.,
no "-j" option)? The behavior shouldn't change for that case (i.e.
qemu_edk2_get_thread_count() should be invoked, and it should print "1").


With (1) and (2) fixed, and (4) confirmed:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo

