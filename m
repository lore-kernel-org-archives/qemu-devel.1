Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C40EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 07:09:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBE822072C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 07:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDQ9Czg8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE822072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSaul-0001r7-Qd
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 03:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kSatt-0001FW-Ip
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 03:08:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48863)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kSatp-0004pQ-K1
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 03:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602659314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1T2rTKu/BBFjHY037MK6cP6OPT1t5yWtb/2w0MYRBbk=;
 b=SDQ9Czg8Lp5cJtLb2Qm+uAChGpCHnbPiq3LfHsgD/yOL+kli6sBH0gXH568XKUikU4EjvC
 S9Q5ATy0rxYgDmCzbNtupKSkCrkRNMJIc74jO5l49Rw4CN5LBt8sVSGsw83WwGanzMeRKe
 9wWiuE9Tyui0hh76fja7krLNeEgLm5w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-AKNcm6afOWyMZ9Rp4HsgIg-1; Wed, 14 Oct 2020 03:08:32 -0400
X-MC-Unique: AKNcm6afOWyMZ9Rp4HsgIg-1
Received: by mail-wm1-f69.google.com with SMTP id r19so286075wmh.9
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 00:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1T2rTKu/BBFjHY037MK6cP6OPT1t5yWtb/2w0MYRBbk=;
 b=cLnMyBERxfPEzTW4R9PxvCmtRAZb2Yq8T6525sp4gz9g2p5LHKyx1tk3Gx7NZMkBvm
 xeSEG1wmKFEgPp6EfuAVdTaFp9+GHJkQ0Zd2iT+Bd4fFxTxRsPDxk3Tb8dfEFlMu25Pm
 5/dm6hBbDufqDm5h/pB+IS1bha9y2XsgaQCc2vAHswul1hnhp6V1fAHvXMS3fT/zoYc6
 Rnht+1Fuk+DC2gnXyGqAi7gOYy3M6cn9XDLreB32clRIzmuUdHiyu45kTog/IbL6daEf
 3WVCFwa2/tsIltuhUMgEbrYIks7SQtYBd/5UyWwyKUvN47TFtv5TYz//CXPpqZoZu//B
 fmVA==
X-Gm-Message-State: AOAM5331imP6LasxrZm5xODfGH83erRb8oFEKaXEd7+hMcmDkmeCOVvO
 LfSqVBAJhR+S0sk2+bwqgqXf/TI/TEP9Oo0USiWKdY8zzBYMELs2wFLaDJNR25csPWdBsmw2Qfs
 tbtwlKC17T7Onsh0=
X-Received: by 2002:adf:dd50:: with SMTP id u16mr3891443wrm.419.1602659311685; 
 Wed, 14 Oct 2020 00:08:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEsBiKddHybC+fJncFv40gU+kdrnCU2cjU+FppgeHVCH5OEMwDE+m/k24h9OSMvHAnpvgFzg==
X-Received: by 2002:adf:dd50:: with SMTP id u16mr3891412wrm.419.1602659311456; 
 Wed, 14 Oct 2020 00:08:31 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id w5sm2268655wmg.42.2020.10.14.00.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 00:08:30 -0700 (PDT)
Date: Wed, 14 Oct 2020 03:08:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: Re: [PATCH] vhost-user: add separate memslot counter for vhost-user
Message-ID: <20201014030340-mutt-send-email-mst@kernel.org>
References: <20200928131731.69684-1-chenjiajun8@huawei.com>
 <20201006114801.6833a72d@redhat.com>
 <CAFubqFtqXorzk6g9d3A3TFcPnE9eSJKsjfSCK5zwTNX6xtJ3kw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFubqFtqXorzk6g9d3A3TFcPnE9eSJKsjfSCK5zwTNX6xtJ3kw@mail.gmail.com>
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

On Tue, Oct 13, 2020 at 08:58:59PM -0400, Raphael Norwitz wrote:
> On Tue, Oct 6, 2020 at 5:48 AM Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > On Mon, 28 Sep 2020 21:17:31 +0800
> > Jiajun Chen <chenjiajun8@huawei.com> wrote:
> >
> > > Used_memslots is equal to dev->mem->nregions now, it is true for
> > > vhost kernel, but not for vhost user, which uses the memory regions
> > > that have file descriptor. In fact, not all of the memory regions
> > > have file descriptor.
> > > It is usefully in some scenarios, e.g. used_memslots is 8, and only
> > > 5 memory slots can be used by vhost user, it is failed to hot plug
> > > a new memory RAM because vhost_has_free_slot just returned false,
> > > but we can hot plug it safely in fact.
> >
> > I had an impression that all guest RAM has to be shared with vhost,
> > so combination of anon and fd based RAM couldn't work.
> > Am I wrong?
> 
> I'm not sure about the kernel backend, but I've tested adding anon
> memory to a VM with a vhost-user-scsi device and it works (eventually
> the VM crashed, but I could see the guest recognized the anon RAM).
> The vhost-user code is designed to work with both. I'm not sure I see
> a use case, but if there is one, this would be a valid issue. Maybe
> Jiajun or Jianjay can elaborate.

Hmm does not vhost-user skip all regions that do not have an fd?


        mr = vhost_user_get_mr_data(reg->userspace_addr, &offset, &fd);
        if (fd > 0) {
            if (track_ramblocks) {
                assert(*fd_num < VHOST_MEMORY_BASELINE_NREGIONS);
                trace_vhost_user_set_mem_table_withfd(*fd_num, mr->name,
                                                      reg->memory_size,
                                                      reg->guest_phys_addr,
                                                      reg->userspace_addr,
                                                      offset);
                u->region_rb_offset[i] = offset;
                u->region_rb[i] = mr->ram_block;
            } else if (*fd_num == VHOST_MEMORY_BASELINE_NREGIONS) {
                error_report("Failed preparing vhost-user memory table msg");
                return -1;
            }
            vhost_user_fill_msg_region(&region_buffer, reg, offset);
            msg->payload.memory.regions[*fd_num] = region_buffer;
            fds[(*fd_num)++] = fd;
        } else if (track_ramblocks) {
            u->region_rb_offset[i] = 0;
            u->region_rb[i] = NULL;
        }



In your test, is it possible that you were lucky and guest did not send
any data from anon memory to the device?



> >
> > >
> > > --
> > > ChangeList:
> > > v3:
> > > -make used_memslots a member of struct vhost_dev instead of a global static value
> > it's global resource, so why?
> 
> I suggested it because I thought it made the code a little cleaner.
> I'm not opposed to changing it back, or having it stored at the
> vhost_user level.


