Received: from eggs.gnu.org ([2001:4830:134:3::10]:46910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cY8ma-0004wG-6z
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 05:01:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cY8mX-0006a1-5k
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 05:01:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35516
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1cY8mX-0006Xc-05
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 05:01:53 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0U9rbsl118225
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 05:01:51 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 289ywy7bcb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 05:01:51 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 30 Jan 2017 03:01:50 -0700
References: <69936381-a99e-adc4-5de0-0f9bdf85323b@weilnetz.de>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 30 Jan 2017 11:01:43 +0100
MIME-Version: 1.0
In-Reply-To: <69936381-a99e-adc4-5de0-0f9bdf85323b@weilnetz.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <f2110c0b-45b5-e2d0-b95d-a12d402cad1d@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] target/s390x: Fix broken user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 01/28/2017 09:36 AM, Stefan Weil wrote:
> Returning NULL from get_max_cpu_model results in a SIGSEGV runtime error.
> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
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
>   static S390CPUModel *get_max_cpu_model(Error **errp)
>  {

I have for whatever reasons problems with this patch. Looks like you pasted
it into thunderbird or something like that and the whitespaces look mangled,
e.g. look at the indentation of static vs {.

> -#ifndef CONFIG_USER_ONLY
>      static S390CPUModel max_model;
>      static bool cached;
>  @@ -680,7 +679,6 @@ static S390CPUModel *get_max_cpu_model(Error **errp)
>          cached = true;
>          return &max_model;
>      }
> -#endif
>      return NULL;
>  }
>  -- 2.1.4
> 
> 
