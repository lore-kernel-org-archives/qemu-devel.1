Received: from eggs.gnu.org ([2001:4830:134:3::10]:32782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ejUFq-00085u-J8
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:15:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ejUFn-0001uu-E7
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:15:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55092
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ejUFn-0001uj-80
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:15:31 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w17I8lLw111571
	for <qemu-devel@nongnu.org>; Wed, 7 Feb 2018 13:15:29 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g044tf86v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 13:15:28 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 7 Feb 2018 18:15:27 -0000
References: <20180207123833.211687-1-borntraeger@de.ibm.com>
	<20180207175810.6db572e7.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 7 Feb 2018 19:15:22 +0100
MIME-Version: 1.0
In-Reply-To: <20180207175810.6db572e7.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <238dde55-387e-7f99-b557-67759d182ce3@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v6] s390x/cpu: expose the guest crash
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Bjoern Walk <bwalk@linux.vnet.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>



On 02/07/2018 05:58 PM, Cornelia Huck wrote:

> 
>> +##
>> +# @S390CrashReason:
>> +#
>> +# Reason why the CPU is in a crashed state.
>> +#
>> +# @unknown: no crash reason was set
>> +#
>> +# @disabledwait: the CPU has entered a disabled wait state
>> +#
>> +# @extintloop: timer interrupt with new PSW enabled for timer
>> +#
>> +# @pgmintloop: program interrupt with BAD new PSW
>> +#
>> +# @opintloop: operation exception interrupt with invalid code at the program
>> +#             interrupt new PSW
>> +#
>> +# Since: 2.12
>> +##
>> +{ 'enum': 'S390CrashReason',
>> +  'data': [ 'unknown',
>> +            'disabledwait',
>> +            'extintloop',
>> +            'pgmintloop',
>> +            'opintloop' ] }
> 
> Would some hyphens or underscores make this a bit more readable? FWICS,
> QAPI would create something like S390_CRASH_REASON_DISABLED_WAIT for
> 'disabled-wait', which looks reasonable to me.


disabled-wait
extint-loop
pgmint-loop
opint-loop 

?
> 
> With the build fix and the description change for extintloop, this
> looks fine to me (with or without a changed enum).
> 
