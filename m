Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7226DC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:31:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B504824682
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gdPLBUry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B504824682
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXnQ7-0007Sp-FI
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 11:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mszeredi@redhat.com>)
 id 1kXnIZ-0006zM-O0
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:23:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32270)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mszeredi@redhat.com>)
 id 1kXnIX-00071X-TV
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603898616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lfY6OhC30XlnKIFtlJz6TSAvke+GkxhljhSyQ5d9N/8=;
 b=gdPLBUry6TfQHsIsL1bmyuRG+lDN70FRNjvWlmUZgoZDpAjaolAM2wZhKw3Otc5LY8U/ra
 1wmllYiKHKRLK2NidAWeEBx3/jEwjuIEBiCnSbqBhHnxtVE1IV06OUJ6vqhBuFCHM2g3UZ
 Nhsl1AjJgUEXsv6BXWbEIscxKBWbItQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-man61lE_O_y16xcF1hpaVA-1; Wed, 28 Oct 2020 11:23:32 -0400
X-MC-Unique: man61lE_O_y16xcF1hpaVA-1
Received: by mail-qt1-f200.google.com with SMTP id r4so3074823qta.9
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 08:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lfY6OhC30XlnKIFtlJz6TSAvke+GkxhljhSyQ5d9N/8=;
 b=DRa9jt2vLCn+bibL3P/aFAAihNZVC32NzuX7csU8EuRTq/6LEJ4iQ2DwQ71CPvet9v
 mnxW/NTMIS3brtrIGy1aYGZzMBlPzSO9m4ekAb5p5tPzutZ8YFKwZFyE0vEB8F1ABidH
 UlhwClpBKH1iV06MVI/RFdPhcu6mq8cOluw5GLO/dKVyiGZPjp66yBBRBxd9hLel1H62
 tM0wJSCmtLRnWQQ3ofX8WFI4uXMYRCYJYf4ywFveqLEC1yUQppqZ4Rn1Y5C9exuWHECF
 w7jGLhZZCmqQgluoU1NhPtK6y29eYnbnSQFBqrKf+b8sGnDSFSuzYdLPb02ig91hnsE1
 jDmw==
X-Gm-Message-State: AOAM5322F9j33BQTGIqurzfKMlR9rApyL1OnNZ5QtEUTZ7QI1IdlKGWK
 7XyoyWYA+yj7v7RheSvqzNVv19BUnUzHZpW9NBYupZuxwIq4p8msG8+XMlN7Is3MtJh8GZPrMTM
 pi3FGMioVzCZ5NjoBRD49QUk7risiyf4=
X-Received: by 2002:a05:620a:1024:: with SMTP id
 a4mr7985795qkk.390.1603898612134; 
 Wed, 28 Oct 2020 08:23:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyi6GhgbLMfn5mdFiOYA4PL9ThhtB1HTYENZ093XnqcSAEqy7ph4sJYW7Yyvq+C3zDO2L+/61pqNMRwBjITrMs=
X-Received: by 2002:a05:620a:1024:: with SMTP id
 a4mr7985769qkk.390.1603898611880; 
 Wed, 28 Oct 2020 08:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <160374054442.22414.10832953989449611268.stgit@gimli.home>
 <CAFEAcA8yBrUH-Bqe7oNhBKqtyeUNw0xVA9aKm8DJFE-WLzLTwQ@mail.gmail.com>
 <20201027200021.00fac851@x1.home> <20201028091859.GA3701@work-vm>
In-Reply-To: <20201028091859.GA3701@work-vm>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Wed, 28 Oct 2020 16:23:21 +0100
Message-ID: <CAOssrKcDQ1_Y1uYTz1ROOQ=Ljh0oM9ymQ_0TEbO_RvWsdRpC8w@mail.gmail.com>
Subject: Re: [PULL 00/32] VFIO updates 2020-10-26 (for QEMU 5.2 soft-freeze)
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mszeredi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mszeredi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:51:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Artem Polyakov <artemp@nvidia.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhengui li <lizhengui@huawei.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Zhi Wang <zhi.wang.linux@gmail.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Neo Jia <cjia@nvidia.com>, Amey Narkhede <ameynarkhede03@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 28, 2020 at 10:19 AM Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> > I'm not comfortable trying to update Max's series to try to determine
> > if FUSE_SUBMOUNTS can be interchanged with FUSE_ATTR_FLAGS, where the

FUSE_SUBMOUNTS is the correct one, FUSE_ATTR_FLAGS was never merged
into mainline linux.

The only difference is that FUSE_ATTR_FLAGS was meant to be negotiated
(AFAIR), while FUSE_SUBMOUNTS is just announcing that the client
supports submounts and will honour the FUSE_ATTR_SUBMOUNT flag from
the server.

Thanks,
Miklos


