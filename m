Received: from eggs.gnu.org ([2001:4830:134:3::10]:58061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f6ISw-00016I-5g
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 12:19:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f6ISr-00011l-4X
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 12:19:22 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f6ISq-000117-Ul
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 12:19:17 -0400
Received: by mail-wm0-x241.google.com with SMTP id r82so4877220wme.0
	for <qemu-devel@nongnu.org>; Wed, 11 Apr 2018 09:19:16 -0700 (PDT)
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-14-alex.bennee@linaro.org>
	<7ee5d1d4-6310-66ae-0730-cb88f9d260a8@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <7ee5d1d4-6310-66ae-0730-cb88f9d260a8@redhat.com>
Date: Wed, 11 Apr 2018 17:19:11 +0100
Message-ID: <87vacx4sxs.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 13/24] tests/tcg/i386: move
 test-i386-sse.c to tests/tcg/x86_64/test-sse.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, cota@braap.org


Thomas Huth <thuth@redhat.com> writes:

> On 10.04.2018 21:39, Alex Benn=C3=A9e wrote:
>> The test mixes up 32bit and 64 bit code. It should probably be split
>> into two distinct test cases. However for now just move it out of the
>> way of the i386 build.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/tcg/{i386/test-i386-ssse3.c =3D> x86_64/test-sse.c} | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>  rename tests/tcg/{i386/test-i386-ssse3.c =3D> x86_64/test-sse.c} (93%)
>
> Do we really want to have a separate x86_64 folder here? We also have
> 64-bit code in hw/i386/ and target/i386/ so I don't think that we should
> handle this differently for tests/tcg/i386 ? Wouldn't it be sufficient
> to simply move this code to a separate file? ... just my 0.02 =E2=82=AC

It's certainly simpler for the build rules to have a simple mapping from
$(TARGET_NAME) to tests/tcg/FOO....

--
Alex Benn=C3=A9e
