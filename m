Received: from eggs.gnu.org ([2001:4830:134:3::10]:33262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gUXsU-00027c-0W
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:10:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gUXsR-0005UQ-T4
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:10:14 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gUXsP-0005NU-BJ
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:10:10 -0500
Received: by mail-wm1-x342.google.com with SMTP id s14so13450673wmh.1
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 06:10:06 -0800 (PST)
MIME-Version: 1.0
References: <1f7db2e27758f26d4c10f7a8ed1d8232635f6909.1536044449.git.pkrempa@redhat.com>
	<20181004113412.GI21448@angien.pipo.sk>
	<20181205123337.GI799@angien.pipo.sk>
In-Reply-To: <20181205123337.GI799@angien.pipo.sk>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 5 Dec 2018 18:09:52 +0400
Message-ID: <CAJ+F1CLr5_nB2hpXJrhMeJnsXjME8k+0s90wZHw-H_qsQht63A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qapi: Add vim magic modelines for qapi
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

Hi

On Wed, Dec 5, 2018 at 4:34 PM Peter Krempa <pkrempa@redhat.com> wrote:
>
> On Thu, Oct 04, 2018 at 13:34:12 +0200, Peter Krempa wrote:
> > On Tue, Sep 04, 2018 at 09:03:10 +0200, Peter Krempa wrote:
> > > The files have a json suffix but look terrible with json syntax
> > > hilighting enabled. Add a magic modeline for vim to switch to python
> > > file format for hilighting similarly to the emacs modeline already
> > > present.
> > >
> > > Signed-off-by: Peter Krempa <pkrempa@redhat.com>
> > > ---
> >
> > Ping?
>
> Ping 2. It looks like no new json files were added meanwhile.

I use both emacs and vim. We solved this for me with emacs .editorconf
file_type_emacs.

The vim plugin doesn't have an equivalent, however, the documentation
suggest vim_filetype, but you need to add
to .vimrc:

function! FiletypeHook(config)
    if has_key(a:config, 'vim_filetype')
        let &filetype =3D a:config['vim_filetype']
    endif

    return 0   " Return 0 to show no error happened
endfunction

call editorconfig#AddNewHook(function('FiletypeHook'))

I think this is a better solution than having to add modelines
everywhere, what do you think?

--=20
Marc-Andr=C3=A9 Lureau
