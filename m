Received: from eggs.gnu.org ([2001:4830:134:3::10]:43734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fNj5e-0005aI-5M
	for qemu-devel@nongnu.org; Tue, 29 May 2018 14:11:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fNj5d-0007dR-Bk
	for qemu-devel@nongnu.org; Tue, 29 May 2018 14:11:22 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:34283)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fNj5d-0007cM-75
	for qemu-devel@nongnu.org; Tue, 29 May 2018 14:11:21 -0400
Received: by mail-oi0-x243.google.com with SMTP id l1-v6so13916473oii.1
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 11:11:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <B3BA09EF-3D8A-4C7A-94C8-A71DC919FDEF@gmail.com>
References: <20180525102636.13136-1-peter.maydell@linaro.org>
	<B3BA09EF-3D8A-4C7A-94C8-A71DC919FDEF@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 May 2018 19:11:00 +0100
Message-ID: <CAFEAcA-6QBEx8YzKM0U+ivNSkiKoyt2s31VKXYgbw4XdQnfoSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] ui/cocoa: Suppress
 NSFileHandlingPanelOKButton deprecation warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 29 May 2018 at 18:52, Programmingkid <programmingkidx@gmail.com> wrote:
>
>> On May 25, 2018, at 6:26 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> OSX 10.13 deprecates the NSFileHandlingPanelOKButton constant, and
>> would rather you use NSModalResponseOK, which was introduced in OS 10.9.
>> Use the recommended new constant name, with a backward compatibility
>> define if we're building on an older OSX.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> Tested on 10.13; I don't hvae anything older to test on.

>
> Sorry but this patch does not work with Mac OS 10.6. The MAC_OS_X_VERSION_10_9
> constant is not defined. I did make a patch that does work. It will be sent shortly.

Oops, yes, we need to add the
#ifndef MAC_OS_X_VERSION_10_9
#define MAC_OS_X_VERSION_10_9 1090
#endif

I hadn't noticed that we only defined the ones of those we currently use.

Thanks for testing.

-- PMM
