Received: from eggs.gnu.org ([2001:4830:134:3::10]:53404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ey7w1-0006o2-BP
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ey7vy-0004bV-1U
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:27:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51352 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ey7vx-0004bG-Sc
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:27:33 -0400
From: Jason Wang <jasowang@redhat.com>
References: <152120204902.1103.7114773412109402452.stgit@bahia.lan>
	<181e938f-76b7-84b2-96f1-1f8832236e23@redhat.com>
Message-ID: <1301d99e-9cc8-e481-985e-4afe9bd6b82c@redhat.com>
Date: Tue, 20 Mar 2018 11:27:26 +0800
MIME-Version: 1.0
In-Reply-To: <181e938f-76b7-84b2-96f1-1f8832236e23@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] virtio_net: flush uncompleted TX on
 reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: R Nageswara Sastry <nasastry@in.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>


>> =C2=A0 -static
>> =C2=A0 void qemu_flush_or_purge_queued_packets(NetClientState *nc, boo=
l=20
>> purge)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nc->receive_disabled =3D 0;
>>
>>
>
> Applied and queued for -stable.
>
> Thanks
>

Unfortunately, this breaks hotplug test:

 =C2=A0TEST: tests/virtio-net-test... (pid=3D7117)
/x86_64/virtio/net/pci/basic: OK
/x86_64/virtio/net/pci/rx_stop_cont: OK
/x86_64/virtio/net/pci/hotplug: Broken pipe
FAIL

Thanks
