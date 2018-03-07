Received: from eggs.gnu.org ([2001:4830:134:3::10]:37988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1etTNr-0001sL-Mj
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 02:21:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1etTNo-0000sz-GA
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 02:21:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38512 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1etTNo-0000st-B3
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 02:21:04 -0500
Date: Wed, 7 Mar 2018 12:50:54 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <1513877118-3149-3-git-send-email-jack.schwartz@oracle.com>
Message-ID: <nycvar.YSQ.7.76.1803071249330.20163@wniryva>
References: <1513877118-3149-1-git-send-email-jack.schwartz@oracle.com>
	<1513877118-3149-3-git-send-email-jack.schwartz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH QEMU v1 2/4] multiboot: Remove unused
 variables from multiboot.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jack Schwartz <jack.schwartz@oracle.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, konrad.wilk@oracle.com, daniel.kiper@oracle.com, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net

+-- On Thu, 21 Dec 2017, Jack Schwartz wrote --+
| Remove unused variables: mh_mode_type, mh_width, mh_height, mh_depth
| 
| Signed-off-by: Jack Schwartz <jack.schwartz@oracle.com>
| Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
| ---
|  hw/i386/multiboot.c | 6 ------
|  1 file changed, 6 deletions(-)
| 
| diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
| index ff2733d..964feaf 100644
| --- a/hw/i386/multiboot.c
| +++ b/hw/i386/multiboot.c
| @@ -255,12 +255,6 @@ int load_multiboot(FWCfgState *fw_cfg,
|              mb_kernel_size = mb_load_size;
|          }
|  
| -        /* Valid if mh_flags sets MULTIBOOT_HEADER_HAS_VBE.
| -        uint32_t mh_mode_type = ldl_p(header+i+32);
| -        uint32_t mh_width = ldl_p(header+i+36);
| -        uint32_t mh_height = ldl_p(header+i+40);
| -        uint32_t mh_depth = ldl_p(header+i+44); */
| -

+1 They are anyway comments.
Reviewed-by: Prasad J Pandit <pjp@fedoraproject.org>

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
