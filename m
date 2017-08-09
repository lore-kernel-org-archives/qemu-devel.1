Received: from eggs.gnu.org ([2001:4830:134:3::10]:39201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dfZga-0003uj-2i
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 18:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dfZgW-0000dN-Un
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 18:42:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dfZgW-0000ca-O9
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 18:42:40 -0400
Date: Wed, 9 Aug 2017 18:42:38 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <297851555.2838965.1502318558787.JavaMail.zimbra@redhat.com>
In-Reply-To: <613DA9EA-28E9-426C-8A9A-5D4805A46E2C@gmail.com>
References: <1C4DF81E-D39F-42E2-9D0C-5D76819662A4@gmail.com>
	<9a34ac74-d96f-bd9c-7666-b02e2f8accba@redhat.com>
	<613DA9EA-28E9-426C-8A9A-5D4805A46E2C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] No video for Windows 2000 guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>, ehabkost@redhat.com, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>


> I haven't test version QEMU 2.9.0 but I did test version 2.8.0 and it has the
> same problem. Starting up Windows 2000 in VGA mode allowed me to access the
> operating system. Found out QEMU's default video controller is not
> recognized. In the Device Manager I can see a yellow question mark for Video
> Controller (VGA Compatible). I remember Windows 2000 being able to use the
> default video card in QEMU in the past. I may be able to bisect this issue
> after all.

Try going back to 2.7.0 and so on...

Paolo
