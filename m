Received: from eggs.gnu.org ([2001:4830:134:3::10]:43134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMDXE-0001Vc-HS
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:49:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMDXB-0005lK-7N
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:49:51 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gMDX9-0005jC-D8
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:49:49 -0500
Received: by mail-oi1-x243.google.com with SMTP id a77so1421752oii.5
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 06:49:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b2b2f4ba-3b9d-b36d-f2f9-af8cd830122a@vivier.eu>
References: <20181019161715.12122-1-peter.maydell@linaro.org>
	<7d7f51e2-49fa-7fc9-4d6d-153fa9cff5c5@vivier.eu>
	<CAFEAcA84UV6ahvwG8pVnoUkt75Y0bHbHFCHhvtDZWnK=t09PEQ@mail.gmail.com>
	<b2b2f4ba-3b9d-b36d-f2f9-af8cd830122a@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Nov 2018 14:49:23 +0000
Message-ID: <CAFEAcA9mzq8_A3+me6sikzvBeRKPWZKo-eGjniOhWFp7i=xNdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] linux-user: Remove dead error-checking code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Riku Voipio <riku.voipio@iki.fi>

On 12 November 2018 at 14:45, Laurent Vivier <laurent@vivier.eu> wrote:
> On 12/11/2018 15:38, Peter Maydell wrote:
>> On 19 October 2018 at 17:26, Laurent Vivier <laurent@vivier.eu> wrote:
>>> Le 19/10/2018 =C3=A0 18:17, Peter Maydell a =C3=A9crit :
>>>> Remove some dead code spotted by Coverity (CID 1009855,
>>>> 1390854, 1390847). The underlying cause in all these cases
>>>> is the same: QEMU's put_user operations can't result in
>>>> errors, but the kernel's equivalent does. So when code
>>>> was copied from the kernel signal-frame-setup/teardown
>>>> code, checks on error flags that were needed in the kernel
>>>> became dead code for us.
>>>>
>>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>>> ---
>>>>  linux-user/m68k/signal.c  | 3 ---
>>>>  linux-user/sh4/signal.c   | 4 ----
>>>>  linux-user/sparc/signal.c | 2 --
>>>>  3 files changed, 9 deletions(-)
>>>>
>>>
>>> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>>
>> Ping? Looks like you reviewed this but it hasn't made it into
>> a pullreq.
>
> Sorry... do you want it in 3.1?

I think it would be nice to, since it does silence some Coverity
issues.

thanks
-- PMM
