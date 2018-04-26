Received: from eggs.gnu.org ([2001:4830:134:3::10]:33192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBhqI-0008Du-8m
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:25:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBhqH-0006Ft-6Y
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:25:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39702 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fBhqH-0006Fp-2K
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:25:49 -0400
References: <20180426135755.GI29865@localhost.localdomain>
	<dffa77fa-11d7-5f3c-4c1e-7ed25a55fa25@redhat.com>
	<20180426141400.GM26812@redhat.com>
	<20180426142236.GJ29865@localhost.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <38a11e73-bb46-873c-b452-feed630b7325@redhat.com>
Date: Thu, 26 Apr 2018 16:25:40 +0200
MIME-Version: 1.0
In-Reply-To: <20180426142236.GJ29865@localhost.localdomain>
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
To: Eduardo Habkost <ehabkost@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Yash Mankad <ymankad@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>

On 26.04.2018 16:22, Eduardo Habkost wrote:
> On Thu, Apr 26, 2018 at 03:14:00PM +0100, Daniel P. Berrang=C3=A9 wrote=
:
>> On Thu, Apr 26, 2018 at 04:09:55PM +0200, Thomas Huth wrote:
>>> On 26.04.2018 15:57, Eduardo Habkost wrote:
>>>> (Starting a new thread, for more visibility)
>>>>
>>>> (This was: Re: [Qemu-devel] [RFC PATCH] tests/device-introspect: Tes=
t
>>>> devices with all machines, not only with "none")
>>>>
>>>> On Thu, Apr 26, 2018 at 01:54:43PM +0200, Markus Armbruster wrote:
>>> [...]
>>>>> I don't mind having make check SPEED=3Dslow run more extensive test=
s.
>>>>> Assuming we actually run them at least once in a while, which seems
>>>>> doubtful.
>>>>
>>>> We probably don't do that, but we really must be running a more
>>>> extensive (and slower) test set at least once before every
>>>> release.
>>>>
>>>> Maybe some people are running SPEED=3Dslow tests, or even more
>>>> extensive test suites like avocado-vt once in a while, but we
>>>> need to know who is running them, and when.
>>>
>>> At least I am running "make check SPEED=3Dslow" manually from time to
>>> time, especially when we enter the hard freeze period.
>>
>> Hmm, we could get this done by travis. It has the concept of "cron job=
s"
>> for scheduling builds separately from pushes.
>>
>> So we could keep the current travis jobs unchanged, but then add an
>> use of SPEED=3Dslow when TRAVIS_EVENT_TYPE =3D=3D "cron" in the travis=
.yml,
>> so we can get SPEED=3Dslow run once a day. Just have to be careful whi=
ch
>> jobs we make slow so we don't hit the 50 minute timeout.
>=20
> I expect SPEED=3Dslow tests to eventually take longer than 50
> minutes, but we can try this and see what happens.

I already had to move some of the slow tests to SPEED=3Dslow mode in the
past due to the travis timeouts (which are hit when the machines are
very loaded), so my guess is that SPEED=3Dslow will hardly work with trav=
is.

 Thomas
