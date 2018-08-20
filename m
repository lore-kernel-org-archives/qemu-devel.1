Received: from eggs.gnu.org ([2001:4830:134:3::10]:33084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1frqCw-0000xE-0i
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 15:51:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1frqCn-0002ZM-JZ
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 15:51:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39832 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1frqCj-0002Vb-7w
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 15:51:10 -0400
References: <20180820174310.17450-1-marcandre.lureau@redhat.com>
	<CAFEAcA_hyByeMb5fK88nHO2JVc9CkWc-sYQDjYoh9MfqHJnF5w@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f3bc790e-bcc2-5273-7825-313f2a72f168@redhat.com>
Date: Mon, 20 Aug 2018 14:51:03 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_hyByeMb5fK88nHO2JVc9CkWc-sYQDjYoh9MfqHJnF5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On 08/20/2018 01:00 PM, Peter Maydell wrote:
> On 20 August 2018 at 18:43, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
>> Some time ago, I proposed to use an (eval) in .dir-locals.el to set
>> the mode for all json files and Makefile. Unfortunately, this isn't
>> safe, and emacs will prompt the user, which isn't very friendly.
>>
>> Fortunately, editorconfig provides a special config key which does
>> allow to set the emacs mode. Set the emacs mode for JSON, GLSL and
>> extra makefiles that are not yet covered. Drop modeline from JSON
>> files.
>=20
> Does emacs apply info from the the editorconfig file by default, though=
?

Per https://editorconfig.org/, no, you have to first install an emacs=20
plugin to get editorconfig files to have any effect.  So this patch is a=20
non-starter unless distros start patching emacs to install that plugin=20
by default.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
