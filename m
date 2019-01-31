Received: from eggs.gnu.org ([209.51.188.92]:36842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gp90w-0005E5-6F
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 04:52:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gp90v-0000RR-A8
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 04:52:06 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:45880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gp90v-0000Pl-4j
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 04:52:05 -0500
Received: by mail-oi1-x243.google.com with SMTP id y1so2168246oie.12
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 01:52:04 -0800 (PST)
MIME-Version: 1.0
References: <mhng-a324878c-b61d-4d8d-80bf-e15404469ef7@palmer-si-x1c4>
	<547f1afb-cce5-e456-5466-87ba333859b8@redhat.com>
In-Reply-To: <547f1afb-cce5-e456-5466-87ba333859b8@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Jan 2019 09:51:52 +0000
Message-ID: <CAFEAcA_hP=iuqWrVoqRjRhge27uC8VOJTjfATj2DMY0Hh5HHxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PR RFC] RISC-V Patches for 3.2, Part 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Palmer Dabbelt <palmer@sifive.com>, Eric Blake <eblake@redhat.com>, qemu-riscv@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>

On Thu, 31 Jan 2019 at 06:39, Thomas Huth <thuth@redhat.com> wrote:
>
> On 2019-01-30 20:01, Palmer Dabbelt wrote:
> > On Wed, 30 Jan 2019 09:45:33 PST (-0800), eblake@redhat.com wrote:
> >> On 1/30/19 11:35 AM, Palmer Dabbelt wrote:
> >>> The following changes since commit
> >>> 5385a5988c8a55bebdc878c05b96648579b5d6e0:
> >>>
> >>>   hw/virtio/virtio-balloon: zero-initialize the virtio_balloon_config
> >>> struct (2019-01-21 17:20:36 +0000)
> >>>
> >>> are available in the Git repository at:
> >>>
> >>>   git://github.com/palmer-dabbelt/qemu.git
> >>> tags/riscv-for-master-3.2-part3
> >>>
> >>> for you to fetch changes up to 461ab9de46d085a37b0da6f096aadc4e0dda4d4c:
> >>>
> >>>   target/riscv: fix counter-enable checks in ctr() (2019-01-29
> >>> 11:33:38 -0800)
> >>>
> >>> ----------------------------------------------------------------
> >>> RISC-V Patches for 3.2, Part 3
> >>
> >> There is no 3.2 release; the next release is named 4.0.  However, if you
> >> don't want to bother with sending a v2 pull request just to fix the
> >> merge commit message, that's okay with me.
> >
> > Ah, sorry.  I think I'm just going to leave it as is, I'll get it right
> > next time.
>
> Also note that you used "PR RFC" in the title ... so not sure whether
> Peter's scripts will catch this PR as a valid one...

My mail filter finds these RFC pullrequests, yes. I'm then
relying on my manual brain to not actually apply them.
(If it's a slow day I might do a test merge on them, but
usually my queue is full enough that I don't get to them
before the real PR appears.)

thanks
-- PMM
