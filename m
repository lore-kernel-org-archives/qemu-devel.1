Received: from eggs.gnu.org ([209.51.188.92]:40462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hG5FH-0007r7-GF
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 13:18:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hG5FG-0007OJ-GF
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 13:18:15 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hG5FG-0007Nf-8Q
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 13:18:14 -0400
Received: by mail-ot1-x343.google.com with SMTP id f10so15124870otb.6
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 10:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190415154503.6758-1-berrange@redhat.com>
	<83042152-1af4-a237-92a1-f56841623e89@redhat.com>
In-Reply-To: <83042152-1af4-a237-92a1-f56841623e89@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Apr 2019 18:18:01 +0100
Message-ID: <CAFEAcA9ndqdFv8hkMhjVudbajTDLZtcu7rpSdR5OFiqiJtp1bg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0? 0/3] usb-mtp: fix ObjectInfo
 request handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>, Bandan Das <bsd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Mon, 15 Apr 2019 at 18:10, Eric Blake <eblake@redhat.com> wrote:
> On 4/15/19 10:45 AM, Daniel P. Berrang=C3=A9 wrote:
> > The 2nd patch in this series is a security flaw fix since the
> > code was not correctly validating guest provided data length.
>
> Given that this is a security flaw, I've added this series to
> https://wiki.qemu.org/Planning/4.0 in case you're hoping to get it in -rc=
4.

What are the consequences of the flaw ? IIRC it's only one
extra byte read?

thanks
-- PMM
