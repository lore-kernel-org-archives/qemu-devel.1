Received: from eggs.gnu.org ([2001:4830:134:3::10]:55839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5Taq-0007Id-8D
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 05:27:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5Tap-0008Cf-6P
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 05:27:52 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:55368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e5Tao-0008CL-Ty
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 05:27:51 -0400
Received: by mail-wr0-x235.google.com with SMTP id z99so8341607wrc.12
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 02:27:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1508443483-5429-1-git-send-email-alindsay@codeaurora.org>
References: <1508443483-5429-1-git-send-email-alindsay@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Oct 2017 10:27:29 +0100
Message-ID: <CAFEAcA-R-3F8US1RGJVNyVnC81z9+1dd3Liq0tmVSNz1eDszbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] build: Don't force preserving permissions
 on config-devices.mak.old
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Paul Brook <paul@codesourcery.com>

On 19 October 2017 at 21:04, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> I get the following error when building on an NFSv3 filesystem:
>
> % make -j8
>   GEN     aarch64-softmmu/config-devices.mak.tmp
>   GEN     config-host.h
> [snip]
>   GEN     qmp-marshal.c
>   GEN     aarch64-softmmu/config-devices.mak
> cp: preserving permissions for =E2=80=98aarch64-softmmu/config-devices.ma=
k.old=E2=80=99: Operation not supported
> make: *** Deleting file `aarch64-softmmu/config-devices.mak'
>   GEN     qapi-types.c
> [snip]
>   CC      scsi/qemu-pr-helper.o
> make: *** No rule to make target `config-all-devices.mak', needed by `sub=
dir-aarch64-softmmu'.  Stop.
> make: *** Waiting for unfinished jobs....
>
> Ideally you would only build on a filesystem with proper support, but I h=
aven't
> been able to find a reason why preserving exact permissions is important =
in
> this case.

Do we even need this code at all? As far as I can tell from
the git logs, the idea is to support users who hand-modify
config-devices.mak. But do we want to support that? I would
think of config-devices.mak as an internal part of the build
machinery, and the bit you can edit as a user is the stuff
in default-configs/.

thanks
-- PMM
