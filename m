Received: from eggs.gnu.org ([2001:4830:134:3::10]:52791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fwnT1-0000k8-Ex
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 07:56:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fwnSy-0002OJ-2f
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 07:56:27 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:37757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1fwnSx-0002O9-Ry
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 07:56:24 -0400
Received: by mail-ed1-x544.google.com with SMTP id a20-v6so589618edd.4
	for <qemu-devel@nongnu.org>; Mon, 03 Sep 2018 04:56:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <76fd34e6-3055-1832-0b6c-4728d583a284@redhat.com>
References: <20180830142708.14311-1-sameeh@daynix.com>
	<20180830142708.14311-4-sameeh@daynix.com>
	<76fd34e6-3055-1832-0b6c-4728d583a284@redhat.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Mon, 3 Sep 2018 14:56:22 +0300
Message-ID: <CAKPgXcGsqRmamAa6DWz2T5u155xf9N836_zz1n44i2XOO+9KwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 3/6] vhost-net: Expose vhost_net_get_fd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yan Vugenfirer <yan@daynix.com>

On Mon, Sep 3, 2018 at 6:24 AM, Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2018=E5=B9=B408=E6=9C=8830=E6=97=A5 22:27, Sameeh Jubran wrote:
>>
>> From: Sameeh Jubran <sjubran@redhat.com>
>>
>> Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
>
>
> Better explain the motivation in the commit log.
I used to use this function in my initial implementation, but this is
unneeded now and the patch can be dropped
>
> Thanks
>
>
>> ---
>>   hw/net/vhost_net.c             | 2 +-
>>   include/hw/virtio/virtio-net.h | 2 ++
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
>> index e037db63a3..c0bff725c9 100644
>> --- a/hw/net/vhost_net.c
>> +++ b/hw/net/vhost_net.c
>> @@ -129,7 +129,7 @@ uint64_t vhost_net_get_acked_features(VHostNetState
>> *net)
>>       return net->dev.acked_features;
>>   }
>>   -static int vhost_net_get_fd(NetClientState *backend)
>> +int vhost_net_get_fd(NetClientState *backend)
>>   {
>>       switch (backend->info->type) {
>>       case NET_CLIENT_DRIVER_TAP:
>> diff --git a/include/hw/virtio/virtio-net.h
>> b/include/hw/virtio/virtio-net.h
>> index 02484dc94c..a7b53edc96 100644
>> --- a/include/hw/virtio/virtio-net.h
>> +++ b/include/hw/virtio/virtio-net.h
>> @@ -107,4 +107,6 @@ typedef struct VirtIONet {
>>   void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
>>                                      const char *type);
>>   +int vhost_net_get_fd(NetClientState *backend);
>> +
>>   #endif
>
>



--=20
Respectfully,
Sameeh Jubran
Linkedin
Software Engineer @ Daynix.
