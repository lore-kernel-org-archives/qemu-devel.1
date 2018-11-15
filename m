Received: from eggs.gnu.org ([2001:4830:134:3::10]:45262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNHq8-00052F-W7
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:37:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNHpw-0006hW-9G
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:37:41 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNHpp-0006f9-Bo
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:37:30 -0500
Received: by mail-ot1-x344.google.com with SMTP id s5so18015008oth.7
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 05:37:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <a27227e9-d1b0-2e79-90ff-380bdd64119e@vivier.eu>
References: <20181115114616.26265-1-peter.maydell@linaro.org>
	<a27227e9-d1b0-2e79-90ff-380bdd64119e@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Nov 2018 13:37:04 +0000
Message-ID: <CAFEAcA8AnA4bAKRpELtUm+XO9KM8k1G-kRbeO22ZA9u7h38GQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.1] linux-user/sparc/signal.c: Remove
 dead code
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

On 15 November 2018 at 11:59, Laurent Vivier <laurent@vivier.eu> wrote:
> On 15/11/2018 12:46, Peter Maydell wrote:
>> Coverity complains (CID 1390847) about some dead code in
>> do_sigreturn(). This is an if (err) clause that can never be
>> true, copied from the kernel (where __get_user returns an error).
>> The one code path that could report an error is in the
>> currently commented-out pseudocode for handling FPU register
>> restoring, so move the if into that comment (and fix the
>> broken indent in the comment in the process).
>>
>> (The new position for the error check is also the semantically
>> correct one -- we should not restore the signal mask from
>> the signal frame if we get an error here, so the check must
>> be done before set_sigmask(), not after.)
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  linux-user/sparc/signal.c | 16 ++++++++--------
>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>
>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>
> Do you apply it directly to the master or do you want a linux-user pull
> request?

Applied to master, thanks.

-- PMM
