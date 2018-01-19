Received: from eggs.gnu.org ([2001:4830:134:3::10]:57992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecYbc-0003tO-2R
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 10:29:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecYba-00055q-TO
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 10:29:24 -0500
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:39263)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ecYba-00055E-PE
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 10:29:22 -0500
Received: by mail-ot0-x230.google.com with SMTP id d9so1693200oth.6
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 07:29:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-Z4PbC+Ze7uGriu-V+qJcLMVjEjeYJsrMbgemnHAu6bQ@mail.gmail.com>
References: <20180117144756.31049-1-marcandre.lureau@redhat.com>
	<595f00e6-d5ad-b7c6-29be-7c6e135f9d12@redhat.com>
	<CAFEAcA_M7FazuMDpne5Fr=hQUmfp75BHqttYOWV+HJ9zinW6mA@mail.gmail.com>
	<CAMxuvazG-y3XpE09oBRCJtB1OcNSbOP4heyGXYFHpLMbFj7VnA@mail.gmail.com>
	<CAFEAcA-Z4PbC+Ze7uGriu-V+qJcLMVjEjeYJsrMbgemnHAu6bQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jan 2018 15:29:01 +0000
Message-ID: <CAFEAcA9gv3LsbPkYpqsotZ-7Xigx1obkwMjGxF3ttnxDDK=+KA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Dump patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc-Andre Lureau <mlureau@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 19 January 2018 at 15:24, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 19 January 2018 at 14:35, Marc-Andre Lureau <mlureau@redhat.com> wrote:
>> I have not found how to translate a python 'buffer' to a bytes string
>> in 2.6.
>
> A local python expert suggests that "bytes(buffer)" should work.

...and that it ought to work if handed a memoryview too, so do we
just want

   self.elf.add_vmcoreinfo_note(bytes(vmcoreinfo))

?

thanks
-- PMM
