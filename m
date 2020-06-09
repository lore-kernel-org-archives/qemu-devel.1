Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47572C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:30:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC7B220734
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7B220734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jifH3-0001wH-JJ
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 10:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jifC7-000585-4P
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 10:25:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:34524)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jifC5-0001ao-KX
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 10:25:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jifC3-0000CC-PJ
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 14:25:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B979D2E8106
 for <qemu-devel@nongnu.org>; Tue,  9 Jun 2020 14:25:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2020 14:18:12 -0000
From: malib69055 <1882787@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: audio subsystem voice
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: malib69055
X-Launchpad-Bug-Reporter: malib69055 (malib69055)
X-Launchpad-Bug-Modifier: malib69055 (malib69055)
Message-Id: <159171229296.18905.15367974946504993001.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1882787] [NEW] AUD_set_volume_out takes SWVoiceOut as parameter, 
 but controls HWVoiceOut
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="ef9fc486e875d54078fa61cf91e898b895125d89";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 98d51e7e28caa108cffa56c955b720f196738f10
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 10:15:37
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Reply-To: Bug 1882787 <1882787@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

There was a change in
https://github.com/qemu/qemu/commit/571a8c522e0095239598347ac0add93337c1e0bf
#diff-230ab01fa7fb1668a1e9183241115cb0R1852-R1853 (audio/audio.c) which
breaks audio output on devices which have multiple software voices on
the same hardware voice.

When multiple software voices use the same hardware voice, then setting
a volume / mute for any of the software voices, will affect all other
software voices, too.

I'm not sure if such a use-case exists in QEMU; however, it does exist in m=
y fork.
It's also easy to see that this is a bug in the QEMU audio subsystem.

The API (and broken function) for this is:

```
    void AUD_set_volume_out (SWVoiceOut *sw, int mute, uint8_t lvol, uint8_=
t rvol)
```

So this is supposed to modify the SWVoiceOut.

However, if the backend supports `pcm_ops->volume_out` this does not
work as expected. It's always as if you had called:

```
    void AUD_set_volume_out (HWVoiceOut *hw, int mute, uint8_t lvol, uint8_=
t rvol)
```

*(Note how this modifies the hardware voice)*


In my specific use case, I have 2 outputs (digital and analog audio on AC97=
), and I want to mute the digital audio output, but I still need to keep th=
e voice activated for timing.
However, if I mute the digital audio SWVoiceOut, it will also affect the ot=
her SWVoiceOut (for analog audio) on the same HWVoiceOut.

---

Old code - if the hardware supports volume changes, it will receive the
software voice which should be modified, so changes can be restricted to
that one voice:

```
        HWVoiceOut *hw =3D sw->hw;
        [...]
        if (hw->pcm_ops->ctl_out) {
            hw->pcm_ops->ctl_out (hw, VOICE_VOLUME, sw);
        }
```

New code - the hardware backend will have no way to differentiate
software voices; so any change will affect all voices. The volume which
was set last on any sw voice will set a global volume / mute for all
voices on the hardware backend:

```
        HWVoiceOut *hw =3D sw->hw;
        [...]
        if (hw->pcm_ops->volume_out) {
            hw->pcm_ops->volume_out(hw, &sw->vol);
        }
```

The old interface was already broken with some (all?) backends, because the=
y ignored the software voice, but at least the design made sense.
However, the new design is fundamentally broken because it doesn't even tel=
l the backend which voice is supposed to be modified.

---

Bug was introduced in cecc1e79bf9ad9a0e2d3ce513d4f71792a0985f6
The affected code was touched since then, but still remains in 49ee11555262=
a256afec592dfed7c5902d5eefd2

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: audio subsystem voice

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1882787

Title:
  AUD_set_volume_out takes SWVoiceOut as parameter, but controls
  HWVoiceOut

Status in QEMU:
  New

Bug description:
  There was a change in
  https://github.com/qemu/qemu/commit/571a8c522e0095239598347ac0add93337c1e=
0bf
  #diff-230ab01fa7fb1668a1e9183241115cb0R1852-R1853 (audio/audio.c)
  which breaks audio output on devices which have multiple software
  voices on the same hardware voice.

  When multiple software voices use the same hardware voice, then
  setting a volume / mute for any of the software voices, will affect
  all other software voices, too.

  I'm not sure if such a use-case exists in QEMU; however, it does exist in=
 my fork.
  It's also easy to see that this is a bug in the QEMU audio subsystem.

  The API (and broken function) for this is:

  ```
      void AUD_set_volume_out (SWVoiceOut *sw, int mute, uint8_t lvol, uint=
8_t rvol)
  ```

  So this is supposed to modify the SWVoiceOut.

  However, if the backend supports `pcm_ops->volume_out` this does not
  work as expected. It's always as if you had called:

  ```
      void AUD_set_volume_out (HWVoiceOut *hw, int mute, uint8_t lvol, uint=
8_t rvol)
  ```

  *(Note how this modifies the hardware voice)*

  =

  In my specific use case, I have 2 outputs (digital and analog audio on AC=
97), and I want to mute the digital audio output, but I still need to keep =
the voice activated for timing.
  However, if I mute the digital audio SWVoiceOut, it will also affect the =
other SWVoiceOut (for analog audio) on the same HWVoiceOut.

  ---

  Old code - if the hardware supports volume changes, it will receive
  the software voice which should be modified, so changes can be
  restricted to that one voice:

  ```
          HWVoiceOut *hw =3D sw->hw;
          [...]
          if (hw->pcm_ops->ctl_out) {
              hw->pcm_ops->ctl_out (hw, VOICE_VOLUME, sw);
          }
  ```

  New code - the hardware backend will have no way to differentiate
  software voices; so any change will affect all voices. The volume
  which was set last on any sw voice will set a global volume / mute for
  all voices on the hardware backend:

  ```
          HWVoiceOut *hw =3D sw->hw;
          [...]
          if (hw->pcm_ops->volume_out) {
              hw->pcm_ops->volume_out(hw, &sw->vol);
          }
  ```

  The old interface was already broken with some (all?) backends, because t=
hey ignored the software voice, but at least the design made sense.
  However, the new design is fundamentally broken because it doesn't even t=
ell the backend which voice is supposed to be modified.

  ---

  Bug was introduced in cecc1e79bf9ad9a0e2d3ce513d4f71792a0985f6
  The affected code was touched since then, but still remains in 49ee115552=
62a256afec592dfed7c5902d5eefd2

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1882787/+subscriptions

