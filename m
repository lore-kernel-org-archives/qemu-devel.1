Received: from eggs.gnu.org ([209.51.188.92]:43444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1vRh-0008Qy-1G
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:00:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1vRg-0001jc-0s
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:00:32 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1vRf-0001iw-Qe
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:00:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so18039858wrw.0
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 08:00:31 -0800 (PST)
References: <20190307142822.8531-1-philmd@redhat.com>
	<20190307145756.GG32268@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <559dbb08-1bfb-19ef-2d64-ed384883ab24@redhat.com>
Date: Thu, 7 Mar 2019 17:00:29 +0100
MIME-Version: 1.0
In-Reply-To: <20190307145756.GG32268@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 0/2] OpenBSD: Let QEMU 4.0 be usable
 from OpenBSD 6.0 and onwards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Brad Smith <brad@comstyle.com>

On 3/7/19 3:57 PM, Daniel P. Berrangé wrote:
> On Thu, Mar 07, 2019 at 03:28:20PM +0100, Philippe Mathieu-Daudé wrote:
>> Since OpenBSD 6.0, the W^X protection is enforced by default.
>> TCG is incompatible with this protection, to be able to use the
>> QEMU binary, this protection has to be disabled.
>> The OpenBSD ports seens to have downstream patches to be able to
>> use QEMU, but these patches were never upstreamed.
>> This series allow to run QEMU when built from the mainstream sources.
>>
>> I salvaged the minimum patches required to be able to run OpenBSD
>> from a previous series, which aimed at running the QEMU QTest suite
>> on OpenBSD. Sadly it seems there is not much interest in having this
>> OS covered by tests (except by Peter Maydell).
> 
> What were the blocking issues with getting the test fixes accepted in
> previous postings ?  Was it simply no one interested in reviewing it
> or actual review problems ?
> 
> With our increased interest in CI & push to drop build targets which
> are not actively maintained, I'd question whether OpenBSD (or any
> build target in the same situation) should continue to be supported
> if the test suite hasn't worked for several releases in a row & not
> enough people are willing to contribute to fix it.

It is true nobody complained about this OS since the 6.0 release on
Sep 1, 2016, more than 2 years ago.

Looking at the mailing archive, Peter is the only one reporting build
failures since.
