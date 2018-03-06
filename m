Received: from eggs.gnu.org ([2001:4830:134:3::10]:58105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1etGiL-0002OI-Pq
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 12:49:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1etGiL-0000EF-06
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 12:49:25 -0500
Date: Tue, 6 Mar 2018 12:49:18 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180306174918.GA22807@flamenco>
References: <20180207125037.13510-1-vsementsov@virtuozzo.com>
	<20180306160017.GM31045@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306160017.GM31045@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] block latency histogram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, kwolf@redhat.com, qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, den@openvz.org

On Tue, Mar 06, 2018 at 16:00:17 +0000, Stefan Hajnoczi wrote:
> On Wed, Feb 07, 2018 at 03:50:35PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > Vladimir Sementsov-Ogievskiy (2):
> >   block/accounting: introduce latency histogram
> >   qapi: add block latency histogram interface
(snip)
> >  5 files changed, 228 insertions(+), 1 deletion(-)
> 
> The feature looks good.  I posted documentation and code readability
> suggestions.

Hi Vladimir,

Did you consider using qdist? For reference, see commit bf3afd5f419
and/or grep 'qdist'.

Thanks,

		Emilio
