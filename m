Received: from eggs.gnu.org ([2001:4830:134:3::10]:39072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWOR5-0008AG-KC
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:20:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWOR2-0007bb-FF
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:20:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cWOR2-0007bP-9N
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:20:28 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6BA923B755
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 14:20:28 +0000 (UTC)
Date: Wed, 25 Jan 2017 14:20:22 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170125142022.GD15529@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170125141426.23454-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170125141426.23454-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] trace: clean up trace-events files
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

On Wed, Jan 25, 2017 at 02:14:26PM +0000, Stefan Hajnoczi wrote:
> There are a number of unused trace events that
> scripts/cleanup-trace-events.pl finds.  The "hw/vfio/pci-quirks.c"
> filename was typoed and "qapi/qapi-visit-core.c" was missing the qapi/
> directory prefix.
> 
> diff --git a/qapi/trace-events b/qapi/trace-events
> index 2c5d3bc..82a0b73 100644
> --- a/qapi/trace-events
> +++ b/qapi/trace-events
> @@ -1,4 +1,4 @@
> -# qapi-visit-core.c
> +# qapi/qapi-visit-core.c
>  visit_free(void *v) "v=%p"
>  visit_complete(void *v, void *opaque) "v=%p opaque=%p"
>  
> @@ -15,7 +15,6 @@ visit_end_alternate(void *v, void *obj) "v=%p obj=%p"
>  
>  visit_optional(void *v, const char *name, bool *present) "v=%p name=%s present=%p"
>  
> -visit_type_enum(void *v, const char *name, int *obj) "v=%p name=%s obj=%p"

The actual bug is that the source file is mistakenly not calling this
trace point - we shouldn't delete it - we should call it from the
visit_type_enum() method


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
