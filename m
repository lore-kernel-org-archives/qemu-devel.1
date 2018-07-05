Received: from eggs.gnu.org ([2001:4830:134:3::10]:57866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb1Ry-0006LN-Ps
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:25:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb1Rx-0002EO-QD
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:25:22 -0400
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:35635)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fb1Rx-0002D6-K6
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:25:21 -0400
Received: by mail-oi0-x22f.google.com with SMTP id i12-v6so15847715oik.2
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 03:25:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180703210613.25619-1-armbru@redhat.com>
References: <20180703210613.25619-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jul 2018 11:25:00 +0100
Message-ID: <CAFEAcA8Fgc7SOszMOoyv22NFUcd+gkbzisJMK4RbaoQBog02Ow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/14] QAPI patches for 2018-07-03
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 3 July 2018 at 22:05, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit b07cd3e748b3f27a17c27afeee578dc4eedb8d=
d5:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-3.0-20180703=
' into staging (2018-07-03 14:59:27 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2018-07-03
>
> for you to fetch changes up to 514337c142f9522f6ab89c3d2f964f446ebeb1cd:
>
>   qapi: add conditions to SPICE type/commands/events on the schema (2018-=
07-03 18:38:54 +0200)
>
> ----------------------------------------------------------------
> QAPI patches for 2018-07-03
>
> ----------------------------------------------------------------
> Marc-Andr=C3=A9 Lureau (13):
>       qapi: add 'if' to top-level expressions
>       qapi: pass 'if' condition into QAPISchemaEntity objects
>       qapi: leave the ifcond attribute undefined until check()
>       qapi: add 'ifcond' to visitor methods
>       qapi: mcgen() shouldn't indent # lines
>       qapi: add #if/#endif helpers
>       qapi-introspect: modify to_qlit() to append ',' on level > 0
>       qapi-introspect: add preprocessor conditions to generated QLit
>       qapi/commands: add #if conditions to commands
>       qapi/events: add #if conditions to events
>       qapi: add 'If:' section to generated documentation
>       qapi: add conditions to VNC type/commands/events on the schema
>       qapi: add conditions to SPICE type/commands/events on the schema
>
> Markus Armbruster (1):
>       qapi-types: add #if conditions to types & visitors
>

Applied, thanks.

-- PMM
