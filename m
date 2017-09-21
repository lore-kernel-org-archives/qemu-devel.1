Received: from eggs.gnu.org ([2001:4830:134:3::10]:38204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1duwU3-0003ul-99
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:05:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1duwU1-0008Hd-L4
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 04:05:19 -0400
Date: Thu, 21 Sep 2017 10:05:11 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170921100511.2f082330@nial.brq.redhat.com>
In-Reply-To: <1505811746-29439-1-git-send-email-thuth@redhat.com>
References: <1505811746-29439-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] trivial: Add missing "-m" parameter in
 docs/memory-hotplug.txt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org

On Tue, 19 Sep 2017 11:02:26 +0200
Thomas Huth <thuth@redhat.com> wrote:

> The example obviously lacks the "-m" parameter.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  docs/memory-hotplug.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/memory-hotplug.txt b/docs/memory-hotplug.txt
> index 56bdd0a..d96397c 100644
> --- a/docs/memory-hotplug.txt
> +++ b/docs/memory-hotplug.txt
> @@ -24,7 +24,7 @@ Where,
>  
>  For example, the following command-line:
>  
> - qemu [...] 1G,slots=3,maxmem=4G
> + qemu [...] -m 1G,slots=3,maxmem=4G
>  
>  Creates a guest with 1GB of memory and three hotpluggable memory slots.
>  The hotpluggable memory slots are empty when the guest is booted, so all
