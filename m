Received: from eggs.gnu.org ([2001:4830:134:3::10]:42121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dzM5s-000221-5f
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:14:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dzM5o-0004LQ-4Z
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:14:36 -0400
Received: from mail.ispras.ru ([83.149.199.45]:57188)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dzM5n-0004Cw-Tb
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:14:32 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Tue, 03 Oct 2017 15:14:27 +0300
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
In-Reply-To: <20171002194359.GC22777@stefanha-x1.localdomain>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
	<20171002194359.GC22777@stefanha-x1.localdomain>
Message-ID: <1b946ef88bd5ecca28439dca1b01be5d@ispras.ru>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/43] Windbg supporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, sw@weilnetz.de, lprosek@redhat.com, dovgaluk@ispras.ru, rkagan@virtuozzo.com, pbonzini@redhat.com, den@openvz.org

Stefan Hajnoczi =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2017-10-02 22:43:
> On Tue, Sep 26, 2017 at 02:04:06PM +0300, Mihail Abakumov wrote:
>> We made the debugger module WinDbg (like GDB) for QEMU. This is the=20
>> replacement of the remote stub in Windows kernel. Used for remote=20
>> Windows kernel debugging without debugging mode.
>=20
> How do the feature sets of the GDB remote protocol and WinDbg protocol
> compare?  (I don't mean the debuggers themselves, but just the
> protocols.)
>=20
> Stefan

The GDB remote protocol is symbolic. The WinDbg remote protocol is a=20
higher level protocol. Interaction occurs through packets. The=20
structures of these packets are defined in windbgkd.h header file.

Mihail Abakumov
