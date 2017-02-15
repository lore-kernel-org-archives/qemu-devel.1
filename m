Received: from eggs.gnu.org ([2001:4830:134:3::10]:52227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cdyHc-0002HV-6o
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 07:02:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cdyHZ-0000fF-5E
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 07:02:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53201
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cdyHY-0000ek-W3
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 07:02:01 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1FBwoOu067352
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 07:01:59 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28mhh13q30-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 07:01:59 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 15 Feb 2017 12:01:56 -0000
References: <1484727757-41240-1-git-send-email-arei.gonglei@huawei.com>
	<1484727757-41240-2-git-send-email-arei.gonglei@huawei.com>
	<62a99d8e-1735-0838-4067-bce401c86526@linux.vnet.ibm.com>
	<20170207140710.01e4b694.cornelia.huck@de.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA1AFF1E@DGGEMA505-MBX.china.huawei.com>
	<a80c3f48-e3c9-dd7e-643b-a54bdde54882@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA1B30AA@DGGEMA505-MBX.china.huawei.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 15 Feb 2017 13:01:49 +0100
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA1B30AA@DGGEMA505-MBX.china.huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <10648449-6b1a-2a97-673a-6d9681b0fb68@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v16 1/2] virtio-crypto: Add
 virtio crypto device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "john.griffin@intel.com" <john.griffin@intel.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "agraf@suse.de" <agraf@suse.de>, "nmorey@kalray.eu" <nmorey@kalray.eu>, longpeng <longpeng2@huawei.com>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, Luonengjun <luonengjun@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>, "Wubin (H)" <wu.wubin@huawei.com>



On 02/09/2017 03:29 AM, Gonglei (Arei) wrote:
[..]
> Oh, so much work need to be done.
> 
> Halil, Would you mind work together with me to perfect the spec?
> And feel free to add your signed-off-by tag. :)
> 
> TBH as a non-native English speaker, it's more difficult writing a
> spec than coding. :(
> 
> Look forward to your reply.
> 


First, sorry for the long delay -- was busy and then ill. Thank you
very much for your offer. I would prefer continuing as a reviewer,
but I would very much appreciate if you could add me to the
'Acknowledgments' appendix as a part of your patch ;). Unfortunately
I do not have the time now to allocate significantly more time for
this. I'm also having difficulties to think of another way of working
efficiently together on this, than what we already do. I can try to
provide more suggestions in terms of formulation, but it's still 
just review. Thank you very much!

Halil
