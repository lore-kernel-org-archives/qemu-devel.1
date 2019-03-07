Received: from eggs.gnu.org ([209.51.188.92]:37969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h205N-00012i-RU
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 15:57:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h205I-0005dz-2C
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 15:57:47 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38133)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1h205F-0005b0-UX
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 15:57:42 -0500
Received: by mail-wm1-f66.google.com with SMTP id a188so10535427wmf.3
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 12:57:40 -0800 (PST)
References: <1551968191-10821-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA9=eKhnL40T8nZuktoVGabq8MoGoYLiRO1fjg9dsNXLXQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2d2db167-2b50-3c51-6739-6b72339bc90c@redhat.com>
Date: Thu, 7 Mar 2019 21:57:35 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9=eKhnL40T8nZuktoVGabq8MoGoYLiRO1fjg9dsNXLXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL v2 00/54] Kconfig conversion,
 excluding ARM and MIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 07/03/19 19:35, Peter Maydell wrote:
> On Thu, 7 Mar 2019 at 14:18, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> The following changes since commit 1ba530a4ecba6015d52d8f392fd327cfa07bc37a:
>>
>>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190304' into staging (2019-03-04 13:38:54 +0000)
>>
>> are available in the git repository at:
>>
>>
>>   git://github.com/bonzini/qemu.git tags/for-upstream-kconfig
>>
>> for you to fetch changes up to 1f749c0626f6f79cfc27fc3e6b910a6df03d3488:
>>
>>   kconfig: add documentation (2019-03-07 15:06:29 +0100)
>>
>> ----------------------------------------------------------------
>> Initial Kconfig work, excluding ARM and MIPS
> 
> This passes my build tests, but something in your workflow
> has mangled a Cc: line in one of the commit messages.
> In commit 11db78e98317e1a0c the accented character in
> Hervé Poussineau's name has been mangled and isn't correct
> UTF-8. Could you fix that up and resend, please?
> 
> PS: since the sphinx patchset just got in ahead of
> yours, Sphinx now warns:
> docs/devel/kconfig.rst: WARNING: document isn't included in any toctree
> 
> I'll send a followup patch which adds 'kconfig' to
> docs/devel/index.rst once this is merged.

I just rebased and did the change myself, which was a good idea because
I also had to use ==== headings instead of ---- for the ToC to come out
right.

Thanks for working on Sphinx!  I will dig out the Texinfo->Sphinx
patches for 4.1, as well as the small changes to kerneldoc that support
QEMU's hybrid of kerneldoc and gtkdoc.

Paolo
