Received: from eggs.gnu.org ([2001:4830:134:3::10]:41348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cqgGH-00037t-CI
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:25:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cqgGC-0006t5-Jz
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:25:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cqgGC-0006qc-E2
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:25:08 -0400
References: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
	<CAFEAcA-2mcGih5bscnMsevTNTy71g9kE7OjTy3hYJKeGoGQw-g@mail.gmail.com>
	<87k27hxyni.fsf@linaro.org>
	<CAFEAcA-oLDW2F=L3NCdSvrLp_eh3tu9mfKR0mTfZ=3O3dpdKbQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c681f3ee-0b7b-601d-0802-6f9fb88d533a@redhat.com>
Date: Wed, 22 Mar 2017 14:24:57 +0100
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Paul Burton <paul.burton@imgtec.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>

On 22.03.2017 14:09, Peter Maydell wrote:
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

Maybe one of our MIPS maintainers has a clue whether there is a public
MIPS build machine available somewhere? (I've put them on CC:)

 Thomas
