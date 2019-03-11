Received: from eggs.gnu.org ([209.51.188.92]:43877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h3KxA-0001VA-BW
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:26:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h3Kx9-0007vW-JR
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:26:52 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:33613)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h3Kx9-0007v7-Cp
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:26:51 -0400
Received: by mail-oi1-x236.google.com with SMTP id z14so3607940oid.0
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 06:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190214190603.25030-1-peter.maydell@linaro.org>
	<20190214190603.25030-12-peter.maydell@linaro.org>
	<72c526bd-6c30-5e7a-4ff0-da8473348d0a@redhat.com>
In-Reply-To: <72c526bd-6c30-5e7a-4ff0-da8473348d0a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Mar 2019 13:26:37 +0000
Message-ID: <CAFEAcA9=oUk_W+pqYLkd=oBC7eENU1yYKbGzoOzgxXoOmg7_+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 11/27] arm: Allow system registers for KVM
 guests to be changed by QEMU code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Thu, 21 Feb 2019 at 14:20, Auger Eric <eric.auger@redhat.com> wrote:
> This commit introduces a regression when running with EDK2 FW:
>
> I get the following traces:
>
> error: kvm run failed Function not implemented

Unfortunately I can't repro this, on a Mustang host with
4.8.0-42-generic host kernel, with this command line:

 ./build/kvm/aarch64-softmmu/qemu-system-aarch64  -M
virt,gic-version=host -cpu host -smp 2 -m 4G -display none
--enable-kvm  -serial stdio -bios
~/QEMU_EFI_cbuild_debug_feb21_2019.fd

Does that simplified command line still repro the problem
for you on your hardware, or does the bug require all
the extra stuff with blk and net devices and a real
guest filesystem to trigger? (You'll need to revert the
revert commit 942f99c825fc94c8b1a4, obivously.)

More generally, can you strip the repro command line
down as much as possible to something that still shows
the bug? I'd rather not have to sort out getting TAP networking
on this box if it isn't actually a necessary component of
reproducing the bug :-)

thanks
-- PMM
