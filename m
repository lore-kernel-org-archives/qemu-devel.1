Received: from eggs.gnu.org ([2001:4830:134:3::10]:39765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eLs2A-0008LJ-Ll
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 09:47:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eLs27-00051G-F9
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 09:47:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57368
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eLs27-00050t-99
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 09:47:47 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB4EiXOM106250
	for <qemu-devel@nongnu.org>; Mon, 4 Dec 2017 09:47:42 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2en5a3k186-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 04 Dec 2017 09:47:42 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 4 Dec 2017 14:47:40 -0000
References: <20171128134648.21530-1-cohuck@redhat.com>
	<6513d1c5-032e-b9d0-3dab-f2d0bd337ae2@linux.vnet.ibm.com>
	<20171128152718.229a20fe.cohuck@redhat.com>
	<bf78fad3-b6b2-bf82-2625-477233adb6cf@linux.vnet.ibm.com>
	<389e2efe-cbc5-8a78-e009-cd330d4ede6a@linux.vnet.ibm.com>
	<20171204102220.31fce015.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 4 Dec 2017 15:47:37 +0100
MIME-Version: 1.0
In-Reply-To: <20171204102220.31fce015.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <f3a922c1-6b8e-8c97-2809-ee929a79d744@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC 0/2] s390x: cut down on unattached
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, borntraeger@de.ibm.com, pmorel@linux.vnet.ibm.com



On 12/04/2017 10:22 AM, Cornelia Huck wrote:
> On Fri, 1 Dec 2017 15:41:21 +0100
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> On 11/28/2017 04:21 PM, Halil Pasic wrote:
>> [..]
>>>>> Otherwise at first glance both patches seem sane.  
>>>>
>>>> Can I count this as an ack, or do you plan to do more review?
>>>>  
>>>
>>> Yes I was planning to give it another look. And I do already
>>> have questions. Isn't the QOM composition tree API? I mean
>>> let's assume the QMP commands working on this tree are not completely
>>> useless. How is client code (management software) supposed to work,
>>> assumed it can rely on paths of e.g. properties being stable. Just
>>> imagine we had this default-cssid property (for the sake of the
>>> argument, not like we want it) on the css bridge.  
>>
>> Ping! I would like to get this clarified before proceeding with reviewing
>> this series.
> 
> [It might be helpful to not drop cc:s.]
> 

Sorry. Wrong button.

> I don't think we really want a static tree. As long as the devices are
> locateable, it should be fine.
> 

What do you mean by locateable in particular?

Let's say I'm management software guy who want's to access a certain
property of a certain device. For that I'm supposed to use qom-get. Now
qom-get takes a path as input argument (absolute or relative). The question
is, how I'm supposed to figure out this path as management software developer?
In other words what is the algorithm?

One naive approach would be, to assume that the path is stable between
releases. So I have to figure it out when I'm implementing the stuff,
and then it keeps working ever after. I read your answer as this naive
approach is wrong.

(BTW I find static also confusing in this context.)

[..]
