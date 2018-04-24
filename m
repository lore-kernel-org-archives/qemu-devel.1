Received: from eggs.gnu.org ([2001:4830:134:3::10]:36429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6454bde7c=Ian.Jackson@citrix.com>)
	id 1fB2DA-000788-Mq
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 13:58:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6454bde7c=Ian.Jackson@citrix.com>)
	id 1fB2D5-0006ql-Si
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 13:58:40 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:9743)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=6454bde7c=Ian.Jackson@citrix.com>)
	id 1fB2D5-0006on-Jq
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 13:58:35 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Tue, 24 Apr 2018 18:58:13 +0100
Message-ID: <1524592709-6553-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v8 00/16] xen: xen-domid-restrict improvements
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

This series provides necessary support for running qemu as a Xen
device model without power equivalent to root.  In particular, it
makes -xen-domid-restrict effective.

Compared to v8, it addresses review comments.

      01/16 checkpatch: Add xendevicemodel_handle to the list of
  r   02/16 AccelClass: Introduce accel_setup_post
 * a  03/16 xen: link against xentoolcore
   a  04/16 xen: restrict: use xentoolcore_restrict_all
 * a  05/16 xen: defer call to xen_restrict until just before
   a  06/16 xen: destroy_hvm_domain: Move reason into a variable
   a  07/16 xen: move xc_interface compatibility fallback further
  r   08/16 xen: destroy_hvm_domain: Try xendevicemodel_shutdown
      09/16 os-posix: cleanup: Replace fprintfs with error_report in change_...
  r   10/16 os-posix: Provide new -runas <uid>:<gid> facility
   a  11/16 xen: Use newly added dmops for mapping VGA memory
   a  12/16 xen: Remove now-obsolete xen_xc_domain_add_to_physmap
   a  13/16 xen: Expect xenstore write to fail when restricted
 *r   14/16 os-posix: cleanup: Replace fprintf with error_report in remaining
  r   15/16 os-posix: cleanup: Replace perror with error_report
 *    16/16 configure: do_compiler: Dump some extra info under bash

 r = reviewed (by someone other than me)
 a = acked
 * = amended patch

Thanks for your attention.

Ian.
