Received: from eggs.gnu.org ([2001:4830:134:3::10]:37860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cg7DP-0003cj-8f
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:58:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cg7DO-0005jK-Dt
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:58:35 -0500
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:33977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cg7DO-0005it-8H
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:58:34 -0500
Received: by mail-wr0-x232.google.com with SMTP id z61so78517364wrc.1
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 01:58:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87wpcjlw32.fsf@dusky.pond.sub.org>
References: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
	<1933406e-2576-e687-3545-a72f3b999310@redhat.com>
	<bf1410bc-bc6d-bb29-5591-55634f25d487@redhat.com>
	<CABHMSTUsZy0u4b1b84YC5CgafKvD-Zms5dCQ=31+XnQphUQxLA@mail.gmail.com>
	<20170217064327.GB21716@lemon.lan>
	<CAFEAcA8_f8SVX+rirAFBJ76ZiXaKUwh9uO0AeBFoR7G_q8pGDg@mail.gmail.com>
	<6ab86cf8-4780-ca76-f648-ac0ce211e27b@redhat.com>
	<CABHMSTWN2KdAXDjEEbyWio6rNM2FuDk_NUj40mFW0HdyZFu68g@mail.gmail.com>
	<fc3b6729-6739-5daf-5e78-85fbd7d3260d@redhat.com>
	<CABHMSTUS4Oi5WZt0NcYaOnX9_u8zQeu=CupLVX2LjvD+mTYATg@mail.gmail.com>
	<ac569867-6629-7b56-0bf1-85f15b52f143@redhat.com>
	<87wpcjlw32.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Feb 2017 09:58:12 +0000
Message-ID: <CAFEAcA8jC7swgVYN=pRhbFRD23t8eqrY5GuaLaO8MnUBKpLm5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Fix build break during configuration on musl-libc
 based Linux systems.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Chad Joan <chadjoan@gmail.com>, Fam Zheng <famz@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On 21 February 2017 at 09:41, Markus Armbruster <armbru@redhat.com> wrote:
> Eric Blake <eblake@redhat.com> writes:
>
> [...]
>> 'git send-email -s' can also add Signed-off-by: lines, if you didn't add
>> them earlier (but only if you use send-email, rather than attachments) :)
>
> That's fine, as you *should* use git send-email.

It has the disadvantage that checkpatch will complain at you
when you test your patches before sending them, because the
sign-off is missing... Personally I recommend adding the signoff
lines earlier in the process.

thanks
-- PMM
