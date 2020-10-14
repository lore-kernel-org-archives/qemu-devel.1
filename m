Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2912FC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 17:56:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44BAC2222A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 17:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CsNukzPH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44BAC2222A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSl0S-0004J2-9E
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 13:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kSkzU-0003n2-7g
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 13:55:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50207)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kSkzR-00074a-I6
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 13:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602698104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tq/N+/zfOsdHriu0JWKFaVWI3EzgfYb9YRXl+7khpyc=;
 b=CsNukzPHKHsMI9JD1X+6B/5aUP5JljUYDAXmU3lCjFFsXLYmN6eFBfB9KXuPmQAIF/gLL8
 9omQ+25uDc+8/3QRwabVixNhpW+wQIfV+tfBUcu7Z/e2eJwzJDAqAft4se12hQIOkN0jOq
 EjGVR3iFt3QIbLf1B3vvXndMS4RMQek=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-Zy0oOGdJNlm-OBCWeTDpig-1; Wed, 14 Oct 2020 13:55:03 -0400
X-MC-Unique: Zy0oOGdJNlm-OBCWeTDpig-1
Received: by mail-wm1-f72.google.com with SMTP id 73so169400wma.5
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 10:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tq/N+/zfOsdHriu0JWKFaVWI3EzgfYb9YRXl+7khpyc=;
 b=fO7dQ3LGzxyRpD87n8Rjuegzixw9tnjOSX95gAOv3he/maW1ntxQsEJjqDwS6Xz1PN
 9iAFO2WjXVFTBJcLKYrgJs4/VPR8YD0j28m/ufq63gZJ2G74YlUbev2ajkGhmBIiAYWs
 kqOIV8HVEuh2dgsU9Vj/Z0qf2XYSJD/ox4V538i8gjcwuHiyzF0s4gJNx0S1JpfnbDhv
 zrqtrtSsjdXCngS7TX6ugepn+F4yIAdh5Qmm/xWa0VjA4Gmoy0Jz4CQNR7JZ6NKKfS0t
 bu11YpBx2bmO/aTq0U1TjCzsisSgEeGWDn0EZMr1dQtoOKqsfQLoR4Lwn6i+fPWaHCik
 bdUA==
X-Gm-Message-State: AOAM533IMYcApsSwf6mtwubqIcSAZupusx00bOTr9DmtzqUIyGlDGTPi
 Rwm95IrGFcLE28j5wLGe77pprxQRT7exVuKcq0H9+Xw37UZpUtRH4KQ1wIH8p7Yxs+aZXm9+8BE
 /+U6loeELTmIxyBA=
X-Received: by 2002:a7b:cd9a:: with SMTP id y26mr40730wmj.101.1602698101942;
 Wed, 14 Oct 2020 10:55:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTntcdvyxf2p+weMqud+EzqSFKWwBMdj4sSkLdoQWCfkPaw5Q5vteR1lDfFlqbAQZFYE6p5g==
X-Received: by 2002:a7b:cd9a:: with SMTP id y26mr40714wmj.101.1602698101702;
 Wed, 14 Oct 2020 10:55:01 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id f63sm245221wme.38.2020.10.14.10.55.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 10:55:01 -0700 (PDT)
Date: Wed, 14 Oct 2020 13:54:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: Re: [PATCH] vhost-user: add separate memslot counter for vhost-user
Message-ID: <20201014135313-mutt-send-email-mst@kernel.org>
References: <20200928131731.69684-1-chenjiajun8@huawei.com>
 <20201006114801.6833a72d@redhat.com>
 <CAFubqFtqXorzk6g9d3A3TFcPnE9eSJKsjfSCK5zwTNX6xtJ3kw@mail.gmail.com>
 <20201014030340-mutt-send-email-mst@kernel.org>
 <CAFubqFsax9YabyYLE0E=++gw_iZm5QjQr-OUG_4po7JO4pvQYw@mail.gmail.com>
 <20201014121306-mutt-send-email-mst@kernel.org>
 <CAFubqFvKdWzQi7ufyzz+SFEuQT6K++5foznobCYDRB8AAusnug@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFubqFvKdWzQi7ufyzz+SFEuQT6K++5foznobCYDRB8AAusnug@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: zhang.zhanghailiang@huawei.com, jasowang@redhat.com,
 QEMU <qemu-devel@nongnu.org>, xiexiangyou@huawei.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Jiajun Chen <chenjiajun8@huawei.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 14, 2020 at 01:21:39PM -0400, Raphael Norwitz wrote:
