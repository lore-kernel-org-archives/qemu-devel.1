Received: from eggs.gnu.org ([2001:4830:134:3::10]:56833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBhb9-0000GL-2G
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:10:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBhb5-0003VW-Qb
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:10:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37048 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fBhb5-0003Uz-NG
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:10:07 -0400
References: <20180426135755.GI29865@localhost.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <dffa77fa-11d7-5f3c-4c1e-7ed25a55fa25@redhat.com>
Date: Thu, 26 Apr 2018 16:09:55 +0200
MIME-Version: 1.0
In-Reply-To: <20180426135755.GI29865@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Who is running QEMU automated tests, and when?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Yash Mankad <ymankad@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>

On 26.04.2018 15:57, Eduardo Habkost wrote:
> (Starting a new thread, for more visibility)
>=20
> (This was: Re: [Qemu-devel] [RFC PATCH] tests/device-introspect: Test
> devices with all machines, not only with "none")
>=20
> On Thu, Apr 26, 2018 at 01:54:43PM +0200, Markus Armbruster wrote:
[...]
>> I don't mind having make check SPEED=3Dslow run more extensive tests.
>> Assuming we actually run them at least once in a while, which seems
>> doubtful.
>=20
> We probably don't do that, but we really must be running a more
> extensive (and slower) test set at least once before every
> release.
>=20
> Maybe some people are running SPEED=3Dslow tests, or even more
> extensive test suites like avocado-vt once in a while, but we
> need to know who is running them, and when.

At least I am running "make check SPEED=3Dslow" manually from time to
time, especially when we enter the hard freeze period.

> Today, the only test set I know people really run and would
> surely block a release is "make check [SPEED=3Dquick]".

Same is true for the iotests, though they are run a little bit more
often than "check SPEED=3Dslow", I think.

 Thomas


> So, for anybody that runs automated QEMU tests once in a while,
> can we know:
>=20
> * What test cases are you running?  Where can we get more
>   information about the tests you run?
> * When do you run them?  What triggers a new test run?
>=20
> Peter, do you have additional tests you run before merging a pull
> request?  Additional test sets run before tagging a release?
>=20
