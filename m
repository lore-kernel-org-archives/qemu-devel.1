Received: from eggs.gnu.org ([2001:4830:134:3::10]:39566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1g7LJ7-0004yU-GK
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 10:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1g7LJ2-0003rF-Fv
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 10:05:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58707
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1g7LJ2-0003qc-AD
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 10:05:44 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w92Dws73135107
	for <qemu-devel@nongnu.org>; Tue, 2 Oct 2018 10:05:43 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2mv82qwbda-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 10:05:42 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Tue, 2 Oct 2018 08:05:41 -0600
References: <20180926225440.6204-1-akrowiak@linux.vnet.ibm.com>
	<20180927112852.71782355.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Tue, 2 Oct 2018 10:05:30 -0400
MIME-Version: 1.0
In-Reply-To: <20180927112852.71782355.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <1b1126bc-ca9a-ff38-bce9-c9330320d8ef@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v9 0/6] s390x: vfio-ap: guest dedicated
 crypto adapters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net, fiuczy@linux.ibm.com, mimu@linux.ibm.com

On 09/27/2018 05:28 AM, Cornelia Huck wrote:
> On Wed, 26 Sep 2018 18:54:34 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> 
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> This patch series is the QEMU counterpart to the KVM/kernel support for
>> guest dedicated crypto adapters. The KVM/kernel model is built on the
>> VFIO mediated device framework and provides the infrastructure for
>> granting exclusive guest access to crypto devices installed on the linux
>> host. This patch series introduces a new QEMU command line option, QEMU
>> object model and CPU model features to exploit the KVM/kernel model.
>>
>> See the detailed specifications for AP virtualization provided by this
>> patch set in docs/vfio-ap.txt for a more complete discussion of the
>> design introduced by this patch series.
> 
> This seems to look sane in general. However, before I merge this:
> 
> - This needs to wait for a proper headers sync, which can only be done
>    after the Linux code hits upstream. Shouldn't be long, I guess (I can
>    queue on a staging branch while waiting.)
> - As I don't have the hardware, I cannot run more than some generic
>    "verify it does not break anything" testing. So, I'd like to see a
>    Tested-by by someone who actually does have access to the hardware.
> - I'd like to see some more review/acks from others. If other (minor)
>    things crop up, I'd prefer a respin (I don't want to juggle too many
>    "minor changes"...)

I am planning on a v10 series to address issues raised by Thomas, David
and you.

> 
