Received: from eggs.gnu.org ([2001:4830:134:3::10]:41678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dV20c-0000eN-Pf
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:43:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dV20Y-0006dn-3S
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:43:50 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:34749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dV20X-0006dY-T1
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:43:46 -0400
Received: by mail-wr0-f182.google.com with SMTP id 77so5314674wrb.1
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 13:43:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170711220915-mutt-send-email-mst@kernel.org>
References: <1499111049-13721-1-git-send-email-mst@redhat.com>
	<1499111049-13721-20-git-send-email-mst@redhat.com>
	<CAFEAcA_giHFa-aw=WuuqmVFL+dr7HeD9E1o=oLszQywJbAd0wA@mail.gmail.com>
	<7EC3FA95-777F-4F8F-B02D-85FA09BAFC00@skyportsystems.com>
	<CAFEAcA8-o28j-FvHWz3=nZX_pO=+XOc_6MnmyFWB324+G7Ppqw@mail.gmail.com>
	<CAFEAcA-ireu_2fW00dX=Z3hu4Jongftab_ysymbJMB0893M4Ww@mail.gmail.com>
	<20170711220915-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jul 2017 21:42:24 +0100
Message-ID: <CAFEAcA_-hCV2Ogy3BS2RV4_AWYYQDT+fCNChVcz8uKZ8-VxhWA@mail.gmail.com>
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
Cc: Ben Warren <ben@skyportsystems.com>, QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 11 July 2017 at 20:10, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Tue, Jul 11, 2017 at 05:49:07PM +0100, Peter Maydell wrote:
>> The good news is it's not aarch64-specific. I just hit this on
>> a build on x86_64 host, gcc, debug build:
>>
>>   GTESTER check-qtest-x86_64
>> **
>> ERROR:/home/petmay01/linaro/qemu-for-merges/tests/vmgenid-test.c:65:acpi_find_vgia:
>> assertion failed (ACPI_ASSERT_CMP_str == "RSDT"): ("" == "RSDT")
>> GTester: last random seed: R02S9eefaf38297e67e4f67d5db77989350e
>> /home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:826:
>> recipe for target 'check-qtest-x86_64' failed

> Couldn't reproduce here. I suspect VM didn't start at all.
> Am I right to assume this is without KVM?

On aarch64 host, definitely without KVM. On x86-64 host,
I think it is without KVM but am not totally sure.

It may be one of those cases that only triggers if the
host is heavily loaded at the time the test is running.

thanks
-- PMM
