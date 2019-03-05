Received: from eggs.gnu.org ([209.51.188.92]:43384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h16Re-0000dv-9j
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 04:33:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h16Rc-00058S-Ca
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 04:33:06 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h16Ra-0004uW-PI
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 04:33:03 -0500
Received: by mail-ot1-x343.google.com with SMTP id b3so6867787otp.4
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 01:33:01 -0800 (PST)
MIME-Version: 1.0
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2019 09:32:49 +0000
Message-ID: <CAFEAcA8WZuAmNFQqCsvsN35UnFJk=sGcCJmF27v3SS++FnpXXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/54] Kconfig conversion,
 excluding ARM and MIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yang Zhong <yang.zhong@intel.com>, Thomas Huth <thuth@redhat.com>

On Mon, 4 Mar 2019 at 19:25, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 1ba530a4ecba6015d52d8f392fd327cfa07bc37a:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190304' into staging (2019-03-04 13:38:54 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream-kconfig
>
> for you to fetch changes up to b1d8b9a6cc37e33dde1873379174de78957830ca:
>
>   kconfig: add documentation (2019-03-04 19:09:35 +0100)
>
> ----------------------------------------------------------------
> Initial Kconfig work, excluding ARM and MIPS

Everything fails to build with errors like
make: *** No rule to make target `config-all-devices.mak', needed by
`subdir-aarch64-softmmu'.  Stop.

or
make: *** No rule to make target
`/home/pm215/qemu/default-configs/pci.mak', needed by
`aarch64-softmmu/config-devices.mak'.  Stop.

If there are special instructions for what to do with
build trees over the transition to kconfig, the pullreq
cover letter would be a good place to mention them :-)


thanks
-- PMM
