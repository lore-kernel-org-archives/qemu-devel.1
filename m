Received: from eggs.gnu.org ([2001:4830:134:3::10]:60412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dpGCi-0002HM-0h
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:56:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dpGCd-0005c8-8S
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:55:56 -0400
MIME-Version: 1.0
References: <CAJ+F1C+mPu9ftXwgs4UrGTQp4f65-thhvmWoB-kuRmu0=vnFFw@mail.gmail.com>
	<87zia9palk.fsf@dusky.pond.sub.org>
	<CAJ+F1CJaxdbHnLQy6H=5=Q3ZMw0w01xsvK3ybhj80=6F9dR6gQ@mail.gmail.com>
	<87fuc1ma7d.fsf@dusky.pond.sub.org>
In-Reply-To: <87fuc1ma7d.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 05 Sep 2017 15:55:28 +0000
Message-ID: <CAJ+F1CLAFEHjWpZpJQ_QS2VV=sjYqYpydjSe2ZEdRN-N-bhHzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu trival <qemu-trivial@nongnu.org>, QEMU <qemu-devel@nongnu.org>

Hi


> Suggest you show us cool things you can do with clang-tidy that haven't
> been done with Coccinelle :)
>
> Well to do that I would have to have a transformations to do & know the
limits/strength of coccinelle & clang-tidy, I am not there yet... Today, I
prefer invest in clang-tidy for what I need to do.

We already discussed some of the pros/cons of coccinelle vs tidy her and in
the previous round-up series. For ex, clang-tidy is able to evaluate
constant expressions, so you can write generic rules that you can't capture
with coccinelle yet (A + B-1) / B * B:
https://github.com/elmarco/clang-tools-extra/blob/master/clang-tidy/qemu/Ro=
undCheck.cpp
.

However, I think it is more difficult to write clang-tidy transformation
that spans accross various code paths (like adding errors/free/locks etc).
Coccinelle makes that fairly easily apparently.
--=20
Marc-Andr=C3=A9 Lureau
