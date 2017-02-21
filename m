Received: from eggs.gnu.org ([2001:4830:134:3::10]:58914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cg6f8-0000iS-TZ
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:23:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cg6f5-0001Da-0E
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:23:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45453
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cg6f4-0001CT-PJ
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:23:06 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1L9E1Ys096150
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 04:23:05 -0500
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28rg6w6ads-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 04:23:05 -0500
Received: from localhost
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Tue, 21 Feb 2017 14:53:02 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <785114cf-ae1e-fff2-4f20-7c2183475db2@twiddle.net>
References: <1487585521-19445-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487585521-19445-6-git-send-email-nikunj@linux.vnet.ibm.com>
	<785114cf-ae1e-fff2-4f20-7c2183475db2@twiddle.net>
Date: Tue, 21 Feb 2017 14:52:51 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87efyrdhjo.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH v1 05/10] target/ppc: update overflow flags
 for add/sub
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

> On 02/20/2017 09:11 PM, Nikunj A Dadhania wrote:
>>      tcg_temp_free(t0);
>> +    tcg_gen_extract_tl(cpu_ov32, cpu_ov, 31, 1);
>> +    tcg_gen_extract_tl(cpu_ov, cpu_ov, 63, 1);
>>      if (NARROW_MODE(ctx)) {
>> -        tcg_gen_ext32s_tl(cpu_ov, cpu_ov);
>> +        tcg_gen_mov_tl(cpu_ov, cpu_ov32);
>>      }
>> -    tcg_gen_shri_tl(cpu_ov, cpu_ov, TARGET_LONG_BITS - 1);
>
> Don't compute ov32 only to overwrite it again.  Move the ov32 extraction into 
> an else of NARROW_MODE.

Sure.

Regards
Nikunj
