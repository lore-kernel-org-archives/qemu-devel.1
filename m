Received: from eggs.gnu.org ([2001:4830:134:3::10]:36441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1w9U-0002lv-Ib
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:09:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1w9T-0000fb-IK
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:09:00 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:47980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1w9T-0000fS-BU
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:08:59 -0400
Received: by mail-wm0-x236.google.com with SMTP id t69so6134500wmt.2
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 08:08:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1507599235-25123-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1507599235-25123-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Oct 2017 16:08:37 +0100
Message-ID: <CAFEAcA-Kod+DTZ5MnG4JwswtKTj2PQw4Q8mhBN7sr50000M=Hg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/10] Merge tpm 2017/10/04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, amarnath.valluri@intel.com, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>

On 10 October 2017 at 02:33, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
> The following changes since commit d147f7e815f97cb477e223586bcb80c316ae10ea:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-10-03 16:27:24 +0100)
>
> are available in the git repository at:
>
>   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2017-10-04-2
>
> for you to fetch changes up to 3bfc6666c21bf9e437734bb3e90db7e5b5f6b8bf:
>
>   specs: Describe the TPM support in QEMU (2017-10-05 12:50:45 -0400)
>
> ----------------------------------------------------------------
> Merge tpm 2017/10/04 v2
>
> ----------------------------------------------------------------

Hi. This fails to build, I'm afraid:

On OpenBSD:

  CC      hw/tpm/tpm_emulator.o
/home/qemu/hw/tpm/tpm_emulator.c: In function 'tpm_emulator_probe_caps':
/home/qemu/hw/tpm/tpm_emulator.c:223:5: warning: format '%lx' expects
argument of type 'long unsigned int', but argument 3 has type
'ptm_cap' [-Wformat=]
     DPRINTF("capbilities : 0x%lx", tpm_emu->caps);
     ^
gmake: Leaving directory '/home/qemu/build/all'
gmake: Entering directory '/home/qemu/build/all'
  CC      hw/tpm/tpm_util.o
/home/qemu/hw/tpm/tpm_util.c: In function 'tpm_util_test':
/home/qemu/hw/tpm/tpm_util.c:94:16: error: 'EBADMSG' undeclared (first
use in this function)
         return EBADMSG;
                ^
/home/qemu/hw/tpm/tpm_util.c:94:16: note: each undeclared identifier
is reported only once for each function it appears in

On AArch32:

/home/peter.maydell/qemu/hw/tpm/tpm_emulator.c: In function
'tpm_emulator_probe_caps':
/home/peter.maydell/qemu/hw/tpm/tpm_emulator.c:53:25: error: format
'%lx' expects argument of type 'long unsigned int', but argument 3 has
type 'ptm_cap {aka long long unsigned int}' [-Werror=format=]
         fprintf(stderr, "tpm-emulator:"fmt"\n", ## __VA_ARGS__); \
                         ^
/home/peter.maydell/qemu/hw/tpm/tpm_emulator.c:223:5: note: in
expansion of macro 'DPRINTF'
     DPRINTF("capbilities : 0x%lx", tpm_emu->caps);
     ^

On OSX:
/Users/pm215/src/qemu-for-merges/hw/tpm/tpm_emulator.c:223:36: error:
format specifies type 'unsigned long' but the argument has type
'ptm_cap' (aka 'unsigned long long') [-Werror,-Wformat]
    DPRINTF("capbilities : 0x%lx", tpm_emu->caps);
                             ~~~   ^~~~~~~~~~~~~
                             %llx
/Users/pm215/src/qemu-for-merges/hw/tpm/tpm_emulator.c:53:52: note:
expanded from macro 'DPRINTF'
        fprintf(stderr, "tpm-emulator:"fmt"\n", ## __VA_ARGS__); \
                                                   ^

thanks
-- PMM
