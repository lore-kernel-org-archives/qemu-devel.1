Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28B8C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 17:22:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A31F2173E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 17:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxRcE9br"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A31F2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSkU0-0004ct-Ky
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 13:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kSkTK-0003zm-51
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 13:21:54 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:39660)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kSkTI-00039z-95
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 13:21:53 -0400
Received: by mail-oi1-x242.google.com with SMTP id c13so3999200oiy.6
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 10:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xUw/ujGTJDuigT88eXSC9cYH2z8vhSXDZ6GG9hA21LE=;
 b=PxRcE9brdW0OnXwGjJHPXSiarPbC+4Af6R+zynuq1eh+5+mY4bPOaoBUs6VZThClFW
 V6Kb6Qs2A5KpeWc8x4NJGAwpQLJcZGfrt0moOJNUT5hwYld0r33yNO0QZyDYjYwMzlQP
 bpkCCNglBqg7omz6uiee2WrT3djZG9rKGhZEHQze7vNhiQjbPg/1bXUkZz8yBkERqMRY
 r+XK4N/L8WIdP3jMDOayqvA4orEo+yAIVBqTsDTNHysRCmpmcVuNN6phL3lOHwxtSFsk
 U4+NA91Xt3llP4LE2dsj1HMvMXv8NyRqJ1ZN+0UvsPOlgSLfg8dQwqHMdnJnvU3A7XrN
 Uvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xUw/ujGTJDuigT88eXSC9cYH2z8vhSXDZ6GG9hA21LE=;
 b=gF7DvnXO5YdM4UuZ0aPQ2trc25JAkxC0oDWK9bzblGhdpiLRJHfEHV3Rjq+JUC5nIh
 3mAiqdSP+yVoTQg2sEl+aDqSi0jn7kwKpdT5ip8ioqk2RUME2EJg86Jtg+QT6mvMPESF
 LE1xouM6eybEvwvUfZG9RopR4A95muFsJ2tkD9CDoPMxnd0qopo6aLLwFfVmxlgfEdMQ
 e7A9Xo3U2gb79t22+9h/Pi2Fvq7vJwG1AtBJEShtRtq7i0w2Q0liNVyb1tVGH/IBn9Fz
 YoK0ldKgx6g3KLBiLsAksuB9Q5CPqlyeRoYykDvqlAuqdnQHSdKMuWE2Mqr9TBXlNOET
 68Gg==
X-Gm-Message-State: AOAM533FaIB3HhUMPy7iYNwaR+MMabomY7f1PZVNcSOfxrgevZDK2Kqj
 UBB/W0epYkj487O6uQlrwyLbJjjxr5eaOWCrcmQ=
X-Google-Smtp-Source: ABdhPJyHl1kJHMpLHXtbHUYVVd9d8tx+Bx17lo22nwAvynjkQb2w6t1GkssG6iMeYQFdXndOPVnuPK6phB34FVDv0DA=
X-Received: by 2002:aca:724a:: with SMTP id p71mr236164oic.157.1602696110712; 
 Wed, 14 Oct 2020 10:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200928131731.69684-1-chenjiajun8@huawei.com>
 <20201006114801.6833a72d@redhat.com>
 <CAFubqFtqXorzk6g9d3A3TFcPnE9eSJKsjfSCK5zwTNX6xtJ3kw@mail.gmail.com>
 <20201014030340-mutt-send-email-mst@kernel.org>
 <CAFubqFsax9YabyYLE0E=++gw_iZm5QjQr-OUG_4po7JO4pvQYw@mail.gmail.com>
 <20201014121306-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201014121306-mutt-send-email-mst@kernel.org>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Wed, 14 Oct 2020 13:21:39 -0400
Message-ID: <CAFubqFvKdWzQi7ufyzz+SFEuQT6K++5foznobCYDRB8AAusnug@mail.gmail.com>
Subject: Re: [PATCH] vhost-user: add separate memslot counter for vhost-user
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-oi1-x242.google.com
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

