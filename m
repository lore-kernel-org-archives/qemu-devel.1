Received: from eggs.gnu.org ([2001:4830:134:3::10]:52538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dYBE4-0007Hk-9I
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 09:10:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dYBE1-0003xR-FK
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 09:10:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56667
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dYBE1-0003x4-6I
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 09:10:41 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6KD9Djf115398
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 09:10:40 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2btuhn4n7c-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 09:10:40 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 20 Jul 2017 09:10:39 -0400
References: <1500550051-7821-1-git-send-email-borntraeger@de.ibm.com>
	<1500550051-7821-2-git-send-email-borntraeger@de.ibm.com>
	<20170720150537.1bf00f96@gondolin>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 20 Jul 2017 15:10:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170720150537.1bf00f96@gondolin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <706a3c69-3558-940c-fd42-4f2a88277cdc@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] s390/cpumodel: remove KSS from the
 default model of z14
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

On 07/20/2017 03:05 PM, Cornelia Huck wrote:
> On Thu, 20 Jul 2017 13:27:31 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> The SIE_KSS feature will allow a guest to use KSS for a nested guest.
>> To create a nested guest the SIE_F2 facility is still necessary.
>> Since SIE_F2 is not part of the default model it does not make
>> a lot of sense to provide the SIE_KSS feature in the default model.
>> Let's also create a dependency check.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Reviewed-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
>> Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>> ---
>>  target/s390x/cpu_models.c   | 1 +
>>  target/s390x/gen-features.c | 1 -
>>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> I can either queue this; or, if you want to push this out as a fixup,
> feel free to add

I want this in 2.10, but it can wait some days of course. I am on vacation
starting end of next week, so maybe its better if you do the next round
(and also take care of Davids and Thomas patches if those are appropriate
for 2.10)

Thanks a lot
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> 
