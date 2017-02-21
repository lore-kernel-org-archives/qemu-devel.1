Received: from eggs.gnu.org ([2001:4830:134:3::10]:59046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cg6fe-00010W-Aa
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:23:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cg6fa-0001Qq-Ep
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:23:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46230
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cg6fa-0001Q2-7l
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:23:38 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1L9E2gr096269
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 04:23:37 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28rg6w6b1j-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 04:23:37 -0500
Received: from localhost
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Tue, 21 Feb 2017 14:53:34 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <c12cf81e-9d49-ff45-e94e-fd441cf8302d@twiddle.net>
References: <1487585521-19445-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487585521-19445-7-git-send-email-nikunj@linux.vnet.ibm.com>
	<c12cf81e-9d49-ff45-e94e-fd441cf8302d@twiddle.net>
Date: Tue, 21 Feb 2017 14:53:28 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87bmtvdhin.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH v1 06/10] target/ppc: use tcg ops for neg
 instruction
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
>>  static void gen_neg(DisasContext *ctx)
>>  {
>> -    gen_op_arith_neg(ctx, 0);
>> +    tcg_gen_neg_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)]);
>>  }
>>
>
> NACK.  You're forgetting "neg.".

Oops, i totally missed that. :(

Regards
Nikunj
