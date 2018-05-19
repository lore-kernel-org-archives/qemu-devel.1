Received: from eggs.gnu.org ([2001:4830:134:3::10]:50617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fJv4P-00046e-E7
	for qemu-devel@nongnu.org; Sat, 19 May 2018 02:10:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fJv4L-0005mZ-3g
	for qemu-devel@nongnu.org; Sat, 19 May 2018 02:10:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44330 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fJv4K-0005k1-VN
	for qemu-devel@nongnu.org; Sat, 19 May 2018 02:10:17 -0400
References: <20180518091440.1559-1-alex.bennee@linaro.org>
	<20180518091440.1559-3-alex.bennee@linaro.org>
	<CAFEAcA968HDBJiBRCBEu+hV=fUx5HzHbnn6GDGKYzusEtjHGUQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <dd2d19de-eba5-90be-5f01-ff9fd268685f@redhat.com>
Date: Sat, 19 May 2018 08:10:12 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA968HDBJiBRCBEu+hV=fUx5HzHbnn6GDGKYzusEtjHGUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 2/2] tests/Makefile: comment out flakey
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Fam Zheng <famz@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 18.05.2018 20:31, Peter Maydell wrote:
> On 18 May 2018 at 10:14, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>> The following tests keep showing up in failed Travis runs:
>>
>>   - test-aio
>>   - rcutorture
>>   - tpm-crb-test
>>   - tpm-tis-test
>>
>> I suspect it is load that causes the problems but they really need to
>> be fixed properly.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20
> Another flaky test for the collection:
>=20
> TEST: tests/boot-serial-test... (pid=3D25144)
>   /sparc64/boot-serial/sun4u:                                          =
**
> ERROR:/home/petmay01/linaro/qemu-for-merges/tests/boot-serial-test.c:14=
0:check_guest_output:
> assertion failed: (output_ok)
> FAIL
>=20
> Probably another "overly optimistic timeout" setting. (Failed
> for me on x86-64 host just now.)

That test normally finishes within 3 seconds on my machine. The test
timeout is 60 seconds. How much load did you have on that machine to go
from 3s to 60s ?

And even if we increase the timeout, how to find a good value here? I
think we rather need a "no-timeout" switch where we can tell the tests
to not use timeouts and rather run forever instead, until they really
finished? So in normal interactive mode, we'd run with timeouts, but
when running on a loaded builder machine, you'd enable that "no-timeout"
switch to make sure to not run in such "early" timeouts.

 Thomas
