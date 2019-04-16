Received: from eggs.gnu.org ([209.51.188.92]:40259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hGTzR-0000Ei-KB
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 15:43:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hGTzO-0001X1-UH
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 15:43:33 -0400
References: <20190401031155.21293-1-richard.henderson@linaro.org>
	<20190401031155.21293-4-richard.henderson@linaro.org>
	<c6b66db9-24d5-b55b-8b45-e73f3d7c3fba@mail.uni-paderborn.de>
	<50effb1c-3bbe-126b-9bfb-0b65eacc9c36@linaro.org>
	<abdf9c63-8f27-8cb2-dc94-22318c3836ae@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6f30be40-014e-d825-aadc-a689dad120c3@redhat.com>
Date: Tue, 16 Apr 2019 21:43:22 +0200
MIME-Version: 1.0
In-Reply-To: <abdf9c63-8f27-8cb2-dc94-22318c3836ae@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.1 3/8] target/riscv: Merge argument
 sets for insn32 and insn16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@sifive.com, Alistair.Francis@wdc.com, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>

On 16/04/2019 19.32, Richard Henderson wrote:
> On 4/16/19 7:22 AM, Richard Henderson wrote:
>> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
>> index fb66e886bf..c96c616539 100644
>> --- a/target/riscv/translate.c
>> +++ b/target/riscv/translate.c
>> @@ -695,6 +695,7 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
>>   */
>>  #pragma GCC diagnostic push
>>  #pragma GCC diagnostic ignored "-Wredundant-decls"
>> +#pragma GCC diagnostic ignored "-Wtypedef-redefinition"
>=20
> Bah.  Of course gcc doesn't know this one.  And looking closer elsewher=
e, I see
> we've got a configure test for the pragmas, which I suppose I ought to =
use.

I wonder whether we should maybe always add "-Wno-typedef-redefinition"
in the configure script when we detect clang. All the versions of GCC
that we currently support seem to ignore typedef redefinitions anyway...?
(I think I've seen that warning with GCC in the past, too, see e.g.
commit eeb61d4f8270a6849d9a584fc83da3869b79066d, but that does not seem
to be the case anymore with GCC >=3D 4.8)

 Thomas
