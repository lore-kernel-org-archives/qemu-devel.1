Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC4AC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 18:21:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A017420692
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 18:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A017420692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO3iA-00047j-Lr
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 14:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jO3hR-0003VY-6e
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 14:20:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jO3hP-0004lw-5J
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 14:20:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:59116)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jO3hO-0004k8-VY
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 14:20:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jO3hN-0007jC-IQ
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 18:20:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 8A1622E8105
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 18:20:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2020 18:14:00 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: arm
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bcantrill pmaydell
X-Launchpad-Bug-Reporter: Bryan Cantrill (bcantrill)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <158663515939.5446.1890827991506574310.malonedeb@chaenomeles.canonical.com>
Message-Id: <158680164042.12679.16973910529458517462.malone@soybean.canonical.com>
Subject: [Bug 1872237] Re: SysTick reload behavior emulated incorrectly
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="2e26c9bbd21cdca248baaea29aeffb920afcc32a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 72d52e451d7967e3b13d4124bf0e94b3eac12e16
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1872237 <1872237@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Other than the systick issue, I think the core M-profile emulation
should be pretty solid (bugs are always possible, of course). We have
support for v6M (cortex-m0), v7M (cortex-m3, m4) and v8M (cortex-m33,
including the security extension) and at least some board models for all
of those. No v8.1M yet (that is next on my todo list). Board and device
support in QEMU is in general more likely to have missing features than
the core cpu emulation, but I can't think of anything specifically
annoyingly missing offhand. Of the upstream board models, the various
MPS2 boards are I think fairly solid, as are the Musca board models. We
also have a Netduino 2 and a Netduino Plus 2 model which I think ought
to be OK. The Stellaris boards (lm3s6965evb and lm3s811evb) are rather
older and I dunno that I'd recommend them unless you have no other
choice.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1872237

Title:
  SysTick reload behavior emulated incorrectly

Status in QEMU:
  New

Bug description:
  QEMU's emuation of SysTick on ARM is incorrect with respect to reload
  behavior.  This issue is described here, and also in a repository
  dedicated to the issue:

    https://github.com/oxidecomputer/qemu-systick-bug

  =

  (What follows is in Markdown, which I understand that Launchpad does
  not support; see the repository linked above for a rendering of it.)

  Take this Rust program:

  ```rust
  #![no_std]
  #![no_main]

  extern crate panic_semihosting;

  use cortex_m_rt::entry;
  use cortex_m_semihosting::hprintln;
  use cortex_m::peripheral::syst::SystClkSource;
  use cortex_m::peripheral::SYST;

  fn delay(syst: &mut cortex_m::peripheral::SYST, ms: u32)
  {
      /*
       * Configured for the LM3S6965, which has a default CPU clock of 12 M=
hz
       */
      let reload =3D 12_000 * ms;

      syst.set_reload(reload);
      syst.clear_current();
      syst.enable_counter();

      hprintln!("waiting for {} ms (SYST_CVR=3D{}) ...",
          ms, SYST::get_current()
      ).unwrap();

      while !syst.has_wrapped() {}

      hprintln!("  ... done (SYST_CVR=3D{})\n",
  SYST::get_current()).unwrap();

      syst.disable_counter();
  }

  #[entry]
  fn main() -> ! {
      let p =3D cortex_m::Peripherals::take().unwrap();
      let mut syst =3D p.SYST;

      syst.set_clock_source(SystClkSource::Core);

      loop {
          delay(&mut syst, 1000);
          delay(&mut syst, 100);
      }
  }
  ```

  This program should oscillate between waiting for one second and waiting
  for 100 milliseconds.  Under hardware, this is more or less what it does
  (depending on core clock frequency); e.g., from an STM32F4107 (connected =
via
  OCD and with semi-hosting enabled):

  ```
  waiting for 1000 ms (SYST_CVR=3D11999949) ...
    ... done (SYST_CVR=3D11999902)

  waiting for 100 ms (SYST_CVR=3D1199949) ...
    ... done (SYST_CVR=3D1199897)

  waiting for 1000 ms (SYST_CVR=3D11999949) ...
    ... done (SYST_CVR=3D11999885)

  waiting for 100 ms (SYST_CVR=3D1199949) ...
    ... done (SYST_CVR=3D1199897)

  waiting for 1000 ms (SYST_CVR=3D11999949) ...
    ... done (SYST_CVR=3D11999885)

  ```

  Under QEMU, however, its behavior is quite different:

  ```
  $ cargo run
      Finished dev [unoptimized + debuginfo] target(s) in 0.03s
       Running `qemu-system-arm -cpu cortex-m3 -machine lm3s6965evb -nograp=
