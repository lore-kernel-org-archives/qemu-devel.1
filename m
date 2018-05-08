Received: from eggs.gnu.org ([2001:4830:134:3::10]:58579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fG2sw-00060X-GN
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:42:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fG2ss-0006p8-E1
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:42:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43602
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fG2ss-0006oo-60
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:42:26 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w48De8ZM104979
	for <qemu-devel@nongnu.org>; Tue, 8 May 2018 09:42:24 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hua5m1f89-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 09:42:23 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Tue, 8 May 2018 14:42:22 +0100
References: <20180507155130.21085-1-cohuck@redhat.com>
	<20180507155130.21085-3-cohuck@redhat.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Tue, 8 May 2018 15:42:17 +0200
MIME-Version: 1.0
In-Reply-To: <20180507155130.21085-3-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <388a5b5e-7ba1-4510-d2d3-88e2cc32ae94@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] s390x/ccw: make sure all ccw devices
 are properly reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org



On 05/07/2018 05:51 PM, Cornelia Huck wrote:
> Thomas reported that the subchannel for a  3270 device that ended up
> in a broken state (status pending even though not enabled) did not
> get out of that state even after a reboot (which involves a subsytem
> reset). The reason for this is that the 3270 device did not define
> a reset handler.
> 
> Let's fix this by introducing a base reset handler (set up for all
> ccw devices) that resets the subchannel and have virtio-ccw call
> its virtio-specific reset procedure in addition to that.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Suggested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

The 'all' from the subject is actually 'all except maybe vfio-ccw'
AFAIU.

[..]
