Received: from eggs.gnu.org ([2001:4830:134:3::10]:38331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1cyb6w-0006cw-6o
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 05:32:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1cyb6r-0005xe-UQ
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 05:32:18 -0400
Received: from mail.ispras.ru ([83.149.199.45]:56250)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1cyb6r-0005xS-Lz
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 05:32:13 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Thu, 13 Apr 2017 12:32:12 +0300
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
In-Reply-To: <ec726281-486f-5448-4c3c-c28375c182cb@weilnetz.de>
References: <8a7bf9dbac4c6db5b7e8dd5c968cacae@ispras.ru>
	<20170412163055.GB4915@rkaganb.sw.ru>
	<ec726281-486f-5448-4c3c-c28375c182cb@weilnetz.de>
Message-ID: <b738b19aad6d0f4b7b55b0530b1b5382@ispras.ru>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] WinDbg module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org, Pavel Dovgalyuk <dovgaluk@ispras.ru>, pbonzini@redhat.com

Stefan Weil =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2017-04-12 20:55:
> Am 12.04.2017 um 18:30 schrieb Roman Kagan:
>> On Wed, Apr 12, 2017 at 05:05:45PM +0300, Mihail Abakumov wrote:
>>> Hello.
>>>=20
>>> We made the debugger module WinDbg (like GDB) for QEMU. This is the
>>> replacement of the remote stub in Windows kernel. Used for remote=20
>>> Windows
>>> kernel debugging without debugging mode.
>>>=20
>>> The latest build and instructions for the launch can be found here:
>>> https://github.com/ispras/qemu/releases/tag/v2.7.50-windbg
>>>=20
>>> Currently only one ways to create a remote debugging connection is
>>> supported: using COM port with named pipe.
>>>=20
>>> Should I prepare patches for inclusion in the master branch? Or is it=
=20
>>> too
>>> specific module and it is not needed?
>>=20
>> Please do!
>>=20
>> Every once in a while dealing with a Windows guest problem I wished I
>> had this.  We at Virtuozzo looked into doing something like this but
>> never got around to.
>>=20
>> Thanks,
>> Roman.
>>=20
>=20
> Hello Mihail,
>=20
> from the previous answers you can see that there is a
> need for WinDbg support.
>=20
> If you want to prepare patches for the official QEMU,
> you need signed commits from all developers who contributed
> (Dmitry Koltunov and you?).
>=20
> Make also sure that no licensed code (for example extracts
> from MS header files) gets added.
>=20
> See http://wiki.qemu-project.org/Contribute/SubmitAPatch for
> more hints.
>=20
> As far as I saw, WinDbg support adds several thousand lines
> of code. Do you want to support that code after it has been
> included in QEMU?
>=20
> Cheers
> Stefan

Yes, of course. We can support it.

Thanks,
Mihail Abakumov
