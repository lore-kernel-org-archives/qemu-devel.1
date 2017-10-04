Received: from eggs.gnu.org ([2001:4830:134:3::10]:46901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dzfAw-0005Av-Ug
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 04:37:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dzfAt-0007ij-3x
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 04:37:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dzfAs-0007i9-V2
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 04:37:03 -0400
Date: Wed, 4 Oct 2017 09:36:57 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171004083657.GE17517@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171004030025.7866-1-ehabkost@redhat.com>
	<20171004030025.7866-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171004030025.7866-3-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] qemu-options: Deprecate -nodefconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair23@gmail.com>

On Wed, Oct 04, 2017 at 12:00:25AM -0300, Eduardo Habkost wrote:
> Since 2012 (commit ba6212d8 "Eliminate cpus-x86_64.conf file") we
> have no default config files that would be disabled using
> -nodefconfig.  Update documentation and document -nodefconfig as
> deprecated.
> 
> Cc: Markus Armbruster <armbru@redhat.com>
> Acked-by: Alistair Francis <alistair.francis@xilinx.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v2 -> v3:
> * Move documentation to the right section of qemu-doc.texi
> 
> Changes v1 -> v2:
> * Document at "Deprecated features" section in qemu-doc.texi
>   (Daniel)
> * Remove documentation for the option from qemu-options.hx
>   (Markus)
> ---
>  qemu-doc.texi   |  4 ++++
>  qemu-options.hx | 17 ++++-------------
>  2 files changed, 8 insertions(+), 13 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
