Received: from eggs.gnu.org ([2001:4830:134:3::10]:48209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSNB9-0004D8-05
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:20:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSMws-0006Rd-Mt
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:05:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gSMws-0006RK-H8
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:05:46 -0500
References: <20181129121449.4322-1-jasowang@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <44516b60-dafd-70e3-1638-ea38a804c8a4@redhat.com>
Date: Thu, 29 Nov 2018 08:05:41 -0600
MIME-Version: 1.0
In-Reply-To: <20181129121449.4322-1-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V2 for 3.1 0/4] Fix possible OOB during
 queuing packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: mst@redhat.com, liq3ea@163.com, liq3ea@gmail.com, ppandit@redhat.com, pbonzini@redhat.com

On 11/29/18 6:14 AM, Jason Wang wrote:
> Hi:
> 
> This series tries to fix a possible OOB during queueing packets
> through qemu_net_queue_append_iov(). This could happen when it tries
> to queue a packet whose size is larger than INT_MAX which may lead
> integer overflow. We've fixed similar issue in the past during
> qemu_net_queue_deliver_iov() by ignoring large packets there. Let's
> just move the check earlier to qemu_sendv_packet_async() and reduce
> the limitation to NET_BUFSIZE. A simple qtest were also added this.
> 
> Please review.

How important is this for 3.1?  We've missed -rc3.  Is this CVE quality 
because of a guest being able to cause mayhem by intentionally getting 
into this condition (in which case, we need it, as well as a CVE 
assigned)? Is it pre-existing in 3.0 at which point waiting for 4.0 is 
no worse off than what we already are?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
