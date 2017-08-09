Received: from eggs.gnu.org ([2001:4830:134:3::10]:51830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dfVBd-0004uQ-IL
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 13:54:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dfVBZ-0007ec-Kg
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 13:54:29 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:36868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dfVBZ-0007eN-EP
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 13:54:25 -0400
Received: by mail-io0-x244.google.com with SMTP id c74so173827iod.4
	for <qemu-devel@nongnu.org>; Wed, 09 Aug 2017 10:54:25 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20170809201746-mutt-send-email-mst@kernel.org>
Date: Wed, 9 Aug 2017 13:54:23 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <2FC26BB2-4371-48D6-9081-BC91B1477FB7@gmail.com>
References: <1C4DF81E-D39F-42E2-9D0C-5D76819662A4@gmail.com>
	<9a34ac74-d96f-bd9c-7666-b02e2f8accba@redhat.com>
	<20170809201746-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] No video for Windows 2000 guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, ehabkost@redhat.com, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>


> On Aug 9, 2017, at 1:18 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Wed, Aug 09, 2017 at 06:37:12PM +0200, Paolo Bonzini wrote:
>> On 09/08/2017 16:56, Programmingkid wrote:
>>> The default vga card not longer works with a Windows 2000 guest. All =
I see is a black screen after a the Windows splash screen.
>>>=20
>>> This is the command-line I used:=20
>>>=20
>>> qemu-system-i386 -hda Windows2000HD.qcow2 -boot c -m 512
>>>=20
>>> When using the -vga cirrus option video works. Testing was done with =
QEMU v2.10.0 rc2.=20
>>=20
>> Did it work in 2.9?
>>=20
>> Paolo
>=20
> Generally bisect is extremely helpful to debug these issues.

I tried but the acpi issue kept Windows 2000 from booting.=20
