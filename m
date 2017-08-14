Received: from eggs.gnu.org ([2001:4830:134:3::10]:58482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dh8q6-00053o-CN
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 02:27:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dh8q5-0004Kf-Ie
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 02:27:02 -0400
MIME-Version: 1.0
From: Sam <batmanustc@gmail.com>
Date: Mon, 14 Aug 2017 14:26:58 +0800
Message-ID: <CAOE=1Z2+PwXOCyK+=QR-engRF7P7JDjgCwbC+rbT=AGAgrXhtQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] How to get qemu log?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-discuss@nongnu.org

Hi all,

I add some log like this in QEMU_SRC/hw/i386/pc.c

+++ b/hw/i386/pc.c
>
> @@ -1364,6 +1364,13 @@ void pc_memory_init(PCMachineState *pcms,
>
>
>>      linux_boot = (machine->kernel_filename != NULL);
>
>
>> +    /* add for qemu start speed */
>
> +    time_t rawtime;
>
> +    struct tm * timeinfo;
>
> +    time ( &rawtime );
>
> +    timeinfo = localtime ( &rawtime );
>
> +    error_printf_unless_qmp("jpc_memory_init begin --
>> %s\n",asctime(timeinfo));
>
> +
>
>
Then I use `QEMU -D /qemu.log ...` command to start a vm, but I have seen
nothing in /qemu.log, I don't know why, and how to show my log while
starting qemu?

Thank you~
