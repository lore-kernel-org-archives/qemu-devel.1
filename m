Received: from eggs.gnu.org ([2001:4830:134:3::10]:43758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAezn-0005Qb-53
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:43:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAezi-0005Sz-QB
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:43:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gAezi-0005S0-JV
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:43:30 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-20-armbru@redhat.com>
	<CAJ+F1CLLM7nOAXPABTGRzddRNvryN9BFetv_g5Uo7mM6bGX2MQ@mail.gmail.com>
Date: Thu, 11 Oct 2018 19:43:25 +0200
In-Reply-To: <CAJ+F1CLLM7nOAXPABTGRzddRNvryN9BFetv_g5Uo7mM6bGX2MQ@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 9 Oct 2018
	15:13:46 +0400")
Message-ID: <87y3b4xttu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 19/31] vl: Clean up error reporting in
 parse_add_fd()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Mon, Oct 8, 2018 at 9:51 PM Markus Armbruster <armbru@redhat.com> wrot=
e:
>>
>> Calling error_report() in a function that takes an Error ** argument
>> is suspicious.  chardev_init_func() does that, and then fails without
>> setting an error.  Its caller main(), via qemu_opts_foreach(), is fine
>> with it, but clean it up anyway.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> commit title is wrong, apart from that:

Fixing...

> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks!
