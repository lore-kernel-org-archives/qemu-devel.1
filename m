Received: from eggs.gnu.org ([2001:4830:134:3::10]:38108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fuUe2-0003v0-C5
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 23:26:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fuUdx-0002IN-E9
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 23:26:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57092 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fuUdx-0002Gn-9L
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 23:26:13 -0400
Date: Tue, 28 Aug 2018 11:26:01 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180828032601.GA2768@xz-x1>
References: <20180815095328.32414-1-peterx@redhat.com>
	<20180815095328.32414-4-peterx@redhat.com>
	<8736v0t0cm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8736v0t0cm.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v5 3/3] intel-iommu: replace more vtd_err_*
 traces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Halil Pasic <pasic@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>

On Mon, Aug 27, 2018 at 03:17:45PM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Replace all the trace_vtd_err_*() hooks with the new error_report_once()
> > since they are similar to trace_vtd_err() - dumping the first error
> > would be mostly enough, then we have them on by default too.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> [...]
> 
> Let's use "%x" instead of "%" PRIx16 for simplicity, and add spaces
> around PRIx64 & friends.
> 
> Squashing in:

Thanks for touching up the places around in both patches.

-- 
Peter Xu
