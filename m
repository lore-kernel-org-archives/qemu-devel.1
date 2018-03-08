Received: from eggs.gnu.org ([2001:4830:134:3::10]:48780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eu1lb-0007q2-IG
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 15:03:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eu1lW-0000ZH-MZ
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 15:03:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eu1lW-0000Yy-Hj
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 15:03:50 -0500
Date: Thu, 8 Mar 2018 17:03:45 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180308200345.GD3417@localhost.localdomain>
References: <1520530757-4477-1-git-send-email-ian.jackson@eu.citrix.com>
	<1520530757-4477-4-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520530757-4477-4-git-send-email-ian.jackson@eu.citrix.com>
Subject: Re: [Qemu-devel] [PATCH 03/11] xen: defer call to xen_restrict
 until just before os_setup_post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>

On Thu, Mar 08, 2018 at 05:39:09PM +0000, Ian Jackson wrote:
[...]
> diff --git a/vl.c b/vl.c
> index dae986b..e6e8e1e 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4719,6 +4719,7 @@ int main(int argc, char **argv, char **envp)
>          vm_start();
>      }
>  
> +    xen_setup_post();

I don't think we should have accelerator-specific code in main(),
if we already have accelerator classes that can abstract that
out.  I suggest adding a AccelClass;:setup_post() method that can
be called here.

-- 
Eduardo
