Received: from eggs.gnu.org ([2001:4830:134:3::10]:41200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fijYW-000800-Ot
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 12:56:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fijYR-000883-Ny
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 12:56:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37756
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fijYR-00086h-IH
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 12:55:55 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6QGmtZS082276
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 12:55:54 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2kffxdxs92-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 12:55:53 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Thu, 26 Jul 2018 17:55:51 +0100
References: <1514626559-162312-1-git-send-email-longpeng2@huawei.com>
	<1514626559-162312-2-git-send-email-longpeng2@huawei.com>
	<fcb63fc3-22eb-7f6c-2014-744ee75784eb@linux.vnet.ibm.com>
	<5B51CF0B.8020706@huawei.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Thu, 26 Jul 2018 18:55:44 +0200
MIME-Version: 1.0
In-Reply-To: <5B51CF0B.8020706@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <a332a516-16dc-1e50-3ea6-b68571880cb7@linux.ibm.com>
Subject: Re: [Qemu-devel] [v23 1/2] virtio-crypto: Add virtio crypto device
 specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng (Mike)" <longpeng2@huawei.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: virtio-dev@lists.oasis-open.org, Ola.Liljedahl@arm.com, brian.a.keating@intel.com, wangxinxin.wang@huawei.com, mst@redhat.com, liang.j.ma@intel.com, jasowang@redhat.com, xin.zeng@intel.com, qemu-devel@nongnu.org, john.griffin@intel.com, agraf@suse.de, arei.gonglei@huawei.com, stefanha@redhat.com, jianjay.zhou@huawei.com, cornelia.huck@de.ibm.com, Varun.Sethi@freescale.com, Jani.Kokkonen@huawei.com, vincent.jardin@6wind.com, denglingli@chinamobile.com, weidong.huang@huawei.com

Sorry I did not have any time for this last days. And this
to make it worse this is a follow up to something that was
half a year ago. That means I have to re-familiarize myself
with the topic.

If I don't get around to answer in couple of weeks, feel
free to ping me.

Since from what I've seen most of the questions were of type
'Can we do it like this?', maybe sending out a new version
is the best. So people (like me) can read through the whole
thing and point out problems if any.

Regards,
Halil

On 07/20/2018 02:01 PM, Longpeng (Mike) wrote:
> 
> 
> On 2018/1/10 1:05, Halil Pasic wrote:
> 
>>
>>
>> On 12/30/2017 10:35 AM, Longpeng(Mike) wrote:
>>> From: Gonglei <arei.gonglei@huawei.com>
