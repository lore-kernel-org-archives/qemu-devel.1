Received: from eggs.gnu.org ([2001:4830:134:3::10]:41955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1ch43n-0002Eo-LW
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 19:48:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1ch43k-00020P-K5
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 19:48:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40864
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1ch43k-00020B-D7
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 19:48:32 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1O0htvb113005
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 19:48:31 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28t4yqmua5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 19:48:31 -0500
Received: from localhost
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 24 Feb 2017 06:18:28 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <755c77c5-0930-b5ee-0b3b-1e0608301c8d@twiddle.net>
References: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487879800-12352-7-git-send-email-nikunj@linux.vnet.ibm.com>
	<755c77c5-0930-b5ee-0b3b-1e0608301c8d@twiddle.net>
Date: Fri, 24 Feb 2017 06:18:22 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87a89cza5l.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH v4 06/15] target/ppc: remove xer split-out
 flags(so, ov, ca)
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
>> Now get rid all the split out variables so, ca, ov. After this patch,
>> all the bits are stored in CPUPPCState::xer at appropriate places.
>>
>> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>> ---
>>  target/ppc/cpu.c        |   8 +---
>>  target/ppc/cpu.h        |  26 ++++++------
>>  target/ppc/int_helper.c |  12 +++---
>>  target/ppc/translate.c  | 106 +++++++++++++++++++++++++-----------------------
>>  4 files changed, 78 insertions(+), 74 deletions(-)
>
> I do not think this is a good direction to take this.

Hmm, any particular reason?

I can send back the v3 with suggested changes dropping the xer split out
changes.

Regards
Nikunj
