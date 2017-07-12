Received: from eggs.gnu.org ([2001:4830:134:3::10]:45445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVFvQ-0002xv-G8
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:35:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVFvM-0004Gx-AO
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:35:24 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <CAOE=1Z3ve+zQJbjqqfNA1iB_mNgFkoTTXRxyBikSiJ5_AZwpiA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c5d9a1c7-631e-19d4-0917-51f57887ca28@amsat.org>
Date: Wed, 12 Jul 2017 08:34:15 -0300
MIME-Version: 1.0
In-Reply-To: <CAOE=1Z3ve+zQJbjqqfNA1iB_mNgFkoTTXRxyBikSiJ5_AZwpiA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] How to stop `qemu-system-x86_64 ...` instead of
 `kill -9`?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam <batmanustc@gmail.com>
Cc: qemu-discuss@nongnu.org, qemu-devel@nongnu.org, Vincenzo Romano <vincenzo.romano@notorand.it>, Peter Xu <peterx@redhat.com>, Fam Zheng <famz@redhat.com>

Hi Sam,

On 07/12/2017 06:24 AM, Sam wrote:
> I'm running `qemu-system-x86_64 ...` to start a guest vm. Now I want to
> stop and destroy this vm, I found there is no `qemu-stop` related command,
> so I have to `kill -9` this process.
> 
> How could I stop `qemu-system-x86_64` instead of `kill -9`? Use `virsh`
> command or something?

If you are using -nographic you can use the "^a x" keys sequence as 
described in the man page:

$ man qemu-system-x86_64
QEMU(1)

        During emulation, if you are using a character backend
        multiplexer (which is the default if you are using -nographic)
        then several commands are available via an escape sequence.
        These key sequences all start with an escape character, which
        is Ctrl-a by default, but can be changed with -echr. The list
        below assumes you're using the default.

        Ctrl-a h
            Print this help

        Ctrl-a x
            Exit emulator

        Ctrl-a c
            Rotate between the frontends connected to the multiplexer
            (usually this switches between the monitor and the console)

What I usually does when the guest supports ACPI is enter the monitor 
with "^a c" then type "system_powerdown" so my guest gracefully 
shutdowns, else use "^a x".

Regards,

Phil.
