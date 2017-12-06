Received: from eggs.gnu.org ([2001:4830:134:3::10]:54873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eMbyT-0007tk-Jy
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 10:51:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eMbyO-0004Dj-KX
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 10:51:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38412
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eMbyO-0004DX-Cf
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 10:51:00 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6FosuQ058342
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 10:50:55 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2epkbygj7x-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 10:50:55 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 08:50:30 -0700
References: <20171206120217.11392-1-danielhb@linux.vnet.ibm.com>
	<20171206120217.11392-2-danielhb@linux.vnet.ibm.com>
	<d3550f4f-adc1-ff8e-5aa7-7b1c815f2c90@redhat.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Wed, 6 Dec 2017 13:50:24 -0200
MIME-Version: 1.0
In-Reply-To: <d3550f4f-adc1-ff8e-5aa7-7b1c815f2c90@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <7379da29-1f3e-fe61-6216-67c8839bb8a4@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] qmp: introduce
 query-wakeup-from-suspend-support command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, dgilbert@redhat.com, armbru@redhat.com



On 12/06/2017 12:26 PM, Eric Blake wrote:
> On 12/06/2017 06:02 AM, Daniel Henrique Barboza wrote:
>> When issuing the qmp/hmp 'system_wakeup' command, what happens in a
>> nutshell is:
>>
>> This patch implements a new QMP command called
>> 'query-wakeup-from-suspend-support' that allows the caller to query
>> if the guest supports wake up from suspend via system_wakeup. It
>> goes over the subscribers of the wake up event and, if it's empty,
>> it assumes that the guest does not support wake up from suspend
>> (and thus, pm-suspend itself).
>>
>> This is the expected output of the command when running a x86 guest:
>>
>> {"execute" : "query-wakeup-from-suspend-support"}
>> {"return": {"enabled": true}}
> Do we really need a new command, or can we add it as an additional field
> to an existing command (for example, in MachineInfo under
> query-machines, or TargetInfo under query-target)?

A new QMP command was the first idea that crossed my mind but yeah, adding
the info to an existing command is also valid IMO.


Daniel

>
