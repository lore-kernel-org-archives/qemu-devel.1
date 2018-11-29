Received: from eggs.gnu.org ([2001:4830:134:3::10]:34968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gSU8W-00009T-At
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 16:46:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gSU8T-0006mP-4H
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 16:46:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45302
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1gSU8S-0006lp-To
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 16:46:13 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wATLhvFN056517
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 16:46:12 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2p2q2fjycb-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 16:46:12 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Thu, 29 Nov 2018 21:46:11 -0000
References: <faeb4b80-e191-d670-d057-28eb4ac11d11@linux.ibm.com>
	<79b674dd-d5b5-ff7c-7497-6fce2cb31b8a@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Thu, 29 Nov 2018 16:46:07 -0500
MIME-Version: 1.0
In-Reply-To: <79b674dd-d5b5-ff7c-7497-6fce2cb31b8a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <d72e0106-2395-5154-68bf-b7ed55551c1e@linux.ibm.com>
Subject: Re: [Qemu-devel] qemu-iotests 232 fails when running the test as
 root user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>



On 11/29/2018 04:07 PM, Eric Blake wrote:
> On 11/29/18 3:03 PM, Farhan Ali wrote:
>> Hi,
>>
>> I am seeing a failure of the qemu-iotest number 232 when running the 
>> test as a root user. Is this the expected behavior?
>>
>> Here is the output of the failure:
>>
> 
>> -QEMU_PROG: -drive 
>> driver=file,file=TEST_DIR/t.IMGFMT,if=none,read-only=off,auto-read-only=off: 
>> Could not open 'TEST_DIR/t.IMGFMT': Permission denied
>> -NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
>> -NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
>> -
>> -QEMU_PROG: -drive 
>> driver=file,file=TEST_DIR/t.IMGFMT,if=none,auto-read-only=off: Could 
>> not open 'TEST_DIR/t.IMGFMT': Permission denied
>> -NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
>> -NODE_NAME: TEST_DIR/t.IMGFMT (file, read-only)
>> +NODE_NAME: TEST_DIR/t.IMGFMT (file)
> 
> Not entirely unexpected (since root can read what are otherwise 
> read-only files), but obviously unexpected by the test. The test should 
> probably refuse to run as root.
> 

Yes, I believe it would be better if there was a check to prevent 
running this test as root.

Thanks
Farhan
