Received: from eggs.gnu.org ([2001:4830:134:3::10]:50062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eMBya-0006YB-Ew
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 07:05:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eMByZ-0007bo-5F
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 07:05:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eMByY-0007bb-ON
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 07:05:27 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB5C4bnY134179
	for <qemu-devel@nongnu.org>; Tue, 5 Dec 2017 07:05:22 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2enu28gc1h-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 07:05:20 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 5 Dec 2017 12:05:14 -0000
References: <20171201143136.62497-1-pasic@linux.vnet.ibm.com>
	<20171201143136.62497-4-pasic@linux.vnet.ibm.com>
	<927acf90-4a00-3fa2-9bf3-e34afc6be199@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 5 Dec 2017 13:05:11 +0100
MIME-Version: 1.0
In-Reply-To: <927acf90-4a00-3fa2-9bf3-e34afc6be199@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <f892b02d-58b6-bb81-439c-f9177259f013@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 3/3] s390x: deprecate
 s390-squash-mcss machine prop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 12/05/2017 09:41 AM, Thomas Huth wrote:
> On 01.12.2017 15:31, Halil Pasic wrote:
>> With the cssids unrestricted (commit <COMMIT HERE> "s390x/css: unrestrict
>> cssids") the s390-squash-mcss machine property should not be used.
>> Actually libvirt never supported this, so the expectation is that
>> removing it should be pretty painless.  But let's play nice and deprecate
>> it first.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> ---
> [...]
>> diff --git a/qemu-doc.texi b/qemu-doc.texi
>> index db2351c746..874432d87c 100644
>> --- a/qemu-doc.texi
>> +++ b/qemu-doc.texi
>> @@ -2501,6 +2501,14 @@ enabled via the ``-machine usb=on'' argument.
>>  
>>  The ``-nodefconfig`` argument is a synonym for ``-no-user-config``.
>>  
>> +@subsection -machine virtio-ccw,s390-squash-mcss=on|off (since 2.12.0)
> 
> The machine is called "s390-ccw-virtio", not "virtio-ccw". Anyway, I
> think you could also rather omit the machine name here (since it is the
> default) and just write "-machine s390-squash-mcss=on|off".
> 
>  Thomas
> 

Good catch! Regarding omitting the machine name, I was surprised that
it works, but it does. Our documentation is a bit strange on this: we
document the machine name as non-optional:
"-machine [type=]name[,prop=value[,...]]"
but then use -machine prop=value in the deprecation section (that's
with no name).

Since the documentation doesn't make it clear that the property is
existent only for the s390-ccw-virtio family of the machines I think
being your suggestion has a lot of charm. @Connie: do you agree to
removing the machine name (type)?

Thanks!
Halil
