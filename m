Received: from eggs.gnu.org ([2001:4830:134:3::10]:56956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1eu0pP-0000mK-Db
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:03:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1eu0pL-0002cc-Fe
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:03:47 -0500
Received: from smtp.citrix.com ([66.165.176.89]:27694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1eu0pL-0002cK-7y
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:03:43 -0500
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Thu, 8 Mar 2018 19:02:55 +0000
Message-ID: <1520535787-6223-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6.1 00/11] xen: xen-domid-restrict
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
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

This just-amended series provides necessary support for running qemu
as a Xen device model without power equivalent to root.  In
particular, it makes -xen-domid-restrict effective.

Compared to v6, it fixes some minor checkpatch, style and portability
issues.  Sorry for the earlier troubled submission.

Compared to v5, I have taken into account all the comments from v5
(from October!) and there are also two new patches from Ross
Lagerwall.

 +.    [PATCH 01/12] checkpatch: Add xendevicemodel_handle to the list of     
 m   a [PATCH 02/12] xen: link against xentoolcore                            
     a [PATCH 03/12] xen: restrict: use xentoolcore_restrict_all              
    r  [PATCH 04/12] xen: defer call to xen_restrict until just before        
     a [PATCH 05/12] xen: destroy_hvm_domain: Move reason into a variable     
    ra [PATCH 06/12] xen: move xc_interface compatibility fallback further    
 *. r  [PATCH 07/12] xen: destroy_hvm_domain: Try xendevicemodel_shutdown     
 *. r  [PATCH 08/12] os-posix: Provide new -runas <uid>:<gid> facility        
 m     [PATCH 09/12] configure: do_compiler: Dump some extra info under bash  
 +.    [PATCH 10/12] xen: Use newly added dmops for mapping VGA memory        
 +     [PATCH 11/12] xen: Expect xenstore write to fail when restricted       
 +     [PATCH 12/12] scripts/get_maintainer.pl: Print proper error message    

 m = commit message (only) changed in v6.1 of the series (compared to v5)
 * = patch changed in v6.1 of the series (compared to v5)
 + = new patch
 . = changes made in v6.1 (compared to v6)
 r = reviewed (by someone other than me)
 a = acked

Thanks for your attention.

Regards,
Ian.
