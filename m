Received: from eggs.gnu.org ([2001:4830:134:3::10]:45528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cVxpA-0002Hr-Q0
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:55:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cVxp9-0005vB-Uk
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:55:36 -0500
Received: from mail-vk0-x22c.google.com ([2607:f8b0:400c:c05::22c]:34330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cVxp9-0005v5-Jn
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:55:35 -0500
Received: by mail-vk0-x22c.google.com with SMTP id r136so108530824vke.1
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 01:55:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87pojcx3zd.fsf@dusky.pond.sub.org>
References: <1485206518-32403-1-git-send-email-atar4qemu@gmail.com>
	<CAFEAcA860sYR6svwKMtjjoknfkVK=-Ch8vat_ywPyyvjtsr=MA@mail.gmail.com>
	<CAFEAcA-VKUKcCJ2a7Zx_rnWDQTUjbuu4ztXS1AqtmqSQnktVuQ@mail.gmail.com>
	<87pojcx3zd.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jan 2017 09:55:14 +0000
Message-ID: <CAFEAcA8CKZRcGSCrtBvPykh2Z4wCXyHd3ct=wk8jV=dh1uMp1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 1/2] niagara: fail if a firmware file is
 missing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, QEMU Developers <qemu-devel@nongnu.org>

On 24 January 2017 at 08:21, Markus Armbruster <armbru@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>> PS: doesn't this break 'make check' if the rom files
>> are missing?
>
> Yes, it does.  Obvious incremental fix appended.  It still prints
> rom_add_file()'s message.  Swap the operands of && to get rid of it.

Yes, we should do this with
 (!qtest_enabled && rom_add_file_fixed(file, addr, -1))
to avoid printing the warnings in the make check output.

thanks
-- PMM
