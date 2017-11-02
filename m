Received: from eggs.gnu.org ([2001:4830:134:3::10]:48136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eABWS-0007zY-Gz
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 05:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eABWM-0000a6-Jq
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 05:10:48 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:43145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eABWM-0000ZS-Cl
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 05:10:42 -0400
Received: by mail-wr0-x230.google.com with SMTP id w105so4301698wrc.0
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 02:10:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171005145557.5746-2-programmingkidx@gmail.com>
References: <20171005145557.5746-1-programmingkidx@gmail.com>
	<20171005145557.5746-2-programmingkidx@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Nov 2017 09:10:20 +0000
Message-ID: <CAFEAcA83iZs0T-rM24QZn1ttAsXjuWfsehW86kJBt52Up1p1Hw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/2] ui/cocoa.m: move ungrab to
 ctrl-alt-g
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 5 October 2017 at 15:55, John Arbuckle <programmingkidx@gmail.com> wrote:
> Currently the cocoa user interface relys on the user pushing control-alt to ungrab the mouse. This is patch changes the key combination to control-alt-g to be in line with the GTK user interface.
>
> signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---

> +
> +                    // release the mouse grab
> +                    case Q_KEY_CODE_G:
> +                        [self ungrabMouse];
> +                        break;
>                  }

Testing this I have found that it makes the grab key be
"ctrl+alt+ the key labelled 'g'", even if in the
OSX host keyboard mapping that key doesn't produce the
letter 'g'. This is in contrast to for instance the menu
accelerators which honour the host keyboard layout, and
it's also not what the GTK UI does. So I think we need
to fix that.

thanks
-- PMM
