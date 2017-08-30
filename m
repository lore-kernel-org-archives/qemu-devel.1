Received: from eggs.gnu.org ([2001:4830:134:3::10]:43678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn5VR-0007v2-Kf
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:06:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn5VM-0000az-Nu
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:06:17 -0400
Date: Wed, 30 Aug 2017 17:06:09 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170830160608.GW24565@stefanha-x1.localdomain>
References: <20170822131832.20191-1-pbonzini@redhat.com>
	<20170822131832.20191-10-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170822131832.20191-10-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/10] scsi: add multipath support to
 qemu-pr-helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org

On Tue, Aug 22, 2017 at 03:18:31PM +0200, Paolo Bonzini wrote:
> @@ -444,6 +740,11 @@ static int drop_privileges(void)
>                       CAP_SYS_RAWIO) < 0) {
>          return -1;
>      }
> +    /* For /dev/mapper/control ioctls */
> +    if (capng_update(CAPNG_ADD, CAPNG_EFFECTIVE | CAPNG_PERMITTED,
> +                     CAP_SYS_ADMIN) < 0) {
> +        return -1;
> +    }

Only if mpath is being used?  This capability isn't necessary with
ordinary sg_io so it would be nice to avoid keeping it in that case.
