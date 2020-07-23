Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE39C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 17:40:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A8A420771
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 17:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="is2gxOs1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A8A420771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyfDA-0003NE-P0
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 13:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jyfCL-0002re-TJ
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 13:40:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45755
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jyfCJ-0002rF-BQ
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 13:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595525997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wgF/HKix6CRFS9CWzpsEpdrDfijYnYElI7+xSeJelDo=;
 b=is2gxOs1nMqyY9malSn0rGSALEed2QEZ7nNgbwzjtgETgHJVn1LP89pySfH8X/DQjmB5Kg
 4TZcUWbIl5552rqH2d1dirpGHvGyUQQJ2qjMncQUIMDs7huX38ibNaYgdbH89ZxWLC3zWQ
 hwGQ77hGMKSpYub1ErIk7kPyU+p98zw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-9-c0EJGBPB2QErYoh9N3mA-1; Thu, 23 Jul 2020 13:39:55 -0400
X-MC-Unique: 9-c0EJGBPB2QErYoh9N3mA-1
Received: by mail-qt1-f199.google.com with SMTP id g6so4191825qtr.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 10:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=wgF/HKix6CRFS9CWzpsEpdrDfijYnYElI7+xSeJelDo=;
 b=JxzHTUK3ELhRKbEHiE6aw1NisL35m3b8tPhF9pczGFyol/p+SQM94wAW8qmhdGp020
 qYm/VqYfd0n/bablgub+yRzYCETze8btX8Bmv+gyySbpGblVbfT49q5H9MnQzxFzyAQC
 3Szq/gABd/7AnfdIBv8IJb5yQyz/6oEPQEM3R71j925L7OADCkNuLtkMz8KnI/fLwEqQ
 06xS47PV2Ca3Omh2X0zbmr/yJBZscyvvXaHde9qmSkIMubYpD1hon097n1+SLPxbjcXS
 OOZPfHN5q4k514Hgh3sphDG7fAtlEjwXYfRiXAgZWYpXu5hbfLDwkyLvXkEw5gLouhSK
 1fPg==
X-Gm-Message-State: AOAM5332TIGCA45Ap+5Uno537mR2azVx73dqg8carla6N+Z8Gutz/pfs
 ZvNa8Zro3eZ+rGgLbQ2w+fSto7hHZ1W9fudUK9NMOrWyd9Z2NL5F2pV6wToc1cfFsMDJZ3QI4bO
 rK9T1Oxo4tOfhhjA=
X-Received: by 2002:ae9:e505:: with SMTP id w5mr6224065qkf.282.1595525995040; 
 Thu, 23 Jul 2020 10:39:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgBWA6bs6R0X04Ea2Q78U6KS9D1hkJ5Lgxj/odCcMwDGbnk7H49UwYS52WZIHh4e5i2zWoNQ==
X-Received: by 2002:ae9:e505:: with SMTP id w5mr6224034qkf.282.1595525994725; 
 Thu, 23 Jul 2020 10:39:54 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c8:6f::1f4f])
 by smtp.gmail.com with ESMTPSA id o37sm3435291qte.9.2020.07.23.10.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 10:39:53 -0700 (PDT)
Date: Thu, 23 Jul 2020 13:39:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v0 0/4] background snapshot
Message-ID: <20200723173952.GB831087@xz-x1>
References: <20200722081133.29926-1-dplotnikov@virtuozzo.com>
 <20200722145034.GZ535743@xz-x1>
 <8146768f-7804-e239-41a0-3f7997f6b75d@virtuozzo.com>
 <bf3fd4f4-31a1-9d13-94b0-e3b026edb6b1@virtuozzo.com>
 <20200722163009.GA535743@xz-x1>
 <a34af0de-a6ce-59f1-13bf-4f99e0e41c55@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <a34af0de-a6ce-59f1-13bf-4f99e0e41c55@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 22:13:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: quintela@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, den@openvz.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 23, 2020 at 11:03:55AM +0300, Denis Plotnikov wrote:
> 
> 
> On 22.07.2020 19:30, Peter Xu wrote:
> > On Wed, Jul 22, 2020 at 06:47:44PM +0300, Denis Plotnikov wrote:
> > > 
> > > On 22.07.2020 18:42, Denis Plotnikov wrote:
> > > > 
> > > > On 22.07.2020 17:50, Peter Xu wrote:
> > > > > Hi, Denis,
> > > > Hi, Peter
> > > > > ...
> > > > > > How to use:
> > > > > > 1. enable background snapshot capability
> > > > > >      virsh qemu-monitor-command vm --hmp migrate_set_capability
> > > > > > background-snapshot on
> > > > > > 
> > > > > > 2. stop the vm
> > > > > >      virsh qemu-monitor-command vm --hmp stop
> > > > > > 
> > > > > > 3. Start the external migration to a file
> > > > > >      virsh qemu-monitor-command cent78-bs --hmp migrate exec:'cat
> > > > > > > ./vm_state'
> > > > > > 4. Wait for the migration finish and check that the migration
> > > > > > has completed state.
> > > > > Thanks for continued working on this project! I have two high level
> > > > > questions
> > > > > before dig into the patches.
> > > > > 
> > > > > Firstly, is step 2 required?  Can we use a single QMP command to
> > > > > take snapshots
> > > > > (which can still be a "migrate" command)?
> > > > With this series it is required, but steps 2 and 3 should be merged into
> > > > a single one.
> > I'm not sure whether you're talking about the disk snapshot operations, anyway
> > yeah it'll be definitely good if we merge them into one in the next version.
> 
> After thinking for a while, I remembered why I split these two steps.
> The vm snapshot consists of two parts: disk(s) snapshot(s) and vmstate.
> With migrate command we save the vmstate only. So, the steps to save
> the whole vm snapshot is the following:
> 
> 2. stop the vm
>     virsh qemu-monitor-command vm --hmp stop
> 
> 2.1. Make a disk snapshot, something like
>     virsh qemu-monitor-command vm --hmp snapshot_blkdev drive-scsi0-0-0-0 ./new_data
> 3. Start the external migration to a file
>     virsh qemu-monitor-command vm --hmp migrate exec:'cat ./vm_state'
> 
> In this example, vm snapshot consists of two files: vm_state and the disk file. new_data will contain all new disk data written since [2.1.] executing.

But that's slightly different to the current interface of savevm and loadvm
which only requires a snapshot name, am I right?  Now we need both a snapshot
name (of the vmstate) and the name of the new snapshot image.

I'm not familiar with qemu image snapshots... my understanding is that current
snapshot (save_snapshot) used internal image snapshots, while in this proposal
you want the live snapshot to use extrenal snapshots.  Is there any criteria on
making this decision/change?

Thanks,

-- 
Peter Xu


