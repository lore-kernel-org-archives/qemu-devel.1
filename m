Received: from eggs.gnu.org ([2001:4830:134:3::10]:35574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dh9Jz-0005Bz-Ah
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 02:57:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dh9Jy-00036I-Nn
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 02:57:55 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:35034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dh9Jy-000361-HY
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 02:57:54 -0400
Received: by mail-wr0-x229.google.com with SMTP id k71so31377171wrc.2
	for <qemu-devel@nongnu.org>; Sun, 13 Aug 2017 23:57:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOE=1Z2+PwXOCyK+=QR-engRF7P7JDjgCwbC+rbT=AGAgrXhtQ@mail.gmail.com>
References: <CAOE=1Z2+PwXOCyK+=QR-engRF7P7JDjgCwbC+rbT=AGAgrXhtQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Aug 2017 07:57:32 +0100
Message-ID: <CAFEAcA-q5Q8LTgx-yXsCMNp9ODdcjMcZjffRCRmGkNuyE4unJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-discuss] How to get qemu log?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam <batmanustc@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-discuss <qemu-discuss@nongnu.org>

On 14 August 2017 at 07:26, Sam <batmanustc@gmail.com> wrote:
> Hi all,
>
> I add some log like this in QEMU_SRC/hw/i386/pc.c
>
> +++ b/hw/i386/pc.c
>>
>> @@ -1364,6 +1364,13 @@ void pc_memory_init(PCMachineState *pcms,
>>
>>
>>>      linux_boot = (machine->kernel_filename != NULL);
>>
>>
>>> +    /* add for qemu start speed */
>>
>> +    time_t rawtime;
>>
>> +    struct tm * timeinfo;
>>
>> +    time ( &rawtime );
>>
>> +    timeinfo = localtime ( &rawtime );
>>
>> +    error_printf_unless_qmp("jpc_memory_init begin --
>>> %s\n",asctime(timeinfo));
>>
>> +
>>
>>
> Then I use `QEMU -D /qemu.log ...` command to start a vm, but I have seen
> nothing in /qemu.log, I don't know why, and how to show my log while
> starting qemu?

You haven't called a function that adds a message to the -d/-D
qemu.log logging -- those are the ones declared in include/qemu/log.h.

The function you have called is for printing error messages,
which will be displayed to the QEMU monitor prompt if they
were provoked by a monitor command, otherwise to stderr.
It's not intended for general debug/progress logging.

thanks
-- PMM
