Received: from eggs.gnu.org ([2001:4830:134:3::10]:49851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cqcGn-0000zy-LN
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 05:09:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cqcGj-0005nb-Ll
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 05:09:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33948
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1cqcGj-0005nU-GL
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 05:09:25 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2M93a5r006899
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 05:09:24 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29b9vk9gwg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 05:09:24 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 22 Mar 2017 05:09:23 -0400
References: <20170130131517.8092-1-sw@weilnetz.de>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 22 Mar 2017 10:09:17 +0100
MIME-Version: 1.0
In-Reply-To: <20170130131517.8092-1-sw@weilnetz.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Message-Id: <e1595ad1-0de1-3f59-1bac-812a437f6c1f@de.ibm.com>
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

applied to our tree. Do we need cc stable?
