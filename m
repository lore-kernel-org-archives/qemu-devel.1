Received: from eggs.gnu.org ([209.51.188.92]:59373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gmLmD-0004Ic-JW
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:53:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gmLmC-0000ZS-E9
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:53:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gmLmC-0000Ye-6G
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:53:20 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 23 Jan 2019 16:53:10 +0000
Message-Id: <20190123165310.9380-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [qemu-web PATCH v2] Add GSoC/Outreachy 2018
 retrospective blog post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: airlied@redhat.com, joel@jms.id.au, Fam Zheng <famz@euphon.net>, thuth@redhat.com, jim@groklearning.com, Paolo Bonzini <pbonzini@redhat.com>, kraxel@redhat.com, marcandre.lureau@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v2:
 * Added mentor names
 * Added additional details from Marc-Andr=C3=A9 and Paolo
---
 _posts/2019-01-23-internships-wrapup.md | 79 +++++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 _posts/2019-01-23-internships-wrapup.md

diff --git a/_posts/2019-01-23-internships-wrapup.md b/_posts/2019-01-23-=
internships-wrapup.md
new file mode 100644
index 0000000..fefcc2a
--- /dev/null
+++ b/_posts/2019-01-23-internships-wrapup.md
@@ -0,0 +1,79 @@
+---
+layout: post
+title:  "GSoC and Outreachy 2018 retrospective"
+date:   2019-01-23 07:50:00 +0100
+categories: [gsoc, outreachy, internships]
+---
+QEMU participates in open source internship programs including Google Su=
mmer of
+Code (GSoC) and Outreachy.  These full-time remote work opportunities al=
low
+talented new developers to get involved in our community.  This post hig=
hlights
+what our interns achieved in 2018.
+
+## micro:bit board emulation
+
+Julia Suvorova (Outreachy) and Steffen G=C3=B6rtz (GSoC) tackled adding =
emulation
+support for the [micro:bit ARM board](https://microbit.org/).  Although =
QEMU
+already has plenty of ARM emulation code, the Cortex-M0 CPU used in the
+micro:bit was not yet implemented and the nRF51 system-on-chip was also
+missing.
+
+The goal of this project was to run micro:bit programs (usually created =
with
+the [MicroPython](https://python.microbit.org/v/1.1) or
+[Javascript/Blocks](https://makecode.microbit.org/) IDEs) with a core se=
t of
+emulated devices, including the serial port, pushbuttons, and LEDs.
+
+QEMU 3.1 already shipped the groundwork for the new `qemu-system-arm -M
+microbit` machine type.  Enough functionality to run basic micro:bit pro=
grams
+is expected in the next QEMU release.
+
+This project was mentored by Jim Mussared, Joel Stanley, and Stefan Hajn=
oczi.
+
+## Patchew REST API improvements
+
+Shubham Jain (GSoC) created a REST API for the Patchew continuous integr=
ation
+system that is at the heart of QEMU's development process.  The previous=
 API
+was not RESTful and exposed database schema internals.
+
+The improvements to the REST API have been included into Patchew and are
+deployed on <a href=3D"https://patchew.org/">patchew.org</a>.  They are =
not in
+use yet, pending more work on authentication; this may be the topic of a=
 future
+Summer of Code internship.
+
+This project was mentored by Paolo Bonzini and Fam Zheng.
+
+## Qtest Driver Framework
+
+Emanuele Esposito (GSoC) enhanced QEMU's test infrastructure with an eng=
ine
+that starts tests with all variants of devices that they are capable of
+driving.
+
+This is a complicated task in QEMU since certain devices and busses are
+available in an architecture-specific way on each emulation target, maki=
ng it
+hard to write test cases without lots of hardcoded dependencies - and to=
 keep
+them up-to-date!
+
+The qgraph framework that Emanuele created eliminates the need to hardco=
de each
+variant into the test.  Emanuele also converted several existing tests. =
 His
+framework was also <a
+href=3D"https://www.youtube.com/watch?v=3DN8Go4NEw0Ss">presented at KVM =
Forum 2019
+by Laurent Vivier</a> and should be merged in 4.0.
+
+This project was mentored by Paolo Bonzini and Laurent Vivier.
+
+## Vulkan-izing VirGL
+
+Nathan Gau=C3=ABr (GSoC) improved VirGL, which provides an OpenGL path w=
ell
+supported on Linux guests. On the host, QEMU offers several console back=
-ends,
+from EGL to SDL. Adding a Vulkan path will require to change the current=
 VirGL
+API, write new guest drivers, and also offer a way to display the output=
. This
+is a huge task, which can be split in several sub-projects. Expending th=
e
+current VirGL API to support Vulkan is the first step.
+
+Code is available [here](https://github.com/Keenuts/vulkan-virgl).
+
+This project was mentored by Marc-Andr=C3=A9 Lureau.
+
+## Stay tuned for 2019 internships!
+
+QEMU will apply to Google Summer of Code and Outreachy again in 2019.  W=
e hope
+to offer more great open source internship opportunities for new develop=
ers.
--=20
2.20.1
