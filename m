Received: from eggs.gnu.org ([2001:4830:134:3::10]:35230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dsSkS-0000SO-3o
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:56:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dsSkO-0002wZ-9A
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:56:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dsSkN-0002uo-W4
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:55:56 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8EBswGZ097692
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 07:55:54 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cyqvb68uu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 07:55:53 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 14 Sep 2017 12:55:51 +0100
References: <1505385363-27717-1-git-send-email-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 14 Sep 2017 13:55:46 +0200
MIME-Version: 1.0
In-Reply-To: <1505385363-27717-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <473d7e2e-2313-3228-259c-b00fd6b1356c@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] configure: Allow --enable-seccomp on s390x, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Eduardo Otubo <otubo@redhat.com>, Christian Ehrhardt <christian.ehrhardt@canonical.com>

On 09/14/2017 12:36 PM, Thomas Huth wrote:
> libseccomp supports s390x since version 2.3.0, and I was able to start
> a VM with "-sandbox on" without any obvious problems by using this patch,
> so it should be safe to allow --enable-seccomp on s390x nowadays, too.

Seems to work fine on s390x.
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index fd7e3a5..83ba64e 100755
> --- a/configure
> +++ b/configure
> @@ -2032,7 +2032,7 @@ if test "$seccomp" != "no" ; then
>      arm|aarch64)
>          libseccomp_minver="2.2.3"
>          ;;
> -    ppc|ppc64)
> +    ppc|ppc64|s390x)
>          libseccomp_minver="2.3.0"
>          ;;
>      *)
> 
