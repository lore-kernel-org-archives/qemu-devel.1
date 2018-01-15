Received: from eggs.gnu.org ([2001:4830:134:3::10]:37933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eb4G1-0002DH-3x
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 07:52:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eb4Fw-0005lR-9S
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 07:52:57 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:59036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eb4Fv-0005ky-VP
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 07:52:52 -0500
References: <1511879725-9576-1-git-send-email-peter.maydell@linaro.org>
	<CAFEAcA90dgSX9kYC5TbPBV2UHgQjz3HWT3eyE4RUC6x9P=7_QQ@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <21eaac25-23d4-7c03-b541-a93b79157e23@vivier.eu>
Date: Mon, 15 Jan 2018 13:52:32 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA90dgSX9kYC5TbPBV2UHgQjz3HWT3eyE4RUC6x9P=7_QQ@mail.gmail.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "patches@linaro.org" <patches@linaro.org>

Le 15/01/2018 à 13:48, Peter Maydell a écrit :
> On 28 November 2017 at 14:35, Peter Maydell <peter.maydell@linaro.org> wrote:
>> If multiple guest threads in user-mode emulation write to a
>> page which QEMU has marked read-only because of cached TCG
>> translations, the threads can race in page_unprotect:
> 
>> Peter Maydell (2):
>>   linux-user: Propagate siginfo_t through to handle_cpu_signal()
>>   page_unprotect(): handle calls to pages that are PAGE_WRITE
> 
> Ping! Linux-user maintainers, any chance this could get into
> a pull-request sometime soon? (I have another cleanup I'm
> thinking of that will touch the same code so I'd rather this
> went into master before I look at that.)
> 
> (I have a bunch of other pending linux-user patchsets which
> I shan't bother to ping individually unless you want me to.)

Riku,

if you have no time to prepare a pull request, I can.

Thanks,
Laurent
