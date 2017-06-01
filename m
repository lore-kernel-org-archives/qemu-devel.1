Received: from eggs.gnu.org ([2001:4830:134:3::10]:53690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGUIE-00061E-CR
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:53:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGUID-00083H-12
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:53:54 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:37246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dGUIC-00081Z-MA
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:53:52 -0400
Received: by mail-wm0-x232.google.com with SMTP id d127so69985952wmf.0
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 10:53:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170601170733.13080-1-pbonzini@redhat.com>
References: <20170601170733.13080-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Jun 2017 18:53:30 +0100
Message-ID: <CAFEAcA9Yteb5jsB2AJhuhx1Ejg+nwrF8PgetRWv+yFPduLHOgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/34] Misc patches for 2016-06-01
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

On 1 June 2017 at 18:07, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 56821559f0ba682fe6b367815572e6f974d329ab:
>
>   Merge remote-tracking branch 'dgilbert/tags/pull-hmp-20170517' into staging (2017-05-18 13:36:15 +0100)
>
> are available in the git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to f3c3ad2dc98c6610152355f6a4de1445efc87421:
>
>   cpus: reset throttle_thread_scheduled after sleep (2017-06-01 18:01:05 +0200)
>
> ----------------------------------------------------------------
> * virtio-scsi use-after-free fix (Fam)
> * vhost-user-scsi support (Felipe)
> * SMM fixes and improvements for TCG (myself, Mihail)
> * irqchip and AddressSpaceDispatch cleanups and fixes (Peter)
> * Coverity fix (Stefano)
> * NBD cleanups and fixes (Vladimir, Eric, myself)
> * RTC accuracy improvements and code cleanups (Guangrong+Yunfang)
> * socket error reporting improvement (Daniel)
> * GDB XML description for SSE registers (Abdallah)
> * kvmclock update fix (Denis)
> * SMM memory savings (Gonglei)
> * -cpu 486 fix (Paolo)
> * various bugfixes (Roman, Peter, myself, Thomas)
> * rtc-test improvement (Guangrong)
> * migration throttling fix (Felipe)

Test failure on OSX:

TEST: tests/device-introspect-test... (pid=66373)
  /aarch64/device/introspect/list:                                     OK
  /aarch64/device/introspect/none:                                     OK
  /aarch64/device/introspect/abstract:                                 OK
  /aarch64/device/introspect/concrete:                                 **
ERROR:/root/qemu/qom/object.c:364:object_initialize_with_type:
assertion failed: (type != NULL)
Broken pipe

Test failures on FreeBSD:
  GTESTER check-qtest-aarch64
**
ERROR:/Users/pm215/src/qemu-for-merges/qom/object.c:364:void
object_initialize_with_type(void *, size_t, TypeImpl *): assertion
failed: (type != NULL)
Broken pipe
GTester: last random seed: R02S8983f4bd019deabaf27dbf8281490ab9
  GTESTER check-qtest-alpha
**
ERROR:/Users/pm215/src/qemu-for-merges/qom/object.c:364:void
object_initialize_with_type(void *, size_t, TypeImpl *): assertion
failed: (type != NULL)
Broken pipe
GTester: last random seed: R02S5ba80c00f420a9cbe79b7926bc90901c
  GTESTER check-qtest-arm
**
ERROR:/Users/pm215/src/qemu-for-merges/qom/object.c:364:void
object_initialize_with_type(void *, size_t, TypeImpl *): assertion
failed: (type != NULL)
Broken pipe
GTester: last random seed: R02S9a3f10d16d54467f421a79a355a25714
  GTESTER check-qtest-cris
  GTESTER check-qtest-i386
"kvm" accelerator not found.
"kvm" accelerator not found.
"kvm" accelerator not found.
"kvm" accelerator not found.
"kvm" accelerator not found.
"kvm" accelerator not found.
"kvm" accelerator not found.
"kvm" accelerator not found.
"kvm" accelerator not found.
"kvm" accelerator not found.
**
ERROR:/Users/pm215/src/qemu-for-merges/qom/object.c:364:void
object_initialize_with_type(void *, size_t, TypeImpl *): assertion
failed: (type != NULL)
Broken pipe
GTester: last random seed: R02S29797c8935576bfd6237cce3e02075c9
  GTESTER check-qtest-lm32
  GTESTER check-qtest-m68k
  GTESTER check-qtest-microblaze
  GTESTER check-qtest-microblazeel
  GTESTER check-qtest-mips
