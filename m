Received: from eggs.gnu.org ([2001:4830:134:3::10]:42381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgUJ4-0002tu-J6
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:37:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cgUJ1-0001pk-Gf
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:37:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45302
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cgUJ1-0001pJ-8t
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:37:55 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1MAYa2N112073
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 05:37:54 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28rm7ua7bc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 05:37:53 -0500
Received: from localhost
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 22 Feb 2017 16:07:50 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <e1087dd8-3bc2-002a-2293-83366eed6ee2@twiddle.net>
References: <1487755788-16415-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487755788-16415-5-git-send-email-nikunj@linux.vnet.ibm.com>
	<e1087dd8-3bc2-002a-2293-83366eed6ee2@twiddle.net>
Date: Wed, 22 Feb 2017 16:07:44 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87a89ebjev.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH v2 04/11] target/ppc: update ca32 in
 arithmetic add
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

> On 02/22/2017 08:29 PM, Nikunj A Dadhania wrote:
>> +            tcg_gen_mov_tl(cpu_ca32, cpu_ca);
>
> Should also be conditional on isa300.

Ah yes, will fix it.

Regards
Nikunj
