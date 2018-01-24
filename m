Received: from eggs.gnu.org ([2001:4830:134:3::10]:50147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eeSQg-0002Tb-Bl
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 16:17:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eeSQb-0000XT-Qt
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 16:17:58 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:51280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eeSQb-0000XA-Gx
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 16:17:53 -0500
References: <1511879725-9576-1-git-send-email-peter.maydell@linaro.org>
	<CAFEAcA90dgSX9kYC5TbPBV2UHgQjz3HWT3eyE4RUC6x9P=7_QQ@mail.gmail.com>
	<21eaac25-23d4-7c03-b541-a93b79157e23@vivier.eu>
	<20180119145152.GA28929@kos.to>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <96fd163b-e066-947c-35e0-925bb469b1b6@vivier.eu>
Date: Wed, 24 Jan 2018 22:17:36 +0100
MIME-Version: 1.0
In-Reply-To: <20180119145152.GA28929@kos.to>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/2] linux-user: Fix race between threads
 in page_unprotect()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Riku Voipio <riku.voipio@iki.fi>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Le 19/01/2018 à 15:51, Riku Voipio a écrit :
> Hi Laurent,
> 
> On Mon, Jan 15, 2018 at 01:52:32PM +0100, Laurent Vivier wrote:
>> Le 15/01/2018 à 13:48, Peter Maydell a écrit :
>>> On 28 November 2017 at 14:35, Peter Maydell <peter.maydell@linaro.org> wrote:
>>>> If multiple guest threads in user-mode emulation write to a
>>>> page which QEMU has marked read-only because of cached TCG
>>>> translations, the threads can race in page_unprotect:
>>>
>>>> Peter Maydell (2):
>>>>   linux-user: Propagate siginfo_t through to handle_cpu_signal()
>>>>   page_unprotect(): handle calls to pages that are PAGE_WRITE
>>>
>>> Ping! Linux-user maintainers, any chance this could get into
>>> a pull-request sometime soon? (I have another cleanup I'm
>>> thinking of that will touch the same code so I'd rather this
>>> went into master before I look at that.)
>>>
>>> (I have a bunch of other pending linux-user patchsets which
>>> I shan't bother to ping individually unless you want me to.)
>>
>> Riku,
>>
>> if you have no time to prepare a pull request, I can.
> 
> Thanks, that would be great.

Riku, if you agree, I can continue to collect patches for the next
pull-request. It's easier to collect patches on the fly than scanning
the ML when we want to create a pull request.

Thanks,
Laurent
