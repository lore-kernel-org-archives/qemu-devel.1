Received: from eggs.gnu.org ([209.51.188.92]:54196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ekohler@gmail.com>) id 1h0qtB-000168-Vj
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:56:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ekohler@gmail.com>) id 1h0qt9-00061J-WF
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:56:29 -0500
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:33484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ekohler@gmail.com>) id 1h0qt8-0005m6-0i
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:56:26 -0500
Received: by mail-qk1-x744.google.com with SMTP id x9so3174737qkf.0
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 08:56:21 -0800 (PST)
MIME-Version: 1.0
References: <20190303104430.7692-1-samuel.thibault@ens-lyon.org>
	<20190303104430.7692-3-samuel.thibault@ens-lyon.org>
	<20190304080338.jalgvluxwqiygqi2@sirius.home.kraxel.org>
	<20190304080622.fvrsvkkq4h4k2z37@function>
In-Reply-To: <20190304080622.fvrsvkkq4h4k2z37@function>
Reply-To: kohler@seas.harvard.edu
From: Eddie Kohler <ekohler@gmail.com>
Date: Mon, 4 Mar 2019 11:56:09 -0500
Message-ID: <CAF0C5SLZzDpR3qin4kixXpb-ewLoYThFLHBHG26=pi5Oa-6dGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com

Another difference is that Samuel's patch supports platforms on which
wchar_t is not Unicode.

I don't know if there are many/any such platforms but it does support them!


On Mon, Mar 4, 2019 at 3:14 AM Samuel Thibault <samuel.thibault@gnu.org>
wrote:

> Gerd Hoffmann, le lun. 04 mars 2019 09:03:38 +0100, a ecrit:
> > On Sun, Mar 03, 2019 at 11:44:30AM +0100, Samuel Thibault wrote:
> > > This uses iconv to convert glyphs from the specified VGA font encoding
> to
> > > unicode, and makes use of cchar_t instead of chtype when using
> ncursesw,
> > > which allows to store all wide char as well as the WACS values.
> > >
> > > Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> > > Cc: Eddie Kohler <ekohler@gmail.com>
> >
> > So the difference to the patch from Eddie is that charset
> > is configurable instead of being hard-coded to CP437?
>
> Yes.
>
> Samuel
>
