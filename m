Received: from eggs.gnu.org ([209.51.188.92]:37750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h1tUU-00077Y-DB
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:55:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h1tUT-0001Bl-NG
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:55:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1h1tUT-0001Ac-Cy
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:55:17 -0500
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA-nGLVySjjK65Bfedr5H-6XP1_t1rpnupjL89KB-HN8wQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <daccd090-d192-4a84-6df7-a5fce7155485@redhat.com>
Date: Thu, 7 Mar 2019 14:55:11 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-nGLVySjjK65Bfedr5H-6XP1_t1rpnupjL89KB-HN8wQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yang Zhong <yang.zhong@intel.com>, Thomas Huth <thuth@redhat.com>

On 07/03/19 14:25, Peter Maydell wrote:
> In file included from /home/petmay01/qemu-for-merges/hw/tpm/tpm_emulator.c:37:0:
> /home/petmay01/qemu-for-merges/hw/tpm/tpm_ioctl.h:11:21: fatal error:
> sys/uio.h: No such file or directory
> 
> I'm not sure what's happened here. It looks like the Kconfig machinery
> is putting CONFIG_TPM_EMULATOR in build/x86-64-softmmu/config-devices.mak,
> but configure is trying to put it into config-host.mak. The configure
> code is where the "don't do TPM on windows" check is, but the Kconfig
> entry in config-devices.mak overrides that and tries to build this
> code on Windows anyway.
> 
> All the other builds seemed to run ok (I'm just rerunning one lot
> which failed due to an issue on my end; will follow up if there's
> any failure there).

I did the final push to github from the wrong machine. :(  Resending.

Paolo
