Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E773C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD80021531
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHkLACqu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD80021531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNG3E-0001zw-QI
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 09:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mszeredi@redhat.com>)
 id 1kNG24-00011x-BT
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 09:51:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47733)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mszeredi@redhat.com>)
 id 1kNG22-00034o-LZ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 09:51:03 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601387461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rtSFUYByHhQaoMaVJTnkOkgKM4EJfs4sYnhnO0cykzs=;
 b=CHkLACquDbINVPgPbh4HtChQDWwCkweWZ8hIHOyv3/CQdjmiTjDZK/MhQwaw6AjFZrxkCS
 arda9D8mg9fyiE7s7gL3TtXsoPXPgUZVDDZUn1kSEt5Zjipp/x34MZh/d4gNdPvDNsCUjE
 8rdmyqHjSVlX/Y/tnEvmWS9CH6JktDE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-Dyxm4IbQN7KW6yfd6eAm7A-1; Tue, 29 Sep 2020 09:49:16 -0400
X-MC-Unique: Dyxm4IbQN7KW6yfd6eAm7A-1
Received: by mail-qt1-f197.google.com with SMTP id 60so2991791qtf.21
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 06:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rtSFUYByHhQaoMaVJTnkOkgKM4EJfs4sYnhnO0cykzs=;
 b=uYawku2IiNnxk6mVPNxo8unokTqVgnV0E2FzI8Bf5oyIaRPC6Hg8dsYEwmnG3b3OqJ
 xkKOsNgQ1LwQipkfxR8LwuCD31mOfTAC3fI6hE0xGqfylIupmi5dokeTuvGAis+HdBPl
 fdXiwC/KicPOODQWLasWaY6Q2qB2vBrnDR9ZMBsfXCJfW1vwW2/32SDkphwlYIVHebUB
 5ZNHVUtheafeY/pFD7Ynb4gn+xqvxjVc3uIHgRMzBpAMtfWB8LHA/tVlPV500w4ENr7t
 yvLOG2/nJCow+B39gZSqoJELBnUdJ+dHsevIVjLCf9exzX2T7gbuWNDDiSIv9SjmBTF0
 VIng==
X-Gm-Message-State: AOAM531CczWmyugmhbeoA/8N1DhTWqouK1K6gyW4IZLKlGC8PqEaKdGf
 voJDrAXKQhr/HItTdBe7+fXpo/C07iX7PfW0jA2HwrZV7FBNwDw7nkhkw5pjqoQqz10ioe4+Kp/
 YFU7HtIBDLGyEl0ff75QvfgFenQiW7NY=
X-Received: by 2002:aed:3245:: with SMTP id y63mr3368690qtd.324.1601387355575; 
 Tue, 29 Sep 2020 06:49:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJym6ANQBU/+dCvVfDHDKuw5Mo/kSFqtt9Qbpjhaf3tKQ+xHFuyd8gY/9zUJ39qwiFwBoWALJQYbir+7HHUM7VE=
X-Received: by 2002:aed:3245:: with SMTP id y63mr3368666qtd.324.1601387355387; 
 Tue, 29 Sep 2020 06:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200918213436.GA3520@redhat.com> <20200921153243.GK3221@work-vm>
 <20200922102531.GA2837@work-vm> <20200922174733.GD57620@redhat.com>
 <46D726A6-72F3-40FE-9382-A189513F783D@intel.com>
 <20200924221023.GB132653@redhat.com>
 <20200925124139.GJ2873@work-vm> <20200929131753.GB220516@redhat.com>
In-Reply-To: <20200929131753.GB220516@redhat.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Tue, 29 Sep 2020 15:49:04 +0200
Message-ID: <CAOssrKcVNs=uiU2U1-ScowogFan8W=iw7kyTCnaz-vL8r9gLmw@mail.gmail.com>
Subject: Re: [Virtio-fs] virtiofs vs 9p performance(Re: tools/virtiofs: Multi
 threading seems to hurt performance)
To: Vivek Goyal <vgoyal@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mszeredi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mszeredi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Venegas Munoz,
 Jose Carlos" <jose.carlos.venegas.munoz@intel.com>,
 "cdupontd@redhat.com" <cdupontd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 virtio-fs-list <virtio-fs@redhat.com>, "Shinde,
 Archana M" <archana.m.shinde@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 29, 2020 at 3:18 PM Vivek Goyal <vgoyal@redhat.com> wrote:

> - virtiofs cache=none mode is faster than cache=auto mode for this
>   workload.

Not sure why.  One cause could be that readahead is not perfect at
detecting the random pattern.  Could we compare total I/O on the
server vs. total I/O by fio?

Thanks,
Millos


