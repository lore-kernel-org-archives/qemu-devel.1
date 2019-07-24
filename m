Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D965C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 12:33:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA734218B8
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 12:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA734218B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqGSU-0001YH-VJ
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 08:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47672)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dovgaluk@ispras.ru>) id 1hqGSI-00019j-PC
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 08:33:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1hqGSG-0000Iw-TB
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 08:33:14 -0400
Received: from mail.ispras.ru ([83.149.199.45]:34214)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1hqGSG-0008Sj-Gs
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 08:33:12 -0400
Received: from PASHAISP (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id A1FDB54006A;
 Wed, 24 Jul 2019 15:32:57 +0300 (MSK)
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
To: "'Dr. David Alan Gilbert \(git\)'" <dgilbert@redhat.com>,
 <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <pavel.dovgaluk@ispras.ru>
References: <20190724115823.4199-1-dgilbert@redhat.com>
 <20190724115823.4199-4-dgilbert@redhat.com>
In-Reply-To: <20190724115823.4199-4-dgilbert@redhat.com>
Date: Wed, 24 Jul 2019 15:32:59 +0300
Message-ID: <000c01d5421b$edf515f0$c9df41d0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdVCFxwTvlHLiRCVToKko65sRUVmowABMUqQ
Content-Language: ru
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Subject: Re: [Qemu-devel] [for 4.2 PATCH v2 3/4] replay: Remove
 host_clock_last
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>


Pavel Dovgalyuk

> -----Original Message-----
> From: Dr. David Alan Gilbert (git) [mailto:dgilbert@redhat.com]
> Sent: Wednesday, July 24, 2019 2:58 PM
> To: qemu-devel@nongnu.org; pbonzini@redhat.com; pavel.dovgaluk@ispras.ru
> Subject: [for 4.2 PATCH v2 3/4] replay: Remove host_clock_last
> 
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Now we're not using the 'last' field in the timer, remove it from
> replay.
> 
> Bump the version number of the replay structure since we've
> removed the field.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  replay/replay-snapshot.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
> index 756f48bc02..3a58734b9a 100644
> --- a/replay/replay-snapshot.c
> +++ b/replay/replay-snapshot.c
> @@ -24,7 +24,6 @@ static int replay_pre_save(void *opaque)
>  {
>      ReplayState *state = opaque;
>      state->file_offset = ftell(replay_file);
> -    state->host_clock_last = qemu_clock_get_last(QEMU_CLOCK_HOST);
> 
>      return 0;
>  }
> @@ -34,7 +33,6 @@ static int replay_post_load(void *opaque, int version_id)
>      ReplayState *state = opaque;
>      if (replay_mode == REPLAY_MODE_PLAY) {
>          fseek(replay_file, state->file_offset, SEEK_SET);
> -        qemu_clock_set_last(QEMU_CLOCK_HOST, state->host_clock_last);
>          /* If this was a vmstate, saved in recording mode,
>             we need to initialize replay data fields. */
>          replay_fetch_data_kind();
> @@ -50,8 +48,8 @@ static int replay_post_load(void *opaque, int version_id)
> 
>  static const VMStateDescription vmstate_replay = {
>      .name = "replay",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 2,
>      .pre_save = replay_pre_save,
>      .post_load = replay_post_load,
>      .fields = (VMStateField[]) {
> @@ -62,7 +60,6 @@ static const VMStateDescription vmstate_replay = {
>          VMSTATE_UINT32(has_unread_data, ReplayState),
>          VMSTATE_UINT64(file_offset, ReplayState),
>          VMSTATE_UINT64(block_request_id, ReplayState),
> -        VMSTATE_UINT64(host_clock_last, ReplayState),
>          VMSTATE_INT32(read_event_kind, ReplayState),
>          VMSTATE_UINT64(read_event_id, ReplayState),
>          VMSTATE_INT32(read_event_checkpoint, ReplayState),
> --
> 2.21.0



