Received: from eggs.gnu.org ([2001:4830:134:3::10]:48783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cJXeg-0002Q7-96
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 22:33:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cJXec-0001PN-Ub
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 22:33:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cJXec-0001P3-On
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 22:33:22 -0500
Date: Wed, 21 Dec 2016 11:33:13 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20161221033313.GD22006@pxdev.xzpeter.org>
References: <1482158486-18597-1-git-send-email-peterx@redhat.com>
	<148227497312.73.13130379400389723612@790289a7ca88>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <148227497312.73.13130379400389723612@790289a7ca88>
Subject: Re: [Qemu-devel] [PATCH] intel_iommu: allow dynamic switch of IOMMU
 region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com, david@gibson.dropbear.id.au

On Tue, Dec 20, 2016 at 03:02:54PM -0800, no-reply@patchew.org wrote:

[...]

> === OUTPUT BEGIN ===
> Checking PATCH 1/1: intel_iommu: allow dynamic switch of IOMMU region...
> ERROR: "(foo**)" should be "(foo **)"
> #55: FILE: hw/i386/intel_iommu.c:1190:
> +    while (g_hash_table_iter_next (&iter, NULL, (void**)&vtd_bus)) {
> 
> ERROR: space prohibited between function name and open parenthesis '('
> #55: FILE: hw/i386/intel_iommu.c:1190:
> +    while (g_hash_table_iter_next (&iter, NULL, (void**)&vtd_bus)) {
> 
> total: 2 errors, 0 warnings, 118 lines checked

Hmm, let me fix.

-- peterx
