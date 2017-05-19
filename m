Received: from eggs.gnu.org ([2001:4830:134:3::10]:55030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dBgDb-0001Qk-0x
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:37:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dBgDX-0006XC-T9
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:37:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52999
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dBgDX-0006Wm-Nj
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:37:11 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4JBYRRM015959
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 07:37:08 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ahts7wx6u-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 07:37:08 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 19 May 2017 12:37:06 +0100
References: <20170510151209.32767-1-pasic@linux.vnet.ibm.com>
	<20170518174714.GK2079@work-vm>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 19 May 2017 13:37:04 +0200
MIME-Version: 1.0
In-Reply-To: <20170518174714.GK2079@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <14e80dcc-9e3b-4a45-0dbe-735ad2590ade@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] s390x/css: catch section mismatch on
 load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org



On 05/18/2017 07:47 PM, Dr. David Alan Gilbert wrote:
>> Hi!
>>
>> I also wonder what is the best way to do this with vmstate.  I know there
>> are VMSTATE_*_EQUAL macros for integers, and I have partially modelled my
>> patch after that, but there we only get a != b as error message, which is
>> satisfactory for detecting bugs which are supposed to get fixed. In this
>> particular case having a verbose error message should be really helpful
>> and thus important.
>>
>> I'm asking because I'm currently working on a vmstate conversion of the
>> s390x css and virtio-ccw  stuff (find my latest patch set here
>> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg01364.html).
> I think the way to solve that problem will probably be adding a 'hint'
> parameter to the VMSTATE_*_EQUAL macros that is a constant string,
> stuff a pointer to that into a possibly new field in VMStateField,
> and then make the get_*_equal functions include that string in the
> message like you do.  There's a lot of copy and paste but it's
> not too bad now that Jianjun's patch from a few months ago passed
> the VMStateField* to the .get/.put.
> 
> Dave
> 
> 

Thanks Dave! I read your reply like you are seeing this verbose
message if VMSTATE_*_EQUAL feature something worth of inclusion.
Am I right? 

If yes, I'm willing to implement it.

Halil
