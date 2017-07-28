Received: from eggs.gnu.org ([2001:4830:134:3::10]:38004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dat5c-0002lh-8a
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 20:25:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dat5Y-0001qf-Em
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 20:25:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dat5Y-0001oM-5i
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 20:25:08 -0400
Date: Fri, 28 Jul 2017 08:25:01 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170728002501.GM5117@lemon.lan>
References: <201707250902596770211@zte.com.cn>
	<f53aa34f-5ca0-c38e-a303-4688698a2d42@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f53aa34f-5ca0-c38e-a303-4688698a2d42@cn.fujitsu.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCHv2 02/04] colo-compare: Processpactkets in
 the IOThreadofthe primary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Cc: wang.yong155@zte.com.cn, pbonzini@redhat.com, lizhijian@cn.fujitsu.com, wang.guang55@zte.com.cn, jasowang@redhat.com, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, marcandre.lureau@gmail.com, stefanha@redhat.com, zhang.zhanghailiang@huawei.com

On Thu, 07/27 15:47, Zhang Chen wrote:
> CC. Fam and David.
>=20
> Any idea about it?

Is it possible to use g_main_context_{push,pop}_thread_default to "move" =
chardev
GSources to IOThread's context, then use g_main_context_query like main t=
hread
and poll the fds in aio_poll?

Fam

>=20
>=20
> Thanks
>=20
> Zhang Chen
>=20
>=20
> On 07/25/2017 09:02 AM, wang.yong155@zte.com.cn wrote:
> >=20
> > >On 24/07/2017 12:38, wang.yong155@zte.com.cn wrote:
> >=20
> > >> finally use g_main_loop_run to replace aio_poll  in the
> >=20
> > >> iothread_run function.
> >=20
> > >
> >=20
> > >That would make the performance of virtio-blk with iothreads worse,
> >=20
> > >unfortunately.  aio_poll is much more optimized than g_main_loop_run=
.
> >=20
> > Hi Paolo,
> >=20
> > Any other good idea to achieve this?
> >=20
> >=20
> > Thanks
> >=20
> >=20
> > >
> >=20
> > >Paolo
> >=20
> > >
> >=20
> > >> After that IOThread
> >=20
> > >> runs the GMainContext event loop,chardev and IOThread can work
> > together.
> >=20
> > >>
> >=20
> > >> How about it? If feasible, I will try to submit
> >=20
> >=20
> >=20
> >=20
> > =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6
> > *=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A*<pbonzini@redhat.com>;
> > *=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A*=E7=8E=8B=E5=8B=8710170530;<ste=
fanha@redhat.com>;<jasowang@redhat.com>;<marcandre.lureau@gmail.com>;
> > *=E6=8A=84=E9=80=81=E4=BA=BA=EF=BC=9A*<zhang.zhanghailiang@huawei.com=
>;<zhangchen.fnst@cn.fujitsu.com>;<lizhijian@cn.fujitsu.com>;<qemu-devel@=
nongnu.org>;=E7=8E=8B=E5=B9=BF10165992;
> > *=E6=97=A5 =E6=9C=9F =EF=BC=9A*2017=E5=B9=B407=E6=9C=8824=E6=97=A5 19=
:59
> > *=E4=B8=BB =E9=A2=98 =EF=BC=9A**Re: [PATCHv2 02/04] colo-compare: Pro=
cesspactkets in the
> > IOThreadofthe primary*
> >=20
> >=20
> > On 24/07/2017 12:38, wang.yong155@zte.com.cn wrote:
> > > finally use g_main_loop_run to replace aio_poll  in the
> > > iothread_run function.
> >=20
> > That would make the performance of virtio-blk with iothreads worse,
> > unfortunately.  aio_poll is much more optimized than g_main_loop_run.
> >=20
> > Paolo
> >=20
> > > After that IOThread
> > > runs the GMainContext event loop,chardev and IOThread can work toge=
ther.
> > >
> > > How about it? If feasible, I will try to submit a patch.
> >=20
> >=20
> >=20
>=20
> --=20
> Thanks
> Zhang Chen
>=20
>=20
>=20
>=20
