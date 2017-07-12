Received: from eggs.gnu.org ([2001:4830:134:3::10]:48215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVG4E-0000Hh-4l
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:44:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVG4B-0001YX-1d
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:44:30 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVG4A-0001YJ-SZ
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:44:26 -0400
Received: by mail-qk0-f196.google.com with SMTP id q66so3007060qki.1
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 04:44:26 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170712105216.747-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e2243590-08c3-d24b-f523-2cbc302cf2ae@amsat.org>
Date: Wed, 12 Jul 2017 08:43:22 -0300
MIME-Version: 1.0
In-Reply-To: <20170712105216.747-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 0/4] some gdbstub fixes for debug and
 vcont
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, pbonzini@redhat.com, Kamil Rytarowski <kamil@netbsd.org>
Cc: qemu-devel@nongnu.org

CC'ed Kamil Rytarowski (new NetBSD maintainer)

On 07/12/2017 07:52 AM, Alex Bennée wrote:
> Hi Paolo,
> 
> I was going through my review queue and realised I had this hanging
> around with an outstanding comment. Basically the only change is to
> fix the bsd-user build by adding a field for the thread-id. It isn't
> populated but it never was and it looks like the gdbstub for threaded
> bsd-user programs has been broken forever.
> 
> Given the range of different ways of getting a thread-id and the fact
> the bsd fork machinery looks like it needs updating anyway I'd left
> this for a future BSD maintainer to fix up properly.
> 
> Are you happy to take this into your tree?
> 
> Alex Bennée (4):
>    gdbstub: modernise DEBUG_GDB
>    gdbstub: rename cpu_index -> cpu_gdb_index
>    qom/cpu: remove host_tid field
>    gdbstub: don't fail on vCont;C04:0;c packets
> 
>   bsd-user/qemu.h        |   2 +
>   gdbstub.c              | 117 ++++++++++++++++++++++++-------------------------
>   include/exec/gdbstub.h |   9 ----
>   include/qom/cpu.h      |   2 -
>   linux-user/syscall.c   |   1 -
>   5 files changed, 59 insertions(+), 72 deletions(-)
> 
