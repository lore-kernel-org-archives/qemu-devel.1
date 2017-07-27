Received: from eggs.gnu.org ([2001:4830:134:3::10]:59204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dafWY-00028h-Le
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:56:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dafWU-0007VO-UV
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:56:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dafWU-0007V3-NY
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:56:02 -0400
Date: Thu, 27 Jul 2017 10:55:58 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170727095557.GA2080@work-vm>
References: <1501149097-19071-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501149097-19071-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tests/hmp: Fix typo in the
 'chardev-send-break' test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Fritsch <sf@sfritsch.de>

* Thomas Huth (thuth@redhat.com) wrote:
> testchardev2 is not a valid chardev id here. Use testchardev1
> instead which has been created with chardev-add right before
> the 'chardev-send-break' line.
> And while we're at it, add the test-hmp.c file to the MAINTAINERS
> file, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  MAINTAINERS      | 1 +
>  tests/test-hmp.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5ea273f..ce2341a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1346,6 +1346,7 @@ F: monitor.c
>  F: hmp.[ch]
>  F: hmp-commands*.hx
>  F: include/monitor/hmp-target.h
> +F: tests/test-hmp.c
>  
>  Network device backends
>  M: Jason Wang <jasowang@redhat.com>
> diff --git a/tests/test-hmp.c b/tests/test-hmp.c
> index d77b3c8..729c033 100644
> --- a/tests/test-hmp.c
> +++ b/tests/test-hmp.c
> @@ -22,7 +22,7 @@ static int verbose;
>  static const char *hmp_cmds[] = {
>      "boot_set ndc",
>      "chardev-add null,id=testchardev1",
> -    "chardev-send-break testchardev2",
> +    "chardev-send-break testchardev1",
>      "chardev-change testchardev1 ringbuf",
>      "chardev-remove testchardev1",
>      "commit all",
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
