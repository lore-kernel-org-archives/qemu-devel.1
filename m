Received: from eggs.gnu.org ([2001:4830:134:3::10]:35390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dgAty-0002ue-7M
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:27:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dgAtu-0004Nn-4B
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:27:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dgAtt-0004NI-Tz
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:26:58 -0400
References: <alpine.DEB.2.20.1708111422580.11919@digraph.polyomino.org.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b8eac78e-e617-b789-5c3d-ff725640a854@redhat.com>
Date: Fri, 11 Aug 2017 16:26:54 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1708111422580.11919@digraph.polyomino.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/i386: fix phminposuw in-place
 operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joseph Myers <joseph@codesourcery.com>, qemu-devel@nongnu.org, rth@twiddle.net, ehabkost@redhat.com

On 11/08/2017 16:23, Joseph Myers wrote:
> The SSE4.1 phminposuw instruction finds the minimum 16-bit element in
> the source vector, putting the value of that element in the low 16
> bits of the destination vector, the index of that element in the next
> three bits and zeroing the rest of the destination.  The helper for
> this operation fills the destination from high to low, meaning that
> when the source and destination are the same register, the minimum
> source element can be overwritten before it is copied to the
> destination.  This patch fixes it to fill the destination from low to
> high instead, so the minimum source element is always copied first.
> This fixes one gcc test failure in my GCC 6-based testing (and so
> concludes the present sequence of patches, as I don't have any further
> gcc test failures left in that testing that I attribute to QEMU bugs).
> 
> Signed-off-by: Joseph Myers <joseph@codesourcery.com>

Nice, thanks for the patches!  Queued too.

Paolo
