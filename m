Received: from eggs.gnu.org ([2001:4830:134:3::10]:50154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1cz5KN-0007Z1-KT
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 13:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1cz5KM-0000gT-P4
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 13:48:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1cz5KM-0000gI-Ij
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 13:48:10 -0400
References: <20170414174056.28946-1-maxime.coquelin@redhat.com>
	<20170414174056.28946-5-maxime.coquelin@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <7304c97c-2ced-ce35-e981-e77b9e58537b@redhat.com>
Date: Fri, 14 Apr 2017 19:47:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170414174056.28946-5-maxime.coquelin@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 4/4] spec/vhost-user spec: Add IOMMU
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcandre.lureau@gmail.com, vkaplans@redhat.com, jasowang@redhat.com, wexu@redhat.com, peterx@redhat.com, yuanhan.liu@linux.intel.com, qemu-devel@nongnu.org



On 04/14/2017 07:40 PM, Maxime Coquelin wrote:
>  static void slave_read(void *opaque)
>  {
>      struct vhost_dev *dev = opaque;
> @@ -611,6 +639,8 @@ static void slave_read(void *opaque)
>      }
>
>      switch (msg.request) {
Oops, I missed "case VHOST_USER_SLAVE_IOTLB_MSG:" here..
> +        ret = vhost_user_iotlb_read(dev, &msg);
> +        break;
>      default:
>          error_report("Received unexpected msg type.");
>          ret = -EINVAL;
> @@ -848,6 +878,71 @@ static int vhost_user_net_set_mtu(struct vhost_dev *dev, uint16_t mtu)
>      return 0;
>  }

Maxime
