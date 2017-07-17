Received: from eggs.gnu.org ([2001:4830:134:3::10]:51926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dX6dD-0006Bi-8E
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:04:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dX6dC-0007cA-CV
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:04:15 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:35748)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dX6dC-0007by-5X
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:04:14 -0400
Received: by mail-wm0-x22c.google.com with SMTP id w126so77109718wme.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 07:04:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b08f6c95-9189-e052-98f6-e643ccc16a54@redhat.com>
References: <1499862868-102130-1-git-send-email-agraf@suse.de>
	<b08f6c95-9189-e052-98f6-e643ccc16a54@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2017 15:03:52 +0100
Message-ID: <CAFEAcA_e0yJEsfwjOjV4UOhSS54LJ3zu8ut1rB79mE7Huhd35A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] PPC: E500: Update u-boot to v2017.07
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On 12 July 2017 at 14:15, Thomas Huth <thuth@redhat.com> wrote:
> On 12.07.2017 14:34, Alexander Graf wrote:
>> Quite a while has passed since we last updated U-Boot for e500. This patch
>> bumps it to the last released version 2017.07 to make sure users don't feel
>> like they're using out of date software.
>>
>> Signed-off-by: Alexander Graf <agraf@suse.de>
>> ---
>>  pc-bios/u-boot.e500 | Bin 347788 -> 388672 bytes
>>  roms/u-boot         |   2 +-
>>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> I've checked that the U-Boot prompt still shows up correctly, and prints
> the correct version information, so if that counts, feel free to add my:
>
> Tested-by: Thomas Huth <thuth@redhat.com>

David asked me to apply this one directly to master, so I have
done so.

thanks
-- PMM
