Received: from eggs.gnu.org ([209.51.188.92]:58867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1h1t4H-0006kk-64
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:28:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1h1t4G-0000L7-Ir
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:28:13 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1h1t4G-0000KS-AX
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:28:12 -0500
Received: by mail-wm1-x344.google.com with SMTP id n19so9248554wmi.1
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 05:28:12 -0800 (PST)
MIME-Version: 1.0
References: <20190307072025.8041-1-elena.ufimtseva@oracle.com>
	<20190307104550.GE2843@stefanha-x1.localdomain>
In-Reply-To: <20190307104550.GE2843@stefanha-x1.localdomain>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 7 Mar 2019 14:27:57 +0100
Message-ID: <CAJ+F1CK_Lr+UKkzicLvfwcBRa4kTTrOQTm0wN8cEHek+Tkj=dw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [multiprocess RFC PATCH 00/37] Initial support of
 multi-process qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: elena.ufimtseva@oracle.com, john.g.johnson@oracle.com, Stefano Stabellini <sstabellini@kernel.org>, jag.raman@oracle.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, QEMU <qemu-devel@nongnu.org>, Ross Lagerwall <ross.lagerwall@citrix.com>, liran.alon@oracle.com, Stefan Hajnoczi <stefanha@redhat.com>, kanth.ghatraju@oracle.com

Hi

On Thu, Mar 7, 2019 at 11:46 AM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Wed, Mar 06, 2019 at 11:20:25PM -0800, elena.ufimtseva@oracle.com wrot=
e:
> > From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> >
> > Initial support of multi-process qemu
>
> Hi Elena,
> Please use the following setting when sending future patch series:
>
>   $ git config sendemail.thread shallow
>
> This way all patches are part of a single email thread (starting with
> your PATCH 00 cover letter).  Reviewers find this more convenient so
> that individual emails don't get separated and lost.
>

Please also check that there is no regression after each commit. In
particular, the build shouldn't fail, so we can easily study, apply
and bisect patches one by one.

thanks


--=20
Marc-Andr=C3=A9 Lureau
