Received: from eggs.gnu.org ([209.51.188.92]:54497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1hDTTI-0001It-9s
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 08:33:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1hDTTG-0003vT-Gb
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 08:33:55 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <i.maximets@samsung.com>)
	id 1hDTTA-0003ov-PN
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 08:33:50 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
	20190408123342euoutp025f3a148c3785953af3b756f3c24f2ffb~Tf87afdpS0613506135euoutp02D
	for <qemu-devel@nongnu.org>; Mon,  8 Apr 2019 12:33:42 +0000 (GMT)
From: Ilya Maximets <i.maximets@samsung.com>
Message-ID: <c138abfe-61fd-6e04-8900-2ba2a24073de@samsung.com>
Date: Mon, 8 Apr 2019 15:33:39 +0300
MIME-Version: 1.0
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
References: <CGME20190408123341eucas1p2add7886160b2b66912413defd4544d1f@eucas1p2.samsung.com>
Subject: [Qemu-devel]  [PATCH 00/97] Patch Round-up for stable 3.0.1,
 freeze on 2019-04-08
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-stable@nongnu.org, dgilbert@redhat.com

> Hi everyone,                                                                    
>                           
> 
> The following new patches are queued for QEMU stable v3.0.1:
> 
>   https://github.com/mdroth/qemu/commits/stable-3.0-staging
> 
> The release is planned for 2019-04-11:
> 
>   https://wiki.qemu.org/Planning/3.0
> 
> Please respond here or CC address@hidden on any patches you
> think should be included in the release.
> 
> Note that this update falls outside the normal stable release support
> window (~1 development cycle), but is being release now since it was
> delayed from its intended release date.
> 
> Thanks!
> 

[...]

> 
> Ilya Maximets (1):
>       migration: Stop postcopy fault thread before notifying

Hi.

Sorry for late response, but what about following two patches:

  c4f753859ae6 ("vhost-user: Fix userfaultfd leak")
  5ce43896e167 ("vhost-user: Don't ask for reply on postcopy mem table set")

?

Best regards, Ilya Maximets.
