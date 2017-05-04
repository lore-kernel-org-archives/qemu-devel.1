Received: from eggs.gnu.org ([2001:4830:134:3::10]:36968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1d6EcS-0005cz-PJ
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:08:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1d6EcK-0007wv-GR
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:08:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36226
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1d6EcK-0007vI-AH
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:08:16 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v44B46f0009697
	for <qemu-devel@nongnu.org>; Thu, 4 May 2017 07:08:14 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a7m0rbp6u-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 04 May 2017 07:08:13 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 4 May 2017 05:08:13 -0600
References: <CAJ+F1C+gLTVpZZeKtxuLFUgs6nJ0KbgnJp4VdAuuM4JK2RbYMA@mail.gmail.com>
	<38a2aa2e-6270-63af-3dec-bd666d56780d@linux.vnet.ibm.com>
	<CAJ+F1CKcZvWE4OQOMKuDqNvKGEQK3DdihM6Eyx-piqtQtSbXGQ@mail.gmail.com>
	<5ee48b85-0404-a810-95b5-4b19b197373e@linux.vnet.ibm.com>
	<1493749518.4241.225.camel@intel.com>
	<CAJ+F1CK4jN2Nb6eKB1x9Km0xnurs976=Kb0idFpPgtH+JHYTcQ@mail.gmail.com>
	<b6e0d6d2-d276-c66d-ae5e-c6502cbe0b5c@linux.vnet.ibm.com>
	<20170503084136.GC4121@redhat.com> <20170503111659.GA2077@work-vm>
	<CAJ+F1CJ2JnLS2BbMWES0HQ3-iJUzXrrj21RVPo70d04xpWbgDQ@mail.gmail.com>
	<20170503112948.GA3985@redhat.com>
	<14dc8420-0a21-b92e-4e50-a92676d35b96@linux.vnet.ibm.com>
	<1493891098.4241.285.camel@intel.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 4 May 2017 07:08:06 -0400
MIME-Version: 1.0
In-Reply-To: <1493891098.4241.285.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <242ac1b9-1b2e-f8b2-a29e-2fd6dd4a63cf@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 8/8] tpm: Added support for TPM emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Patrick Ohly <patrick.ohly@intel.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Amarnath Valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org

On 05/04/2017 05:44 AM, Patrick Ohly wrote:
> On Wed, 2017-05-03 at 10:42 -0400, Stefan Berger wrote:
>>    - the TPM 2 part , as stated before, is still somewhat in flux. I am
>> not sure when there will be a final TPM 2 from TCG. There the
>> possibility exists that the state blobs the TPM 2 is writing out still
>> change. I have added a version tag in front of the blobs so in case
>> something else gets added that that can be accommodated. Besides that
>> it's also adapted to write the state blobs in big endian format for the
>> same reason as above. Maybe at some point I'll just freeze the code and
>> don't follow the ongoing TPM 2 development anymore besides bug fixes to
>> exsting code, which then freezes the state blobs as well.
> Ignoring the "work in progress" status of TPM 2 and your
> https://github.com/stefanberger/swtpm/tree/tpm2-preview branch, should
> your current code already also work with the qemu device backend that is
> getting discussed here?

Yes.

>
> In other words, are protocol changes needed? I know that TPM 2 has
> changed the commands, but I don't know whether that affects also the
> lower layers.
>
No, should work as-is.
