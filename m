Received: from eggs.gnu.org ([2001:4830:134:3::10]:45953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cZiGX-0005sV-0L
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 13:07:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cZiGS-0002KL-24
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 13:07:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37352
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cZiGR-0002KA-Sn
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 13:07:16 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v13I3iP0112160
	for <qemu-devel@nongnu.org>; Fri, 3 Feb 2017 13:07:15 -0500
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28cxs388fs-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 13:07:14 -0500
Received: from localhost
	by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 3 Feb 2017 18:07:12 -0000
References: <1484727757-41240-1-git-send-email-arei.gonglei@huawei.com>
	<1484727757-41240-2-git-send-email-arei.gonglei@huawei.com>
	<20170203103316.GA29200@stefanha-x1.localdomain>
	<20170203173607-mutt-send-email-mst@kernel.org>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 3 Feb 2017 19:07:02 +0100
MIME-Version: 1.0
In-Reply-To: <20170203173607-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <1fdc2663-2090-9e19-5ea9-1f5b8eef4eb1@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v16 1/2] virtio-crypto: Add virtio crypto
 device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: weidong.huang@huawei.com, qemu-devel@nongnu.org, john.griffin@intel.com, jianjay.zhou@huawei.com, Varun.Sethi@freescale.com, denglingli@chinamobile.com, arei.gonglei@hotmail.com, virtio-dev@lists.oasis-open.org, agraf@suse.de, Gonglei <arei.gonglei@huawei.com>, nmorey@kalray.eu, longpeng2@huawei.com, vincent.jardin@6wind.com, Ola.Liljedahl@arm.com, luonengjun@huawei.com, xin.zeng@intel.com, liang.j.ma@intel.com, stefanha@redhat.com, cornelia.huck@de.ibm.com, Jani.Kokkonen@huawei.com, brian.a.keating@intel.com, claudio.fontana@huawei.com, mike.caraman@nxp.com, wu.wubin@huawei.com



On 02/03/2017 04:37 PM, Michael S. Tsirkin wrote:
> On Fri, Feb 03, 2017 at 10:33:16AM +0000, Stefan Hajnoczi wrote:
>>> +\begin{description}
>>> +\item[0] dataq1
>>> +\item[\ldots]
>>> +\item[N-1] dataqN
>>> +\item[N] controlq
>>> +\end{description}
>>> +
>>> +N is set by \field{max_dataqueues}.
>>> +
>>> +\subsection{Feature bits}\label{sec:Device Types / Crypto Device / Feature bits}
>>> +
>>> +VIRTIO_CRYPTO_F_NON_SESSION_MODE (0) non-session mode is available.
>>> +VIRTIO_CRYPTO_F_CIPHER_NON_SESSION_MODE (1) non-session mode is available for CIPHER service.
>>> +VIRTIO_CRYPTO_F_HASH_NON_SESSION_MODE (2) non-session mode is available for HASH service.
>>> +VIRTIO_CRYPTO_F_MAC_NON_SESSION_MODE (3) non-session mode is available for MAC service.
>>> +VIRTIO_CRYPTO_F_AEAD_NON_SESSION_MODE (4) non-session mode is available for AEAD service.
>>
>> Bits 1-4 require bit 0.  Is bit 0 necessary at all?  Or may bits 1-4 can
>> be eliminated in favor of just bit 0.
> 
> Too late to change it as QEMU released a device with that feature.
> 

When was this introduced to QEMU? Can't find it in current master
and I do not remember seeing the patches.

Regards,
Halil
