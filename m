Received: from eggs.gnu.org ([2001:4830:134:3::10]:49434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cqcFW-0000Cx-Ij
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 05:08:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cqcFS-0005cG-IS
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 05:08:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45034
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1cqcFS-0005c8-C0
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 05:08:06 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2M94YVx085008
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 05:08:04 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29bnw7s920-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 05:08:04 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 22 Mar 2017 05:08:03 -0400
References: <20170130131517.8092-1-sw@weilnetz.de>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 22 Mar 2017 10:07:59 +0100
MIME-Version: 1.0
In-Reply-To: <20170130131517.8092-1-sw@weilnetz.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Message-Id: <d2935727-a192-878d-49fe-77d6c4f14fb1@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] target/s390x: Fix broken user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

On 01/30/2017 02:15 PM, Stefan Weil wrote:
> Returning NULL from get_max_cpu_model results in a SIGSEGV runtime error.
> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
> 
> v2: Re-sent as v1 was damaged by my mailer.
> 
> This is also broken in Debian.
> 
> In addition, there is no default CPU ("any"), so binfmt and related
> actions currently don't work. I hacked my local installation by
> duplicating the "qemu" cpu definition for "any", but maybe there is
> a better solution.

applied to our tree. Do we need cc stable as well?


> 
> Regards
> Stefan
> 
>  target/s390x/cpu_models.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 2a894ee..6e34763 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -660,7 +660,6 @@ static void check_compatibility(const S390CPUModel *max_model,
> 
>  static S390CPUModel *get_max_cpu_model(Error **errp)
>  {
> -#ifndef CONFIG_USER_ONLY
>      static S390CPUModel max_model;
>      static bool cached;
> 
> @@ -680,7 +679,6 @@ static S390CPUModel *get_max_cpu_model(Error **errp)
>          cached = true;
>          return &max_model;
>      }
> -#endif
>      return NULL;
>  }
> 
