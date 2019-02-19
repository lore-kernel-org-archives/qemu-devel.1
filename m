Received: from eggs.gnu.org ([209.51.188.92]:34683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gw5Wv-0000wL-NN
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:33:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gw5Wt-00074U-Vm
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:33:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gw5Wt-00070a-Ow
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:33:47 -0500
References: <1550118402-4057-1-git-send-email-wexu@redhat.com>
	<1550118402-4057-12-git-send-email-wexu@redhat.com>
	<ba86ca50-73e8-1c06-8ab0-0e8b74aeac58@redhat.com>
	<20190219112312.GA1582@wei-ubt>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4e786e43-4ef0-f463-5be4-7d264d6d35be@redhat.com>
Date: Tue, 19 Feb 2019 21:33:40 +0800
MIME-Version: 1.0
In-Reply-To: <20190219112312.GA1582@wei-ubt>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 11/11] virtio: CLI and provide packed
 ring feature bit by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Xu <wexu@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, jfreiman@redhat.com, tiwei.bie@intel.com, mst@redhat.com


On 2019/2/19 =E4=B8=8B=E5=8D=887:23, Wei Xu wrote:
> On Tue, Feb 19, 2019 at 03:32:19PM +0800, Jason Wang wrote:
>> On 2019/2/14 =E4=B8=8B=E5=8D=8812:26,wexu@redhat.com  wrote:
>>> From: Wei Xu<wexu@redhat.com>
>>>
>>> Add userspace and vhost kernel/user support.
>>>
>>> Add CLI "ring_packed=3Dtrue/false" to enable/disable packed ring prov=
ision.
>>> Usage:
>>>      -device virtio-net-pci,netdev=3Dxx,mac=3Dxx:xx:xx:xx:xx:xx,ring_=
packed=3Dfalse
>>>
>>> By default it is provided.
>> Please compat this for old machine types.
> It is provided by default, how to make it compatible for old machine ty=
pes?
> Hide or provide it?
>
> Wei
>

Take a look at e.g how pc_compat_3_1 and hw_compat_3_1 was used.

Thanks
