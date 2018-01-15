Received: from eggs.gnu.org ([2001:4830:134:3::10]:36539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eb2TT-00079U-TA
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:58:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eb2TP-0003wH-UM
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:58:43 -0500
Received: from mail.ispras.ru ([83.149.199.45]:47084)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eb2TP-0003va-N2
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:58:39 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Mon, 15 Jan 2018 13:58:36 +0300
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
In-Reply-To: <f7ec43ca-632f-c402-0bea-f7df552b4604@redhat.com>
References: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
	<f7ec43ca-632f-c402-0bea-f7df552b4604@redhat.com>
Message-ID: <c37ad2283b9843b17b99c6252d6d876e@ispras.ru>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 00/46] Windbg supporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, sw@weilnetz.de, lprosek@redhat.com, dovgaluk@ispras.ru, rkagan@virtuozzo.com, den@openvz.org

Paolo Bonzini =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2018-01-12 11:27:
> On 11/12/2017 14:21, Mihail Abakumov wrote:
>> How it works:
>> The WinDbg debugger has the possibility of connecting to a remote=20
>> debug service
>> (Kdsrv.exe) in the Windows kernel. Therefore, it is possible to=20
>> connect to the
>> guest system running in the QEMU emulator. Kernel debugging is=20
>> possible only
>> with the enabled debugging mode, may change at the same time. Our=20
>> module of
>> WinDbg debugger for QEMU is an alternative of the remote debugging=20
>> service in
>> the kernel. Thus, the debugger connects to the debugging module, not=20
>> to the
>> kernel of the operating system. The module obtains all the necessary=20
>> information
>> answering debugger requests from the QEMU emulator. At the same time=20
>> for
>> debugging there is no need to enable debugging mode in the kernel.=20
>> This leads to
>> hidden debugging. Our module supports all features of WinDbg regarding=
=20
>> remote
>> debugging, besides interception of events and exceptions. Only i386 is=
=20
>> supported
>> now.
>=20
> How hard would it be to support x86_64?  I'm not sure how useful this=20
> is
> for 32-bit only.
>=20
> Paolo

I tried it a year ago. But I did it only partially because I could not=20
even
run Windows 7 x64 on x86_64 due to some kind of error. Today I tried the=20
last
version and it ran. So I think I can add support x86_64.

--=20
Thanks,
Mihail
