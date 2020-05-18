Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD3FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 02:53:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9FB220787
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 02:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f3i/Kq9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9FB220787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaVuA-0000SQ-UQ
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 22:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jaVtF-0008IB-QI
 for qemu-devel@nongnu.org; Sun, 17 May 2020 22:52:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35314
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jaVtE-0004kX-Ly
 for qemu-devel@nongnu.org; Sun, 17 May 2020 22:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589770347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FtRk+bnwwNwWWxyCnlhR5aQjzZOFMJcUYzcyDGLbM5k=;
 b=f3i/Kq9bmKySCLHtr+2jz/P3Ar0eGuYFyIgt0hcrpw6RCl3xtlf/lSR9QbM15SYeFLP11V
 BV8+yUtqwGGhyZSWnc6EzhWQKLlkaKrhTxJACaPMgfWY/YdusPW+GtGTCOh2VVnhZdiNGG
 cZSQ8EClz+1zbSxI9VlgUJY5AzxXzb0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-7p8Xl5BcOhe11V8WfyUGhg-1; Sun, 17 May 2020 22:52:26 -0400
X-MC-Unique: 7p8Xl5BcOhe11V8WfyUGhg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED644835B40;
 Mon, 18 May 2020 02:52:24 +0000 (UTC)
Received: from [10.72.13.232] (ovpn-13-232.pek2.redhat.com [10.72.13.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3CEF15F7EA;
 Mon, 18 May 2020 02:52:09 +0000 (UTC)
Subject: Re: [PATCH v2 5/5] vhost: add device started check in migration set
 log
To: Li Feng <fengli@smartx.com>, Dima Stepanov <dimastep@yandex-team.ru>
References: <cover.1588252861.git.dimastep@yandex-team.ru>
 <d25241eb1fe7a55fc7dbe63ecedb4f1adf407837.1588252862.git.dimastep@yandex-team.ru>
 <ed805147-d87d-5ac2-3196-367981b0679c@redhat.com>
 <20200511092541.GA27558@dimastep-nix>
 <fd260f1f-75f3-46ac-8ca5-bbb7e41e712f@redhat.com>
 <20200512093521.GA5363@dimastep-nix>
 <20200512235934-mutt-send-email-mst@kernel.org>
 <b9cd40fd-53fb-e1e1-7cb7-ec437bc60ff2@redhat.com>
 <20200513094703.GA15906@dimastep-nix>
 <722839b2-9412-b768-3ce6-d1b697d6d5dd@redhat.com>
 <20200515165449.GA1627@dimastep-nix>
 <CAHckoCyE0r-aRnqqU2m0vgzdcP22RjO39foaJheRYTrnkZTArA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6bf8a077-01fb-dfd1-164e-440d313503d3@redhat.com>
Date: Mon, 18 May 2020 10:52:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHckoCyE0r-aRnqqU2m0vgzdcP22RjO39foaJheRYTrnkZTArA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:52:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gonglei <arei.gonglei@huawei.com>, yc-core@yandex-team.ru,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/5/16 上午11:20, Li Feng wrote:
> Hi, Dima.
> This abort is what I have mentioned in my previous email.
> I have triggered this crash without any fix a week ago.
> And I have written a test patch to let vhost_log_global_start return
> int and propagate the error to up layer.
> However, my change is a little large, because the origin callback
> return void, and don't do some rollback.
> After test, the migration could migrate to dst successfully, and fio
> is still running perfectly, but the src vm is still stuck here, no
> crash.
>
> Is it right to return this error to the up layer?


That could be a solution or we may ask David for more suggestion.

Another thing that might be useful is to block re connection during 
migration.

Thanks


>
> Thanks,
> Feng Li
>
> Dima Stepanov <dimastep@yandex-team.ru> 于2020年5月16日周六 上午12:55写道：
>> On Thu, May 14, 2020 at 03:34:24PM +0800, Jason Wang wrote:
>>> On 2020/5/13 下午5:47, Dima Stepanov wrote:
>>>>>>      case CHR_EVENT_CLOSED:
>>>>>>          /* a close event may happen during a read/write, but vhost
>>>>>>           * code assumes the vhost_dev remains setup, so delay the
>>>>>>           * stop & clear to idle.
>>>>>>           * FIXME: better handle failure in vhost code, remove bh
>>>>>>           */
>>>>>>          if (s->watch) {
>>>>>>              AioContext *ctx = qemu_get_current_aio_context();
>>>>>>
>>>>>>              g_source_remove(s->watch);
>>>>>>              s->watch = 0;
>>>>>>              qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, NULL, NULL,
>>>>>>                                       NULL, NULL, false);
>>>>>>
>>>>>>              aio_bh_schedule_oneshot(ctx, chr_closed_bh, opaque);
>>>>>>          }
>>>>>>          break;
>>>>>>
>>>>>> I think it's time we dropped the FIXME and moved the handling to common
>>>>>> code. Jason? Marc-André?
>>>>> I agree. Just to confirm, do you prefer bh or doing changes like what is
>>>>> done in this series? It looks to me bh can have more easier codes.
>>>> Could it be a good idea just to make disconnect in the char device but
>>>> postphone clean up in the vhost-user-blk (or any other vhost-user
>>>> device) itself? So we are moving the postphone logic and decision from
>>>> the char device to vhost-user device. One of the idea i have is as
>>>> follows:
>>>>    - Put ourself in the INITIALIZATION state
>>>>    - Start these vhost-user "handshake" commands
>>>>    - If we got a disconnect error, perform disconnect, but don't clean up
>>>>      device (it will be clean up on the roll back). I can be done by
>>>>      checking the state in vhost_user_..._disconnect routine or smth like it
>>>
>>> Any issue you saw just using the aio bh as Michael posted above.
>>>
>>> Then we don't need to deal with the silent vhost_dev_stop() and we will have
>>> codes that is much more easier to understand.
>> I've implemented this solution inside
>> hw/block/vhost-user-blk.c:vhost_user_blk_event() in the similar way by
>> using the s->connected field. Looks good and more correct fix ). I have
>> two questions here before i'll rework the fixes:
>> 1. Is it okay to make the similar fix inside vhost_user_blk_event() or
>> we are looking for more generic vhost-user solution? What do you think?
>> 2. For migration we require an additional information that for the
>> vhost-user device it isn't an error, because i'm trigerring the
>> following assert error:
>>    Core was generated by `x86_64-softmmu/qemu-system-x86_64 -nodefaults -no-user-config -M q35,sata=false'.
>>    Program terminated with signal SIGABRT, Aborted.
>>    #0  0x00007fb56e729428 in raise () from /lib/x86_64-linux-gnu/libc.so.6
>>    [Current thread is 1 (Thread 0x7fb486ef5700 (LWP 527734))]
>>
>>    (gdb) bt
>>    #0  0x00007fb56e729428 in raise () from /lib/x86_64-linux-gnu/libc.so.6
>>    #1  0x00007fb56e72b02a in abort () from /lib/x86_64-linux-gnu/libc.so.6
>>    #2  0x00005648ea376ee6 in vhost_log_global_start
>>        (listener=0x5648ece4eb08) at ./hw/virtio/vhost.c:857
>>    #3  0x00005648ea2dde7e in memory_global_dirty_log_start ()
>>        at ./memory.c:2611
>>    #4  0x00005648ea2e68e7 in ram_init_bitmaps (rs=0x7fb4740008c0)
>>        at ./migration/ram.c:2305
>>    #5  0x00005648ea2e698b in ram_init_all (rsp=0x5648eb1f0f20 <ram_state>)
>>        at ./migration/ram.c:2323
>>    #6  0x00005648ea2e6cc5 in ram_save_setup (f=0x5648ec609e00,
>>        opaque=0x5648eb1f0f20 <ram_state>)
>>        at ./migration/ram.c:2436
>>    #7  0x00005648ea67b7d3 in qemu_savevm_state_setup (f=0x5648ec609e00) at
>>        migration/savevm.c:1176
>>    #8  0x00005648ea674511 in migration_thread (opaque=0x5648ec031ff0) at
>>        migration/migration.c:3416
>>    #9  0x00005648ea85d65d in qemu_thread_start (args=0x5648ec6057f0) at
>>        util/qemu-thread-posix.c:519
>>    #10 0x00007fb56eac56ba in start_thread () from
>>        /lib/x86_64-linux-gnu/libpthread.so.0
>>    #11 0x00007fb56e7fb41d in clone () from /lib/x86_64-linux-gnu/libc.so.6
>>    (gdb) frame 2
>>    #2  0x00005648ea376ee6 in vhost_log_global_start
>>       (listener=0x5648ece4eb08) at ./hw/virtio/vhost.c:857
>>    857             abort();
>>    (gdb) list
>>    852     {
>>    853         int r;
>>    854
>>    855         r = vhost_migration_log(listener, true);
>>    856         if (r < 0) {
>>    857             abort();
>>    858         }
>>    859     }
>>    860
>>    861     static void vhost_log_global_stop(MemoryListener *listener)
>> Since bh postphone the clean up, we can't use the ->started field.
>> Do we have any mechanism to get the device type/state in the common
>> vhost_migration_log() routine? So for example for the vhost-user/disconnect
>> device we will be able to return 0. Or should we implement it and introduce
>> it in this patch set?
>>
>> Thanks, Dima.
>>
>>> Thank
>>>
>>>
>>>>    - vhost-user command returns error back to the _start() routine
>>>>    - Rollback in one place in the start() routine, by calling this
>>>>      postphoned clean up for the disconnect
>>>>


