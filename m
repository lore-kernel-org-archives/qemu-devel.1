Received: from eggs.gnu.org ([2001:4830:134:3::10]:38492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dfUcd-0004oD-Cp
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 13:18:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dfUcc-0003qs-DO
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 13:18:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dfUcc-0003qC-6a
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 13:18:18 -0400
Date: Wed, 9 Aug 2017 20:18:16 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170809201746-mutt-send-email-mst@kernel.org>
References: <1C4DF81E-D39F-42E2-9D0C-5D76819662A4@gmail.com>
	<9a34ac74-d96f-bd9c-7666-b02e2f8accba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a34ac74-d96f-bd9c-7666-b02e2f8accba@redhat.com>
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
Cc: Programmingkid <programmingkidx@gmail.com>, Richard Henderson <rth@twiddle.net>, ehabkost@redhat.com, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

On Wed, Aug 09, 2017 at 06:37:12PM +0200, Paolo Bonzini wrote:
> On 09/08/2017 16:56, Programmingkid wrote:
> > The default vga card not longer works with a Windows 2000 guest. All I see is a black screen after a the Windows splash screen.
> > 
> > This is the command-line I used: 
> > 
> > qemu-system-i386 -hda Windows2000HD.qcow2 -boot c -m 512
> > 
> > When using the -vga cirrus option video works. Testing was done with QEMU v2.10.0 rc2. 
> 
> Did it work in 2.9?
> 
> Paolo

Generally bisect is extremely helpful to debug these issues.

-- 
MST
