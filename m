Received: from eggs.gnu.org ([209.51.188.92]:38615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1h0rmC-0004pM-FH
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:53:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1h0rmB-0005YP-Iv
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:53:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1h0rmB-0005Wp-6x
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:53:19 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x24HmiXL046333
	for <qemu-devel@nongnu.org>; Mon, 4 Mar 2019 12:53:13 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r1716wffa-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 12:53:12 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 4 Mar 2019 17:53:10 -0000
References: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
	<20190304172423.482162ab.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 4 Mar 2019 18:53:05 +0100
MIME-Version: 1.0
In-Reply-To: <20190304172423.482162ab.cohuck@redhat.com>
Content-Language: en-US
Message-Id: <50fdb5b8-64e4-5202-df1b-e1c3fa037ac3@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 00/16] s390: vfio-ccw dasd ipl support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, alifm@linux.ibm.com, Thomas Huth <thuth@redhat.com>



On 04.03.2019 17:24, Cornelia Huck wrote:
> On Fri,  1 Mar 2019 13:59:20 -0500
> "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
> 
>> This is to support booting from vfio-ccw dasd devices. We basically implement
>> the real hardware ipl procedure. This allows for booting Linux guests on
>> vfio-ccw devices.
>>
>> vfio-ccw's channel program prefetch algorithm complicates ipl because most ipl
>> channel programs dynamically modify themselves. Details on the ipl process and
>> how we worked around this issue can be found in docs/devel/s390-dasd-ipl.txt.
>>
>> Note to Connie: In the v2 review you mentioned some issues with the error
>> handling code involving printing of the eckd dasd sense data. I've addressed
>> those concerns in a new patch just to make those changes clearly stand out from
>> the rest of the code. I can squash them into patches 10, 11, and 15 if you
>> prefer that to having it as a separate patch.
> 
> Whatever makes sense... but I'll let the s390 bios maintainers decide.

Both variants are fine with me.
> 
> Speaking of which: Please do keep Thomas on cc:...
> 
> [This is probably a bit late for 4.0, as softfreeze is next Tuesday and
> pull requests for master need to be on-list by then... speaking of pull
> requests: I'd prefer to queue this via a pull request from the bios
> maintainers rather than picking the patches myself, if possible.]


there are still some minor discussions on the patch set, but I (or Thomas) can
certainly pick up the next version and send a pull request. 
Thomas do you want to do it or shall I take care about it?