On Wed, Oct 14, 2020 at 12:26 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Oct 14, 2020 at 12:11:34PM -0400, Raphael Norwitz wrote:
> > On Wed, Oct 14, 2020 at 3:08 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, Oct 13, 2020 at 08:58:59PM -0400, Raphael Norwitz wrote:
> > > > On Tue, Oct 6, 2020 at 5:48 AM Igor Mammedov <imammedo@redhat.com> wrote:
> > > > >
> > > > > On Mon, 28 Sep 2020 21:17:31 +0800
> > > > > Jiajun Chen <chenjiajun8@huawei.com> wrote:
> > > > >
> > > > > > Used_memslots is equal to dev->mem->nregions now, it is true for
> > > > > > vhost kernel, but not for vhost user, which uses the memory regions
> > > > > > that have file descriptor. In fact, not all of the memory regions
> > > > > > have file descriptor.
> > > > > > It is usefully in some scenarios, e.g. used_memslots is 8, and only
> > > > > > 5 memory slots can be used by vhost user, it is failed to hot plug
> > > > > > a new memory RAM because vhost_has_free_slot just returned false,
> > > > > > but we can hot plug it safely in fact.
> > > > >
> > > > > I had an impression that all guest RAM has to be shared with vhost,
> > > > > so combination of anon and fd based RAM couldn't work.
> > > > > Am I wrong?
> > > >
> > > > I'm not sure about the kernel backend, but I've tested adding anon
> > > > memory to a VM with a vhost-user-scsi device and it works (eventually
> > > > the VM crashed, but I could see the guest recognized the anon RAM).
> > > > The vhost-user code is designed to work with both. I'm not sure I see
> > > > a use case, but if there is one, this would be a valid issue. Maybe
> > > > Jiajun or Jianjay can elaborate.
> > >
> > > Hmm does not vhost-user skip all regions that do not have an fd?
> > >
> > >
> > >         mr = vhost_user_get_mr_data(reg->userspace_addr, &offset, &fd);
> > >         if (fd > 0) {
> > >             if (track_ramblocks) {
> > >                 assert(*fd_num < VHOST_MEMORY_BASELINE_NREGIONS);
> > >                 trace_vhost_user_set_mem_table_withfd(*fd_num, mr->name,
> > >                                                       reg->memory_size,
> > >                                                       reg->guest_phys_addr,
> > >                                                       reg->userspace_addr,
> > >                                                       offset);
> > >                 u->region_rb_offset[i] = offset;
> > >                 u->region_rb[i] = mr->ram_block;
> > >             } else if (*fd_num == VHOST_MEMORY_BASELINE_NREGIONS) {
> > >                 error_report("Failed preparing vhost-user memory table msg");
> > >                 return -1;
> > >             }
> > >             vhost_user_fill_msg_region(&region_buffer, reg, offset);
> > >             msg->payload.memory.regions[*fd_num] = region_buffer;
> > >             fds[(*fd_num)++] = fd;
> > >         } else if (track_ramblocks) {
> > >             u->region_rb_offset[i] = 0;
> > >             u->region_rb[i] = NULL;
> > >         }
> > >
> > >
> > >
> > > In your test, is it possible that you were lucky and guest did not send
> > > any data from anon memory to the device?
> >
> > Yes - vhost-user skips the region and does not send anon memory to the
> > device, but it does not fail the hot-add operation.
> >
> > In my test the fd > 0 check definitely failed and went on to add the
> > memory without sending it to the backend. I understand why this can be
> > problematic (it did eventually crash the VM), but it seems like we
> > allow it as of today. I can't think of a valid reason why you would
> > want anon and FD ram together, but I figured there may be a reason
> > since the vhost-user code allows for it. Should we maybe block that
> > path altogether instead of patching it up?
>
>
> Hmm where do we patch it up? Reason we might have non FD MRs is IIUC
> due to things like IO regions...

The issue is that today such non FD MRs count towards the vhost-user
max ramslots limit even though there is no good reason for them to. By
"patching it up", I mean accepting this change, which makes it so that
the vhost-user max ramslots limit only applies to FD RAM regions.

>
>
> > >
> > >
> > >
> > > > >
> > > > > >
> > > > > > --
> > > > > > ChangeList:
> > > > > > v3:
> > > > > > -make used_memslots a member of struct vhost_dev instead of a global static value
> > > > > it's global resource, so why?
> > > >
> > > > I suggested it because I thought it made the code a little cleaner.
> > > > I'm not opposed to changing it back, or having it stored at the
> > > > vhost_user level.
> > >
>

