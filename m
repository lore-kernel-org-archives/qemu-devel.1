Received: from eggs.gnu.org ([2001:4830:134:3::10]:41691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1ch42J-00017d-BP
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 19:47:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1ch42G-0001Nn-AH
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 19:47:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1ch42G-0001NX-0m
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 19:47:00 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1O0i1AO095373
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 19:46:58 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28t0avkadd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 19:46:57 -0500
Received: from localhost
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 24 Feb 2017 10:46:55 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <7ceb696b-d4b3-86a6-a1db-47e46de7dcb4@twiddle.net>
References: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487879800-12352-3-git-send-email-nikunj@linux.vnet.ibm.com>
	<7ceb696b-d4b3-86a6-a1db-47e46de7dcb4@twiddle.net>
Date: Fri, 24 Feb 2017 06:15:58 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87d1e8za9l.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH v4 02/15] target/ppc: update ov flag from
 remaining paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

Richard Henderson <rth@twiddle.net> writes:

> On 02/24/2017 06:56 AM, Nikunj A Dadhania wrote:
>> @@ -320,22 +320,24 @@ target_ulong helper_divo(CPUPPCState *env, target_ulong arg1,
>>                           target_ulong arg2)
>>  {
>>      uint64_t tmp = (uint64_t)arg1 << 32 | env->spr[SPR_MQ];
>> +    int ov;
>>
>>      if (((int32_t)tmp == INT32_MIN && (int32_t)arg2 == (int32_t)-1) ||
>>          (int32_t)arg2 == 0) {
>> -        env->so = env->ov = 1;
>> +        ov = 1;
>>          env->spr[SPR_MQ] = 0;
>>          return INT32_MIN;
>>      } else {
>>          env->spr[SPR_MQ] = tmp % arg2;
>>          tmp /= (int32_t)arg2;
>>          if ((int32_t)tmp != tmp) {
>> -            env->so = env->ov = 1;
>> +            ov = 1;
>>          } else {
>> -            env->ov = 0;
>> +            ov = 0;
>>          }
>>          return tmp;
>>      }
>> +    helper_update_ov_legacy(env, ov);
>>  }
>>
>
> You're attempting to run the helper after "return".

Right, will correct it.

Regards
Nikunj
