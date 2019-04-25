Received: from eggs.gnu.org ([209.51.188.92]:48606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hJUiW-0004qH-L0
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 23:06:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hJUcO-0007wp-QI
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 23:00:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hJUcO-0007vZ-Jf
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 23:00:12 -0400
References: <20190409055850.25797-1-jasowang@redhat.com>
	<20190424095058-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7d8971f7-4c50-5ea1-d168-3300a079caaa@redhat.com>
Date: Thu, 25 Apr 2019 11:00:04 +0800
MIME-Version: 1.0
In-Reply-To: <20190424095058-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V3] vhost_net: don't set backend for the
 uninitialized virtqueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: yuri.benditovich@daynix.com, qemu-devel@nongnu.org


On 2019/4/24 =E4=B8=8B=E5=8D=889:51, Michael S. Tsirkin wrote:
> On Tue, Apr 09, 2019 at 01:58:50PM +0800, Jason Wang wrote:
>> We used to set backend unconditionally, this won't work for some
>> guests (e.g windows driver) who may not initialize all virtqueues. For
>> kernel backend, this will fail since it may try to validate the rings
>> during setting backend.
>>
>> Fixing this by simply skipping the backend set when we find desc is
>> not ready.
>>
>> Signed-off-by: Jason Wang<jasowang@redhat.com>
> Reviewed-by: Michael S. Tsirkin<mst@redhat.com>
>

Applied.

Thanks
