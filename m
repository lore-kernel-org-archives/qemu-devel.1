Received: from eggs.gnu.org ([2001:4830:134:3::10]:33066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cgSPz-0008D3-5f
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 03:37:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cgSPy-0000Zt-A9
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 03:36:59 -0500
Received: from mail-lf0-x235.google.com ([2a00:1450:4010:c07::235]:35194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cgSPy-0000ZT-3O
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 03:36:58 -0500
Received: by mail-lf0-x235.google.com with SMTP id z127so2314654lfa.2
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 00:36:56 -0800 (PST)
MIME-Version: 1.0
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
	<20170221141451.28305-27-marcandre.lureau@redhat.com>
	<1487718088.20449.3.camel@redhat.com>
In-Reply-To: <1487718088.20449.3.camel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 22 Feb 2017 08:36:43 +0000
Message-ID: <CAJ+F1C+nSxEBrX4XCHVy+Jb1_tcrA39F5jXQEi+9ubcjdTTvNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 26/30] tests: allows to run single test
 in usb-hcd-ehci-test
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

Hi

On Wed, Feb 22, 2017 at 3:05 AM Gerd Hoffmann <kraxel@redhat.com> wrote:

> On Di, 2017-02-21 at 18:14 +0400, Marc-Andr=C3=A9 Lureau wrote:
> > pci_init() shouldn't be a test function, but instead called before any
> > test. This allows to run a single test with -p /x86_64/ehci/....
>
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
>
> /me assumes you'll go send a pull request for the whole series?
> Or do you want me cherry-pick the usb patches into the usb queue?
>

Since the whole series is pending for reviews, feel free to pick the usb
patches, I'll rebase regularly.

thanks
--=20
Marc-Andr=C3=A9 Lureau
