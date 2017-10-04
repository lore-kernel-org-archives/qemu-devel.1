Received: from eggs.gnu.org ([2001:4830:134:3::10]:50776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dzjqM-0002ip-2v
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1dzjqG-000448-6R
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:36:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55384
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1dzjqG-00043i-0i
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:36:04 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v94DZNG7136342
	for <qemu-devel@nongnu.org>; Wed, 4 Oct 2017 09:35:59 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dcxvf735y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 09:35:59 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 4 Oct 2017 09:35:58 -0400
References: <1506683421-27004-1-git-send-email-amarnath.valluri@intel.com>
	<1506683421-27004-9-git-send-email-amarnath.valluri@intel.com>
	<306334f5-358e-a7df-b663-b1b77e78c934@linux.vnet.ibm.com>
	<1507103131.2282.5.camel@intel.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 4 Oct 2017 09:35:55 -0400
MIME-Version: 1.0
In-Reply-To: <1507103131.2282.5.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <4cd9e414-3c21-6627-94db-99832529ac05@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v10 8/9] tpm: Added support for TPM emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Valluri, Amarnath" <amarnath.valluri@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>

On 10/04/2017 03:45 AM, Valluri, Amarnath wrote:
> On Tue, 2017-10-03 at 17:21 -0400, Stefan Berger wrote:
>> On 09/29/2017 07:10 AM, Amarnath Valluri wrote:
>>> This change introduces a new TPM backend driver that can
>>> communicate with
>>> swtpm(software TPM emulator) using unix domain socket interface.
>>> QEMU talks to
>>> TPM emulator using QEMU's socket-based chardev backend device.
>>>
>>> Swtpm uses two Unix sockets for communications, one for plain TPM
>>> commands and
>>> responses, and one for out-of-band control messages. QEMU passes
>>> data socket to
>>> be used over the control channel.
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
>> To run this, one needs the latest version of swtpm that supports the
>> file descriptor passing.
>> Then one can start the swtpm like this:
>>
>> swtpm socket --tpmstate dir=/tmp/mytpm --ctrl
>> type=unixio,path=/tmp/swtpm-sock --log level=20
>>
>> I tested the SeaBIOS menu items so far and that works fine, also for
>> TPM2 (--tpm2).
> Greate, Thanks for you feedback.

Thanks for the great work. I will try to fix up the requests for v10 
before sending out a pull request for the series. :-)

    Stefan


>
> - Amarnath
