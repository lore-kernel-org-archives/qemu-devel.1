Received: from eggs.gnu.org ([2001:4830:134:3::10]:45799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fBcl0-0005LA-R2
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 05:00:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fBckw-00085s-Tj
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 05:00:02 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:37378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fBckw-00085X-Ly
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 04:59:58 -0400
Received: by mail-wm0-x22c.google.com with SMTP id l16so11746560wmh.2
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 01:59:58 -0700 (PDT)
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-23-alex.bennee@linaro.org>
	<3bcdb8d9-2d67-c928-07ee-78c2a2e7e781@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <3bcdb8d9-2d67-c928-07ee-78c2a2e7e781@linaro.org>
Date: Thu, 26 Apr 2018 09:59:56 +0100
Message-ID: <877eoul4vn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 22/46] tests/tcg/i386: disable i386
 version of test-i386-ssse
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> On 04/24/2018 05:23 AM, Alex Benn=C3=A9e wrote:
>>  # Update TESTS
>> -TESTS+=3D$(I386_TESTS)
>> +TESTS+=3D$(I386_ONLY_TESTS)
>
> Doesn't this depend on a variable you introduce in the next patch?
<snip>

Hmm, it should probably be merged.

--
Alex Benn=C3=A9e
