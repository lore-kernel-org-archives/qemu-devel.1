Received: from eggs.gnu.org ([2001:4830:134:3::10]:51501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eAIyM-0003gY-K7
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:08:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eAIyI-0000JS-IH
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:08:06 -0400
Received: from mail-qt0-x22b.google.com ([2607:f8b0:400d:c0d::22b]:51199)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <makovick@gmail.com>) id 1eAIyI-0000IS-CU
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:08:02 -0400
Received: by mail-qt0-x22b.google.com with SMTP id d9so250101qtd.7
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 10:08:02 -0700 (PDT)
MIME-Version: 1.0
References: <20171023210803.20998-1-makovick@gmail.com>
	<20171023210803.20998-6-makovick@gmail.com>
	<1509533019.3856.9.camel@redhat.com>
In-Reply-To: <1509533019.3856.9.camel@redhat.com>
From: =?UTF-8?B?SmluZMWZaWNoIE1ha292acSNa2E=?= <makovick@gmail.com>
Date: Thu, 02 Nov 2017 17:07:50 +0000
Message-ID: <CAHmvugfcOMEZf1UKAcV0o_-EynuWtSFtzPznDCrVk1R42KWwLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/7] sdl2 uses surface relative coordinates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

Hi,

this patch fixes the exact case you mentioned. Currently, with surface size
smaller than the window, the pointer is confined to the top left corner
when using the absolute mode (-usbdevice tablet).

On Wed, Nov 1, 2017 at 11:43 AM Gerd Hoffmann <kraxel@redhat.com> wrote:

> Why?
>
> Also I think this breaks the pointer in case window size doesn't match
> surface size.
>
> cheers,
>   Gerd
>
> --
Jind=C5=99ich Makovi=C4=8Dka
