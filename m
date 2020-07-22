Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3246BC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 14:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF76820771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 14:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aFsYNsyW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF76820771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyG5r-0003ne-N7
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 10:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jyG4w-00036B-Rn
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 10:50:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28583
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jyG4u-0004WG-Ow
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 10:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595429439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=38nx9F+bAXWxVqy4ge7M01D6/3fGl6p/LxzAZB5uNoE=;
 b=aFsYNsyW1Fw3vWxMd48efPPrvR9Asas1T4meinhaK0UWW2KZxSEluX8JJ0J/fIN2eYem3m
 5Ur5CrZlnyrx3xeRN6MppK5yHj1RCMeXQtO7wE3g9vH7wK2fFlFBqYk8dUgdl4q7HtHMxg
 HhyM8ghlBXHOPPklN93o19eWy/xX4iw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-YsVKxhmjOy6lu5U2FtoDsA-1; Wed, 22 Jul 2020 10:50:37 -0400
X-MC-Unique: YsVKxhmjOy6lu5U2FtoDsA-1
Received: by mail-qk1-f197.google.com with SMTP id i6so1560567qkn.22
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 07:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=38nx9F+bAXWxVqy4ge7M01D6/3fGl6p/LxzAZB5uNoE=;
 b=X0L1eru189ty2iiaJaWz/rF1FJPC6KJicO6Z8lgYBJTA/skVNT6y5guPSaoiSCZfIO
 HSz2GAdiE5+b+zg8ktaN625y+yfUteshRXwpVpSlHJ7xG/BGRvqoYBKyN1G33tCstntE
 SPgKCHBf3DUOZp26p07CAjollKEOZkz9QSkUWJMl243Y6Yr+Z6cNdCf93Sw7DgPCET9a
 swgnER8xKdTlmpR81BsE1TPRWSGtzKuvceGZh2p/AX2D89T3x8hXFO5bj7sj28d8yXFT
 NMSUCLSF1rc3cviJGmLHyfh5RqyZRox3Zx2OqBnBVCniBp7R793iL9BatjmObm2qLt7W
 PWFA==
X-Gm-Message-State: AOAM531mepX7IPUGBnqlthloXG1q9+rWDzJ8dga+3XztlSVDxDj0SnaY
 zCKn0QgvckFaFxNFcNgohFenqVLzbnTjogeaGioz12iJXEOM313dt1hQC5YUoyr0ZtqZ9TbIzjg
 mRLWw1RSvhZvBVlQ=
X-Received: by 2002:a37:a746:: with SMTP id q67mr287514qke.93.1595429437217;
 Wed, 22 Jul 2020 07:50:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySTcMIh0I6nktBvL7zPOyV4ygAjOuuv3asl0tlYvUA9nSAEfBXuBVvQ5D2EJr5ZHoBMGJrZQ==
X-Received: by 2002:a37:a746:: with SMTP id q67mr287492qke.93.1595429436973;
 Wed, 22 Jul 2020 07:50:36 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c8:6f::1f4f])
 by smtp.gmail.com with ESMTPSA id u21sm95811qkk.1.2020.07.22.07.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 07:50:36 -0700 (PDT)
Date: Wed, 22 Jul 2020 10:50:34 -0400
From: Peter Xu <peterx@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v0 0/4] background snapshot
Message-ID: <20200722145034.GZ535743@xz-x1>
References: <20200722081133.29926-1-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200722081133.29926-1-dplotnikov@virtuozzo.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:34:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Hi, Denis,

On Wed, Jul 22, 2020 at 11:11:29AM +0300, Denis Plotnikov wrote:
> Currently where is no way to make a vm snapshot without pausing a vm
> for the whole time until the snapshot is done. So, the problem is
> the vm downtime on snapshoting. The downtime value depends on the vmstate
> size, the major part of which is RAM and the disk performance which is
> used for the snapshot saving.
> 
> The series propose a way to reduce the vm snapshot downtime. This is done
> by saving RAM, the major part of vmstate, in the background when the vm
> is running.
> 
> The background snapshot uses linux UFFD write-protected mode for memory
> page access intercepting. UFFD write-protected mode was added to the linux v5.7.
> If UFFD write-protected mode isn't available the background snapshot rejects to
> run.
> 
> How to use:
> 1. enable background snapshot capability
>    virsh qemu-monitor-command vm --hmp migrate_set_capability background-snapshot on
> 
> 2. stop the vm
>    virsh qemu-monitor-command vm --hmp stop
> 
> 3. Start the external migration to a file
>    virsh qemu-monitor-command cent78-bs --hmp migrate exec:'cat > ./vm_state'
> 
> 4. Wait for the migration finish and check that the migration has completed state.

Thanks for continued working on this project! I have two high level questions
before dig into the patches.

Firstly, is step 2 required?  Can we use a single QMP command to take snapshots
(which can still be a "migrate" command)?

Meanwhile, we might also want to check around the type of backend RAM.  E.g.,
shmem and hugetlbfs are still not supported for uffd-wp (which I'm still
working on).  I didn't check explicitly whether we'll simply fail the migration
for those cases since the uffd ioctls will fail for those kinds of RAM.  It
would be okay if we handle all the ioctl failures gracefully, or it would be
even better if we directly fail when we want to enable live snapshot capability
for a guest who contains other types of ram besides private anonymous memories.

Thanks,

-- 
Peter Xu


