Received: from eggs.gnu.org ([2001:4830:134:3::10]:57818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cGpjr-0005ua-K7
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 11:15:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cGpjn-0008Cd-PY
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 11:15:35 -0500
Received: from mail.avalus.com ([2001:41c8:10:1dd::10]:49784)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cGpjn-0008CP-Jb
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 11:15:31 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <20161213160610.6xlwhvwq7xhee2wg@grep.be>
Date: Tue, 13 Dec 2016 16:15:28 +0000
Content-Transfer-Encoding: 7bit
Message-Id: <1A0E3F59-A361-4F81-91E6-65C6AFC82C4F@alex.org.uk>
References: <20161212204313.anhjire2gkwd6gzi@grep.be>
	<2D482F67-8115-48CD-921D-5728BC1AD92B@alex.org.uk>
	<20161213150343.3g3fxjixbteum7ju@grep.be>
	<B6B52260-6814-40CB-AA00-E79099B8ED56@alex.org.uk>
	<20161213160610.6xlwhvwq7xhee2wg@grep.be>
Subject: Re: [Qemu-devel] [Nbd] [PATCH v5] doc: Add NBD_CMD_BLOCK_STATUS
 extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wouter Verhelst <w@uter.be>
Cc: Alex Bligh <alex@alex.org.uk>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>


> On 13 Dec 2016, at 16:06, Wouter Verhelst <w@uter.be> wrote:
> 
>> 
>> "If a server supports the `base:allocation` metadata context, then writing
>> to an extent which has `NBD_STATE_HOLE` clear MUST NOT fail with ENOSPC
>> unless for reasons specified in the definition of another context."
> 
> That is essentially what I mean, yes. The point though, is that I also
> think a client should assume the worst.
> 
> (additionally, there may be reasons for ENOSPC that the server isn't
> aware of; so even if NBD_STATE_HOLE is clear, it should still not be an
> error for the server to return ENOSPC)

All of this suggests 'SHOULD NOT' would be more appropriate than
'MUST NOT'.

-- 
Alex Bligh
