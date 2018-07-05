Received: from eggs.gnu.org ([2001:4830:134:3::10]:55067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fb6kH-0000mo-RL
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fb6kE-0008RM-OM
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:04:37 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:53360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fb6kE-0008R2-Gz
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:04:34 -0400
Received: by mail-wm0-x22c.google.com with SMTP id b188-v6so12146574wme.3
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 09:04:34 -0700 (PDT)
References: <20180704090642.3469-1-alex.bennee@linaro.org>
	<CAFEAcA-PoR6FBpnyodwTqSh5Y24euirBDGa_d=doUYgyUHn1yw@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA-PoR6FBpnyodwTqSh5Y24euirBDGa_d=doUYgyUHn1yw@mail.gmail.com>
Date: Thu, 05 Jul 2018 17:04:32 +0100
Message-ID: <87muv58y9b.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/20] Travis,
 Code Coverage and Cross Build updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, andrzej zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 4 July 2018 at 10:06, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>> The following changes since commit 2a018f6e98782a4931b936a3087404ed81685=
bac:
>>
>>   Merge remote-tracking branch 'remotes/berrange/tags/qcrypto-next-pull-=
request' into staging (2018-07-03 23:06:18 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/stsquad/qemu.git tags/pull-code-coverage-and-build-=
tweaks-040718-2
>>
>> for you to fetch changes up to a785003b11220afebae929b5c52f3b69bbfc4a40:
>>
>>   docker: add linux-user powered cross builder for QEMU (2018-07-04 09:3=
0:33 +0100)
>>
>> ----------------------------------------------------------------
>> Code coverage and other build tweaks
>>
>>   - revert 208ecb3e (and drop filter for mingw)
>>   - some travis speed-ups
>>   - modernise code coverage support
>>   - docker image cleanups
>>   - clean-up binfmt_misc docker infrastructure
>>   - add debian-powerpc-user-cross image for ppc32 build
>>
>
> Alex said on IRC there's some sort of problem with this; dropping
> and waiting for a v3.

I've just posted v3 to you. Sorry about the pull-churn... the result
will be worth it though ;-)

--
Alex Benn=C3=A9e
