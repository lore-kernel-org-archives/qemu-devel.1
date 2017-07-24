Received: from eggs.gnu.org ([2001:4830:134:3::10]:33787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dZc1i-0003hN-M7
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:59:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dZc1f-00080x-GV
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:59:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dZc1f-0007zn-Ap
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:59:51 -0400
References: <201707241838172813942@zte.com.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <effe3acf-9471-97cc-793d-5826c19f422b@redhat.com>
Date: Mon, 24 Jul 2017 13:59:43 +0200
MIME-Version: 1.0
In-Reply-To: <201707241838172813942@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCHv2 02/04] colo-compare: Processpactkets in
 the IOThread ofthe primary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wang.yong155@zte.com.cn, stefanha@redhat.com, jasowang@redhat.com, marcandre.lureau@gmail.com
Cc: zhang.zhanghailiang@huawei.com, zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com, qemu-devel@nongnu.org, wang.guang55@zte.com.cn

On 24/07/2017 12:38, wang.yong155@zte.com.cn wrote:
> finally use g_main_loop_run to replace aio_poll  in the
> iothread_run function.

That would make the performance of virtio-blk with iothreads worse,
unfortunately.  aio_poll is much more optimized than g_main_loop_run.

Paolo

> After that IOThread
> runs the GMainContext event loop,chardev and IOThread can work together=
.
>=20
> How about it? If feasible, I will try to submit a patch.
