Received: from eggs.gnu.org ([2001:4830:134:3::10]:57962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dfVSh-00012v-2F
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 14:12:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dfVSd-00086y-Oy
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 14:12:07 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:34848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dfVSd-00086q-KD
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 14:12:03 -0400
Received: by mail-io0-x242.google.com with SMTP id h70so209870ioi.2
	for <qemu-devel@nongnu.org>; Wed, 09 Aug 2017 11:12:03 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <9a34ac74-d96f-bd9c-7666-b02e2f8accba@redhat.com>
Date: Wed, 9 Aug 2017 14:12:01 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <613DA9EA-28E9-426C-8A9A-5D4805A46E2C@gmail.com>
References: <1C4DF81E-D39F-42E2-9D0C-5D76819662A4@gmail.com>
	<9a34ac74-d96f-bd9c-7666-b02e2f8accba@redhat.com>
Subject: Re: [Qemu-devel] No video for Windows 2000 guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, ehabkost@redhat.com, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>


> On Aug 9, 2017, at 12:37 PM, Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>=20
> On 09/08/2017 16:56, Programmingkid wrote:
>> The default vga card not longer works with a Windows 2000 guest. All =
I see is a black screen after a the Windows splash screen.
>>=20
>> This is the command-line I used:=20
>>=20
>> qemu-system-i386 -hda Windows2000HD.qcow2 -boot c -m 512
>>=20
>> When using the -vga cirrus option video works. Testing was done with =
QEMU v2.10.0 rc2.=20
>=20
> Did it work in 2.9?
>=20
> Paolo

I haven't test version QEMU 2.9.0 but I did test version 2.8.0 and it =
has the same problem. Starting up Windows 2000 in VGA mode allowed me to =
access the operating system. Found out QEMU's default video controller =
is not recognized. In the Device Manager I can see a yellow question =
mark for Video Controller (VGA Compatible). I remember Windows 2000 =
being able to use the default video card in QEMU in the past. I may be =
able to bisect this issue after all.=
