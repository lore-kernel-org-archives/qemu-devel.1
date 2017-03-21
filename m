Received: from eggs.gnu.org ([2001:4830:134:3::10]:32967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cqJPY-00065G-Gc
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 09:01:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cqJPU-0000fP-K1
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 09:01:16 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vfeenstr@redhat.com>) id 1cqJPU-0000em-EX
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 09:01:12 -0400
Received: by mail-wm0-f52.google.com with SMTP id u132so11529181wmg.0
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 06:01:12 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
From: Vinzenz Feenstra <vfeenstr@redhat.com>
In-Reply-To: <CAFEAcA-bu9noosLApv83U2WAs27q4Kx2zVv_xpZtWjL=64VSdA@mail.gmail.com>
Date: Tue, 21 Mar 2017 14:01:09 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <494FFBCD-C622-41B8-827B-171E89970971@redhat.com>
References: <20170316111416.25587-1-vfeenstr@redhat.com>
	<CAFEAcA-bu9noosLApv83U2WAs27q4Kx2zVv_xpZtWjL=64VSdA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] checkpatch: Supress warning in function
 pointer typedefs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>


> On Mar 21, 2017, at 1:37 PM, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On 16 March 2017 at 11:14, Vinzenz 'evilissimo' Feenstra
> <vfeenstr@redhat.com> wrote:
>> From: Vinzenz Feenstra <vfeenstr@redhat.com>
>>=20
>> When importing dynamically functions via `GetProcAddress` in windows
>> related code, it is quite common to make a typedef for the resulting
>> function pointer. When the function to be imported, has a stdcall
>> calling convention, usually the `WINAPI` macro is used. This patch =
adds an
>> exception in the checkpatch.pl script to allow the calling convention
>> specification in function pointer typedefs, to be `WINAPI`.
>>=20
>> Signed-off-by: Vinzenz Feenstra <vfeenstr@redhat.com>
>=20
> Could you provide an example of the kind of source line that provokes
> the incorrect warning and the checkpatch output that results,
> please?

Hmm I just realize that it is working now, but I figured out now what is =
the real problem and that
my patch is wrong. Please discard this patch and thanks for making me =
think again :-)

>=20
> thanks
> -- PMM
