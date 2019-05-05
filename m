Received: from eggs.gnu.org ([209.51.188.92]:50411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hNJSu-0002eu-Oe
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:54:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hNJSt-0005pU-NG
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:54:12 -0400
References: <20190503143904.31211-1-alex.bennee@linaro.org>
	<98cd84db-2aed-4aa1-1f2d-eaa7ac63b72b@redhat.com>
	<87d0kz4iqs.fsf@zen.linaroharston>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0badc17e-90bc-1a09-89c1-20f88ff75d3b@redhat.com>
Date: Sun, 5 May 2019 17:54:05 +0200
MIME-Version: 1.0
In-Reply-To: <87d0kz4iqs.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] tests/qemu-iotests: re-format output
 to for make check-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 03/05/2019 18.15, Alex Benn=C3=A9e wrote:
>=20
> Thomas Huth <thuth@redhat.com> writes:
>=20
>> On 03/05/2019 16.39, Alex Benn=C3=A9e wrote:
>>> This attempts to clean-up the output to better match the output of th=
e
>>> rest of the QEMU check system. This includes:
>>>
>>>   - formatting as "  TEST    iotest: nnn"
>>>   - calculating time diff at the end
>>>   - only dumping config on failure
>>>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> ---
>>>  tests/qemu-iotests/check | 71 +++++++++++++++++++-------------------=
--
>>>  1 file changed, 34 insertions(+), 37 deletions(-)
>>
>> Thanks for tackling this! The output now looks nicer indeed if you run
>> "make check-qtest check-block -j8". However, if you add a "V=3D1" at t=
he
>> end of the command line, the outputs look quite different again...
>>
>> That's why I thought that having a TAP mode for the check script could
>> be a good idea, too. Then we could pipe the output through the
>> tap-driver.pl script, too, so we get uniform output for all tests...?
>=20
> That would probably be a cleaner approach. What would be even better is
> somehow expanding the list of tests at make time so you could run your
> tests in parallel.

I agree that this might be the ultimate solution ... but I'm not sure
whether the iotests are really ready for being run in parallel yet, so
it will likely take quite some while 'till we are at that point. With
that in mind (and thus also not sure yet whether my TAP idea is really
the right approach), your patch is certainly a good interim solution
which we should try to get merged, too, when my "make check" series gets
accepted?

> I did wonder how useful the timing stuff was to developers.

Yes, me too ... maybe the block layer folks can comment on that one...?

 Thomas
