Received: from eggs.gnu.org ([2001:4830:134:3::10]:47889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eX7VJ-0004Ap-2f
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 10:32:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eX7VG-0004sW-89
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 10:32:25 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:5345)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1eX7VF-0004pt-Tl
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 10:32:22 -0500
Date: Thu, 4 Jan 2018 16:32:19 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180104153219.wsxtkzuznu2iwra7@var.youpi.perso.aquilenet.fr>
References: <1515071752-22961-1-git-send-email-thuth@redhat.com>
	<20180104140930.7hbtnen3lw7epmrh@var.youpi.perso.aquilenet.fr>
	<a78b6f7a-3eb2-6749-ccba-ad1ba4d525ae@redhat.com>
	<20180104141524.m5xy66jsn2hiajwl@var.youpi.perso.aquilenet.fr>
	<20180104142101.rivje5qn5dasb6jw@var.youpi.perso.aquilenet.fr>
	<aea97804-c6a9-d903-13d8-23bc6b46af86@redhat.com>
	<20180104152402.fv52umjmlb2g22wc@var.youpi.perso.aquilenet.fr>
	<b1a86fed-8a98-cc1d-46ca-5462f8be3fc7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1a86fed-8a98-cc1d-46ca-5462f8be3fc7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] usb: Remove legacy -usbdevice option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, kraxel@redhat.com, qemu-devel@nongnu.org

Paolo Bonzini, on jeu. 04 janv. 2018 16:28:27 +0100, wrote:
> On 04/01/2018 16:24, Samuel Thibault wrote:
> >> Maybe we can add "-braille" instead.
> > I guess such legacy-looking option would be frowned up :)
> 
> Not really.  As long as it doesn't propagate everywhere in device code,
> it's fine.  We are not going to deprecate "-serial mon:stdio", so...
> 
> > And anyway we need to be able to specify either -serial braille or
> > -device usb-braille.
> 
> So "-braille serial" and "-braille usb"?

Well, why not, it just doesn't seem to me much simpler than
"-serial braille" and "-device usb-braille" :)

Samuel
