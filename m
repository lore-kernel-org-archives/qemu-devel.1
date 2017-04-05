Received: from eggs.gnu.org ([2001:4830:134:3::10]:56676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cvgNx-0001bx-BJ
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:33:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cvgNs-00043z-D6
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:33:49 -0400
Received: from chuckie.co.uk ([82.165.15.123]:42805
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1cvgNs-0003qh-5P
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:33:44 -0400
References: <20170404102315.24923-1-kraxel@redhat.com>
	<72577ece-417f-ed7f-1dcf-6ecc8336e321@ilande.co.uk>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <adcf721f-ecfb-e47b-e7ed-44a81d47e638@ilande.co.uk>
Date: Wed, 5 Apr 2017 09:33:13 +0100
MIME-Version: 1.0
In-Reply-To: <72577ece-417f-ed7f-1dcf-6ecc8336e321@ilande.co.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 00/10] make display updates thread safe.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 04/04/17 13:54, Mark Cave-Ayland wrote:

> I've just noticed that TCX 24-bit is still leaving some artifacts, but
> from looking at the code I'm fairly confident that it's bugs in the
> existing TCX code where some of the accelerated features aren't
> correctly invalidating the external color plane.
> 
> Will have a play and see if I can send a patch later.

So actually I started digging into the issues and ended up with a load
of invalidation fixes for TCX24 exposed by the thread-safe work, along
with some good clean ups.

I'll send through what I have shortly, however now that patchset has
expanded I think it's better to remove the TCX/CG3 patches from your
queue and just include the conversation to thread-safe routines.

Here's what your vga-fixes branch looks like rebased upon my patchset:
https://github.com/mcayland/qemu/commits/vga-fixes-sparc.


ATB,

Mark.
