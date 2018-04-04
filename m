Received: from eggs.gnu.org ([2001:4830:134:3::10]:55627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1f3e5W-0002ck-Cc
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:48:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1f3e5T-0002ho-Ak
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:48:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bala24@linux.vnet.ibm.com>)
	id 1f3e5T-0002hf-1u
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:48:11 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w348ixlS081138
	for <qemu-devel@nongnu.org>; Wed, 4 Apr 2018 04:48:09 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h4pvhb4m3-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 04:48:09 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bala24@linux.vnet.ibm.com>;
	Wed, 4 Apr 2018 04:48:08 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Apr 2018 14:19:38 +0530
From: Balamuruhan S <bala24@linux.vnet.ibm.com>
In-Reply-To: <20180404080600.GA10540@xz-mi>
References: <bb088a1ba2e344273db32402f7c9fae4@linux.vnet.ibm.com>
	<20180404080600.GA10540@xz-mi>
Message-Id: <0a48a834f08d064eaa3eb4ef1b41235f@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] migration: calculate expected_downtime
 with ram_bytes_remaining()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, amit.shah@redhat.com, quintela@redhat.com

On 2018-04-04 13:36, Peter Xu wrote:
> On Wed, Apr 04, 2018 at 11:55:14AM +0530, Balamuruhan S wrote:
> 
> [...]
> 
>> > too. So still I'll put aside the "which one is better" question.
>> >
>> > For your use case, you can have a look on either of below way to
>> > have a converged migration:
>> >
>> > - auto-converge: that's a migration capability that throttles CPU
>> >   usage of guests
>> 
>> I used auto-converge option before hand and still it doesn't help
>> for migration to complete
> 
> Have you digged about why?  AFAIK auto-convergence will at last absort
> merely the whole vcpu resource (99% of them maximum).  Maybe you are
> not with the best throttle values?  Or do you think that could be a
> auto-convergence bug too?

I am not sure, I will work on it to find why.

> 
>> 
>> >
>> > - postcopy: that'll let you start the destination VM even without
>> >   transferring all the RAMs before hand
>> 
>> I am seeing issue in postcopy migration between POWER8(16M) -> 
>> POWER9(1G)
>> where the hugepage size is different. I am trying to enable it but 
>> host
>> start
>> address have to be aligned with 1G page size in 
>> ram_block_discard_range(),
>> which I am debugging further to fix it.
> 
> I thought the huge page size needs to be matched on both side
> currently for postcopy but I'm not sure.

you are right! it should be matched, but we need to support
POWER8(16M) -> POWER9(1G)

> CC Dave (though I think Dave's still on PTO).
