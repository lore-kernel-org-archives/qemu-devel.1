Received: from eggs.gnu.org ([2001:4830:134:3::10]:48734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dfTyx-0004bT-RJ
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:37:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dfTyu-0001fp-Oi
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:37:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dfTyu-0001fJ-Id
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:37:16 -0400
References: <1C4DF81E-D39F-42E2-9D0C-5D76819662A4@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9a34ac74-d96f-bd9c-7666-b02e2f8accba@redhat.com>
Date: Wed, 9 Aug 2017 18:37:12 +0200
MIME-Version: 1.0
In-Reply-To: <1C4DF81E-D39F-42E2-9D0C-5D76819662A4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Programmingkid <programmingkidx@gmail.com>, Richard Henderson <rth@twiddle.net>, ehabkost@redhat.com
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

On 09/08/2017 16:56, Programmingkid wrote:
> The default vga card not longer works with a Windows 2000 guest. All I see is a black screen after a the Windows splash screen.
> 
> This is the command-line I used: 
> 
> qemu-system-i386 -hda Windows2000HD.qcow2 -boot c -m 512
> 
> When using the -vga cirrus option video works. Testing was done with QEMU v2.10.0 rc2. 

Did it work in 2.9?

Paolo
