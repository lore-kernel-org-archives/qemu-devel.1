Received: from eggs.gnu.org ([209.51.188.92]:36278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h0jNO-0001VG-OV
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 03:55:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h0jNM-0004yV-Sx
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 03:55:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:7991)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h0jNL-0004u7-3y
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 03:55:08 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190303104430.7692-1-samuel.thibault@ens-lyon.org>
	<20190303104430.7692-3-samuel.thibault@ens-lyon.org>
	<87h8cjdtpp.fsf@dusky.pond.sub.org>
	<20190304070857.zxgn6qt3wzjxjca4@function>
Date: Mon, 04 Mar 2019 09:55:01 +0100
In-Reply-To: <20190304070857.zxgn6qt3wzjxjca4@function> (Samuel Thibault's
	message of "Mon, 4 Mar 2019 08:08:57 +0100")
Message-ID: <87zhqb9fyy.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] curses: add option to specify VGA font
 encoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Eddie Kohler <ekohler@gmail.com>, pbonzini@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com

Samuel Thibault <samuel.thibault@gnu.org> writes:

> Markus Armbruster, le lun. 04 mars 2019 07:44:34 +0100, a ecrit:
>> Samuel Thibault <samuel.thibault@ens-lyon.org> writes:
>> > --- a/qapi/ui.json
>> > +++ b/qapi/ui.json
>> > @@ -1131,6 +1131,7 @@
>> >  # @full-screen:   Start user interface in fullscreen mode (default: o=
ff).
>> >  # @window-close:  Allow to quit qemu with window close button (defaul=
t: on).
>> >  # @gl:            Enable OpenGL support (default: off).
>> > +# @charset:       Font charset used by guest (default: CP437).
>>=20
>> Can you give brief rationale for defaulting to CP437?
>
> I have added to the commit message:
>
> =E2=80=9C
> The default charset is made CP437 since that is the charset of the
> hardware default VGA font.
> =E2=80=9D
>
>> > @@ -492,6 +709,10 @@ static void curses_display_init(DisplayState *ds,=
 DisplayOptions *opts)
>> >      }
>> >  #endif
>> >=20=20
>> > +    setlocale(LC_CTYPE, "");
>>=20
>> General principles: any change to locale deserves prominent mention in
>> the commit message.
>
> I have added to the commit message:
>
> =E2=80=9C
> This also makes the curses backend set the LC_CTYPE locale to "" to
> allow curses to emit wide characters.
> =E2=80=9D

Your commit message amendments work for me.  Thanks!
