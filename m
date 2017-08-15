Received: from eggs.gnu.org ([2001:4830:134:3::10]:50904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhXV4-0004vN-VT
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:46:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhXV4-00089P-3M
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:46:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dhXV3-00088m-Td
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:46:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C6A3276026
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 08:46:56 +0000 (UTC)
Date: Tue, 15 Aug 2017 09:46:52 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170815084652.GC9674@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170815084430.7128-1-stefanha@redhat.com>
	<20170815084430.7128-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170815084430.7128-2-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 v2 1/2] trace: use static event ID
 mapping in simpletrace.stp
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

On Tue, Aug 15, 2017 at 09:44:29AM +0100, Stefan Hajnoczi wrote:
> This is a partial revert of commit
> 7f1b588f20d027730676e627713ae3bbf6baab04 ("trace: emit name <-> ID
> mapping in simpletrace header"), which broke the SystemTap flight
> recorder because event mapping records may not be present in the ring
> buffer when the trace is analyzed.  This means simpletrace.py
> --no-header does not know the event ID mapping needed to pretty-print
> the trace.
> 
> Instead of numbering events dynamically, use a static event ID mapping
> as dictated by the event order in the trace-events-all file.
> 
> The simpletrace.py script also uses trace-events-all so the next patch
> will fix the simpletrace.py --no-header option to take advantage of this
> knowledge.
> 
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  scripts/tracetool/format/simpletrace_stap.py | 31 ++--------------------------
>  1 file changed, 2 insertions(+), 29 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
