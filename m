Received: from eggs.gnu.org ([2001:4830:134:3::10]:52146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cbNu7-0007tI-7t
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 03:47:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cbNu4-0005fT-5Z
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 03:47:07 -0500
References: <1486399909-16338-1-git-send-email-quintela@redhat.com>
	<CAFEAcA-yFVYzwxt4FG9D3g3BwEJFPnmNrr-pJOzYV-h5Y6bu7A@mail.gmail.com>
	<87lgti1lta.fsf@emacs.mitica>
	<CAFEAcA9RXeubPXZhTS+FHyYVARvb=gVFOQxK8ZYt8OQnhe9WXw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f296fbdf-67c3-8891-e5ca-a25570e3e12f@redhat.com>
Date: Wed, 8 Feb 2017 09:47:00 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9RXeubPXZhTS+FHyYVARvb=gVFOQxK8ZYt8OQnhe9WXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/6] Migration pull
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Juan Quintela <quintela@redhat.com>
Cc: qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 07.02.2017 18:47, Peter Maydell wrote:
> On 7 February 2017 at 07:50, Juan Quintela <quintela@redhat.com> wrote:
>> Peter Maydell <peter.maydell@linaro.org> wrote:
>>> On 6 February 2017 at 16:51, Juan Quintela <quintela@redhat.com> wrot=
e:
>>
>>> I get a test failure on aarch64 host on one of the ppc guest tests:
>>>
>>> TEST: tests/prom-env-test... (pid=3D26435)
>>>   /ppc64/prom-env/mac99:                                             =
  OK
>>>   /ppc64/prom-env/g3beige:                                           =
  OK
>>>   /ppc64/prom-env/pseries:                                           =
  **
>>> ERROR:/home/petmay01/qemu/tests/prom-env-test.c:42:check_guest_memory=
:
>>> assertion failed (signature =3D=3D MAGIC): (0x7c7f1b78 =3D=3D 0xcafec=
0de)
>>> FAIL
>>> GTester: last random seed: R02Sbd97cf9617f5dd55ba90b08765cfa0d0
>>> (pid=3D26445)
>>> FAIL: tests/prom-env-test
>>>
>>>
>>> This might just be the test having an overzealous timeout (I
>>> think I've seen this before a while back, when I was trying
>>> to do a 'make -j2 check' on this slow board); but on the other
>>> hand it's been fine recently but it failed twice trying to test
>>> this pullreq.
>>
>> I don't have n aarch64 host, all I can say is that make check worked o=
n
>> x86_64.
>>
>> I would expect that this didn't change anything for prom enviroment, b=
ut
>> one never knows :p
>>
>> I will wait to see if ppc folks can take a look at this.
>=20
> I tried this pull again, and got two good test runs in a row,
> so I suspect this is just the host being a bit slow and the
> timeout being a bit enthusiastic.

How fast is that aarch64 machine? The timeout of the prom-env test is
already 100 seconds, so that seems to be plenty to me (the test normally
finishes here on my laptop within 15 seconds).
OTOH, if it helps with the aarch64 machine, I'm also fine if we increase
the timeout further - but what value would be appropriate then? Could you
please run the following on that slow machine:

 time QTEST_QEMU_BINARY=3Dppc64-softmmu/qemu-system-ppc64 tests/prom-env-=
test

Thomas