hic -semihosting-config enable=3Don,target=3Dnative -kernel target/thumbv7m=
-none-eabi/debug/qemu-systick-bug`
  waiting for 1000 ms (SYST_CVR=3D11999658) ...
    ... done (SYST_CVR=3D11986226)

  waiting for 100 ms (SYST_CVR=3D0) ...
    ... done (SYST_CVR=3D1186560)

  waiting for 1000 ms (SYST_CVR=3D1185996) ...
    ... done (SYST_CVR=3D11997350)

  waiting for 100 ms (SYST_CVR=3D0) ...
    ... done (SYST_CVR=3D1186581)
  ```

  In addition to the values being strangely wrong, the behavior is wrong:
  the first wait correctly waits for 1000 ms -- but the subsequent wait
  (which should be for 100 ms) is in fact 1000 ms, and the next wait (which
  should be for 1000 ms) is in fact 100 ms.  (That is, it appears as if
  the periods of the two delays have been switched.)

  The problems is that the QEMU ARM emulation code does not reload SYST_CVR=
 from
  SYST_RVR if SYST_CSR.ENABLE is not set -- and moreover, that SYST_CVR is
  not reloaded from SYST_RVR even when SYST_CSR.ENABLE becomes set.  This is
  very explicit; from
  <a
  href=3D"https://github.com/qemu/qemu/blob/8bac3ba57eecc466b7e73dabf7d1932=
8a59f684e/hw/timer/armv7m_systick.c#L42-L60">hw/timer/armv7m_systick.c</a>:

  ```c
  static void systick_reload(SysTickState *s, int reset)
  {
      /* The Cortex-M3 Devices Generic User Guide says that "When the
       * ENABLE bit is set to 1, the counter loads the RELOAD value from the
       * SYST RVR register and then counts down". So, we need to check the
       * ENABLE bit before reloading the value.
       */
      trace_systick_reload();

      if ((s->control & SYSTICK_ENABLE) =3D=3D 0) {
          return;
      }

      if (reset) {
          s->tick =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
      }
      s->tick +=3D (s->reload + 1) * systick_scale(s);
      timer_mod(s->timer, s->tick);
  }
  ```

  The statement in the code is stronger than the statement in the
  <a href=3D"https://static.docs.arm.com/ddi0403/eb/DDI0403E_B_armv7m_arm.p=
df">ARMv7-M Architecture Reference Manual</a> (sec B3.3.1):

  > Writing to SYST_CVR clears both the register and the COUNTFLAG status
  > bit to zero. This causes the SysTick logic to reload SYST_CVR from SYST=
_RVR
  > on the next timer clock. A write to SYST_CVR does not trigger the
  > SysTick exception logic.

  Note that this does not mention the behavior on a write to SYST_CVR when
  SYST_CSR.ENABLE is not set -- and in particular, does *not* say that writ=
es to
  SYST_CVR will be ignored if SYST_CSR.ENABLE is not set.

  Section 3.3.1 does go on to say:

  > The SYST_CVR value is UNKNOWN on reset. Before enabling the SysTick cou=
nter,u
  > software must write the required counter value to SYST_RVR, and then wr=
ite
  > to SYST_CVR. This clears SYST_CVR to zero. When enabled, the counter =

  > reloads the value from SYST_RVR, and counts down from that value, rathe=
r]
  > than from an arbitrary value.

  (This is more or less what has been quoted in the implementation of
  `systick_reload`, above.)  This note does **not** say, however, that writ=
