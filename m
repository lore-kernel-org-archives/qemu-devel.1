Received: from eggs.gnu.org ([2001:4830:134:3::10]:54460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTlej-0007Fe-Cy
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:08:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTlei-00021r-Bg
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:08:33 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:42113)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTlei-00020y-74
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:08:32 -0400
Received: by mail-oi0-x241.google.com with SMTP id k190-v6so8321054oib.9
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 03:08:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180604110358.2821-1-peter.maydell@linaro.org>
References: <20180604110358.2821-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 11:08:11 +0100
Message-ID: <CAFEAcA9m8Q0KSHDBFv_AhTv+R6T1w+6A9Ux65M1aFXR6cM6Abg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/2] mips boston/malta: don't have
 nomigrate RAM regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Juan Quintela <quintela@redhat.com>, "patches@linaro.org" <patches@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paul Burton <paul.burton@mips.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Yongbok Kim <yongbok.kim@mips.com>, Aurelien Jarno <aurelien@aurel32.net>

On 4 June 2018 at 12:03, Peter Maydell <peter.maydell@linaro.org> wrote:
> This patchset fixes a a bug in the MIPS boston and malta boards:
> they currently use memory_region_init_rom_nomigrate() to create
> memory regions for their BIOS/flash, and they don't manually
> register the MR with vmstate_register_ram() either. This currently
> means that its contents are migrated, but as a RAM block whose
> name is the empty string; in future (when a patch which is currently
> in the outstanding migration tree pull request hits master) it
> will mean they are not migrated at all. Switch to using
> memory_region_init_ram() instead, so the memory contents are
> migrated with a reasonable name.
>
> Note that this is a cross-version migration compatibility break
> for both machines, but:
>  (a) migration will break anyway due to the "don't migrate
>      unnamed RAM blocks" patch
>  (b) neither machine is versioned, so we don't really care about
>      maintaining cross-version migration compatibility AFAIK

Any comment from the MIPS maintainers?

thanks
-- PMM
