Received: from eggs.gnu.org ([2001:4830:134:3::10]:35196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gZcuy-00044w-TT
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 09:33:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gZcux-0007Az-54
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 09:33:48 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:43742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gZcuw-0007AV-Ub
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 09:33:47 -0500
Received: by mail-ot1-x335.google.com with SMTP id a11so19222576otr.10
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 06:33:46 -0800 (PST)
MIME-Version: 1.0
References: <20181217231700.24482-1-pbonzini@redhat.com>
In-Reply-To: <20181217231700.24482-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Dec 2018 14:33:34 +0000
Message-ID: <CAFEAcA-=jLUHhcUeBMQtOU-tA6nKaNoBkf2eYqC6CA2TkG+6ZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/35] Misc patches for 2018-12-18
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

On Mon, 17 Dec 2018 at 23:23, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 0f98c9945899c5dfacd5a410ff04178eda605a16:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2018-12-12' into staging (2018-12-14 10:19:47 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to cf7d97201d31cf14c7285e76ffb58bd518280184:
>
>   avoid TABs in files that only contain a few (2018-12-18 00:13:10 +0100)
>
> I removed the vhost-user patches, which need a small linux-headers update
> in order to fix the BSDs, and added TAB fixes and the script to convert
> multiline comments into 4-line format.
>

Something seems to be wrong with the new test harness, eg
for aarch32 builds I get:

PASS 50 test-hmp /arm/hmp/vexpress-a15
PASS 5 display-vga-test /x86_64/display/pci/virtio-gpu
PASS 1 intel-hda-test /x86_64/intel-hda/ich6
PASS 2 intel-hda-test /x86_64/intel-hda/ich9
shm_open: Permission denied
ERROR - missing test plan
/home/peter.maydell/qemu/tests/Makefile.include:836: recipe for target
'check-qtest-x86_64' failed

and OSX host prints
  TEST    check-tests/test-io-channel-buffer
  TEST    check-tests/test-base64
  TEST    check-tests/test-crypto-pbkdf
ERROR - missing test plan

PS: can the colorization be disabled? Grepping logfiles for
ERROR, FAIL, etc doesn't work in the presence of colour
escape sequences...

thanks
-- PMM
