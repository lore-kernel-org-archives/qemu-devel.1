Received: from eggs.gnu.org ([2001:4830:134:3::10]:41674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWRQv-0000UQ-KD
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:09:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWRQr-0007Ai-Kq
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:09:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39634 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fWRQr-0007Ae-Fo
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:09:17 -0400
References: <20180622134610.23713-1-f4bug@amsat.org>
	<CAFEAcA84t5uSTWqVoVS6dVh8YXL6SLHAv4DPAqvXUNtDb4jP3g@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4378ee8b-1eec-95e5-7b21-483a033b4c36@redhat.com>
Date: Fri, 22 Jun 2018 21:09:13 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA84t5uSTWqVoVS6dVh8YXL6SLHAv4DPAqvXUNtDb4jP3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] exec: Move hw_error() to the CPU
 namespace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On 22.06.2018 16:32, Peter Maydell wrote:
> On 22 June 2018 at 14:46, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>> hw_error() is only meant for CPU errors (since it dumps the CPU state)=
.
>=20
> I would disagree. hw_error() dumps the state of every CPU. The
> corresponding function for CPU errors is cpu_abort(), which
> dumps only the state of the relevant CPU. It is used pretty
> much only by device models, not by cpu models.
>=20
> In any case, this is one of those functions that's a left
> over from a more innocent time when causing QEMU to bomb out
> with a screenful of hexdump was a reasonable response to the
> guest doing something weird or unsupported.

... but I really wonder why this function got so popular in the hw/
folder. Printing a dump of all CPU states does not make much sense in
most of the cases (which are really not directly related to CPU states).
So yes, we should try to slowly get rid of hw_error() these days!

 Thomas
