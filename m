Received: from eggs.gnu.org ([209.51.188.92]:36476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggr1i-0002hp-3m
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 08:02:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggr1R-0002RE-4q
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 08:02:27 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggr1N-00029n-B6
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 08:02:18 -0500
Received: by mail-ot1-x341.google.com with SMTP id n8so3385264otl.6
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 05:02:14 -0800 (PST)
MIME-Version: 1.0
References: <20181122170309.4856-1-peter.maydell@linaro.org>
	<20181210143112.ea24zv6klorfkwad@sirius.home.kraxel.org>
In-Reply-To: <20181210143112.ea24zv6klorfkwad@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Jan 2019 13:02:02 +0000
Message-ID: <CAFEAcA9Cz3x_g0Ofkt6qU9bTcEsSEjpfx7VLOuqK0NP+C-dYAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.0] ui/console: Remove
 qemu_create_display_surface_guestmem()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On Mon, 10 Dec 2018 at 14:31, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Thu, Nov 22, 2018 at 05:03:09PM +0000, Peter Maydell wrote:
> > The qemu_create_display_surface_guestmem() function was added in
> > commit a77549b3ffcc24c32ee4e but apparently never used. Remove it.
> >
> > (The API of this function is in any case awkward as a generic
> > function: it assumes that a physical address uniquely identifies
> > a piece of memory in the system, which is mostly but not
> > always true.)
>
> Added to ui queue.

Ping? This doesn't seem to have made it to master.

thanks
-- PMM
