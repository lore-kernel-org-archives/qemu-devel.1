Received: from eggs.gnu.org ([2001:4830:134:3::10]:50217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gUWGJ-00042Z-H6
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:26:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gUWAn-0002ZT-J6
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:21:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gUWAn-0002Yw-AX
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:21:01 -0500
References: <HE1P190MB00739AD5A654DAA3FE9B4662DEAF0@HE1P190MB0073.EURP190.PROD.OUTLOOK.COM>
	<a3fe5633-d031-6a58-40c2-aee43b2bec45@tuxfamily.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ced8df86-4fe3-f11e-005c-e9b8127434d6@redhat.com>
Date: Wed, 5 Dec 2018 13:20:51 +0100
MIME-Version: 1.0
In-Reply-To: <a3fe5633-d031-6a58-40c2-aee43b2bec45@tuxfamily.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] i386: don't require elf64 for multiboot kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>, Gonzo FWS <fwsgonzo@hotmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On 05/12/18 06:35, Thomas Huth wrote:
> On 2018-12-04 17:55, Gonzo FWS wrote:
>> Right now IncludeOS on x86_64 must use a chainloader for multiboot
>> support. The chainloader is an ELF32 kernel that loads the real
>> ELF64 kernel and jumps to it. As long as the ELF has the .multiboot
>> section and conforms to the spec, meaning _start is be a 32-bit
>> entry, it should be fine.
>>=20
>> By removing the extra check in multiboot.c, we can also boot ELF64
>> files. As can be seen here:=20
>> https://cloud.fwsnet.net/index.php/s/XrkBkC8zy7MLa9p
>>=20
>> Signed-off-by: Alf-Andr=C3=A9 Walla <fwsgonzo@hotmail.com>

I think a 64-bit multiboot specification doesn't exist, but if it
existed, it would require an EM_X86_64 ELF file to be booted already in
long mode.  I don't think it's a good idea to allow booting into an
EM_X86_64 ELF file with the processor in 32-bit mode.

Paolo
