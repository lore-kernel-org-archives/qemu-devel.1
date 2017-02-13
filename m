Received: from eggs.gnu.org ([2001:4830:134:3::10]:47556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cdD5y-0005ZM-39
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 04:38:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cdD5u-0008LD-Ec
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 04:38:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cdD5u-0008Kv-8T
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 04:38:50 -0500
Date: Mon, 13 Feb 2017 09:38:44 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170213093844.GA12387@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170213092709.24711-1-lma@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170213092709.24711-1-lma@suse.com>
Subject: Re: [Qemu-devel] [PATCH] trace: fix trace-events-all dependencies
 in Makefile.objs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lin Ma <lma@suse.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

On Mon, Feb 13, 2017 at 05:27:09PM +0800, Lin Ma wrote:
> It causes that file trace-events-all isn't generated during build, make
> install reports 'No such file or directory'. The patch fixes it.
> 
> Signed-off-by: Lin Ma <lma@suse.com>
> ---
>  trace/Makefile.objs | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/trace/Makefile.objs b/trace/Makefile.objs
> index 7de840a..8e5e85a 100644
> --- a/trace/Makefile.objs
> +++ b/trace/Makefile.objs
> @@ -17,7 +17,7 @@ $(BUILD_DIR)/trace-events-all: $(trace-events-files)
>  
>  $(obj)/generated-helpers-wrappers.h: $(obj)/generated-helpers-wrappers.h-timestamp
>  	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
> -$(obj)/generated-helpers-wrappers.h-timestamp: $(trace-events-files) $(BUILD_DIR)/config-host.mak $(tracetool-y)
> +$(obj)/generated-helpers-wrappers.h-timestamp: $(BUILD_DIR)/trace-events-all $(BUILD_DIR)/config-host.mak $(tracetool-y)

This dependancy change is not right. The correct fix is here

  https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00959.html


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
