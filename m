Received: from eggs.gnu.org ([2001:4830:134:3::10]:51462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cQzFV-0006wh-5U
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:26:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cQzFT-0003es-SN
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:26:13 -0500
Received: from mail-yw0-x22d.google.com ([2607:f8b0:4002:c05::22d]:32983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cQzFT-0003em-Lg
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:26:11 -0500
Received: by mail-yw0-x22d.google.com with SMTP id l75so39225300ywb.0
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 08:26:11 -0800 (PST)
MIME-Version: 1.0
References: <20170109143437.30554-1-marcandre.lureau@redhat.com>
	<20170109143437.30554-13-marcandre.lureau@redhat.com>
	<87wpe3qf2a.fsf@dusky.pond.sub.org>
	<724269411.621337.1484052915061.JavaMail.zimbra@redhat.com>
	<87d1fuoqa3.fsf@dusky.pond.sub.org>
In-Reply-To: <87d1fuoqa3.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 10 Jan 2017 16:25:59 +0000
Message-ID: <CAJ+F1CJAmaC_TzkYrdcwQocpop0nZShakDVydXS7Q3Jxe_r_jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 12/21] qapi.py: fix line break before
 binary operator pep8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

Hi

On Tue, Jan 10, 2017 at 5:04 PM Markus Armbruster <armbru@redhat.com> wrote=
:

> Marc-Andr=C3=A9 Lureau <mlureau@redhat.com> writes:
>
> > Hi
> >
> > ----- Original Message -----
> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
> >>
> >> > Python code style accepts both form, but pep8 complains. Better to
> clean
> >> > up the single warning for now, so new errors stand out more easily.
> >> >
> >> > Fix scripts/qapi.py:1539:21: W503 line break before binary operator
> >>
> >> PEP 8 permits both, but prefers line break before binary operator.
> >> Thus, this warning is clearly bogus.  What version of pep8 do you use?
> >> Mine doesn't warn.
> >
> > I tried both 1.6.2 and 1.7.0
>
> I tried again, and I can now see the warning.  No idea what I did wrong
> the first time.
>
> Turns out PEP8 used to demand line break after the operator, but no
> more[1].  The pep8 program hasn't caught up, but it will[2]: its current
> git HEAD already suppresses W503.  There's work in progress[3] on a new
> W504 to warn on line break after binary operator.
>
> We will have to live with a mix of old and new pep8 / pycodestyle
> versions.  Changing code to make new versions instead of old versions
> complain instead is not a good idea.  We should simply ignore the
> obsolete warning from old versions.
>
>
ok, feel free to drop this patch then

thanks


> pep8 lets you do that with --ignore=3DW503.  Sadly, --ignore overwrites
> the default, so you have to --ignore=3DE121,E123,E126,E226,E24,E704,W503.
> Or have a file tox.ini with
>
>     [pep8]
>     ignore=3DE121,E123,E126,E226,E24,E704,W503
>
>
> [1] https://hg.python.org/peps/rev/3857909d7956
> [2] https://github.com/PyCQA/pycodestyle/issues/498
> [3] https://github.com/PyCQA/pycodestyle/pull/502
>
> --
Marc-Andr=C3=A9 Lureau
