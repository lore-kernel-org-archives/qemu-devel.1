Received: from eggs.gnu.org ([2001:4830:134:3::10]:45999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e7vyU-0000ji-Lw
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 00:10:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e7vyQ-0006Ax-Kg
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 00:10:26 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:53517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1e7vyQ-0006AR-Du
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 00:10:22 -0400
Received: by mail-pf0-x244.google.com with SMTP id t188so4042084pfd.10
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 21:10:22 -0700 (PDT)
References: <20171026130426.10626-1-berrange@redhat.com>
	<5670f64b-15e5-0747-8ab0-c329a83537ee@amsat.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <9b36faef-8798-9d3c-3803-c1800f3a4e2f@ozlabs.ru>
Date: Fri, 27 Oct 2017 15:10:17 +1100
MIME-Version: 1.0
In-Reply-To: <5670f64b-15e5-0747-8ab0-c329a83537ee@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] build: allow automatic git submodule
 updates to be disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

On 27/10/17 00:33, Philippe Mathieu-Daudé wrote:
> On 10/26/2017 10:04 AM, Daniel P. Berrange wrote:
>> Some people building QEMU use VPATH builds where the source directory is on a
>> read-only volume. In such a case 'scripts/git-submodules.sh update' will always
>> fail and users are required to run it manually themselves on their original
>> writable source directory.
>>
>> While this is already supported, it is nice to give users a command line flag
>> to configure to permanently disable automatic submodule updates, as it means
>> they won't get hard to diagnose failures from git-submodules.sh at an arbitrary
>> later date.
>>
>> This patch thus introduces a flag '--disable-git-update' which will prevent
>> 'make' from ever running 'scripts/git-submodules.sh update'. It will still run
>> the 'status' command to determine if a submodule update is needed, but when it
>> does this it'll simply stop and print a message instructing the developer what
>> todo. eg
>>
>> $ ./configure  --target-list=x86_64-softmmu --disable-git-update
>> ...snip...
>>
>> $ make
>>   GEN     config-host.h
>>   GEN     trace/generated-tcg-tracers.h
>>   GEN     trace/generated-helpers-wrappers.h
>>   GEN     trace/generated-helpers.h
>>   GEN     trace/generated-helpers.c
>>   GEN     module_block.h
>>
>> GIT submodule checkout is out of date. Please run
>>   scripts/git-submodule.sh update ui/keycodemapdb
>> from the source directory checkout /home/berrange/src/virt/qemu
> 
> Clean :)
> 
>>
>> make: *** [Makefile:31: git-submodule-update] Error 1
>>
>> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> 
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


What tree did you apply on top of? Does not apply for me :-/


-- 
Alexey
