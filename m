Received: from eggs.gnu.org ([209.51.188.92]:50104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gmJr3-0002gv-Mv
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:50:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gmJr1-0003H6-4W
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:50:13 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:38896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gmJr0-0003Ex-RW
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:50:10 -0500
Received: by mail-wr1-f52.google.com with SMTP id v13so2782710wrw.5
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 06:50:09 -0800 (PST)
References: <20190103153320.21687-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <975d05a9-57f1-4183-b84e-231265e3177e@redhat.com>
Date: Wed, 23 Jan 2019 15:50:05 +0100
MIME-Version: 1.0
In-Reply-To: <20190103153320.21687-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [qemu-web RFC] Add GSoC/Outreachy 2018
 retrospective blog post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: jim@groklearning.com, Fam Zheng <famz@euphon.net>, airlied@redhat.com, Thomas Huth <thuth@redhat.com>, joel@jms.id.au, marcandre.lureau@redhat.com, kraxel@redhat.com

On 03/01/19 16:33, Stefan Hajnoczi wrote:
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> Dear mentors,
> Let's post an overview of what was achieved in GSoC/Outreachy 2018.  I
> have populated a blog post with information available to me, but I'm
> sure it can be improved to explain how the project went and the current
> status.
> 
> Please let me know what should be changed, thanks!
> ---
>  _posts/2019-01-03-internships-wrapup.md | 61 +++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 _posts/2019-01-03-internships-wrapup.md
> 
> diff --git a/_posts/2019-01-03-internships-wrapup.md b/_posts/2019-01-03-internships-wrapup.md
> new file mode 100644
> index 0000000..ec245e6
> --- /dev/null
> +++ b/_posts/2019-01-03-internships-wrapup.md
> @@ -0,0 +1,61 @@
> +---
> +layout: post
> +title:  "GSoC and Outreachy 2018 retrospective"
> +date:   2019-01-03 07:50:00 +0100
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
> +## Patchew REST API improvements
> +
> +Shubham Jain (GSoC) created a REST API for the Patchew continuous integration
> +system that is at the heart of QEMU's development process.  The previous API
> +was not RESTful and exposed database schema internals.

The improvements to the REST API have been included into Patchew and are
deployed on http://patchew.org/.  They are not in use yet, pending more
work on authentication; this may be the topic of a future Summer of Code
internship.

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
> +variant into the test.

Emanuele also converted several existing tests.  His framework was also
presented at KVM Forum 2019 by Laurent Vivier, Emanuele's mentor,  and
should be merged in 4.0.

Paolo
