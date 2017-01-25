Received: from eggs.gnu.org ([2001:4830:134:3::10]:43436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ale@clearmind.me>) id 1cWI7k-0003B1-1v
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 02:36:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ale@clearmind.me>) id 1cWI7f-0000Ee-7l
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 02:36:08 -0500
Received: from clearmind.me ([178.32.49.9]:51263)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ale@clearmind.me>) id 1cWI7f-0000D1-0O
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 02:36:03 -0500
Date: Wed, 25 Jan 2017 08:37:01 +0100
From: Alessandro Di Federico <ale+qemu@clearmind.me>
In-Reply-To: <CAJ+F1CKqDZtyy3jXqTmk=juYAjm=8a-U4+_Pqtg3ikmQZ4BdvQ@mail.gmail.com>
References: <20170121084600.5860-1-ale+qemu@clearmind.me>
	<20170121084600.5860-2-ale+qemu@clearmind.me>
	<CAJ+F1CKqDZtyy3jXqTmk=juYAjm=8a-U4+_Pqtg3ikmQZ4BdvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <E1cWIAK-0000hJ-EQ@clearmind.me>
Sender: ale@clearmind.me
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] Factor out {linux, bsd}-user/qemu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org

On Tue, 24 Jan 2017 10:10:08 +0000
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:

>=20
> Looks good. Probably worth to mention that the main difference is in
> commit 658f2dc970996d547a641b5685e384ebe6f2648e not being applied to
> bsd-user.
>=20

Yeah, I'll rebase my next patches on master.

My only doubt about this patch was whether the linux-* and bsd-*
implementations of put_user are equivalent. The linux one seems more
optimized, but they look equivalent to me.

--
Alessandro Di Federico
PhD student at Politecnico di Milano
