Received: from eggs.gnu.org ([2001:4830:134:3::10]:40530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eS7JV-0006fB-49
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 15:19:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eS7JU-000175-Bh
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 15:19:33 -0500
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:43357)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eS7JU-00015c-4T
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 15:19:32 -0500
Received: by mail-oi0-x236.google.com with SMTP id f69so17621507oig.10
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 12:19:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171221085524.11674-1-pbonzini@redhat.com>
References: <20171221085524.11674-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Dec 2017 20:19:10 +0000
Message-ID: <CAFEAcA9kZDxYYxP5=_cH_5jsec=8n=KK6TWKFhCQrm0aNXvxsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/19] Initial support for
 Hypervisor.framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 December 2017 at 08:55, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 200780a3a3ed067dfb2e0d2210b0ed09e748ba26:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-cmdline-2017-12-18-v2' into staging (2017-12-20 13:20:48 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream-hvf
>
> for you to fetch changes up to 0a4609ab57575f89565845af1ad076579add3e4b:
>
>   i386: hvf: cleanup x86_gen.h (2017-12-21 09:51:53 +0100)
>
> ----------------------------------------------------------------
> Initial support for the HVF accelerator

Still doesn't build on OSX, I'm afraid:

/Users/pm215/src/qemu-for-merges/target/i386/hvf/hvf.c:657:9: error:
statement requires expression of scalar type ('void' invalid)
        if (hvf_inject_interrupts(cpu)) {
        ^   ~~~~~~~~~~~~~~~~~~~~~~~~~~
1 error generated.

thanks
-- PMM
