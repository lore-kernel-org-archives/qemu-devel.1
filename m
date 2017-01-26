Received: from eggs.gnu.org ([2001:4830:134:3::10]:51519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cWjRN-0005Zl-R5
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 07:46:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cWjRJ-0000hu-6i
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 07:46:13 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:35473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cWjRI-0000gi-Ui
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 07:46:09 -0500
Received: by mail-wm0-x232.google.com with SMTP id r126so70396719wmr.0
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 04:46:07 -0800 (PST)
References: <20170124143346.22240-1-alex.bennee@linaro.org>
	<20170124143346.22240-4-alex.bennee@linaro.org>
	<20170126112601.GK6879@lemon>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170126112601.GK6879@lemon>
Date: Thu, 26 Jan 2017 12:46:03 +0000
Message-ID: <87fuk69egk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 3/7] .travis.yml: DEBUG MacOSX build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: "open list:-----------------..." <qemu-devel@nongnu.org>


Fam Zheng <famz@redhat.com> writes:

> On Tue, 01/24 14:33, Alex Bennée wrote:
>> Currently the MacOSX build is failing. Dump some information to help
>> with figuring out what has gone wrong.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>  .travis.yml | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index 9008a796f0..a9ce215f42 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -92,6 +92,7 @@ matrix:
>>      - env: CONFIG=""
>>        os: osx
>>        compiler: clang
>> +      script: make -j3 || cat qemu-options.texi && false
>>      # Plain Trusty System Build
>>      - env: CONFIG="--disable-linux-user"
>>        sudo: required
>> --
>> 2.11.0
>>
>>
>
> Why qemu-options.texi? This looks really ad-hocery, not sure it's useful for the
> mainline.

This is what was failing - I wasn't intending for this to get pulled, it
was just an example for people wanting to debug the current (now fixed?)
problem.

>
> Fam


--
Alex Bennée
