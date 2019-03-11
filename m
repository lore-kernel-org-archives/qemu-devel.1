Received: from eggs.gnu.org ([209.51.188.92]:40711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1h3Osa-00084V-B8
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1h3Opu-0006WM-Qf
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:35:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1h3Opu-0006VB-Dj
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:35:38 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x2BHTMaO029264
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 13:35:35 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r5udp2864-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 13:35:35 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Mon, 11 Mar 2019 17:35:34 -0000
Reply-To: jjherne@linux.ibm.com
References: <1552317693-21979-1-git-send-email-jjherne@linux.ibm.com>
	<20190311183341.62500ec1.cohuck@redhat.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Mon, 11 Mar 2019 13:35:29 -0400
MIME-Version: 1.0
In-Reply-To: <20190311183341.62500ec1.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <8091e2af-2654-2f58-164c-28d208972a38@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 00/15] s390: vfio-ccw dasd ipl support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On 3/11/19 1:33 PM, Cornelia Huck wrote:
> On Mon, 11 Mar 2019 11:21:18 -0400
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
>> *********************
>> NOTE: Newer DASD units which initially present as control unit type 3990 may in
>> fact really be 2107. Some operating systems may enable 2107 features for these
>> devices thereby making sense id return a control unit type of 2107. I've added
>> support for control unit type 2107 so we can ipl from these devices.
>> *********************
> 
> Ugh. I'd have hoped that would have been recognized as A Bad Idea the
> last time we had a design like that...
> 
> Does that cu type switch persist over subchannel enable/disable?
> Subsystem reset?

It persists over a disable/enable, but not a reset it seems.

-- 
-- Jason J. Herne (jjherne@linux.ibm.com)
