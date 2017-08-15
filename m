Received: from eggs.gnu.org ([2001:4830:134:3::10]:51416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhXVk-0005UA-No
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:47:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhXVh-0000CN-M5
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:47:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dhXVh-0000Bs-GS
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:47:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4C0D3C0546FB
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 08:47:36 +0000 (UTC)
Date: Tue, 15 Aug 2017 09:47:31 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170815084731.GD9674@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170815084430.7128-1-stefanha@redhat.com>
	<20170815084430.7128-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170815084430.7128-3-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 v2 2/2] simpletrace: fix flight
 recorder --no-header option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, Aug 15, 2017 at 09:44:30AM +0100, Stefan Hajnoczi wrote:
> The simpletrace.py script can pretty-print flight recorder ring buffers.
> These are not full simpletrace binary trace files but just the end of a
> trace file.  There is no header and the event ID mapping information is
> often unavailable since the ring buffer may have filled up and discarded
> event ID mapping records.
> 
> The simpletrace.stp script that generates ring buffer traces uses the
> same trace-events-all input file as simpletrace.py.  Therefore both
> scripts have the same global ordering of trace events.  A dynamic event
> ID mapping isn't necessary: just use the trace-events-all file as the
> reference for how event IDs are numbered.
> 
> It is now possible to analyze simpletrace.stp ring buffers again using:
> 
>   $ ./simpletrace.py trace-events-all path/to/ring-buffer
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  scripts/simpletrace.py | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
