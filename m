Received: from eggs.gnu.org ([2001:4830:134:3::10]:45736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1crkvG-0004ZJ-Qr
	for qemu-devel@nongnu.org; Sat, 25 Mar 2017 08:35:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1crkvF-0001K7-MS
	for qemu-devel@nongnu.org; Sat, 25 Mar 2017 08:35:58 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:36191)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1crkvF-0001Jf-ED
	for qemu-devel@nongnu.org; Sat, 25 Mar 2017 08:35:57 -0400
Received: by mail-wr0-x22c.google.com with SMTP id u108so8103785wrb.3
	for <qemu-devel@nongnu.org>; Sat, 25 Mar 2017 05:35:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <C94A741879221447B4FC9B607EB4FFCD79EACAC2@DGGEMA504-MBS.china.huawei.com>
References: <1459777195-7907-1-git-send-email-vijayak@caviumnetworks.com>
	<1459777195-7907-3-git-send-email-vijayak@caviumnetworks.com>
	<CAFEAcA_755uEOZoGj0SCtmT-5PyLMntkK3wZeuHvZ_kPG9A1aQ@mail.gmail.com>
	<5703D7EE.2000005@redhat.com>
	<CAFEAcA8G_-jQOtnVag2Ef++RbfbEJ-XzNnyYM=o9Sh8c6ohecA@mail.gmail.com>
	<C94A741879221447B4FC9B607EB4FFCD79EA34F4@DGGEMA504-MBX.china.huawei.com>
	<CAJhHMCDDu_kEJichH=60N=np+ZKbU1e9bWK-pP9Z-9=Fn4w1_w@mail.gmail.com>
	<C94A741879221447B4FC9B607EB4FFCD79EA7BA3@DGGEMA504-MBX.china.huawei.com>
	<CAFEAcA_0UA1hnP9XVBn8w0B66eyR12GnnUoCOxjirPSDgHcHvQ@mail.gmail.com>
	<C94A741879221447B4FC9B607EB4FFCD79EACAC2@DGGEMA504-MBS.china.huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 25 Mar 2017 12:35:35 +0000
Message-ID: <CAFEAcA_NQjvKiGxLwAOZ8zSwJXgHHwABWmDvQfC0dv7kaYFyqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-arm] [patch 1/1]about armv8's prefetch decode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wangjintang <wangjintang@huawei.com>
Cc: Pranith Kumar <bobby.prani@gmail.com>, "Shlomo Pongratz (A)" <shlomo.pongratz@huawei.com>, "Ori Chalak (A)" <Ori.Chalak@huawei.com>, "Wanghaibin (Benjamin)" <benjamin.wanghaibin@huawei.com>, qemu-arm <qemu-arm@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>

On 25 March 2017 at 02:22, Wangjintang <wangjintang@huawei.com> wrote:
> the patch regard the prefetch as load instruction, at the same time
> don't affect rm/rt register. Only the PRFM instruction been emitted to
> intermediate code and do a really load, then we can get the memory
> address relative to the prefetch instruction. Because the rm/rt register
> don't been modified, so the application can run correctly.

It will still fault if the address is not valid, which is
not a permitted behaviour.

> In our case, we need all the instruction trace & ld/st instruction's
> access memory address, the trace as the input for chip cycle-accurate
> model. Similar with flexus + qemu.
> Current code that skip generate prefetch instructions' intermediate code,
> So we can get prefetch instruction, but can't get the prefetch instruction
> relative memory address.

I understand the use case you would like, but if we want
to support that kind of thing we should do it with a much
more significant and consistent degree of support for
tracing of guest code actions, not with a small ad-hoc
change that happens to fix the immediate thing you're
running into for your specific problem.

thanks
-- PMM
