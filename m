Received: from eggs.gnu.org ([2001:4830:134:3::10]:59588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1d0vtl-00075p-8n
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 16:08:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1d0vti-00049n-41
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 16:08:21 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:27709)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1d0vth-00047w-TQ
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 16:08:18 -0400
References: <20170419174535.1860.64403.malonedeb@wampee.canonical.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <60156451-98ac-9c28-a19f-f46275bb1b5a@reactos.org>
Date: Wed, 19 Apr 2017 22:08:09 +0200
MIME-Version: 1.0
In-Reply-To: <20170419174535.1860.64403.malonedeb@wampee.canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1684239] [NEW] vvfat core dump when enabling
 RW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1684239 <1684239@bugs.launchpad.net>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>

Hi Rolando,

Le 19/04/2017 =C3=A0 19:45, Rolando Zappacosta a =C3=A9crit :
> Public bug reported:
>
> Hi guys,
>
> I'm getting this qemu crash message:
>>>> qemu-system-x86_64: /build/qemu-TziMIO/qemu-2.5+dfsg/block/vvfat.c:2=
290: commit_direntries: Assertion `!strncmp(s->directory.pointer, "QEMU",=
 4)' failed.
>>>> Aborted (core dumped)
> when launching qemu with this options for a VVFAT drive:
>>>> -drive file=3Dfat:rw:./ROOT,if=3Dvirtio
> (same happens when using cache=3Dnone and/or if=3Dide)
>
> "uname -a" system info is:
>>>> Linux RJZ-WRK-LNX 4.4.0-72-generic #93-Ubuntu SMP Fri Mar 31 14:07:4=
1 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux
> and "qemu --version" is:
>>>> QEMU emulator version 2.5.0 (Debian 1:2.5+dfsg-5ubuntu10.10), Copyri=
ght (c) 2003-2008 Fabrice Bellard
>
> Not sure what logs to attach but I'll be glad to upload whatever needed=
.
>
> Thanks in advance for you help,
> Rolando
>

This bug has been fixed in following commit:

commit ebb72c9f066e5f85259e1541a6d3fb5bfd6e73ff
Author: Kevin Wolf <kwolf@redhat.com>
Date:   Wed Apr 27 14:11:38 2016 +0200

     vvfat: Fix volume name assertion

     Commit d5941dd made the volume name configurable, but it didn't cons=
ider
     that the rw code compares the volume name string to assert that the
     first directory entry is the volume name. This made vvfat crash in r=
w
     mode.

     This fixes the assertion to compare with the configured volume name
     instead of a literal string.

     Cc: qemu-stable@nongnu.org
     Signed-off-by: Kevin Wolf <kwolf@redhat.com>
     Reviewed-by: Markus Armbruster <armbru@redhat.com>
     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

The fix is present since v2.6.0
As you're using v2.5.0, can you try with a newer QEMU version?

Regards,

Herv=C3=A9
