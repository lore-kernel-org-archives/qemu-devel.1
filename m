Received: from eggs.gnu.org ([2001:4830:134:3::10]:40693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1evn5y-0002IP-OM
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:48:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1evn5r-0001FM-CY
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:48:14 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:40631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1evn5r-0001F8-5k
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:48:07 -0400
Received: by mail-wr0-x242.google.com with SMTP id m4so747777wrb.7
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 09:48:07 -0700 (PDT)
References: <20180313153210.28264-1-alex.bennee@linaro.org>
	<20180313153210.28264-5-alex.bennee@linaro.org>
	<20180313153631.GD3079@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180313153631.GD3079@redhat.com>
Date: Tue, 13 Mar 2018 16:48:04 +0000
Message-ID: <87efknsz0b.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 4/4] .travis.yml: add --disable-tools to
 the modules build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, Fam Zheng <famz@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Mar 13, 2018 at 03:32:10PM +0000, Alex Benn=C3=A9e wrote:
>> The tools are already built elsewhere so we might as well not build it
>> here as we just need to test the modules build of QEMU itself.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  .travis.yml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index c1e99237b2..373181c109 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -53,7 +53,7 @@ env:
>>      - CONFIG=3D"--disable-user"
>>      - CONFIG=3D"--enable-debug --enable-debug-tcg"
>>      - CONFIG=3D"--disable-linux-aio --disable-cap-ng --disable-attr --d=
isable-brlapi --disable-uuid --disable-libusb --disable-user"
>> -    - CONFIG=3D"--enable-modules --disable-linux-user"
>> +    - CONFIG=3D"--enable-modules --disable-tools --disable-linux-user"
>>      - CONFIG=3D"--with-coroutine=3Ducontext --disable-linux-user"
>>      - CONFIG=3D"--with-coroutine=3Dsigaltstack --disable-linux-user"
>>  git:
>
> Modules affects the block drivers in particular, which could in theory
> affect the qemu-img, qemu-io and qemu-nbd tools, so possibly worth
> keeping that enabled.... but only if we actually run those tools
> during the job otherwise we're not likely to catch any problems ?

OK, I've dropped this for the pull-req as it shouldn't affect our
timeouts anyway.

>
>
> Regards,
> Daniel


--
Alex Benn=C3=A9e