**
ERROR:/Users/pm215/src/qemu-for-merges/qom/object.c:364:void
object_initialize_with_type(void *, size_t, TypeImpl *): assertion
failed: (type != NULL)
Broken pipe
GTester: last random seed: R02S1d5b7d14f648cc07be3bfc003b7c66a2
  GTESTER check-qtest-mips64
**
ERROR:/Users/pm215/src/qemu-for-merges/qom/object.c:364:void
object_initialize_with_type(void *, size_t, TypeImpl *): assertion
failed: (type != NULL)
Broken pipe
GTester: last random seed: R02S6c9d59bd8f80319effd07c498108c129
  GTESTER check-qtest-mips64el
**
ERROR:/Users/pm215/src/qemu-for-merges/qom/object.c:364:void
object_initialize_with_type(void *, size_t, TypeImpl *): assertion
failed: (type != NULL)
Broken pipe
GTester: last random seed: R02S530b42302d04c589e6a5f1fc49268dcb
  GTESTER check-qtest-mipsel
**
ERROR:/Users/pm215/src/qemu-for-merges/qom/object.c:364:void
object_initialize_with_type(void *, size_t, TypeImpl *): assertion
failed: (type != NULL)
Broken pipe
GTester: last random seed: R02S404f19f557f26102621573b7b8641871
  GTESTER check-qtest-moxie
  GTESTER check-qtest-nios2
  GTESTER check-qtest-or1k
  GTESTER check-qtest-ppc
**
ERROR:/Users/pm215/src/qemu-for-merges/qom/object.c:364:void
object_initialize_with_type(void *, size_t, TypeImpl *): assertion
failed: (type != NULL)
Broken pipe
GTester: last random seed: R02S8a9874d645fde55f36b7df0204c82959
  GTESTER check-qtest-ppc64
**
ERROR:/Users/pm215/src/qemu-for-merges/qom/object.c:364:void
object_initialize_with_type(void *, size_t, TypeImpl *): assertion
failed: (type != NULL)
Broken pipe
GTester: last random seed: R02S1bf51dd7caadd650ac3be82bd21cbae5
  GTESTER check-qtest-ppcemb
**
ERROR:/Users/pm215/src/qemu-for-merges/qom/object.c:364:void
object_initialize_with_type(void *, size_t, TypeImpl *): assertion
failed: (type != NULL)
Broken pipe
GTester: last random seed: R02Sbb3adb4867092ddb73e7fc0ecfe68c96
  GTESTER check-qtest-s390x
**
ERROR:/Users/pm215/src/qemu-for-merges/qom/object.c:364:void
object_initialize_with_type(void *, size_t, TypeImpl *): assertion
failed: (type != NULL)
Broken pipe
GTester: last random seed: R02S2e85df237abb737f12c5aba4c0592c41
  GTESTER check-qtest-sh4
**
ERROR:/Users/pm215/src/qemu-for-merges/qom/object.c:364:void
object_initialize_with_type(void *, size_t, TypeImpl *): assertion
failed: (type != NULL)
Broken pipe
GTester: last random seed: R02S36667c3c9283bf56a54f105edfd951c4
  GTESTER check-qtest-sh4eb
**
ERROR:/Users/pm215/src/qemu-for-merges/qom/object.c:364:void
object_initialize_with_type(void *, size_t, TypeImpl *): assertion
failed: (type != NULL)
Broken pipe
GTester: last random seed: R02S7a8f453c29b24767afcbf5af6c890072
  GTESTER check-qtest-sparc
  GTESTER check-qtest-sparc64
**
ERROR:/Users/pm215/src/qemu-for-merges/qom/object.c:364:void
object_initialize_with_type(void *, size_t, TypeImpl *): assertion
failed: (type != NULL)
Broken pipe
GTester: last random seed: R02Scf61ab29a9f9630cf0661370bca2f09d
  GTESTER check-qtest-tricore
  GTESTER check-qtest-unicore32
  GTESTER check-qtest-x86_64
"kvm" accelerator not found.
"kvm" accelerator not found.
"kvm" accelerator not found.
"kvm" accelerator not found.
"kvm" accelerator not found.
"kvm" accelerator not found.
"kvm" accelerator not found.
"kvm" accelerator not found.
"kvm" accelerator not found.
"kvm" accelerator not found.
**
ERROR:/Users/pm215/src/qemu-for-merges/qom/object.c:364:void
object_initialize_with_type(void *, size_t, TypeImpl *): assertion
failed: (type != NULL)
Broken pipe
GTester: last random seed: R02S1639c5bd5af52de8b1b097d44666b889
  GTESTER check-qtest-xtensa
  GTESTER check-qtest-xtensaeb

(Yes, the test's error messages are pretty useless.)

thanks
-- PMM
