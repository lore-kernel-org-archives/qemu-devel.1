Received: from eggs.gnu.org ([2001:4830:134:3::10]:51987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1djdUU-0006la-8N
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 23:35:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1djdUP-000891-HB
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 23:35:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1djdUP-00088s-BT
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 23:34:57 -0400
References: <201708211128100789834@zte.com.cn>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6e08a573-515e-925c-dd27-d5062170e479@redhat.com>
Date: Mon, 21 Aug 2017 11:34:48 +0800
MIME-Version: 1.0
In-Reply-To: <201708211128100789834@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
 =?utf-8?b?562U5aSNOiBSZTogW1BBVENIXSB2aG9zdDogZG9u?=
 =?utf-8?q?=27t_set_vring_call_fd_to_-1_invhost=5Fvirtqueue=5Fstart_for_vh?=
 =?utf-8?q?ost-user?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lu.zhipeng@zte.com.cn
Cc: qemu-devel@nongnu.org, mst@redhat.com



On 2017=E5=B9=B408=E6=9C=8821=E6=97=A5 11:28, lu.zhipeng@zte.com.cn wrote=
:
>   if (!vdev->use_guest_notifier_mask) {
>
>          /* TODO: check and handle errors. */
>
>          vhost_virtqueue_mask(dev, vdev, idx, false)
>
>          ---------- set right  callfd
>
>      }
>
>
>
>
>      if (k->query_guest_notifiers &&
>
>          k->query_guest_notifiers(qbus->parent) &&
>
>          virtio_queue_vector(vdev, idx) =3D=3D VIRTIO_NO_VECTOR) {
>
>          file.fd =3D -1
>
>          r =3D dev->vhost_ops->vhost_set_vring_call(dev, &file)
>
> -----------set call fd to -1
>
>          if (r) {
>
>              goto fail_vector
>
>          }
>
>      }
>
>   So   the callfd of  ovs+dpdk in host  is -1.  it  can't be able  to i=
nteract with the guest.
>
>

The queue does not even an vector, so it won't generate any interrupt.=20
Why callfd is still needed?

Thanks
