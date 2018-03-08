Received: from eggs.gnu.org ([2001:4830:134:3::10]:33518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1etzcD-0004Kg-3O
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:46:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1etzc9-00039Y-6b
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:46:05 -0500
Received: from smtp.citrix.com ([66.165.176.89]:3323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1etzc8-00039L-Vh
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:46:01 -0500
From: Ian Jackson <ian.jackson@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23201.30422.443155.208749@mariner.uk.xensource.com>
Date: Thu, 8 Mar 2018 17:45:58 +0000
In-Reply-To: <1520530757-4477-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1520530757-4477-1-git-send-email-ian.jackson@eu.citrix.com>
Subject: Re: [Qemu-devel] [PATCH v6 00/11] xen: xen-domid-restrict
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>

For reasons I still don't quite understand, this cover letter was not
sent to the whole CC list so I am doing that by hand now.

Ian Jackson writes ("[PATCH v6 00/11] xen: xen-domid-restrict improvements"):
> This series provides necessary support for running qemu as a Xen
> device model without power equivalent to root.  In particular, it
> makes -xen-domid-restrict effective.
> 
> I have taken into account all the comments from v5 (from October!) and
> there are also two new patches from Ross Lagerwall.
> 
>   m  a [PATCH 01/11] xen: link against xentoolcore
>      a [PATCH 02/11] xen: restrict: use xentoolcore_restrict_all
>     r  [PATCH 03/11] xen: defer call to xen_restrict until just before
>      a [PATCH 04/11] xen: destroy_hvm_domain: Move reason into a variable
>     ra [PATCH 05/11] xen: move xc_interface compatibility fallback further
>   * r  [PATCH 06/11] xen: destroy_hvm_domain: Try xendevicemodel_shutdown
>   * r  [PATCH 07/11] os-posix: Provide new -runas <uid>:<gid> facility
>   m    [PATCH 08/11] configure: do_compiler: Dump some extra info under bash
>   +    [PATCH 09/11] xen: Use newly added dmops for mapping VGA memory
>   +    [PATCH 10/11] xen: Expect xenstore write to fail when restricted
>   +    [PATCH 11/11] scripts/get_maintainer.pl: Print proper error message
> 
>  m = commit message (only) changed in v6 of the series
>  * = patch changed in v6 of the series
>  + = new patch
>  r = reviewed (by someone other than me)
>  a = acked
> 
> Thanks for your attention.
> 
> Regards,
> Ian.
