Received: from eggs.gnu.org ([209.51.188.92]:44164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMaqN-0000jB-F0
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:15:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMaqM-0000Et-JP
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:15:27 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMaqM-0000DR-Bk
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:15:26 -0400
Received: by mail-wr1-x442.google.com with SMTP id h15so2871560wrb.2
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 09:15:26 -0700 (PDT)
References: <20190503143904.31211-1-alex.bennee@linaro.org>
	<98cd84db-2aed-4aa1-1f2d-eaa7ac63b72b@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <98cd84db-2aed-4aa1-1f2d-eaa7ac63b72b@redhat.com>
Date: Fri, 03 May 2019 17:15:23 +0100
Message-ID: <87d0kz4iqs.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>


Thomas Huth <thuth@redhat.com> writes:

> On 03/05/2019 16.39, Alex Benn=C3=A9e wrote:
>> This attempts to clean-up the output to better match the output of the
>> rest of the QEMU check system. This includes:
>>
>>   - formatting as "  TEST    iotest: nnn"
>>   - calculating time diff at the end
>>   - only dumping config on failure
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/qemu-iotests/check | 71 +++++++++++++++++++---------------------
>>  1 file changed, 34 insertions(+), 37 deletions(-)
>
> Thanks for tackling this! The output now looks nicer indeed if you run
> "make check-qtest check-block -j8". However, if you add a "V=3D1" at the
> end of the command line, the outputs look quite different again...
>
> That's why I thought that having a TAP mode for the check script could
> be a good idea, too. Then we could pipe the output through the
> tap-driver.pl script, too, so we get uniform output for all tests...?

That would probably be a cleaner approach. What would be even better is
somehow expanding the list of tests at make time so you could run your
tests in parallel.

I did wonder how useful the timing stuff was to developers.

>
>  Thomas


--
Alex Benn=C3=A9e
