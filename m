Received: from eggs.gnu.org ([209.51.188.92]:47553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2WjH-0004PK-Jt
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:49:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2WjG-0001Hc-SZ
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:49:11 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h2WjG-0001Ga-LG
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:49:10 -0500
Received: by mail-wr1-x444.google.com with SMTP id t6so4447275wrw.7
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 23:49:10 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20190219211936.6466-1-viktor.prutyanov@phystech.edu>
	<d0855c42-bd84-4f90-9af3-0080e0de1740@redhat.com>
	<CAFEAcA-vMz=2XNkZ7n1WUBj6sMXk4Ffe_-3=tO1-2rowD0O0KQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1d4754e8-fd06-f3b8-93f7-743e8606ad9c@redhat.com>
Date: Sat, 9 Mar 2019 08:49:04 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-vMz=2XNkZ7n1WUBj6sMXk4Ffe_-3=tO1-2rowD0O0KQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] contrib/elf2dmp: add kernel start address
 checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, Roman Kagan <rkagan@virtuozzo.com>, QEMU Developers <qemu-devel@nongnu.org>

On 08/03/19 18:55, Peter Maydell wrote:
> On Wed, 20 Feb 2019 at 11:30, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 19/02/19 22:19, Viktor Prutyanov wrote:
>>> Before this patch, if elf2dmp failed to find NT kernel PE magic in
>>> allowed virtual address range, then it assumes NULL as NT kernel
>>> address and cause segfault.
>>>
>>> This patch fix the problem described above by checking NT kernel address
>>> before futher processing.
>>>
>>> Signed-off-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
>>> ---
>>>  contrib/elf2dmp/main.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
>>> index 1a45eaf565..1bfeb89ba7 100644
>>> --- a/contrib/elf2dmp/main.c
>>> +++ b/contrib/elf2dmp/main.c
>>> @@ -524,6 +524,12 @@ int main(int argc, char *argv[])
>>>          }
>>>      }
>>>
>>> +    if (!nt_start_addr) {
>>> +        eprintf("Failed to find NT kernel image\n");
>>> +        err = 1;
>>> +        goto out_ps;
>>> +    }
>>> +
>>>      printf("KernBase = 0x%016"PRIx64", signature is \'%.2s\'\n", KernBase,
>>>              (char *)nt_start_addr);
>>>
>>>
>>
>> Queued, thanks.
> 
> Hi Paolo -- I noticed this fix wasn't in master yet -- is it in
> a tree you're planning on sending a pullreq for soon?

Yep, I just wanted to flush kconfig and qgraph before everybody starts
sending pull requests for soft freeze.

Paolo
