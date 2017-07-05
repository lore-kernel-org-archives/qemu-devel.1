Received: from eggs.gnu.org ([2001:4830:134:3::10]:55067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSlXx-0003GV-LT
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 10:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSlXw-000496-Hq
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 10:44:53 -0400
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
	<20170704220346.29244-9-marcandre.lureau@redhat.com>
	<4ffefaff-3c04-9328-a27b-332d30153b0a@redhat.com>
	<2079725542.47180593.1499264497487.JavaMail.zimbra@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e8eeea5e-6ec5-d2ca-3ff2-631d493afe76@redhat.com>
Date: Wed, 5 Jul 2017 16:44:36 +0200
MIME-Version: 1.0
In-Reply-To: <2079725542.47180593.1499264497487.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/35] block: all bdrv_aio callbacks are
 coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>



On 05/07/2017 16:21, Marc-Andr=C3=A9 Lureau wrote:
>>
>> They are, but it's an implementation detail.  Why is this patch necess=
ary?
> I didn't think this would be controversial :) well, the checks I added =
to clang verify function pointer share the coroutine attribute.
>=20
> The function themself are/need to be coroutine_fn (as they will call co=
routine_fn too)

It's not controversial, I would not have expected the functions to call
coroutine_fn. :)  How do they do that?

Paolo
