Received: from eggs.gnu.org ([2001:4830:134:3::10]:55116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1eykkJ-0007k0-2D
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:54:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jack.schwartz@oracle.com>) id 1eykkF-0004fA-PT
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:54:07 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:50840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jack.schwartz@oracle.com>)
	id 1eykkF-0004dz-Fu
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:54:03 -0400
From: Jack Schwartz <jack.schwartz@oracle.com>
Date: Wed, 21 Mar 2018 13:53:47 -0700
Message-Id: <1521665627-5451-2-git-send-email-jack.schwartz@oracle.com>
In-Reply-To: <1521665627-5451-1-git-send-email-jack.schwartz@oracle.com>
References: <1521665627-5451-1-git-send-email-jack.schwartz@oracle.com>
Subject: [Qemu-devel] [PATCH 1/1] multiboot.c: Document as fixed against
 CVE-2018-7550
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, pjp@fedoraproject.org, kraxel@redhat.com
Cc: karl.heubaum@oracle.com, konrad.wilk@oracle.com, mark.kanda@oracle.com, jack.schwartz@oracle.com

This empty commit documents multiboot.c as fixed against CVE-2018-7550.
The fix, dated Dec 21 2017, went in before the CVE was created, as:
        2a8fcd119eb7 ("multiboot: bss_end_addr can be zero")

Fixes: CVE-2018-7550
Signed-off-by: Jack Schwartz <jack.schwartz@oracle.com>
Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
-- 
1.8.3.1
