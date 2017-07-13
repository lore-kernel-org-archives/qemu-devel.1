Received: from eggs.gnu.org ([2001:4830:134:3::10]:52123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dVZ3q-0006Cy-TL
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 04:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dVZ3n-0004Go-Sz
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 04:01:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1dVZ3n-0004GO-Ms
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 04:01:19 -0400
References: <1499111049-13721-1-git-send-email-mst@redhat.com>
	<1499111049-13721-2-git-send-email-mst@redhat.com>
	<595AF319.6000708@intel.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <63a5ab83-3352-bf8c-0c19-83eec9bd4232@redhat.com>
Date: Thu, 13 Jul 2017 10:01:08 +0200
MIME-Version: 1.0
In-Reply-To: <595AF319.6000708@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 01/21] virtio-net: enable configurable tx
 queue size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, jan.scheurich@ericsson.com

On 07/04/2017 03:44 AM, Wei Wang wrote:
> On 07/04/2017 03:44 AM, Michael S. Tsirkin wrote:
>> From: Wei Wang <wei.w.wang@intel.com>
>>
>> This patch enables the virtio-net tx queue size to be configurable
>> between 256 (the default queue size) and 1024 by the user when the
>> vhost-user backend is used.
>>

<snip/>

> 
> Btw, users also expect the support of configuring the tx queue size could
> be added to libvirt soon.

Indeed. I've just posted patch for that:

https://www.redhat.com/archives/libvir-list/2017-July/msg00433.html

Michal
