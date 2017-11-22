Received: from eggs.gnu.org ([2001:4830:134:3::10]:52825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eHYCX-0004pB-9t
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 11:48:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eHYCS-0003KS-9Z
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 11:48:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34584
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eHYCS-0003KC-3X
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 11:48:36 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAMGi5WR022942
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 11:48:33 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2edcbm2k39-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 11:48:32 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 22 Nov 2017 16:48:31 -0000
References: <20171122163733.4007-1-pbonzini@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 22 Nov 2017 17:48:28 +0100
MIME-Version: 1.0
In-Reply-To: <20171122163733.4007-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <e0e56414-cde9-e403-2cfe-be3476331163@de.ibm.com>
Subject: Re: [Qemu-devel] [qemu-web PATCH] css: avoid over-large images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com

On 11/22/2017 05:37 PM, Paolo Bonzini wrote:
> Make sure that images are scaled to fit inside their container.

Thanks God. I was thinking "what is wrong with the channel subsystem in QEMU?" when
reading your subject.....
 
> Tested-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  assets/css/style.css | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/assets/css/style.css b/assets/css/style.css
> index 2d4fe0c..b828887 100644
> --- a/assets/css/style.css
> +++ b/assets/css/style.css
> @@ -200,6 +200,10 @@
> 
>  	/* Images */
> 
> +		img {
> +			max-width: 100%;
> +		}
> +
>  		.image
>  		{
>  			display: inline-block;
> 
