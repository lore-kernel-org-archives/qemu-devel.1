Received: from eggs.gnu.org ([2001:4830:134:3::10]:41781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gWNQW-0005XO-LQ
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:25:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gWNQT-0006Vy-H2
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:24:56 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181210151648.GN20272@redhat.com>
References: <20181207161351.4380-1-vsementsov@virtuozzo.com>
	<20181207161351.4380-6-vsementsov@virtuozzo.com>
	<w514lbllblo.fsf@maestria.local.igalia.com>
	<20181210145203.GM20272@redhat.com>
	<w511s6pl8pg.fsf@maestria.local.igalia.com>
	<20181210151648.GN20272@redhat.com>
Date: Mon, 10 Dec 2018 16:24:38 +0100
Message-ID: <w51y38xjtft.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 5/5] crypto: support multiple threads
 accessing one QCryptoBlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

On Mon 10 Dec 2018 04:16:48 PM CET, Daniel P. Berrang=C3=A9 wrote:
>> In other words, the cleanup code won't touch uninitialized elements
>> because it cannot even tell the difference between an index that
>> points to an uninitialized element of the array and an index that
>> points beyond the allocated memory.
>
> .../correctly written/ cleanup code won't touch uninitialized elements...
>
> I prefer to see the code be hardened against mistakes and so would
> always zero-initialize everything unless there's compelling
> performance reason not to in certain specific places.

Ok, sounds reasonable.

Berto
