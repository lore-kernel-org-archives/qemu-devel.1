Received: from eggs.gnu.org ([2001:4830:134:3::10]:53681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpymF-0007lz-KY
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpymE-0002Nt-LG
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:59:19 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:33117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cpymE-0002Nm-FY
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:59:18 -0400
Received: by mail-wm0-x233.google.com with SMTP id v203so19137030wmg.0
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 07:59:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170320142057.GZ17887@stefanha-x1.localdomain>
References: <20170317094714.32220.9387.malonedeb@chaenomeles.canonical.com>
	<20170320142057.GZ17887@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Mar 2017 14:58:56 +0000
Message-ID: <CAFEAcA8MiN9CvMndx=qTSBoYxwh7FvGMDH9EQb6P8o0QaH5Uiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Bug 1673722] [NEW] Reading register at offset. It
 is not fully implemented warning make VM impossible to use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Bug 1673722 <1673722@bugs.launchpad.net>, Leonid Bloch <leonid.bloch@ravellosystems.com>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Dmitry Fleytman <dmitry.fleytman@ravellosystems.com>

On 20 March 2017 at 14:20, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Fri, Mar 17, 2017 at 09:47:14AM -0000, Julien Duponchelle wrote:
>> Hi,
>>
>> Since this commit:
>> https://github.com/qemu/qemu/commit/bc0f0674f037a01f2ce0870ad6270a356a7a8347
>>
>> We can no longer use the IOSvL2 image from Cisco. The problem is we got a lot of warning message saying:
>> e1000: Reading register at offset: 0x00002410. It is not fully implemented.
>>
>> User got so much of this warning that they can't use the VM.
>
> CCing the author and maintainers.
>
> DBGOUT() is compiled in by default.  Warnings that can be triggered at a
> high rate by the guest should be off by default or use a
> printf_once()-style macro so they are only printed once and not again.
>
> Leonid: do you want to adjust e1000 DBGOUT() usage to avoid printing
> guest-triggerable messages by default?

If we want to report "whoops, we don't implement this yet" messages then
the recommended way to do that is
 qemu_log_mask(LOG_UNIMP, "....");

(these are not reported by default but only if the user asks for them.)

thanks
-- PMM
