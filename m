Received: from eggs.gnu.org ([2001:4830:134:3::10]:36375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gUM1K-00041x-70
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 20:30:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gUM1F-0008G7-TN
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 20:30:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gUM1F-0008Dz-7G
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 20:30:29 -0500
References: <CAHyh4xgZhGnEvkD5RiUazZ9Eq_jzr4=bXHfwBvCBkbOLN2UyKA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <915953bd-cc9c-9456-b619-297138f68ae6@redhat.com>
Date: Wed, 5 Dec 2018 09:30:19 +0800
MIME-Version: 1.0
In-Reply-To: <CAHyh4xgZhGnEvkD5RiUazZ9Eq_jzr4=bXHfwBvCBkbOLN2UyKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Logging dirty pages from vhost-net in-kernel with
 vIOMMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jintack Lim <jintack@cs.columbia.edu>, QEMU Devel Mailing List <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>


On 2018/12/5 =E4=B8=8A=E5=8D=882:37, Jintack Lim wrote:
> Hi,
>
> I'm wondering how the current implementation works when logging dirty
> pages during migration from vhost-net (in kernel) when used vIOMMU.
>
> I understand how vhost-net logs GPAs when not using vIOMMU. But when
> we use vhost with vIOMMU, then shouldn't vhost-net need to log the
> translated address (GPA) instead of the address written in the
> descriptor (IOVA) ? The current implementation looks like vhost-net
> just logs IOVA without translation in vhost_get_vq_desc() in
> drivers/vhost/net.c. It seems like QEMU doesn't do any further
> translation of the dirty log when syncing.
>
> I might be missing something. Could somebody shed some light on this?


Good catch. It looks like a bug to me. Want to post a patch for this?

Thanks


>
> Thanks,
> Jintack
>
>