es
  to SYST_CVR will be discarded when not enabled, but rather that the count=
ing
  will only begin (and the value in SYST_RVR loaded or reloaded) when
  SYST_CSR.ENABLE becomes set.

  While QEMU's behavior does not match that of the hardware (and is therefo=
re
  at some level malfunctioning), there is additional behavior that is very
  clearly incorrect: once SYST_CSR.ENABLE is set, not only will SYST_CVR
  continue to return 0 (that is, the counter will not be enabled),
  SYST_CSR.COUNTFLAG will become set when the *old* value of SYST_RVR ticks
  have elapsed!  This is wrong in both regards: if SYST_CVR is not counting
  down, SYST_CSR.COUNTFLAG should never become set -- and it certainly
  shouldn't match a value of SYST_RVR that has been overwritten in the
  interim!

  In terms of fixing this, it's helpful to understand the
  <a
  href=3D"https://lists.gnu.org/archive/html/qemu-devel/2015-05/msg01217.ht=
ml">context
  around this change</a>:

  > Consider the following pseudo code to configure SYSTICK (The
  > recommended programming sequence from "the definitive guide to the
  > arm cortex-m3"):
  >    SYSTICK Reload Value Register =3D 0xffff
  >    SYSTICK Current Value Register =3D 0
  >    SYSTICK Control and Status Register =3D 0x7
  >
  > The pseudo code "SYSTICK Current Value Register =3D 0" leads to invoking
  > systick_reload(). As a consequence, the systick.tick member is updated
  > and the systick timer starts to count down when the ENABLE bit of
  > SYSTICK Control and Status Register is cleared.
  >
  > The worst case is that: during the system initialization, the reset
  > value of the SYSTICK Control and Status Register is 0x00000000. =

  > When the code "SYSTICK Current Value Register =3D 0" is executed, the
  > systick.tick member is accumulated with "(s->systick.reload + 1) *
  > systick_scale(s)". The systick_scale() gets the external_ref_clock
  > scale because the CLKSOURCE bit of the SYSTICK Control and Status
  > Register is cleared. This is the incorrect behavior because of the
  > code "SYSTICK Control and Status Register =3D 0x7". Actually, we want
  > the processor clock instead of the external reference clock.
  >
  > This incorrect behavior defers the generation of the first interrupt. =

  >
  > The patch fixes the above-mentioned issue by setting the systick.tick
  > member and modifying the systick timer only if the ENABLE bit of
  > the SYSTICK Control and Status Register is set.
  >
  > In addition, the Cortex-M3 Devices Generic User Guide mentioned that
  > "When ENABLE is set to 1, the counter loads the RELOAD value from the
  > SYST RVR register and then counts down". This patch adheres to the
  > statement of the user guide.

  This fix is simply incorrect -- or at the least, incomplete:
  a write to SYST_CVR must clear any cached state
  such that a subsequent write to SYST_CSR.ENABLE will correctly cause
  a reload.  Here is a diff that solves the problem without re-introducing
  the behavior that the original fix was trying to correct:

  ```diff
  diff --git a/hw/timer/armv7m_systick.c b/hw/timer/armv7m_systick.c
  index 74c58bcf24..3f7b267c2d 100644
  --- a/hw/timer/armv7m_systick.c
  +++ b/hw/timer/armv7m_systick.c
  @@ -181,6 +181,15 @@ static MemTxResult systick_write(void *opaque, hwadd=
r addr,
           break;
       case 0x8: /* SysTick Current Value.  Writes reload the timer.  */
           systick_reload(s, 1);
  +
  +        if ((s->control & SYSTICK_ENABLE) =3D=3D 0) {
  +            /*
  +             * If we're not enabled, explicitly clear our tick value to
  +             * assure that when we do become enabled, we correctly reloa=
d.
  +             */
  +            s->tick =3D 0;
  +        }
  +
           s->control &=3D ~SYSTICK_COUNTFLAG;
           break;
       default:
  ```

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1872237/+subscriptions

