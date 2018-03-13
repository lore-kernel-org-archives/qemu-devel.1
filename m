Received: from eggs.gnu.org ([2001:4830:134:3::10]:48876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1evkW5-0006I4-Ov
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:03:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1evkW2-0001ei-MZ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:03:01 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:45676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1evkW2-0001eI-G9
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:02:58 -0400
Received: by mail-wr0-x242.google.com with SMTP id h2so15732771wre.12
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 07:02:57 -0700 (PDT)
References: <20180209141514.18840-1-alex.bennee@linaro.org>
	<20180209141514.18840-2-alex.bennee@linaro.org>
	<20180313134017.GA24191@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180313134017.GA24191@redhat.com>
Date: Tue, 13 Mar 2018 14:02:54 +0000
Message-ID: <87fu54rs35.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 1/1] .travis.yml: add --disable-linux-user
 for some jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: peter.maydell@linaro.org, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Feb 09, 2018 at 02:15:14PM +0000, Alex Benn=C3=A9e wrote:
>> The modules and co-routine builds are only really relevant to softmmu
>> builds and regularly timeout on Travis. Let's disable linux-user
>> builds here for more headroom.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index 01a57399b5..0dd5020552 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -52,9 +52,9 @@ env:
>>      - CONFIG=3D""
>>      - CONFIG=3D"--enable-debug --enable-debug-tcg --enable-trace-backen=
ds=3Dlog"
>>      - CONFIG=3D"--disable-linux-aio --disable-cap-ng --disable-attr --d=
isable-brlapi --disable-uuid --disable-libusb"
>> -    - CONFIG=3D"--enable-modules"
>> -    - CONFIG=3D"--with-coroutine=3Ducontext"
>> -    - CONFIG=3D"--with-coroutine=3Dsigaltstack"
>> +    - CONFIG=3D"--enable-modules --disable-linux-user"
>> +    - CONFIG=3D"--with-coroutine=3Ducontext --disable-linux-user"
>> +    - CONFIG=3D"--with-coroutine=3Dsigaltstack --disable-linux-user"
>
> Since this merged, the 4th, 5th & 6th jobs are now reliably completing in
> time, but the 1st and 3rd jobs are hitting timeouts on the majority of
> runs :-(

Yeah it's certainly a problem as QEMU has grown. The original
.travis.yml split things up across architecture lines but we removed
that in favour of "feature" selection.

> We've already got a lot of jobs, but for sake of reliability should we
> consider splitting the 1st & 3rd jobs. Add --disable-linux-user to both
> of the existing jobs, and then adding 2 new jobs with --disable-system
> and --disable-tools set ?

Good idea. I don't suppose you've already tried this?

>
> Regards,
> Daniel


--
Alex Benn=C3=A9e
