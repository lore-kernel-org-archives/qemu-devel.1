Received: from eggs.gnu.org ([2001:4830:134:3::10]:37805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQbGV-0007in-E5
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:21:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQbGU-0007kT-Kh
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:21:55 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:35326)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dQbGU-0007k3-DD
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:21:54 -0400
Received: by mail-wr0-x235.google.com with SMTP id k67so190712158wrc.2
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 08:21:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <F6C36C1A-4661-48F4-BEA6-3994889927D0@gmail.com>
References: <F6C36C1A-4661-48F4-BEA6-3994889927D0@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Jun 2017 16:21:32 +0100
Message-ID: <CAFEAcA88nHp3OjqNDSce=3aDWwxPj16AFrXF4jYmg5H8ZE5V_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ui/cocoa.m: Fix compatibility issue with
 Mac OS 10.9 and under
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

On 28 June 2017 at 20:37, Programmingkid <programmingkidx@gmail.com> wrote:
> The [NSEvent modifierFlags] method returns an NSEventModifierFlags type v=
alue in Mac OS 10.10. It use to be of type NSUInteger. Replacing NSEventMod=
ifierFlags with NSUInteger allows for the cooca.m file to be compiled on ol=
der versions of Mac OS. This patch was been tested on Mac OS 10.6 and Mac O=
S 10.12 without problem.
>
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
>  ui/cocoa.m | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 9e81285..93e56d0 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -571,7 +571,7 @@ QemuCocoaView *cocoaView;
>                  // bitmask.
>
>                  if (qemu_console_is_graphic(NULL)) {
> -                    NSEventModifierFlags modifiers =3D [event modifierFl=
ags];
> +                    NSUInteger modifiers =3D [event modifierFlags];
>
>                      if (!!(modifiers & NSEventModifierFlagCapsLock) !=3D=
 !!modifiers_state[Q_KEY_CODE_CAPS_LOCK]) {
>                          [self toggleStatefulModifier:Q_KEY_CODE_CAPS_LOC=
K];
> --

Applied to master, thanks.

-- PMM
