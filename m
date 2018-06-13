Received: from eggs.gnu.org ([2001:4830:134:3::10]:56257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fT1SL-0001xp-Jh
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fT1SI-0003jm-HW
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:48:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38472 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1fT1SI-0003jB-C1
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:48:38 -0400
Date: Wed, 13 Jun 2018 10:48:34 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180613104834.7a372e7b.cohuck@redhat.com>
In-Reply-To: <20180612221923.24469-1-mdroth@linux.vnet.ibm.com>
References: <20180612221923.24469-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] docs: add details regarding submitting
 stable-specific patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org

On Tue, 12 Jun 2018 17:19:23 -0500
Michael Roth <mdroth@linux.vnet.ibm.com> wrote:

> Also add a few more details regarding normal master->stable patch
> flow.
> 
> Cc: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---
>  docs/devel/stable-process.rst | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/docs/devel/stable-process.rst b/docs/devel/stable-process.rst
> index 98736a9ea4..008fb4f9b4 100644
> --- a/docs/devel/stable-process.rst
> +++ b/docs/devel/stable-process.rst
> @@ -56,6 +56,21 @@ There are various ways to get a patch into stable:
>    appropriate other people (like the patch author or the relevant maintainer)
>    on copy.
>  
> +Generally patches for a stable release/branch must first be included in the
> +master QEMU branch, and from there the stable branch's maintainer will
> +cherry-pick/backport the patch. However, occasionally there is a need to
> +apply a stable-specific patch, such as a fix from master that isn't easily
> +cherry-picked and has been reworked/backported specifically for a stable
> +branch, or a fix that's only necessary in the context of a particular stable
> +release. In such cases, the patch can be submitted to qemu-devel@nongnu.org
> +using Cc: qemu-stable@nongnu.org just like a normal stable patch, but tagged
> +with a "for-stable" or a "for-<stable-version>" in the subject line to
> +indicate that's it's specifically for a stable branch and not master. For

s/that's/that/

> +instance:
> +
> +  [PATCH for-2.11.2] spapr: make pseries-2.11 the default machine type
> +
> +
>  Stable release process
>  ----------------------
>  

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
