Received: from eggs.gnu.org ([2001:4830:134:3::10]:44779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTBr4-0003Rl-8n
	for Qemu-devel@nongnu.org; Mon, 16 Jan 2017 13:18:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTBr0-0006XG-42
	for Qemu-devel@nongnu.org; Mon, 16 Jan 2017 13:18:06 -0500
Received: from mail-vk0-x22d.google.com ([2607:f8b0:400c:c05::22d]:34657)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cTBqz-0006Vm-NI
	for Qemu-devel@nongnu.org; Mon, 16 Jan 2017 13:18:02 -0500
Received: by mail-vk0-x22d.google.com with SMTP id r136so78132551vke.1
	for <Qemu-devel@nongnu.org>; Mon, 16 Jan 2017 10:18:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <D1505166-849A-439D-8E78-579F708D53BB@livius.net>
References: <6205DF8A-7643-432F-88FF-12B1E9DEF5D8@livius.net>
	<CAFEAcA_CDpXqAAJNdSQpk4MKOorDXqUi_AwsevrHk=pnbrS0NQ@mail.gmail.com>
	<277E72EB-288A-498F-9208-99EBF09218A6@livius.net>
	<CAFEAcA_54fL9YHVJLqAZS8p3OftGd-yq7C7k4jSfVGeCzwMPmA@mail.gmail.com>
	<D1505166-849A-439D-8E78-579F708D53BB@livius.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jan 2017 18:17:40 +0000
Message-ID: <CAFEAcA-AB98qtJcrLQ=T4PDvg=VM2tTqxALVpZYoYQcd9fySFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] CMSIS SVD based peripheral definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liviu Ionescu <ilg@livius.net>
Cc: QEMU Developer <Qemu-devel@nongnu.org>

On 9 January 2017 at 17:47, Liviu Ionescu <ilg@livius.net> wrote:
> I can't dispute this, but does't the GPLv2 requirements apply to
> the qemu executable only? my JSON files are not compiled into the
> binary, but are data files, read by the executable when required.
> and anyway, the original license covers the original XML files,
> mine are not only JSON, but are also slightly different.

I'm not a lawyer, and this isn't legal advice, but merely
my own opinion:
 (1) if you're reading in the data files at runtime then there's
a spectrum between "just reading data provided by the user which
didn't ship with QEMU, and QEMU works OK without this particular
data" (clearly OK) and "reading data that shipped with QEMU
and where QEMU won't work at all without it" (the data files
are clearly part of the program as a whole and the GPL
applies to them even if they don't happen to be binaries);
where you stand legally probably depends on where on the
spectrum you are.

 (2) your JSON files are a derived work from the original
XML, so the license of those XML files (whatever it is) still
applies to them. Making modifications or a mechanical
transformation of the original files is not sufficient to
allow you to discard the license...

With my project maintainer hat on, I prefer to avoid
grey areas, because it avoids potential trouble later on.

thanks
-- PMM
