Received: from eggs.gnu.org ([209.51.188.92]:50487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gmMkU-0002dV-6F
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:55:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gmMkQ-00036Z-8t
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:55:36 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gmMkO-0002vk-7n
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:55:32 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so3506706wrt.13
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 09:55:11 -0800 (PST)
Date: Wed, 23 Jan 2019 18:55:07 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190123175507.7nwm5gjx3ic2v5rm@steredhat>
References: <20190123165310.9380-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190123165310.9380-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [qemu-web PATCH v2] Add GSoC/Outreachy 2018
 retrospective blog post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, Fam Zheng <famz@euphon.net>, jim@groklearning.com, marcandre.lureau@redhat.com, joel@jms.id.au, Paolo Bonzini <pbonzini@redhat.com>, airlied@redhat.com, kraxel@redhat.com

On Wed, Jan 23, 2019 at 04:53:10PM +0000, Stefan Hajnoczi wrote:
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2:
>  * Added mentor names
>  * Added additional details from Marc-André and Paolo
> ---
>  _posts/2019-01-23-internships-wrapup.md | 79 +++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 _posts/2019-01-23-internships-wrapup.md
> 
> diff --git a/_posts/2019-01-23-internships-wrapup.md b/_posts/2019-01-23-internships-wrapup.md
> new file mode 100644
> index 0000000..fefcc2a
> --- /dev/null
> +++ b/_posts/2019-01-23-internships-wrapup.md
> @@ -0,0 +1,79 @@
> +---
> +layout: post
> +title:  "GSoC and Outreachy 2018 retrospective"
> +date:   2019-01-23 07:50:00 +0100
> +categories: [gsoc, outreachy, internships]
> +---
> +QEMU participates in open source internship programs including Google Summer of
> +Code (GSoC) and Outreachy.  These full-time remote work opportunities allow
> +talented new developers to get involved in our community.  This post highlights
> +what our interns achieved in 2018.
> +
> +## micro:bit board emulation
> +
> +Julia Suvorova (Outreachy) and Steffen Görtz (GSoC) tackled adding emulation
> +support for the [micro:bit ARM board](https://microbit.org/).  Although QEMU
> +already has plenty of ARM emulation code, the Cortex-M0 CPU used in the
> +micro:bit was not yet implemented and the nRF51 system-on-chip was also
> +missing.
> +
> +The goal of this project was to run micro:bit programs (usually created with
> +the [MicroPython](https://python.microbit.org/v/1.1) or
> +[Javascript/Blocks](https://makecode.microbit.org/) IDEs) with a core set of
> +emulated devices, including the serial port, pushbuttons, and LEDs.
> +
> +QEMU 3.1 already shipped the groundwork for the new `qemu-system-arm -M
> +microbit` machine type.  Enough functionality to run basic micro:bit programs
> +is expected in the next QEMU release.
> +
> +This project was mentored by Jim Mussared, Joel Stanley, and Stefan Hajnoczi.
> +
> +## Patchew REST API improvements
> +
> +Shubham Jain (GSoC) created a REST API for the Patchew continuous integration
> +system that is at the heart of QEMU's development process.  The previous API
> +was not RESTful and exposed database schema internals.
> +
> +The improvements to the REST API have been included into Patchew and are
> +deployed on <a href="https://patchew.org/">patchew.org</a>.  They are not in
> +use yet, pending more work on authentication; this may be the topic of a future
> +Summer of Code internship.
> +
> +This project was mentored by Paolo Bonzini and Fam Zheng.
> +
> +## Qtest Driver Framework
> +
> +Emanuele Esposito (GSoC) enhanced QEMU's test infrastructure with an engine
> +that starts tests with all variants of devices that they are capable of
> +driving.
> +
> +This is a complicated task in QEMU since certain devices and busses are
> +available in an architecture-specific way on each emulation target, making it
> +hard to write test cases without lots of hardcoded dependencies - and to keep
> +them up-to-date!
> +
> +The qgraph framework that Emanuele created eliminates the need to hardcode each
> +variant into the test.  Emanuele also converted several existing tests.  His
> +framework was also <a
> +href="https://www.youtube.com/watch?v=N8Go4NEw0Ss">presented at KVM Forum 2019

s/2019/2018

Cheers,
Stefano
