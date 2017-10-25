Received: from eggs.gnu.org ([2001:4830:134:3::10]:35825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e7IgN-00061o-CW
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 06:13:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e7IgI-0003Bt-AV
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 06:13:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57868
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1e7IgI-0003Ai-3X
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 06:13:02 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9PAA86E000857
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 06:12:59 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dtnrbt4hw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 06:12:58 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 25 Oct 2017 11:12:56 +0100
References: <20171020115803.14093-1-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 25 Oct 2017 12:12:51 +0200
MIME-Version: 1.0
In-Reply-To: <20171020115803.14093-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <3ad1ca10-68c6-eba4-c733-d4d95d2dc26f@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1] target/s390x: change CPU type name to
 "s390x-cpu"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, cohuck@redhat.com, Igor Mammedov <imammedo@redhat.com>

On 10/20/2017 01:58 PM, David Hildenbrand wrote:
> For now, e.g. host-s390-cpu wasn't exposed to the user. cpu-add, -cpu
> and the CPU model qmp interfaces didn't care about the actual type,
> as that information was hidden.
> 
> This changed with CPU hotplug via device_add. Now the type is visible to
> the user. Before we get that supported in a stable version, this is our
> last chance to change it.
> 
> So change it form "s390-cpu" to "s390x-cpu", to match the architecture
> name. Example names are then e.g. z14-s390x-cpu or qemu-s390x-cpu.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Thanks applied (with the typo fixed)
