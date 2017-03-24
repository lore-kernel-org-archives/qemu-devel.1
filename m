Received: from eggs.gnu.org ([2001:4830:134:3::10]:41559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1crPSA-0003AK-5s
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 09:40:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1crPS9-000379-Ba
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 09:40:30 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:35166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1crPS9-00036s-46
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 09:40:29 -0400
Received: by mail-wm0-x22b.google.com with SMTP id u132so13365854wmg.0
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 06:40:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJSP0QX3z_Zn-jdi7=2qw795Ep2nG5xvWR9DqyWajnKjkCGd3g@mail.gmail.com>
References: <20170316120110.11677-1-iwona260909@gmail.com>
	<20170316120110.11677-2-iwona260909@gmail.com>
	<CAFEAcA8ZBAAqYNbh_3J69W5SMXRsbW4S367Xe8ceF1C0M-RNnA@mail.gmail.com>
	<1489673540.15659.93.camel@redhat.com>
	<CAJSP0QX3z_Zn-jdi7=2qw795Ep2nG5xvWR9DqyWajnKjkCGd3g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Mar 2017 13:40:07 +0000
Message-ID: <CAFEAcA-RH5zqJKAkzRaB-BJBMreLPDUiDtSE639dE_1K-FfBOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] Dead code removal: removing code for
 unsupported DEPTH.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: iwona260909@gmail.com, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On 24 March 2017 at 13:36, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> Gerd, please reply if this is wrong, but here is a summary of the task:
>
> Some emulated graphics cards use qemu_console_surface() and that
> surface is always in 32 bits per pixel format.  Therefore, code for
> dealing with other pixel formats can be removed.
>
> When looking for emulated graphics cards where this cleanup is
> possible, keep in mind that some of the code operates on the guest's
> frame buffer, whose pixel format is not under QEMU's control.
> Therefore we cannot assume that 32bpp is always used and this cleanup
> doesn't apply there.  Limit yourself to code that uses
> qemu_console_surface() exclusively to access the surface and you
> should be fine.  Other code is likely to need support for additional
> pixel formats.

Also worth pointing at an example of a patchset that does
this for some other device, eg Gerd's recent pl110 set,
as a guide to what's getting removed.

thanks
-- PMM
