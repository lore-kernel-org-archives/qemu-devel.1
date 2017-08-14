Received: from eggs.gnu.org ([2001:4830:134:3::10]:35124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dhDyk-0006Gf-UH
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 07:56:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dhDyk-0008FH-7r
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 07:56:19 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:37298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dhDyk-0008E7-01
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 07:56:18 -0400
Received: by mail-wm0-x235.google.com with SMTP id i66so41847290wmg.0
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 04:56:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ff54b90d-9912-ce03-31cf-9fd08571eab2@redhat.com>
References: <cover.1502708830.git.mjt@msgid.tls.msk.ru>
	<a808c0865b720e22ca2929ec3d362d4610fbad51.1502708830.git.mjt@msgid.tls.msk.ru>
	<CAFEAcA-Jac8wFzQ9vRyKjcEwDKYBdXysNyDP7ERFfXFhVcF56w@mail.gmail.com>
	<ff54b90d-9912-ce03-31cf-9fd08571eab2@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Aug 2017 12:55:56 +0100
Message-ID: <CAFEAcA_Fr3U5n+pBqfDk1J9GeaLREU1ttgKvMmmawMF+W1Fi+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 7/7] hw/misc/mmio_interface: Return after
 error_setg() to avoid crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, KONRAD Frederic <fred.konrad@greensocs.com>

On 14 August 2017 at 12:52, Thomas Huth <thuth@redhat.com> wrote:
> On 14.08.2017 13:45, Peter Maydell wrote:
>> It seems like it should be an error to permit this to be
>> created from the command line at all

> That's also what thought first ... but the commit message of commit
> 7cc2298c46a6afa4f4ff7e5cd262809c782d701b says that it "can be
> hotplugged/hotunplugged" ? ... that's confusing ...

It means that memory.c creates and deletes instances of the
device on demand, not that it's hotplugged in the "controlled by
the user simulating PCI or other hotplug" sense.

thanks
-- PMM