> On Wed, Oct 14, 2020 at 12:26 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Oct 14, 2020 at 12:11:34PM -0400, Raphael Norwitz wrote:
> > > On Wed, Oct 14, 2020 at 3:08 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Oct 13, 2020 at 08:58:59PM -0400, Raphael Norwitz wrote:
> > > > > On Tue, Oct 6, 2020 at 5:48 AM Igor Mammedov <imammedo@redhat.com> wrote:
> > > > > >
> > > > > > On Mon, 28 Sep 2020 21:17:31 +0800
> > > > > > Jiajun Chen <chenjiajun8@huawei.com> wrote:
> > > > > >
> > > > > > > Used_memslots is equal to dev->mem->nregions now, it is true for
> > > > > > > vhost kernel, but not for vhost user, which uses the memory regions
> > > > > > > that have file descriptor. In fact, not all of the memory regions
> > > > > > > have file descriptor.
> > > > > > > It is usefully in some scenarios, e.g. used_memslots is 8, and only
> > > > > > > 5 memory slots can be used by vhost user, it is failed to hot plug
> > > > > > > a new memory RAM because vhost_has_free_slot just returned false,
> > > > > > > but we can hot plug it safely in fact.
> > > > > >
> > > > > > I had an impression that all guest RAM has to be shared with vhost,
> > > > > > so combination of anon and fd based RAM couldn't work.
> > > > > > Am I wrong?
> > > > >
> > > > > I'm not sure about the kernel backend, but I've tested adding anon
> > > > > memory to a VM with a vhost-user-scsi device and it works (eventually
> > > > > the VM crashed, but I could see the guest recognized the anon RAM).
> > > > > The vhost-user code is designed to work with both. I'm not sure I see
> > > > > a use case, but if there is one, this would be a valid issue. Maybe
> > > > > Jiajun or Jianjay can elaborate.
> > > >
> > > > Hmm does not vhost-user skip all regions that do not have an fd?
> > > >
> > > >
> > > >         mr = vhost_user_get_mr_data(reg->userspace_addr, &offset, &fd);
> > > >         if (fd > 0) {
> > > >             if (track_ramblocks) {
> > > >                 assert(*fd_num < VHOST_MEMORY_BASELINE_NREGIONS);
> > > >                 trace_vhost_user_set_mem_table_withfd(*fd_num, mr->name,
> > > >                                                       reg->memory_size,
> > > >                                                       reg->guest_phys_addr,
> > > >                                                       reg->userspace_addr,
> > > >                                                       offset);
> > > >                 u->region_rb_offset[i] = offset;
> > > >                 u->region_rb[i] = mr->ram_block;
> > > >             } else if (*fd_num == VHOST_MEMORY_BASELINE_NREGIONS) {
> > > >                 error_report("Failed preparing vhost-user memory table msg");
> > > >                 return -1;
> > > >             }
> > > >             vhost_user_fill_msg_region(&region_buffer, reg, offset);
> > > >             msg->payload.memory.regions[*fd_num] = region_buffer;
> > > >             fds[(*fd_num)++] = fd;
> > > >         } else if (track_ramblocks) {
> > > >             u->region_rb_offset[i] = 0;
> > > >             u->region_rb[i] = NULL;
> > > >         }
> > > >
> > > >
> > > >
> > > > In your test, is it possible that you were lucky and guest did not send
> > > > any data from anon memory to the device?
> > >
> > > Yes - vhost-user skips the region and does not send anon memory to the
> > > device, but it does not fail the hot-add operation.
> > >
> > > In my test the fd > 0 check definitely failed and went on to add the
> > > memory without sending it to the backend. I understand why this can be
> > > problematic (it did eventually crash the VM), but it seems like we
> > > allow it as of today. I can't think of a valid reason why you would
> > > want anon and FD ram together, but I figured there may be a reason
> > > since the vhost-user code allows for it. Should we maybe block that
> > > path altogether instead of patching it up?
> >
> >
> > Hmm where do we patch it up? Reason we might have non FD MRs is IIUC
> > due to things like IO regions...
> 
> The issue is that today such non FD MRs count towards the vhost-user
> max ramslots limit even though there is no good reason for them to. By
> "patching it up", I mean accepting this change, which makes it so that
> the vhost-user max ramslots limit only applies to FD RAM regions.

I don't really remember, maybe one can get these things with things
like ROMs ...

> >
> >
> > > >
> > > >
> > > >
> > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > ChangeList:
> > > > > > > v3:
> > > > > > > -make used_memslots a member of struct vhost_dev instead of a global static value
> > > > > > it's global resource, so why?
> > > > >
> > > > > I suggested it because I thought it made the code a little cleaner.
> > > > > I'm not opposed to changing it back, or having it stored at the
> > > > > vhost_user level.
> > > >
> >


