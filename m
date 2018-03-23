Received: from eggs.gnu.org ([2001:4830:134:3::10]:36720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ezNlC-0004tJ-3V
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:33:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ezNl8-0003ZS-6s
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:33:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57278
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ezNl8-0003Z9-1n
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:33:34 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2NEKOZc151646
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 10:33:33 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gw2ktjfa9-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 10:33:33 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 23 Mar 2018 14:33:31 -0000
References: <20180323140821.28957-1-peterx@redhat.com>
	<20180323141536.GR32362@xz-mi>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 23 Mar 2018 15:33:25 +0100
MIME-Version: 1.0
In-Reply-To: <20180323141536.GR32362@xz-mi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <fcad740c-6819-ba5b-38ac-3a436f84d23d@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 0/4] Turn OOB off for 2.12-rc1,
 revert OOB tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Eric Auger <eric.auger@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>



On 03/23/2018 03:15 PM, Peter Xu wrote:
> On Fri, Mar 23, 2018 at 10:08:17PM +0800, Peter Xu wrote:
>> Temporarily disable OOB for 2.12 since it break (a lot of) things.
>> Luckily it's only a switch so not so hard. Meanwhile, revert all new
>> tests that checks against it.
>>
>> Tests done: all target builds and "make check" passed, but only on
>> x86_64 host.  It can pass all "raw" iotests, but some "qcow2" iotests
>> are still failing.  I can even reproduce many of the qcow2 fails even
>> before the whole OOB series, so I suppose that's something already
>> exists so I'll ignore.
>>
>> More tests are really welcomed.  Thanks,

Series
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>


> 
> CC Eric Blake too.
> 
