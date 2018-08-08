Received: from eggs.gnu.org ([2001:4830:134:3::10]:58025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fnOs0-00046m-0A
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 09:51:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fnOrz-0007gB-2j
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 09:51:24 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:37942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fnOry-0007fq-TL
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 09:51:22 -0400
Received: by mail-oi0-x243.google.com with SMTP id v8-v6so3826530oie.5
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 06:51:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180808104930.23133-4-berrange@redhat.com>
References: <20180808104930.23133-1-berrange@redhat.com>
	<20180808104930.23133-4-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Aug 2018 14:51:01 +0100
Message-ID: <CAFEAcA8XNE5GOtfAi8+pDvYOdeNOU0eHT-xSSA8RK3F94PUv+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] ui: remove support for SDL1.2 in
 favour of SDL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Libvirt <libvir-list@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Fam Zheng <famz@redhat.com>

On 8 August 2018 at 11:49, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wr=
ote:
> SDL1.2 was deprecated in the 2.12.0 release with:
>
>   commit e52c6ba34149b4f39c3fd60e59ee32b809db2bfa
>   Author: Daniel P. Berrange <berrange@redhat.com>
>   Date:   Mon Jan 15 14:25:33 2018 +0000
>
>     ui: deprecate use of SDL 1.2 in favour of 2.0 series
>
>     The SDL 2.0 release was made in Aug, 2013:
>
>       https://www.libsdl.org/release/
>
>     That will soon be 4 + 1/2 years ago, which is enough time to consider
>     the 2.0 series widely supported.
>
>     Thus we deprecate the SDL 1.2 support, which will allow us to delete =
it
>     in the last release of 2018. By this time, SDL 2.0 will be more than =
5
>     years old.
>
>     Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>     Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>     Message-id: 20180115142533.24585-1-berrange@redhat.com
>     Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>
> It is thus able to be removed in the 3.1.0 release.

At least one of the BSD VMs in tests/vm/ is still using SDL1.2.
I think we should update that VM before we drop SDL1.2 support.

(This is probably just a matter of updating the VM image that
is currently stored on patchew somewhere. It would also be
nice if our test infra here had a mechanism for regenerating
that VM image from scratch rather than just being "here's a
disk image blob...")

thanks
-- PMM
