Received: from eggs.gnu.org ([2001:4830:134:3::10]:51299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSmtH-0001KL-EU
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:11:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSmtG-0007Px-KL
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:10:59 -0400
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
	<20170704220346.29244-9-marcandre.lureau@redhat.com>
	<4ffefaff-3c04-9328-a27b-332d30153b0a@redhat.com>
	<2079725542.47180593.1499264497487.JavaMail.zimbra@redhat.com>
	<e8eeea5e-6ec5-d2ca-3ff2-631d493afe76@redhat.com>
	<1661217396.47274977.1499270778716.JavaMail.zimbra@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <97758bb8-cdd1-8318-e8a0-13a3607c849f@redhat.com>
Date: Wed, 5 Jul 2017 18:10:46 +0200
MIME-Version: 1.0
In-Reply-To: <1661217396.47274977.1499270778716.JavaMail.zimbra@redhat.com>
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



On 05/07/2017 18:06, Marc-Andr=C3=A9 Lureau wrote:
>>> coroutine_fn too)
>> It's not controversial, I would not have expected the functions to cal=
l
>> coroutine_fn. :)  How do they do that?
>>
> For example,  null_co_readv() calls  null_co_common() which calls co_ai=
o_sleep_ns()

But these are bdrv_co_*, not bdrv_aio_*.

Paolo
