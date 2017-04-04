Received: from eggs.gnu.org ([2001:4830:134:3::10]:56576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvLip-0007ZT-U9
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:30:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvLik-0002Zk-UH
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:29:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cvLik-0002ZR-OX
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 06:29:54 -0400
References: <20170404102315.24923-1-kraxel@redhat.com>
	<20170404102315.24923-3-kraxel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0a1c9ce3-c67a-a572-13ad-9f396bcaa0ce@redhat.com>
Date: Tue, 4 Apr 2017 12:29:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170404102315.24923-3-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/10] memory: add support getting and
 using a dirty bitmap copy.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>



On 04/04/2017 12:23, Gerd Hoffmann wrote:
> 
> memory_region_copy_and_clear_dirty() will create a copy of the dirty
> bitmap for the specified range, clear the dirty bitmap and return the
> copy.  The returned bitmap can be a bit larger than requested, the range
> is expanded so the code can copy unsigned longs from the bitmap and
> avoid atomic bit update operations.
> 
> memory_region_copy_get_dirty() will return the dirty status of pages,
> pretty much like memory_region_get_dirty(), but using the copy returned
> by memory_region_copy_and_clear_dirty().

Old names in the commit message, otherwise looks good.

This will also help KVM by the way, because there are changes in the
pipeline to limit the amount of work done by log_sync and process dirty
pages periodically in the VCPU thread.

Paolo
