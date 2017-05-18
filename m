Received: from eggs.gnu.org ([2001:4830:134:3::10]:37877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dBLAz-00061M-Vo
	for qemu-devel@nongnu.org; Thu, 18 May 2017 09:09:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dBLAw-00080L-0E
	for qemu-devel@nongnu.org; Thu, 18 May 2017 09:09:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1dBLAv-0007zu-MR
	for qemu-devel@nongnu.org; Thu, 18 May 2017 09:09:05 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4ID8W7U096399
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 09:09:03 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ahb4qbgxt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 09:09:03 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 18 May 2017 14:09:01 +0100
Date: Thu, 18 May 2017 15:08:56 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170517004813.58227-2-bjsdjshi@linux.vnet.ibm.com>
References: <20170517004813.58227-1-bjsdjshi@linux.vnet.ibm.com>
	<20170517004813.58227-2-bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170518150856.50c90513.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v8 01/13] update-linux-headers: update for
 vfio-ccw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, eric.auger@redhat.com

On Wed, 17 May 2017 02:48:01 +0200
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> Add vfio_ccw.h.
> 
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---
>  scripts/update-linux-headers.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> index 6a370a8669..2f906c4d16 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -113,7 +113,7 @@ done
> 
>  rm -rf "$output/linux-headers/linux"
>  mkdir -p "$output/linux-headers/linux"
> -for header in kvm.h kvm_para.h vfio.h vhost.h \
> +for header in kvm.h kvm_para.h vfio.h vfio_ccw.h vhost.h \
>                psci.h userfaultfd.h; do
>      cp "$tmpdir/include/linux/$header" "$output/linux-headers/linux"
>  done

I have included this in a complete linux-headers update.
