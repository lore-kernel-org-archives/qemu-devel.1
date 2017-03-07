Received: from eggs.gnu.org ([2001:4830:134:3::10]:46948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1clIZO-0007lC-Hk
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 12:06:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1clIZN-0007ln-Jo
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 12:06:42 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:37694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1clIZN-0007li-CB
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 12:06:41 -0500
Received: by mail-wm0-x22b.google.com with SMTP id n11so10533060wma.0
	for <qemu-devel@nongnu.org>; Tue, 07 Mar 2017 09:06:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1488556233-31246-1-git-send-email-peter.maydell@linaro.org>
References: <1488556233-31246-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Mar 2017 17:06:19 +0000
Message-ID: <CAFEAcA8=MSRjE=_eakVoFKrVQT6az9cpaX+L4bi_A_bSr-BC1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH for-2.9 0/6] disas: Fix various coverity
 nits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "patches@linaro.org" <patches@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Richard Henderson <rth@twiddle.net>

On 3 March 2017 at 15:50, Peter Maydell <peter.maydell@linaro.org> wrote:
> This patchset fixes all the coverity issues for disas/:
>  * dead ?: code in hppa
>  * a NULL pointer deref following an internal-error case
>    in i386
>  * unintended sign extension after shift of unsigned char
>    in m68k, microblaze, cris, arm
>
> The hppa, i386, and arm changes won't have a visible effect
> as they're either "never happens" cases or the code doesn't
> care. I think m68k, microblaze and cris are genuinely
> bug fixes.

Applied to master.

-- PMM
