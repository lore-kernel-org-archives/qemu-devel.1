Received: from eggs.gnu.org ([2001:4830:134:3::10]:60803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dPu0Z-0006ou-T1
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 13:10:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dPu0Y-0007g5-S6
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 13:10:35 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:38443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dPu0Y-0007fy-MW
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 13:10:34 -0400
Received: by mail-wm0-x233.google.com with SMTP id b184so33525856wme.1
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 10:10:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAAdtpL5F4rNona5qD=FBY4RtOsic+K042wgObayuqXsLBfc5=g@mail.gmail.com>
References: <1498487280-17836-1-git-send-email-peter.maydell@linaro.org>
	<149857598110.66.2259618279911881011@4f20b1c0f442>
	<CAAdtpL5F4rNona5qD=FBY4RtOsic+K042wgObayuqXsLBfc5=g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jun 2017 18:10:13 +0100
Message-ID: <CAFEAcA-g0aQy8BjmrC7QA_0+jsciPdLFX9dr1juCdKah2m+YUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] main_loop: Make main_loop_wait() return
 void
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>
Cc: Fam Zheng <famz@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 27 June 2017 at 17:59, Philippe Mathieu-Daud=C3=A9
<philippe@mathieu-daude.net> wrote:
> On Mon, Jun 26, 2017 at 11:28 AM, Peter Maydell
> <peter.maydell@linaro.org> wrote:
> ...
> On Tue, Jun 27, 2017 at 12:06 PM,  <no-reply@patchew.org> wrote:
>> /tmp/qemu-test/src/tests/test-char.c: In function =E2=80=98main_loop=E2=
=80=99:
>> /tmp/qemu-test/src/tests/test-char.c:29: error: void value not ignored a=
s it ought to be

I guess we need to apply the equivalent of e330c118f2a5a to
tests/test-char.c... (and I obviously forgot to run 'make
check' locally before sending the patch.)

thanks
-- PMM
