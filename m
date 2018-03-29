Received: from eggs.gnu.org ([2001:4830:134:3::10]:39973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f1W1s-0007XQ-0P
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 07:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f1W1o-0000yn-OY
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 07:47:39 -0400
References: <152231456507.69730.15601462044394150786.stgit@bahia.lan>
	<152231458624.69730.1752893648612848392.stgit@bahia.lan>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d0678319-ed49-1ad0-8019-0c292be50434@redhat.com>
Date: Thu, 29 Mar 2018 13:47:33 +0200
MIME-Version: 1.0
In-Reply-To: <152231458624.69730.1752893648612848392.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 1/3] exec: fix memory leak in
 find_max_supported_pagesize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-stable@nongnu.org, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 29.03.2018 11:09, Greg Kurz wrote:
> The string returned by object_property_get_str() is dynamically allocated.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  exec.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/exec.c b/exec.c
> index c09bd93df31e..02b1efebb7c3 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1495,6 +1495,7 @@ static int find_max_supported_pagesize(Object *obj, void *opaque)
>          mem_path = object_property_get_str(obj, "mem-path", NULL);
>          if (mem_path) {
>              long hpsize = qemu_mempath_getpagesize(mem_path);
> +            g_free(mem_path);
>              if (hpsize < *hpsize_min) {
>                  *hpsize_min = hpsize;
>              }
> 
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
