Received: from eggs.gnu.org ([2001:4830:134:3::10]:50609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dKUzM-0003OU-6G
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 15:27:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dKUzJ-0002lh-1u
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 15:27:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43000
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1dKUzI-0002lI-Sr
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 15:26:56 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5CJPMwE046142
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 15:26:55 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2b1v8jed91-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 15:26:55 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 12 Jun 2017 13:26:54 -0600
References: <1494921494-33717-1-git-send-email-amarnath.valluri@intel.com>
	<1494921494-33717-9-git-send-email-amarnath.valluri@intel.com>
	<ed18ccaf-926a-96b8-a1d9-54c9c7f8ab1f@linux.vnet.ibm.com>
	<1496647607.25318.16.camel@intel.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 12 Jun 2017 15:26:49 -0400
MIME-Version: 1.0
In-Reply-To: <1496647607.25318.16.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <dc6f405d-4420-4431-1d0f-28c4467256e1@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 8/8] tpm: Added support for TPM emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Valluri, Amarnath" <amarnath.valluri@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 06/05/2017 03:25 AM, Valluri, Amarnath wrote:
> On Wed, 2017-05-24 at 11:15 -0400, Stefan Berger wrote:
>> On 05/16/2017 03:58 AM, Amarnath Valluri wrote:
>>> This change introduces a new TPM backend driver that can
>>> communicate with
>>> swtpm(software TPM emulator) using unix domain socket interface.
>>>
>>> Swtpm uses two unix sockets, one for plain TPM commands and
>>> responses, and one
>>> for out-of-band control messages.
>>>
>>> The swtpm and associated tools can be found here:
>>>       https://github.com/stefanberger/swtpm
>>>
>>> The swtpm's control channel protocol specification can be found
>>> here:
>>>       https://github.com/stefanberger/swtpm/wiki/Control-Channel-Spe
>>> cification
>>>
>>> Usage:
>>>       # setup TPM state directory
>>>       mkdir /tmp/mytpm
>>>       chown -R tss:root /tmp/mytpm
>>>       /usr/bin/swtpm_setup --tpm-state /tmp/mytpm --createek
>>>
>>>       # Ask qemu to use TPM emulator with given tpm state directory
>>>       qemu-system-x86_64 \
>>>           [...] \
>>>           -tpmdev
>>> emulator,id=tpm0,tpmstatedir=/tmp/mytpm,logfile=/tmp/swtpm.log \
>>>           -device tpm-tis,tpmdev=tpm0 \
>>>           [...]
>>>
>>> Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
>> Since you are not supporting migration in this patch, you probably
>> have
>> to add a migrate_add_blocker() call somewhere along the lines of this
>> here:
>>
>> https://github.com/stefanberger/qemu-tpm/commit/27d332dc3b2c6bfd0fcd3
>> 8e69f5c899651f3a5d8#diff-3a0192eef5d20837af490c32bf396f4eR641
>>
> I need to dig a bit and femiliarize myself about 'migration' support, I
> guess i can send it as a separate patch ?

Fine by me.

>
> - Amarnath
