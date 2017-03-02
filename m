Received: from eggs.gnu.org ([2001:4830:134:3::10]:46731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjXcO-0000Xh-Qo
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 15:46:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjXcN-00046P-RM
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 15:46:32 -0500
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:34447)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjXcN-00045h-Li
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 15:46:31 -0500
Received: by mail-wr0-x22a.google.com with SMTP id l37so61123727wrc.1
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 12:46:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.20.1703022113370.83701@zero.eik.bme.hu>
References: <cover.1488068248.git.balaton@eik.bme.hu>
	<ae7dc986dd60d4a4baef3d4aef31e10b281e85a7.1488068248.git.balaton@eik.bme.hu>
	<CAFEAcA-7AiUb6pMdVf5kRY3eg2Teqw4TOhWt9RNqVjcfvDRx+g@mail.gmail.com>
	<alpine.BSF.2.20.1703022113370.83701@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Mar 2017 20:46:10 +0000
Message-ID: <CAFEAcA9VQWC3Qqosm6EnoBK_Z-z33rVNyDUi=JkkHKWW2=Dvjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 10/14] sm501: Add support for panel layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 2 March 2017 at 20:15, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> On Thu, 2 Mar 2017, Peter Maydell wrote:
>>
>> This is another refactoring that's unrelated to adding panel
>> layer support, right? (It's just changing from having src and
>> offset updated at the end of the loop to dropping src and having offset
>> be updated in the for()).
>
>
> It's a clean up getting rid of the unneded src pointer. Should I move it to
> the cleanup patch or is it OK to leave it here?

I've reviewed it now, so you can leave it. It would have
been better in its own patch, though. (The general principle
is that each patch should do only one thing, and it should do
all of that one thing, and the one thing should be fairly
small and easy to understand.)

thanks
-- PMM
