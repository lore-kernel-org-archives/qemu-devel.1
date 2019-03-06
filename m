Received: from eggs.gnu.org ([209.51.188.92]:50971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1h1XxW-0004Le-2A
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 09:55:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1h1XxV-0008Ho-4P
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 09:55:49 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1h1XxU-000848-S0
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 09:55:49 -0500
Received: by mail-wr1-x443.google.com with SMTP id g12so13746889wrm.5
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 06:55:23 -0800 (PST)
References: <32ad1a44-5398-53de-9adf-9e6ac9f60805@redhat.com>
	<20190306124419.GG20806@redhat.com>
	<686b400b-42ed-d877-50c6-f7be43cc7a63@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <686b400b-42ed-d877-50c6-f7be43cc7a63@redhat.com>
Date: Wed, 06 Mar 2019 14:55:20 +0000
Message-ID: <87wolcf3xj.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] recursive submodules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>


Laszlo Ersek <lersek@redhat.com> writes:

> On 03/06/19 13:44, Daniel P. Berrang=C3=A9 wrote:
>> On Wed, Mar 06, 2019 at 01:30:06PM +0100, Laszlo Ersek wrote:
>>> Hi,
>>>
>>> in order to build any OVMF platform firmware image from the submodule at
>>> "roms/edk2", the (recursive) OpenSSL submodule at
>>> "roms/edk2/CryptoPkg/Library/OpensslLib/openssl" needs to be initialized
>>> as well.
>>>
>>> Am I right to think this would be the first recursive submodule in QEMU?
>>> How should I approach this? (I see we have a related script at
>>> "scripts/git-submodule.sh".)
>>
>> The scripts/git-submodule.sh file is called automatically by "make"
>> in QEMU to activate any submodules that are required during the normal
>> build a QEMU developer does.
>>
>> The ROM submodules are special though. AFAIK, these are never built as a
>> side effect of the QEMU build process, so never need to be initialized by
>> the git-submodule.sh script.  Developers always just use the pre-built
>> ROM files bundled in QEMU. The only people checking out the ROM submodul=
es
>> are the maintainers who periodically build a new binary ROM.
>>
>> So in this sense the fact that EDK has submodules shouldn't be a factor,
>> as we would not expect EDK to be built by regular QEMU developers
>
> Thank you for the explanation. I missed that the "configure" script
> manipulated the "git_submodules" variable explicitly. (Which seems to be
> the origin for GIT_SUBMODULES.) It covers only a subset of
> ".gitmodules".

Yes those are the ones we actually need to build QEMU, so libraries or
test code needed for unit testing (in the softfloat case).

--
Alex Benn=C3=A9e
