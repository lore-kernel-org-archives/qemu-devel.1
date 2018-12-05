Received: from eggs.gnu.org ([2001:4830:134:3::10]:49343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUZuo-0001og-DN
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:20:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUZuj-0001rD-GB
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:20:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gUZuj-0001ji-9K
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:20:41 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1f7db2e27758f26d4c10f7a8ed1d8232635f6909.1536044449.git.pkrempa@redhat.com>
	<20181004113412.GI21448@angien.pipo.sk>
	<20181205123337.GI799@angien.pipo.sk>
	<CAJ+F1CLr5_nB2hpXJrhMeJnsXjME8k+0s90wZHw-H_qsQht63A@mail.gmail.com>
Date: Wed, 05 Dec 2018 17:20:31 +0100
In-Reply-To: <CAJ+F1CLr5_nB2hpXJrhMeJnsXjME8k+0s90wZHw-H_qsQht63A@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 5 Dec 2018
	18:09:52 +0400")
Message-ID: <87tvjsq71s.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Peter Krempa <pkrempa@redhat.com>, QEMU <qemu-devel@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Wed, Dec 5, 2018 at 4:34 PM Peter Krempa <pkrempa@redhat.com> wrote:
>>
>> On Thu, Oct 04, 2018 at 13:34:12 +0200, Peter Krempa wrote:
>> > On Tue, Sep 04, 2018 at 09:03:10 +0200, Peter Krempa wrote:
>> > > The files have a json suffix but look terrible with json syntax
>> > > hilighting enabled. Add a magic modeline for vim to switch to python
>> > > file format for hilighting similarly to the emacs modeline already
>> > > present.
>> > >
>> > > Signed-off-by: Peter Krempa <pkrempa@redhat.com>
>> > > ---
>> >
>> > Ping?
>>
>> Ping 2. It looks like no new json files were added meanwhile.
>
> I use both emacs and vim. We solved this for me with emacs .editorconf
> file_type_emacs.
>
> The vim plugin doesn't have an equivalent, however, the documentation
> suggest vim_filetype, but you need to add
> to .vimrc:
>
> function! FiletypeHook(config)
>     if has_key(a:config, 'vim_filetype')
>         let &filetype =3D a:config['vim_filetype']
>     endif
>
>     return 0   " Return 0 to show no error happened
> endfunction
>
> call editorconfig#AddNewHook(function('FiletypeHook'))
>
> I think this is a better solution than having to add modelines
> everywhere, what do you think?

These .json files are not valid JSON.  They *are* valid Python (except
for a few tests, which could perhaps be fixed).  Makes me wonder why on
earth we insist on naming them .json and create all this trouble.
