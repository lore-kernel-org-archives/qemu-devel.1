Received: from eggs.gnu.org ([2001:4830:134:3::10]:41107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cr03V-0002rC-UA
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 06:33:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cr03S-00059d-RB
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 06:33:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cr03S-00059G-L4
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 06:33:18 -0400
References: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
	<CAFEAcA-2mcGih5bscnMsevTNTy71g9kE7OjTy3hYJKeGoGQw-g@mail.gmail.com>
	<87k27hxyni.fsf@linaro.org>
	<CAFEAcA-oLDW2F=L3NCdSvrLp_eh3tu9mfKR0mTfZ=3O3dpdKbQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1a35985f-ad4b-c017-b355-51d47aaffa11@redhat.com>
Date: Thu, 23 Mar 2017 11:33:15 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-oLDW2F=L3NCdSvrLp_eh3tu9mfKR0mTfZ=3O3dpdKbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Proposal for deprecating unsupported host OSes &
 architecutures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>



On 22/03/2017 14:09, Peter Maydell wrote:
> On 22 March 2017 at 12:51, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>> ...unfortunately the gcc compile farm mips board (1) is very slow
>>> and (2) has very little disk space free in /tmp, which means that
>>> it can't pass "make check" because for instance tests/test-replicatio=
n
>>> assumes it can write comparatively large test files to /tmp/...
>>
>> That makes it sound like a mips cross build or mips linux-user powered
>> image would be useful then?
>=20
> Cross build can't actually run 'make check' and I wouldn't
> trust linux-user to run our test suite. Also, if there's
> no hardware that we can sensibly do make/make check
> on then how much can people really care about QEMU on MIPS?
> (In fact since MIPS supports KVM these days, there really
> ought to be sufficiently capable hardware to work as
> a build system.)

I own a MIPS Creator ci20 board (donated by Imagination Technologies).
I cannot give it a public IP address, but I can try and use it to do
builds every now and then.

Paolo
