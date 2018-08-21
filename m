Received: from eggs.gnu.org ([2001:4830:134:3::10]:43348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1frzOu-0006iO-IO
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 01:40:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1frzBY-0004ic-JQ
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 01:26:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53360 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1frzBY-0004fH-EX
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 01:26:32 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180820174310.17450-1-marcandre.lureau@redhat.com>
	<CAFEAcA_hyByeMb5fK88nHO2JVc9CkWc-sYQDjYoh9MfqHJnF5w@mail.gmail.com>
	<f3bc790e-bcc2-5273-7825-313f2a72f168@redhat.com>
	<CAJ+F1CLvnFD-TSEw8pxhFW=cgTKY0hqjbaMCRFYqbgpkmyqchg@mail.gmail.com>
Date: Tue, 21 Aug 2018 07:26:28 +0200
In-Reply-To: <CAJ+F1CLvnFD-TSEw8pxhFW=cgTKY0hqjbaMCRFYqbgpkmyqchg@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 20 Aug 2018
	22:49:24 +0200")
Message-ID: <87o9dwguij.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] editorconfig: set emacs mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, QEMU <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Mon, Aug 20, 2018 at 9:55 PM Eric Blake <eblake@redhat.com> wrote:
>>
>> On 08/20/2018 01:00 PM, Peter Maydell wrote:
>> > On 20 August 2018 at 18:43, Marc-Andr=C3=A9 Lureau
>> > <marcandre.lureau@redhat.com> wrote:
>> >> Some time ago, I proposed to use an (eval) in .dir-locals.el to set
>> >> the mode for all json files and Makefile. Unfortunately, this isn't
>> >> safe, and emacs will prompt the user, which isn't very friendly.
>> >>
>> >> Fortunately, editorconfig provides a special config key which does
>> >> allow to set the emacs mode. Set the emacs mode for JSON, GLSL and
>> >> extra makefiles that are not yet covered. Drop modeline from JSON
>> >> files.
>> >
>> > Does emacs apply info from the the editorconfig file by default, thoug=
h?
>>
>> Per https://editorconfig.org/, no, you have to first install an emacs
>> plugin to get editorconfig files to have any effect.  So this patch is a
>> non-starter unless distros start patching emacs to install that plugin
>> by default.
>
> But .editorconfing is already present in qemu source tree. (and fwiw,
> it's installed by default with some starter kits, like prelude).
>
> What's the issue adding the emacs mode in the config file?
>
> Let's keep the modeline in existing files if you prefer, but it's
> still very limited (a majority of files are not covered). And I would
> rather see it gone, than having editor-specific lines in our source
> files.

I'm fine with adding stuff to .editorconfig that helps users.

Replacing Emacs file local variables by .editorconfig hurts Emacs users
that don't have the plugin set up.

I suggest you respin with the deletions dropped, and the additions to
.editorconfig limited to ones that still make a difference.
