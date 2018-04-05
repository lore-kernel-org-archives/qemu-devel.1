Received: from eggs.gnu.org ([2001:4830:134:3::10]:51774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f41w5-0006ex-WC
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 06:16:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f41w1-0003aO-UF
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 06:16:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35452 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1f41w1-0003aE-QO
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 06:16:01 -0400
References: <20180219040342.12686-1-mdavidsaver@gmail.com>
	<20180219040342.12686-3-mdavidsaver@gmail.com>
	<bd080194-a170-52a0-59fd-31678e838d34@redhat.com>
	<6b259b00-e185-5ca9-f101-e69a5c8dcbb6@gmail.com>
	<364d195d-b948-52f4-8c65-2ea535061fe9@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b3084712-d24a-6568-9805-27a376940336@redhat.com>
Date: Thu, 5 Apr 2018 12:15:48 +0200
MIME-Version: 1.0
In-Reply-To: <364d195d-b948-52f4-8c65-2ea535061fe9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/5] tests: more thorough test of ds1338
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Antoine Mathys <barsamin@gmail.com>, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>

On 24.03.2018 20:39, Michael Davidsaver wrote:
>> On 02/20/2018 09:44 AM, Michael Davidsaver wrote:
>>> On 02/18/2018 11:39 PM, Thomas Huth wrote:
> ...
>>> That magic (together with patch 1/5) is IMHO a little bit ugly. I've =
hit
>>> the same problem with the m48t59 test recently, and I solved it by
>>> moving the qtest_start() and qtest_end() calls from the main() functi=
on
>>> into the single tests instead, so that each test starts with a clean =
state:
>>>
>>> https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D9c29830c90d82f2=
7f
>>>
>>> Could you maybe try whether that approach works for your test cases
>>> here, too? Then you could do this without the "0xff" hack here...
>>
>> Your right, this looks clearer.  I'll try this approach.
>=20
> I ultimately decided not to go with this approach as test failures
> didn't call qtest_quit(), and the process under test is left running
> after gtester exits.
>=20
> Instead I split the current time test off into a second executable.
> This avoids all of the magic.

Honestly, I don't like the idea that we put tests into different files
just because of this. We're not doing this for any other tests so far,
so just using this pattern for the ds1338 / ds1375 tests sounds wrong.

If there is an issue with test processes not being killed correctly, I
think we should rather fix that issue instead, maybe by adding a special
function with atexit() or something similar ... I haven't looked closely
into that yet.

Just my 0.02 =E2=82=AC.

 Thomas
