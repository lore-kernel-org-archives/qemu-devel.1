Received: from eggs.gnu.org ([2001:4830:134:3::10]:47070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpGdn-0001am-VK
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpGdi-0002mB-VQ
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:23:55 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <CAJ+F1C+mPu9ftXwgs4UrGTQp4f65-thhvmWoB-kuRmu0=vnFFw@mail.gmail.com>
	<87zia9palk.fsf@dusky.pond.sub.org>
	<CAJ+F1CJaxdbHnLQy6H=5=Q3ZMw0w01xsvK3ybhj80=6F9dR6gQ@mail.gmail.com>
	<87fuc1ma7d.fsf@dusky.pond.sub.org>
	<CAJ+F1CLAFEHjWpZpJQ_QS2VV=sjYqYpydjSe2ZEdRN-N-bhHzQ@mail.gmail.com>
Date: Tue, 05 Sep 2017 18:23:47 +0200
In-Reply-To: <CAJ+F1CLAFEHjWpZpJQ_QS2VV=sjYqYpydjSe2ZEdRN-N-bhHzQ@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 05 Sep 2017
	15:55:28 +0000")
Message-ID: <8760cxktbg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] clang-tidy: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu trival <qemu-trivial@nongnu.org>, QEMU <qemu-devel@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
>
>> Suggest you show us cool things you can do with clang-tidy that haven't
>> been done with Coccinelle :)
>>
> Well to do that I would have to have a transformations to do & know the
> limits/strength of coccinelle & clang-tidy, I am not there yet... Today, I
> prefer invest in clang-tidy for what I need to do.

With any luck, you'll soon enough run into something that hasn't been
done with Coccinelle.

> We already discussed some of the pros/cons of coccinelle vs tidy her and =
in
> the previous round-up series. For ex, clang-tidy is able to evaluate
> constant expressions, so you can write generic rules that you can't captu=
re
> with coccinelle yet (A + B-1) / B * B:
> https://github.com/elmarco/clang-tools-extra/blob/master/clang-tidy/qemu/=
RoundCheck.cpp
> .
>
> However, I think it is more difficult to write clang-tidy transformation
> that spans accross various code paths (like adding errors/free/locks etc).
> Coccinelle makes that fairly easily apparently.

Fortunately, we can use both.

I'm not so fond of doing the same things with both, though :)
