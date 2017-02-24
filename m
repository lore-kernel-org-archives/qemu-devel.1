Received: from eggs.gnu.org ([2001:4830:134:3::10]:53393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chEP7-0004GU-Mg
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:51:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chEP6-0005zA-NT
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:51:17 -0500
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:33758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1chEP6-0005xi-HJ
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:51:16 -0500
Received: by mail-wr0-x235.google.com with SMTP id u47so11520488wrb.0
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 03:51:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8cS8DMbHsVU8oWVtB1JsSQJGi1igyFZVMcuzXXjpVkEQ@mail.gmail.com>
References: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
	<1484779123-18968-31-git-send-email-atar4qemu@gmail.com>
	<CAFEAcA8=gKjbo9YaRAzGHi-tP6AWY08ps_tEPOSzpNFXBC6M+Q@mail.gmail.com>
	<CACXAS8COsHWMAqoQTDqs6zh=-f0_u7posLQ1nUe6TKRfBaBSEg@mail.gmail.com>
	<CAFEAcA8cS8DMbHsVU8oWVtB1JsSQJGi1igyFZVMcuzXXjpVkEQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Feb 2017 11:50:54 +0000
Message-ID: <CAFEAcA9iAsAgOidpsdniDHpy6enwca=hr_ALdf+svJP4gvXXWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 30/30] target-sparc: fix up niagara machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <rth@twiddle.net>

On 23 January 2017 at 14:24, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 23 January 2017 at 14:10, Artyom Tarasenko <atar4qemu@gmail.com> wrote:
>> On Mon, Jan 23, 2017 at 1:40 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> I see that 'make check' now warns:
>>>   GTESTER check-qtest-sparc64
>>> Could not open option rom 'nvram1': No such file or directory
>>> Could not open option rom '1up-md.bin': No such file or directory
>>> Could not open option rom '1up-hv.bin': No such file or directory
>>> Could not open option rom 'reset.bin': No such file or directory
>>> Could not open option rom 'q.bin': No such file or directory
>>> Could not open option rom 'openboot.bin': No such file or directory
>>>
>>> (though the tests still pass).

> One thing we could do is only warn if !qtest_enabled().

I notice that 'make check' still warns about these missing option
rom files...could somebody write a patch to silence it, please?

thanks
-- PMM
