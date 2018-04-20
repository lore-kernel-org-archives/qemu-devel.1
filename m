Received: from eggs.gnu.org ([2001:4830:134:3::10]:59808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9e6e-0008CW-3Z
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 18:02:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9e6b-0007SV-2Q
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 18:02:12 -0400
Received: from mail-pl0-x236.google.com ([2607:f8b0:400e:c01::236]:45370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f9e6a-0007Rn-SW
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 18:02:08 -0400
Received: by mail-pl0-x236.google.com with SMTP id w22-v6so1372871pll.12
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 15:02:08 -0700 (PDT)
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<0b1a0dd5-4b79-5e60-5b45-8ee8f2de07c8@linaro.org>
	<87tvs69y61.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e41e5610-043c-2ce5-2f2d-214f4944c431@linaro.org>
Date: Fri, 20 Apr 2018 12:02:00 -1000
MIME-Version: 1.0
In-Reply-To: <87tvs69y61.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 00/43] fix building of tests/tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org

On 04/19/2018 08:42 PM, Alex Bennée wrote:
>> It seems I can't even build fp-test for x86_64.
>>
>>   CROSS-BUILD x86_64 guest-tests with cc
>> In file included from /home/rth/work/qemu/qemu/tests/fp/fp-test.c:14:0:
>> /home/rth/work/qemu/qemu/include/qemu/osdep.h:30:10: fatal error:
>> config-host.h: No such file or directory
>>  #include "config-host.h"
>>           ^~~~~~~~~~~~~~~
>> compilation terminated.
> 
> Weird as that works for me. Has configure been run? Are you in a
> external build dir?

Yes to both -- configure and build completed in an external build dir.


r~
