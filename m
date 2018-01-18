Received: from eggs.gnu.org ([2001:4830:134:3::10]:56164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecANN-0007wT-4s
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:37:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecANJ-0007bd-DO
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:37:05 -0500
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:44290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ecANJ-0007bF-94
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:37:01 -0500
Received: by mail-ot0-x22d.google.com with SMTP id t20so10725596ote.11
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 05:37:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180118143421.10499441@redhat.com>
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
	<CAFEAcA-8dwLpfrbV8+--L4Z9Um9xVsyUOfKjcz9-T1aTPkgrEg@mail.gmail.com>
	<20180117201515.1a49fcbf@redhat.com>
	<CAFEAcA9gXOOkv+-rTXcNyzgY9P8CR66Rrx-0GM2G0m0x+HbAmA@mail.gmail.com>
	<20180118114330.53ad7ce7@redhat.com>
	<CAFEAcA-My_vDd=_7g907MpO2WmVHOHKxsw2-E-vQwn=_SZadRQ@mail.gmail.com>
	<20180118140605.028b7e33@redhat.com>
	<CAFEAcA-oP7hCgjwqiCh4TKKpq-Jfho0JOAsSvWfc09iUouiUWg@mail.gmail.com>
	<20180118143421.10499441@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jan 2018 13:36:40 +0000
Message-ID: <CAFEAcA8K0Sx=rZ-GAZfZfmC2g7TQLGcwbXWOR76xBZKeHWsvig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 00/24] generalize parsing of cpu_model
 (part 4)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

On 18 January 2018 at 13:34, Igor Mammedov <imammedo@redhat.com> wrote:
> and renaming
>
> TARGET_DEFAULT_CPU_TYPE to USERONLY_DEFAULT_CPU_TYPE
>
> but I'd still keep it within $ARCH/cpu.h so we won't
> have to create a bunch of new linux-user/$ARCH/target_elf.h
> files just for that and duplicate it to bsd-user/$ARCH/target_elf.h

We already have linux-user/$ARCH/target_cpu.h, which is exactly
for this kind of define.

thanks
-- PMM
