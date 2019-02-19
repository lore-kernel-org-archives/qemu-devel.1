Received: from eggs.gnu.org ([209.51.188.92]:35827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gvzpr-0007TT-CF
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 02:29:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gvzpn-0007Nl-G7
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 02:28:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gvzpj-0007LH-Iz
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 02:28:55 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <154937205518.29984.9188603364499998604.stgit@pasha-VirtualBox>
	<001c01d4c1cb$65a26390$30e72ab0$@ru>
	<43520125-e1d5-7ee6-60a8-5efc1dc061fe@redhat.com>
Date: Tue, 19 Feb 2019 08:28:42 +0100
In-Reply-To: <43520125-e1d5-7ee6-60a8-5efc1dc061fe@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Sat,
	16 Feb 2019 19:34:47 +0100")
Message-ID: <87k1hww82d.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] mips: implement qmp query-cpu-definitions
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, arikalo@wavecomp.com, aurelien@aurel32.net, mdroth@linux.vnet.ibm.com, natalia.fursova@ispras.ru

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Hi Pavel,
>
> On 2/11/19 6:34 AM, Pavel Dovgalyuk wrote:
>> Ping.
>
> You forgot to Cc Aleksandar, to get his MIPS maintainer Ack-by:
>
> ./scripts/get_maintainer.pl -f target/mips/helper.c
> Aleksandar Markovic <amarkovic@wavecomp.com> (maintainer:MIPS)
>
>>=20
>> Pavel Dovgalyuk
>>=20
>>> -----Original Message-----
>>> From: Pavel Dovgalyuk [mailto:Pavel.Dovgaluk@ispras.ru]
>>> Sent: Tuesday, February 05, 2019 4:08 PM
>>> To: qemu-devel@nongnu.org
>>> Cc: pavel.dovgaluk@ispras.ru; arikalo@wavecomp.com; mdroth@linux.vnet.i=
bm.com;
>>> armbru@redhat.com; dovgaluk@ispras.ru; natalia.fursova@ispras.ru; eblak=
e@redhat.com;
>>> aurelien@aurel32.net
>>> Subject: [PATCH] mips: implement qmp query-cpu-definitions command
>>>
>>> This patch enables QMP-based querying of the available CPU types for MI=
PS
>>> and MIPS64 platforms.
>
> Your patch is a simple copy of the ARM code, so:
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> Also:
>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> However this clashes with Marc-Andr=C3=A9's "qapi: make query-cpu-definit=
ions
> depend on specific targets" posted here by Markus:
> https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg03831.html

This is now in master, merge commit a0430dd8abb.

> I believe your patch will go thru the QMP tree, so you might want to
> rebase on top of the series Markus sent; or see if Markus is OK to do
> the manual cleanup when applying.

Please rebase.  Let me know if you need help.
