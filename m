Received: from eggs.gnu.org ([2001:4830:134:3::10]:33885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1gJyPJ-0001zC-2j
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:16:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1gJyPG-0003v5-Us
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:16:25 -0500
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:45355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1gJyPF-0003Zg-5V
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:16:22 -0500
Received: by mail-yb1-xb42.google.com with SMTP id 131-v6so5060253ybe.12
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 02:16:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8hB=+YKNc8WSxrdmqigtErOsPJSAhYnq0Ha8_Ey=NaMg@mail.gmail.com>
References: <1539939312-19713-1-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA8hB=+YKNc8WSxrdmqigtErOsPJSAhYnq0Ha8_Ey=NaMg@mail.gmail.com>
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Tue, 6 Nov 2018 18:16:19 +0800
Message-ID: <CAHmQWvBOo=g_ZB0RMxuL-fBRzxPZ89u9cmtTLgx_CdnqZgjQUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4] Add arm SBSA reference machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Leif Lindholm <leif.lindholm@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>

On 6 November 2018 at 00:31, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 19 October 2018 at 09:55, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
>> For the Aarch64, there is one machine 'virt', it is primarily meant to
>> run on KVM and execute virtualization workloads, but we need an
>> environment as faithful as possible to physical hardware,  to support
>> firmware and OS development for pysical Aarch64 machines.
>>
>> See the patch commit comments for the features description.
>>
>> V4 changes:
>>  - rebased to v3.0.0
>>  - removed timer, uart, rtc, *hci device tree nodes
>>    (others were removerd in v3)
>>  - other minore codes clean up, mainly unsed header files, comments etc.
>>
>> V3 changes:
>>  - rename the platform 'sbsa-ref'
>>  - move all the codes to a separate file sbsa-ref.c
>>  - remove paravirtualized fw_cfg device
>>  - do not supply ACPI tables, since firmware will do it
>>  - supply only necessary DT nodes
>>  - and other minor code clean up
>
> Hi; just a note that this series isn't going to make it into
> the 3.1 release. It is still on my to-review queue for 4.0,
> but I may not get to reviewing it for a little bit while I
> deal with for-3.1 work.
>
Get it, thanks.

> thanks
> -- PMM
