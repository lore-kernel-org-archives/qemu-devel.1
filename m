Received: from eggs.gnu.org ([2001:4830:134:3::10]:39386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlipchuk@redhat.com>) id 1cIy9p-00057G-TZ
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 08:39:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlipchuk@redhat.com>) id 1cIy9m-00072L-Op
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 08:39:13 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:34965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlipchuk@redhat.com>) id 1cIy9m-00072C-Jq
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 08:39:10 -0500
Received: by mail-io0-f174.google.com with SMTP id h30so152308848iod.2
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 05:39:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161219131022.GA4805@noname.redhat.com>
References: <CAJ1JNOepVarVZZeVKaUN+5TTRFz-BKU+WcEu5koUR_W2YrFADA@mail.gmail.com>
	<CAJ1JNOc_HHVZOx_qZTWK=U_dn6_69UDnD3eDmoEVU4mYnCLC2w@mail.gmail.com>
	<20161219131022.GA4805@noname.redhat.com>
From: Maor Lipchuk <mlipchuk@redhat.com>
Date: Mon, 19 Dec 2016 15:39:08 +0200
Message-ID: <CAJ1JNOcLYDxZ_FD_Sm+g8M+-K1jcVEmg-WPk+21opqqOWotnQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Is qemu-img amend an atomic operation?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Nir Soffer <nsoffer@redhat.com>, mreitz@redhat.com

On Mon, Dec 19, 2016 at 3:10 PM, Kevin Wolf <kwolf@redhat.com> wrote:

> Am 19.12.2016 um 13:49 hat Maor Lipchuk geschrieben:
> >
> > On Mon, Dec 19, 2016 at 2:47 PM, Maor Lipchuk <mlipchuk@redhat.com>
> wrote:
> >
> >     Hi All,
> >
> >     Does amend considered as an atomic operation or should we mark a
> volume as
> >     ILLEGAL once the amend operation fails?
> >
> >     also, if I call amend, but downgrade the QCOW volume compatibility
> level
> >     from 1.1 to 0.10, is that atomic as well (or not, based on the
> answer on
> >     the previous question)?
> >
> >     Regards,
> >     Maor
> >
> > Adding also Nir and Kevin to the thread.
>
> Like with every other operation, the image is supposed to stay
> consistent at all times, even if the host crashes in the middle.
> Leaked clusters are the worst that should be possible, anything
> else would be a bug.
>
> Kevin
>


Great, thank you!
