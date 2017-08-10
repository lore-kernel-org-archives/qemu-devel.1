Received: from eggs.gnu.org ([2001:4830:134:3::10]:54088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dfdsg-0006nU-D6
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 23:11:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dfdsd-0005GK-6T
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 23:11:30 -0400
Received: from mail-io0-x235.google.com ([2607:f8b0:4001:c06::235]:36742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dfdsd-0005Fu-0V
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 23:11:27 -0400
Received: by mail-io0-x235.google.com with SMTP id g35so5027436ioi.3
	for <qemu-devel@nongnu.org>; Wed, 09 Aug 2017 20:11:26 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <297851555.2838965.1502318558787.JavaMail.zimbra@redhat.com>
Date: Wed, 9 Aug 2017 23:11:25 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <035A4482-1BA6-4B9C-8198-7D96A7358075@gmail.com>
References: <1C4DF81E-D39F-42E2-9D0C-5D76819662A4@gmail.com>
	<9a34ac74-d96f-bd9c-7666-b02e2f8accba@redhat.com>
	<613DA9EA-28E9-426C-8A9A-5D4805A46E2C@gmail.com>
	<297851555.2838965.1502318558787.JavaMail.zimbra@redhat.com>
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


> On Aug 9, 2017, at 6:42 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
>=20
>> I haven't test version QEMU 2.9.0 but I did test version 2.8.0 and it =
has the
>> same problem. Starting up Windows 2000 in VGA mode allowed me to =
access the
>> operating system. Found out QEMU's default video controller is not
>> recognized. In the Device Manager I can see a yellow question mark =
for Video
>> Controller (VGA Compatible). I remember Windows 2000 being able to =
use the
>> default video card in QEMU in the past. I may be able to bisect this =
issue
>> after all.
>=20
> Try going back to 2.7.0 and so on...
>=20
> Paolo

I went back all the way to 2.4.1 to find a version that works. I've ran =
into problems with compiling QEMU a little beyond that. I'm seeing this =
error:=20

fatal error:=20
      'epoxy/egl.h' file not found
#include <epoxy/egl.h>

It will take me a while to figure out how to fix this issue. I did see =
some very interesting commits up ahead that involve VGA. If you look at =
this page: https://github.com/qemu/qemu/commits/stable-2.5, there are =
five patches that effect VGA. I'm thinking one of them might be the =
problem.=
