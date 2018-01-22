Received: from eggs.gnu.org ([2001:4830:134:3::10]:39219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eda26-0007Ym-Kw
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:12:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eda25-0007Xo-T8
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:12:58 -0500
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:36589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eda25-0007XM-Of
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:12:57 -0500
Received: by mail-oi0-x233.google.com with SMTP id w135so5649458oie.3
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 03:12:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180119194648.25501-1-ard.biesheuvel@linaro.org>
References: <20180119194648.25501-1-ard.biesheuvel@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2018 11:12:36 +0000
Message-ID: <CAFEAcA8B99T0m3jwJ-4hbG04hJATCpUpsSSyDJhM9D+nct3zEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: Fix 32-bit address truncation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 19 January 2018 at 19:46, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> Commit ("3b39d734141a target/arm: Handle page table walk load failures
> correctly") modified both versions of the page table walking code (i.e.,
> arm_ldl_ptw and arm_ldq_ptw) to record the result of the translation in
> a temporary 'data' variable so that it can be inspected before being
> returned. However, arm_ldq_ptw() returns an uint64_t, and using a
> temporary uint32_t variable truncates the upper bits, corrupting the
> result. This causes problems when using more than 4 GB of memory in
> a TCG guest. So use a uint64_t instead.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Oops. As you probably guessed, I wrote the 32-bit load function
first and then failed to update it correctly when writing the 64-bit
version...

Applied to target-arm.next, thanks.

-- PMM
