Received: from eggs.gnu.org ([2001:4830:134:3::10]:47573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1ek3Xs-0003CV-CD
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 02:56:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1ek3Xp-0005Zd-8K
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 02:56:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1ek3Xo-0005Wf-Vl
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 02:56:29 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w197smb1087454
	for <qemu-devel@nongnu.org>; Fri, 9 Feb 2018 02:56:26 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g16sfadw1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 02:56:24 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Fri, 9 Feb 2018 07:56:22 -0000
References: <20180208111732.09869f84@redhat.com>
	<20180208203342.GE13981@localhost.localdomain>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Fri, 9 Feb 2018 08:56:19 +0100
MIME-Version: 1.0
In-Reply-To: <20180208203342.GE13981@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <f8157f02-4c16-6811-7857-e1ec4d55d49c@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] qmp: add query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com, berrange@redhat.com

On 08.02.2018 21:33, Eduardo Habkost wrote:
> On Thu, Feb 08, 2018 at 11:17:32AM -0500, Luiz Capitulino wrote:
> [...]
>> The "halted" field is somewhat controversial. On the one hand,
>> it offers a convenient way to know if a guest CPU is idle or
>> running. On the other hand, it's a field that can change many
>> times a second. In fact, the halted state can change even
>> before query-cpus-fast has returned. This makes one wonder if
>> this field should be dropped all together. Having the "halted"
>> field as optional gives a better option for dropping it in
>> the future, since we can just stop returning it.
> 
> I'd just drop it, unless we find a use case where it's really
> useful.
> 
> Also, the code that sets/clears cpu->halted is target-specific,
> so I wouldn't be so sure that simply checking for
> !kvm_irqchip_in_kernel() is enough on all targets.
> 
Right, the present patch effectively disables halted anyway (including
s390). So it may be cleaner to just drop it right now.
Assuming the presence of architecure-specific data, libvirt can derive a
halted state (or an equivalent thereof) from query-cpus-fast returned
information.

-- 
Regards,
 Viktor Mihajlovski
