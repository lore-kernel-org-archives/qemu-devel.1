Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832E9C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:12:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86EA920848
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EA920848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSfdS-0004pw-D3
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 08:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kSfYk-0007iN-UE
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 08:07:10 -0400
Received: from mail.ispras.ru ([83.149.199.84]:34908)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kSfYh-0002gi-Di
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 08:07:10 -0400
Received: from [192.168.0.183] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id 7A4A540A2048;
 Wed, 14 Oct 2020 12:07:01 +0000 (UTC)
Subject: Re: [PATCH v4 3/3] replay: do not build if TCG is not available
To: Claudio Fontana <cfontana@suse.de>
References: <20201013192123.22632-1-cfontana@suse.de>
 <20201013192123.22632-4-cfontana@suse.de>
 <281ee6ed-454b-1baf-343c-786421a48c8e@ispras.ru>
 <b3c6ac29-f35f-5c9f-b0d9-03c5a1674d33@suse.de>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Message-ID: <2a46f72f-1fc0-2daf-e600-d989de0041b0@ispras.ru>
Date: Wed, 14 Oct 2020 15:07:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b3c6ac29-f35f-5c9f-b0d9-03c5a1674d33@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 08:07:02
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14.10.2020 09:51, Claudio Fontana wrote:
> привет Pavel!
> 
> On 10/14/20 7:42 AM, Pavel Dovgalyuk wrote:
>> On 13.10.2020 22:21, Claudio Fontana wrote:
>>> this fixes non-TCG builds broken recently by replay reverse debugging.
>>>
>>> stub the needed functions in stub/, including errors for hmp and qmp.
>>> This includes duplicating some code in replay/, and puts the logic
>>> for non-replay related events in the replay/ module (+ the stubs),
>>> so this should be revisited in the future.
>>>
>>> Surprisingly, only _one_ qtest was affected by this, ide-test.c, which
>>> resulted in a buzz as the bh events were never delivered, and the bh
>>> never executed.
>>>
>>> Many other subsystems _should_ have been affected.
>>>
>>> This fixes the immediate issue, however a better way to group replay
>>> functionality to TCG-only code could be developed in the long term.
>>>
>>> Signed-off-by: Claudio Fontana <cfontana@suse.de>
>>> ---
>>>    block/meson.build          |  3 +-
>>>    migration/savevm.c         | 11 +++--
>>>    net/meson.build            |  3 +-
>>>    replay/meson.build         |  2 +-
>>>    replay/replay-input.c      |  4 +-
>>>    stubs/meson.build          |  1 -
>>>    stubs/replay-user.c        |  9 ----
>>>    stubs/replay.c             | 98 ++++++++++++++++++++++++++++++++++++++
>>>    tests/ptimer-test-stubs.c  |  5 --
>>>    tests/qtest/qmp-cmd-test.c |  3 ++
>>>    ui/input.c                 | 12 ++++-
>>>    11 files changed, 125 insertions(+), 26 deletions(-)
>>>    delete mode 100644 stubs/replay-user.c
>>>
>>> diff --git a/block/meson.build b/block/meson.build
>>> index 78e8b25232..01fe6f84d2 100644
>>> --- a/block/meson.build
>>> +++ b/block/meson.build
>>> @@ -7,7 +7,6 @@ block_ss.add(files(
>>>      'backup-top.c',
>>>      'blkdebug.c',
>>>      'blklogwrites.c',
>>> -  'blkreplay.c',
>>>      'blkverify.c',
>>>      'block-backend.c',
>>>      'block-copy.c',
>>> @@ -42,6 +41,8 @@ block_ss.add(files(
>>>      'write-threshold.c',
>>>    ), zstd, zlib)
>>>    
>>> +block_ss.add(when: 'CONFIG_TCG', if_true: files('blkreplay.c'))
>>> +
>>>    block_ss.add(when: 'CONFIG_QCOW1', if_true: files('qcow.c'))
>>>    block_ss.add(when: 'CONFIG_VDI', if_true: files('vdi.c'))
>>>    block_ss.add(when: 'CONFIG_CLOOP', if_true: files('cloop.c'))
>>> diff --git a/migration/savevm.c b/migration/savevm.c
>>> index d2e141f7b1..d9181ca520 100644
>>> --- a/migration/savevm.c
>>> +++ b/migration/savevm.c
>>> @@ -63,6 +63,7 @@
>>>    #include "migration/colo.h"
>>>    #include "qemu/bitmap.h"
>>>    #include "net/announce.h"
>>> +#include "sysemu/tcg.h"
>>>    
>>>    const unsigned int postcopy_ram_discard_version = 0;
>>>    
>>> @@ -2674,10 +2675,12 @@ int save_snapshot(const char *name, Error **errp)
>>>            return ret;
>>>        }
>>>    
>>> -    if (!replay_can_snapshot()) {
>>> -        error_setg(errp, "Record/replay does not allow making snapshot "
>>> -                   "right now. Try once more later.");
>>> -        return ret;
>>> +    if (tcg_enabled()) {
>>> +        if (!replay_can_snapshot()) {
>>> +            error_setg(errp, "Record/replay does not allow making snapshot "
>>> +                       "right now. Try once more later.");
>>> +            return ret;
>>> +        }
>>>        }
>>>    
>>>        if (!bdrv_all_can_snapshot(&bs)) {
>>> diff --git a/net/meson.build b/net/meson.build
>>> index 1c7e3a3cb9..1076b0a7ab 100644
>>> --- a/net/meson.build
>>> +++ b/net/meson.build
>>> @@ -7,7 +7,6 @@ softmmu_ss.add(files(
>>>      'eth.c',
>>>      'filter-buffer.c',
>>>      'filter-mirror.c',
>>> -  'filter-replay.c',
>>>      'filter-rewriter.c',
>>>      'filter.c',
>>>      'hub.c',
>>> @@ -17,6 +16,8 @@ softmmu_ss.add(files(
>>>      'util.c',
>>>    ))
>>>    
>>> +softmmu_ss.add(when: 'CONFIG_TCG', if_true: files('filter-replay.c'))
>>> +
>>>    softmmu_ss.add(when: 'CONFIG_L2TPV3', if_true: files('l2tpv3.c'))
>>>    softmmu_ss.add(when: slirp, if_true: files('slirp.c'))
>>>    softmmu_ss.add(when: ['CONFIG_VDE', vde], if_true: files('vde.c'))
>>> diff --git a/replay/meson.build b/replay/meson.build
>>> index f91163fb1e..cb3207740a 100644
>>> --- a/replay/meson.build
>>> +++ b/replay/meson.build
>>> @@ -1,4 +1,4 @@
>>> -softmmu_ss.add(files(
>>> +softmmu_ss.add(when: 'CONFIG_TCG', if_true: files(
>>>      'replay.c',
>>>      'replay-internal.c',
>>>      'replay-events.c',
>>> diff --git a/replay/replay-input.c b/replay/replay-input.c
>>> index 1147e3d34e..5d1fd92e79 100644
>>> --- a/replay/replay-input.c
>>> +++ b/replay/replay-input.c
>>> @@ -124,7 +124,7 @@ void replay_input_event(QemuConsole *src, InputEvent *evt)
>>>        } else if (replay_mode == REPLAY_MODE_RECORD) {
>>>            replay_add_input_event(QAPI_CLONE(InputEvent, evt));
>>>        } else {
>>> -        qemu_input_event_send_impl(src, evt);
>>> +        g_assert_not_reached();
>>>        }
>>>    }
>>>    
>>> @@ -135,6 +135,6 @@ void replay_input_sync_event(void)
>>>        } else if (replay_mode == REPLAY_MODE_RECORD) {
>>>            replay_add_input_sync_event();
>>>        } else {
>>> -        qemu_input_event_sync_impl();
>>> +        g_assert_not_reached();
>>>        }
>>>    }
> 
> 
> incidentally Pavel, is this ok when replay is enabled, can you give it a spin?
> I used the if (replay_events_enabled()) in the ui/input.c code to only call these when events are enabled.

I think this is ok to use this function for checking that replay is on.

> 
> 
> 
>>> diff --git a/stubs/meson.build b/stubs/meson.build
>>> index 67f2a8c069..bbd2230d69 100644
>>> --- a/stubs/meson.build
>>> +++ b/stubs/meson.build
>>> @@ -32,7 +32,6 @@ stub_ss.add(files('qtest.c'))
>>>    stub_ss.add(files('ram-block.c'))
>>>    stub_ss.add(files('ramfb.c'))
>>>    stub_ss.add(files('replay.c'))
>>> -stub_ss.add(files('replay-user.c'))
>>>    stub_ss.add(files('runstate-check.c'))
>>>    stub_ss.add(files('set-fd-handler.c'))
>>>    stub_ss.add(files('sysbus.c'))
>>> diff --git a/stubs/replay-user.c b/stubs/replay-user.c
>>> deleted file mode 100644
>>> index 2ad9e27203..0000000000
>>> --- a/stubs/replay-user.c
>>> +++ /dev/null
>>> @@ -1,9 +0,0 @@
>>> -#include "qemu/osdep.h"
>>> -#include "sysemu/replay.h"
>>> -#include "sysemu/sysemu.h"
>>> -
>>> -void replay_bh_schedule_oneshot_event(AioContext *ctx,
>>> -    QEMUBHFunc *cb, void *opaque)
>>> -{
>>> -    aio_bh_schedule_oneshot(ctx, cb, opaque);
>>> -}
>>> diff --git a/stubs/replay.c b/stubs/replay.c
>>> index 45ebe77fb9..34b7975b2d 100644
>>> --- a/stubs/replay.c
>>> +++ b/stubs/replay.c
>>> @@ -103,3 +103,101 @@ bool replay_reverse_continue(void)
>>>    {
>>>        return false;
>>>    }
>>> +
>>> +void replay_input_event(QemuConsole *src, InputEvent *evt)
>>> +{
>>> +}
>>> +void replay_input_sync_event(void)
>>> +{
>>> +}
>>> +void replay_bh_schedule_event(QEMUBH *bh)
>>> +{
>>> +    qemu_bh_schedule(bh);
>>> +}
>>> +void replay_bh_schedule_oneshot_event(AioContext *ctx,
>>> +     QEMUBHFunc *cb, void *opaque)
>>> +{
>>> +    aio_bh_schedule_oneshot(ctx, cb, opaque);
>>> +}
>>> +void replay_add_blocker(Error *reason)
>>> +{
>>> +}
>>> +void replay_audio_in(size_t *recorded, void *samples, size_t *wpos, size_t size)
>>> +{
>>> +}
>>> +void replay_audio_out(size_t *played)
>>> +{
>>> +}
>>> +void replay_breakpoint(void)
>>> +{
>>> +}
>>> +bool replay_can_snapshot(void)
>>> +{
>>> +    return false;
>>> +}
>>
>> Shouldn't this one return true to enable snapshotting?
> 
> 
> The check for replay_can_snapshot is wrapped by a
> 
> if (tcg_enabled()) {
> }
> 
> so it should be fine.
> 
> Logically, reading a naked:
> 
> if (!replay_can_snapshot()) { fail; }
> 
> is surprising I think for a reader that compiled the code without replay.

Ok


