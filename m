Received: from eggs.gnu.org ([2001:4830:134:3::10]:60653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dW0Nq-00069i-99
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:11:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dW0Np-0001zQ-HR
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:11:50 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:38376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dW0Np-0001zI-A2
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:11:49 -0400
Received: by mail-wm0-x236.google.com with SMTP id f67so22269950wmh.1
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 06:11:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170713191304-mutt-send-email-mst@kernel.org>
References: <CAFEAcA8-o28j-FvHWz3=nZX_pO=+XOc_6MnmyFWB324+G7Ppqw@mail.gmail.com>
	<CAFEAcA-ireu_2fW00dX=Z3hu4Jongftab_ysymbJMB0893M4Ww@mail.gmail.com>
	<20170711220915-mutt-send-email-mst@kernel.org>
	<CAFEAcA_-hCV2Ogy3BS2RV4_AWYYQDT+fCNChVcz8uKZ8-VxhWA@mail.gmail.com>
	<273a7da7-2243-171f-e96d-39e8e8031984@redhat.com>
	<3CA8C399-80D0-4BC8-ACC6-FD72A09D9685@skyportsystems.com>
	<CAFEAcA8ZiTqAGS01Rtu8Vv9FHKXtUXwfc9mULkCkanQzirB14Q@mail.gmail.com>
	<06cbc0c4-73bc-d527-a466-de5a05b0641e@redhat.com>
	<CAJ+F1CJaRE2hAJUxfeqLYi3Bj46E9nRUOdyWxPHbHQS6oDoQEg@mail.gmail.com>
	<00D9C394-98C2-4AC0-99A9-427117B678F9@skyportsystems.com>
	<20170713191304-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jul 2017 14:11:27 +0100
Message-ID: <CAFEAcA_=35WNC=u9+ZWp4d798b-UPtni=+9vQxpzge7=UxoQhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 19/21] tests: Add unit tests for the VM
 Generation ID feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ben Warren <ben@skyportsystems.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 13 July 2017 at 17:38, Michael S. Tsirkin <mst@redhat.com> wrote:
> It's already a library, I don't think you need changes or refactoring.
> You can just link boot_sector.c and call boot_sector_test like the pxe
> test does. If this passes you know all acpi tables are in memory.
>
> I'll post a patch.

Hi -- you asked me on IRC if I could test that "use boot_sector_test"
patch, but I can't find it in my email archive or in patchwork.
Did you forget to send it, or has it got lost in transit? If you can
provide a pointer to a copy I'll give it a test...

thanks
-- PMM
