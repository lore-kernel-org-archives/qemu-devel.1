Received: from eggs.gnu.org ([2001:4830:134:3::10]:36987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dVfd6-0002Ze-Br
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:02:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dVfd3-0007AU-R7
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:02:12 -0400
Received: from mail-ua0-f175.google.com ([209.85.217.175]:35145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dVfd3-0007AF-MG
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:02:09 -0400
Received: by mail-ua0-f175.google.com with SMTP id j53so35409292uaa.2
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 08:02:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170713164210.45b2f3fc@gondolin>
References: <20170713110237.6712-1-lprosek@redhat.com>
	<20170713110237.6712-4-lprosek@redhat.com>
	<20170713164210.45b2f3fc@gondolin>
From: Ladi Prosek <lprosek@redhat.com>
Date: Thu, 13 Jul 2017 17:02:08 +0200
Message-ID: <CABdb7367eVJNd8hWqVpF3RN58g7xchCyPLP=aaTy7jKXd8ws+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 3/8] virtio: introduce virtqueue_error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Fernando_Casas_Sch=C3=B6ssow?= <casasfernando@hotmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, Greg Kurz <groug@kaod.org>, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, Jul 13, 2017 at 4:42 PM, Cornelia Huck <cohuck@redhat.com> wrote:
> On Thu, 13 Jul 2017 13:02:32 +0200
> Ladi Prosek <lprosek@redhat.com> wrote:
>
>> Most virtio error output pertains to a specific virtqueue so it makes
>> sense to include the queue index in error messages. This commit makes
>> all error output in virtio.c use the newly introduced virtqueue_error.
>
> Split out the change introducing virtqueue_error(), as this patch is
> quite large?

Will do, thanks!

>>
>> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
>> ---
>>  hw/virtio/virtio.c         | 98 ++++++++++++++++++++++++++++------------------
>>  include/hw/virtio/virtio.h |  1 +
>>  2 files changed, 60 insertions(+), 39 deletions(-)
>
> I like the change. Feel free to add
>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
