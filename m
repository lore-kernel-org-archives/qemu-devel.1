Received: from eggs.gnu.org ([2001:4830:134:3::10]:36152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1f4Q8F-00079r-Kf
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:06:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1f4Q8A-0002d9-H4
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:06:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1f4Q8A-0002c6-7f
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:06:10 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w36C4xr6005065
	for <qemu-devel@nongnu.org>; Fri, 6 Apr 2018 08:06:08 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h67xh1qr0-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 08:06:07 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Fri, 6 Apr 2018 06:06:05 -0600
References: <20180405162347.5623-1-pbonzini@redhat.com>
	<5a3d6ece-e68b-5eae-3808-510c4eed4d68@linux.vnet.ibm.com>
	<a94422e9-833f-db3a-fc38-39fab45f1850@redhat.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Fri, 6 Apr 2018 09:06:01 -0300
MIME-Version: 1.0
In-Reply-To: <a94422e9-833f-db3a-fc38-39fab45f1850@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <47635625-d092-1990-8d97-2978038126d4@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 0/2] hw/scsi: support SCSI-2 passthrough
 without PI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com



On 04/06/2018 07:12 AM, Paolo Bonzini wrote:
> On 06/04/2018 01:10, Daniel Henrique Barboza wrote:
>> Yet another fix is to fully prohibit the user to set scsi_version
>> scsi-block and scsi-generic cases, returning an error message right of=
f
>> the start. Not sure how hard this would be - perhaps the above
>> alternatives are cleaner.
>>
>> Another fix is ... no fix. I am not sure how far the design philosophy
>> of passthrough devices allows the user to overwrite device parameters =
in
>> despite of their real values, but ....=C2=A0 what if the user wants to
>> enforce a scsi_version when using a scsi-block device? The device will
>> surely behave badly, but the user explicitly enforced it via command
>> line, so perhaps let him/her have at it?
> Yeah, that was the idea.  Removing it is as easy as dropping the
> DEFINE_PROP_INT32 and initializing to -1 in scsi_block_realize (just
> like for scsi_generic_realize), but for now we can keep it.  My usecase
> was more to downgrade scsi_version from newer to 2.

I agree. +1 for pulling the patch series as is.


Thanks,


Daniel


>
> Paolo
>
