Received: from eggs.gnu.org ([2001:4830:134:3::10]:40282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f3x6P-0002mB-U1
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 01:06:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f3x6L-000830-6j
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 01:06:25 -0400
References: <20180207225540.31698-1-richard.henderson@linaro.org>
	<20180207225540.31698-17-richard.henderson@linaro.org>
	<20180404164908.GA7582@flamenco>
	<330b4559-52a5-50d6-3a85-da7bb0850107@linaro.org>
	<0f10b5a5-2be0-4b6b-3c58-e718a062f07d@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <84a25fa4-d1a6-0e9c-a28f-770baeff0ce4@redhat.com>
Date: Thu, 5 Apr 2018 07:06:08 +0200
MIME-Version: 1.0
In-Reply-To: <0f10b5a5-2be0-4b6b-3c58-e718a062f07d@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 16/20] target/arm: Use vector infrastructure
 for aa64 compares
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, "Emilio G. Cota" <cota@braap.org>
Cc: peter.maydell@linaro.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

On 05.04.2018 02:54, Richard Henderson wrote:
> On 04/05/2018 10:07 AM, Richard Henderson wrote:
>> On 04/05/2018 02:49 AM, Emilio G. Cota wrote:
>>> 1. grab this binary:
>>>   http://cs.columbia.edu/~cota/qemu/nbench-aarch64
>>> 2. run it on a PowerPC host with:
>>>   $ aarch64-linux-user/qemu-aarch64 nbench-aarch64 -V
>>>
>>> Note: the "-V" (or "-v") flag is important! Without it, there's no se=
gfault.
>>
>> How quickly?  I did not see one up until it exited for lack of NNET.DA=
T.
>>
>> I will note that I am using gcc 7.2 on gcc112 (/opt/cfarm/gcc-latest/b=
in/gcc).
>>
>> Are you using gcc 4.8.5, and is commit 74912f6dad in your tree?
>> That commit might have made a difference...
>=20
> Bah.  I confirm that it doesn't, and that the test still fails.
>=20
> Since qemu does work on the same host when built with gcc 7.2, I can on=
ly blame
> this failure on a compiler bug wrt gcc 4.8 on ppc64.
>=20
> I have not tracked down exactly what's going wrong, and probably won't =
unless
> someone feels that it's worthwhile.  This only begs the question of whe=
ther we
> should blacklist this compiler entirely.  Certainly it's old enough tha=
t it's
> probably not worth fixing.

GCC 4.8 is still used in enterprise distros like RHEL7 and AFAIK also in
SLES 12 ... so blacklisting this compiler does not sound like a good
idea to me.

 Thomas
