Received: from eggs.gnu.org ([2001:4830:134:3::10]:48531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eEzRx-0008SF-4F
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 10:18:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eEzRt-0003RA-TW
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 10:18:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52206
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eEzRt-0003Ou-NO
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 10:17:57 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAFFGVIH106648
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 10:17:52 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e8qxhrhpe-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 10:17:51 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 15 Nov 2017 15:17:50 -0000
References: <20171110090354.29608-1-kraxel@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 15 Nov 2017 16:17:46 +0100
MIME-Version: 1.0
In-Reply-To: <20171110090354.29608-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <0c272cd1-6eeb-c1e9-def8-ebf3fafa2aea@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] fix scripts/update-linux-headers.sh here
 document
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org


On 11/10/2017 10:03 AM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>  scripts/update-linux-headers.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> index 8b847e279b..e2b159aa3d 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -108,7 +108,7 @@ for arch in $ARCHLIST; do
>      if [ $arch = x86 ]; then
>          cat <<-EOF >"$output/include/standard-headers/asm-x86/hyperv.h"
>          /* this is a temporary placeholder until kvm_para.h stops including it */
> -        EOF
> +EOF
>          cp "$tmpdir/include/asm/unistd_32.h" "$output/linux-headers/asm-x86/"
>          cp "$tmpdir/include/asm/unistd_x32.h" "$output/linux-headers/asm-x86/"
>          cp "$tmpdir/include/asm/unistd_64.h" "$output/linux-headers/asm-x86/"
> 
