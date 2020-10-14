Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABF5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:18:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74AE7214D8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ute7IgSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74AE7214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSjUK-0003UK-Cw
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 12:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kSjNX-0002aV-6y
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 12:11:51 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46119)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kSjNS-0002TU-T2
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 12:11:50 -0400
Received: by mail-ot1-x342.google.com with SMTP id m11so91990otk.13
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 09:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UBF7OGEBpd17C5YmWo7bC8o1ouVN+xVNM2/IxdBcd6w=;
 b=Ute7IgSXmOL39p8U5FlphJPHtbHWtGm/P9a8Elw3lVK2K+uRvtLKKm0Orc4P9rZ3wo
 ikhQaofY9xzkavF2jJRKA0gmVuJy+etzZU6pfNt057WMJ69CznTUjSSwbb/5sm2Zeqf8
 3Q1i4sholYz3kUMmm6VTxIGwGCgh0yvxbmzgbyP4KA0WWOYPq8pzsIPEhDFs7sRYKEUs
 RpACX2hU5blxSWJP4OnvY0mfohVFxf4KNCIKjnQofZlqurWSV+8fXUvZpslHkQ0UAULq
 7Wrhhydc+xvmiJyl0Ld5p+Zv4r1bfXwGxoz7eQjTziR4ceQDvc/unAUmRc6GHd0gD+hY
 iaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UBF7OGEBpd17C5YmWo7bC8o1ouVN+xVNM2/IxdBcd6w=;
 b=CWzlnsYUcf7cnpHgW/P2dDE93aUMpDHywtcFddvKEZ4oCy2SqONWj1uuORisjw/ZTm
 dJ0G7EqIzZByappUP+611SMaVWTjlukUmis02V24VLsH1vkJg0V400TEJw60lKbEiC6K
 rfJdxGZIQRCLcO4Co8AR6VmJQezMR5OiH718DYpWzsVRykLF3RxCUI+5pPphRA966N6q
 EgwgJfXlQTu/XBtH8SsJIuOaBquY+lON6mRAWMHCUT4I+d92deDaYWFFqP7oRI1idjA0
 G6dbvQ9LPsCAOSYC/EnBeW/QxcMdNELKlBY61IsA4gL7Krk7M7NXNiq5fSlPw60msWpm
 vyYA==
X-Gm-Message-State: AOAM532HJvxgIw+9X706usOj/QGdYLXBSKojdrItRMDybsQNCwKq/o5J
 mPqxDY1hhQAOlPmaPspatJbIR83pUgpM67E75A8=
X-Google-Smtp-Source: ABdhPJxWRDTgHhSbDU4gFXg4MX2znSyQsCv5BBHOqGd8OkituxCpZzfaRCQnxhgz030B8mDgjPWwGxfcQwKkGbCkAjk=
X-Received: by 2002:a05:6830:1201:: with SMTP id
 r1mr3843261otp.326.1602691905439; 
 Wed, 14 Oct 2020 09:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200928131731.69684-1-chenjiajun8@huawei.com>
 <20201006114801.6833a72d@redhat.com>
 <CAFubqFtqXorzk6g9d3A3TFcPnE9eSJKsjfSCK5zwTNX6xtJ3kw@mail.gmail.com>
 <20201014030340-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201014030340-mutt-send-email-mst@kernel.org>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Wed, 14 Oct 2020 12:11:34 -0400
Message-ID: <CAFubqFsax9YabyYLE0E=++gw_iZm5QjQr-OUG_4po7JO4pvQYw@mail.gmail.com>
Subject: Re: [PATCH] vhost-user: add separate memslot counter for vhost-user
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: zhang.zhanghailiang@huawei.com, jasowang@redhat.com,
 QEMU <qemu-devel@nongnu.org>, xiexiangyou@huawei.com,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Jiajun Chen <chenjiajun8@huawei.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 14, 2020 at 3:08 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Oct 13, 2020 at 08:58:59PM -0400, Raphael Norwitz wrote:
> > On Tue, Oct 6, 2020 at 5:48 AM Igor Mammedov <imammedo@redhat.com> wrote:
> > >
> > > On Mon, 28 Sep 2020 21:17:31 +0800
> > > Jiajun Chen <chenjiajun8@huawei.com> wrote:
> > >
> > > > Used_memslots is equal to dev->mem->nregions now, it is true for
> > > > vhost kernel, but not for vhost user, which uses the memory regions
> > > > that have file descriptor. In fact, not all of the memory regions
> > > > have file descriptor.
> > > > It is usefully in some scenarios, e.g. used_memslots is 8, and only
> > > > 5 memory slots can be used by vhost user, it is failed to hot plug
> > > > a new memory RAM because vhost_has_free_slot just returned false,
> > > > but we can hot plug it safely in fact.
> > >
> > > I had an impression that all guest RAM has to be shared with vhost,
> > > so combination of anon and fd based RAM couldn't work.
> > > Am I wrong?
> >
> > I'm not sure about the kernel backend, but I've tested adding anon
> > memory to a VM with a vhost-user-scsi device and it works (eventually
> > the VM crashed, but I could see the guest recognized the anon RAM).
> > The vhost-user code is designed to work with both. I'm not sure I see
> > a use case, but if there is one, this would be a valid issue. Maybe
> > Jiajun or Jianjay can elaborate.
>
> Hmm does not vhost-user skip all regions that do not have an fd?
>
>
>         mr = vhost_user_get_mr_data(reg->userspace_addr, &offset, &fd);
>         if (fd > 0) {
>             if (track_ramblocks) {
>                 assert(*fd_num < VHOST_MEMORY_BASELINE_NREGIONS);
>                 trace_vhost_user_set_mem_table_withfd(*fd_num, mr->name,
>                                                       reg->memory_size,
>                                                       reg->guest_phys_addr,
>                                                       reg->userspace_addr,
>                                                       offset);
>                 u->region_rb_offset[i] = offset;
>                 u->region_rb[i] = mr->ram_block;
>             } else if (*fd_num == VHOST_MEMORY_BASELINE_NREGIONS) {
>                 error_report("Failed preparing vhost-user memory table msg");
>                 return -1;
>             }
>             vhost_user_fill_msg_region(&region_buffer, reg, offset);
>             msg->payload.memory.regions[*fd_num] = region_buffer;
>             fds[(*fd_num)++] = fd;
>         } else if (track_ramblocks) {
>             u->region_rb_offset[i] = 0;
>             u->region_rb[i] = NULL;
>         }
>
>
>
> In your test, is it possible that you were lucky and guest did not send
> any data from anon memory to the device?

Yes - vhost-user skips the region and does not send anon memory to the
device, but it does not fail the hot-add operation.

In my test the fd > 0 check definitely failed and went on to add the
memory without sending it to the backend. I understand why this can be
problematic (it did eventually crash the VM), but it seems like we
allow it as of today. I can't think of a valid reason why you would
want anon and FD ram together, but I figured there may be a reason
since the vhost-user code allows for it. Should we maybe block that
path altogether instead of patching it up?

>
>
>
> > >
> > > >
> > > > --
> > > > ChangeList:
> > > > v3:
> > > > -make used_memslots a member of struct vhost_dev instead of a global static value
> > > it's global resource, so why?
> >
> > I suggested it because I thought it made the code a little cleaner.
> > I'm not opposed to changing it back, or having it stored at the
> > vhost_user level.
>

