Received: from eggs.gnu.org ([2001:4830:134:3::10]:45944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cGqbA-0005ct-80
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 12:10:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cGqb6-0002AT-7V
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 12:10:40 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38623)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cGqb6-0002A0-0J
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 12:10:36 -0500
Received: by mail-wm0-f42.google.com with SMTP id f82so127906732wmf.1
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 09:10:35 -0800 (PST)
References: <20161208175030.12269-1-drjones@redhat.com>
	<20161208175030.12269-4-drjones@redhat.com>
	<8760mnu6ga.fsf@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <8760mnu6ga.fsf@linaro.org>
Date: Tue, 13 Dec 2016 17:09:33 +0000
Message-ID: <874m27u56a.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH kvm-unit-tests v8 03/10] arm/arm64: add
 some delay routines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, marc.zyngier@arm.com, andre.przywara@arm.com, eric.auger@redhat.com, pbonzini@redhat.com, christoffer.dall@linaro.org


Alex Bennée <alex.bennee@linaro.org> writes:

> Andrew Jones <drjones@redhat.com> writes:
>
>> Allow a thread to wait some specified amount of time. Can
>> specify in cycles, usecs, and msecs.
<snip>
>> diff --git a/lib/arm/asm/processor.h b/lib/arm/asm/processor.h
>> index 6b0d36b87817..857bdd96a3cc 100644
>> --- a/lib/arm/asm/processor.h
>> +++ b/lib/arm/asm/processor.h
>> @@ -7,6 +7,7 @@
>>   */
>>  #include <asm/ptrace.h>
>>  #include <asm/sysreg.h>
>> +#include <asm/barrier.h>
>
> Hmm this fails to apply cleanly to master and doesn't build as sysreg.h
> isn't in my tree. What happened to it?
<snip>

Ahh I missed this is based on arm/next

--
Alex Bennée
