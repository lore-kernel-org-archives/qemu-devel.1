Received: from eggs.gnu.org ([2001:4830:134:3::10]:35523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fo46E-0005oL-2O
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:52:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fo46D-0001rl-83
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:52:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46306 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1fo46D-0001r0-2u
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 05:52:49 -0400
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
	<20180806143412.27722-30-e.emanuelegiuseppe@gmail.com>
	<f1bdb55c-9787-f9cb-6da8-c74d192d3c3e@redhat.com>
	<9ac51ed7-b93b-0b0d-2925-e1f570c10cde@gmail.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <57d3075f-3d0e-13f3-dab7-bd0423ef670f@redhat.com>
Date: Fri, 10 Aug 2018 11:52:45 +0200
MIME-Version: 1.0
In-Reply-To: <9ac51ed7-b93b-0b0d-2925-e1f570c10cde@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 29/34] test/qgraph: virtio-blk test node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Emanuele <e.emanuelegiuseppe@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>

On 10/08/2018 11:45, Emanuele wrote:
> On 08/09/2018 04:16 PM, Laurent Vivier wrote:
>> On 06/08/2018 16:34, Emanuele Giuseppe Esposito wrote:
>>> -static void mmio_basic(void)
>>> +static void basic_resize(void *obj, void *data, QGuestAllocator
>>> *t_alloc)
>>> =C2=A0 {
>>> -=C2=A0=C2=A0=C2=A0 QVirtioMMIODevice *dev;
>>> -=C2=A0=C2=A0=C2=A0 QVirtQueue *vq;
>>> -=C2=A0=C2=A0=C2=A0 QGuestAllocator *alloc;
>>> +=C2=A0=C2=A0=C2=A0 QVirtioBlk *blk_if =3D obj;
>>> +=C2=A0=C2=A0=C2=A0 QVirtioDevice *dev =3D blk_if->vdev;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int n_size =3D TEST_IMAGE_SIZE / 2;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t capacity;
>>> +=C2=A0=C2=A0=C2=A0 QVirtQueue *vq;
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 arm_test_start();
>>> -
>>> -=C2=A0=C2=A0=C2=A0 dev =3D qvirtio_mmio_device_new(MMIO_DEV_BASE_ADD=
R, MMIO_PAGE_SIZE);
>> This is the only user of qvirtio_mmio_device_new(), so if you remove t=
he
>> call here, you could also remove the function definition.
> So you suggest to get rid completely of qvirtio_mmio_device_new() in
> virtio-mmio.c=C2=A0 ?

Yes.

> Couldn't it be useful in future maybe?

We'll be able to use qvirtio_mmio_init_device() instead, so I don't
think it's a problem.

Thanks,
Laurent
