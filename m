Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DCFC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 14:55:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B79142075E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 14:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZhgLORc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B79142075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNH2p-0005ex-MK
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 10:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mszeredi@redhat.com>)
 id 1kNH1U-0004Sa-Vg
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 10:54:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29282)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mszeredi@redhat.com>)
 id 1kNH1S-0003kS-0C
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 10:54:32 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601391269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KUxZOCZ4yCLTIOxW6XR/MapCLZuDzU+tF1YLeSlaNS8=;
 b=hZhgLORcfkVN8Om8SxyGW/Qd0eRlDdFfwWcyNVGHX9lzhACQEkJQ7ZuUwTbPIJTCYHMNKn
 qj8JR0xy3rc8kujDbsn2x9UC4InZAe0ro9Mwc4xy4p4RNcXJJ4HCtbHKRWTm0ugEsiMLrm
 0HyRVE8M/3YjN+irIrUNf5rEatnojHQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-RnXrgXirOfGLqogFsqNfCw-1; Tue, 29 Sep 2020 10:54:27 -0400
X-MC-Unique: RnXrgXirOfGLqogFsqNfCw-1
Received: by mail-qt1-f198.google.com with SMTP id w92so3157572qte.19
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 07:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KUxZOCZ4yCLTIOxW6XR/MapCLZuDzU+tF1YLeSlaNS8=;
 b=OR/X1JrHJHaQmxhkQluW2tl5hXnIM0zYOHOD50oSrpysoupfqsoOTiPrnOMQp9hlts
 IzyJ+PIPKcxjStT68/1Hv4PvzaBplDCy0N8zqqWoByn7IfyTlLeifF8NIWrCWDQ0FlpJ
 f5st/ExBGEDBm972H+h4wqD+A4DwOlW8Sz+MtJiZx0mTtWx4KCNtAgWVO55hP4akCBJK
 GLfBM7KoWx4oYj+OpdSu8GOTGppedcotHjhUubLh420E9SyE+0Wu40FTrO625RGvOMhC
 Uf0Fq7Epc1paCZcRq1ejQt6AttMB0AZjgi9egwKgJzPt6p8yJkE1V1g5J75pNDlo6Duj
 rptg==
X-Gm-Message-State: AOAM532uZnqMg7p28TF2OQBPEsUd619Qbg8xPD/cd/vcqfM/pTo2bESn
 ZpE6YpLsx1sue3jBKXjQMjQy2fudDmArOKISN6iTxR8WHDwIP1z2u+VbFLVrNSv8hHEFdYn8lH6
 y86Pt7/rY7L8O10wghukVFPjZHLKvw7M=
X-Received: by 2002:a05:620a:98b:: with SMTP id
 x11mr4667664qkx.211.1601391267345; 
 Tue, 29 Sep 2020 07:54:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1LIZctmVuqN6E6kXLnBaRXRGLgJ53vB7X+tazoAfttAWZnCDeVrxFWAK3zQ162yaIypemOuBS20qDKIVrLvk=
X-Received: by 2002:a05:620a:98b:: with SMTP id
 x11mr4667641qkx.211.1601391267077; 
 Tue, 29 Sep 2020 07:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200918213436.GA3520@redhat.com> <20200921153243.GK3221@work-vm>
 <20200922102531.GA2837@work-vm> <20200922174733.GD57620@redhat.com>
 <46D726A6-72F3-40FE-9382-A189513F783D@intel.com>
 <20200924221023.GB132653@redhat.com>
 <20200925124139.GJ2873@work-vm> <20200929131753.GB220516@redhat.com>
 <CAOssrKcVNs=uiU2U1-ScowogFan8W=iw7kyTCnaz-vL8r9gLmw@mail.gmail.com>
 <20200929140136.GD220516@redhat.com>
In-Reply-To: <20200929140136.GD220516@redhat.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Tue, 29 Sep 2020 16:54:15 +0200
Message-ID: <CAOssrKd8RAQ+D0o8O9HJND5skG0-wZhucz2R9sH-CC_4cASH3w@mail.gmail.com>
Subject: Re: [Virtio-fs] virtiofs vs 9p performance(Re: tools/virtiofs: Multi
 threading seems to hurt performance)
To: Vivek Goyal <vgoyal@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mszeredi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mszeredi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
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

On Tue, Sep 29, 2020 at 4:01 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Tue, Sep 29, 2020 at 03:49:04PM +0200, Miklos Szeredi wrote:
> > On Tue, Sep 29, 2020 at 3:18 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > > - virtiofs cache=none mode is faster than cache=auto mode for this
> > >   workload.
> >
> > Not sure why.  One cause could be that readahead is not perfect at
> > detecting the random pattern.  Could we compare total I/O on the
> > server vs. total I/O by fio?
>
> Hi Miklos,
>
> I will instrument virtiosd code to figure out total I/O.
>
> One more potential issue I am staring at is refreshing the attrs on
> READ if fc->auto_inval_data is set.
>
> fuse_cache_read_iter() {
>         /*
>          * In auto invalidate mode, always update attributes on read.
>          * Otherwise, only update if we attempt to read past EOF (to ensure
>          * i_size is up to date).
>          */
>         if (fc->auto_inval_data ||
>             (iocb->ki_pos + iov_iter_count(to) > i_size_read(inode))) {
>                 int err;
>                 err = fuse_update_attributes(inode, iocb->ki_filp);
>                 if (err)
>                         return err;
>         }
> }
>
> Given this is a mixed READ/WRITE workload, every WRITE will invalidate
> attrs. And next READ will first do GETATTR() from server (and potentially
> invalidate page cache) before doing READ.
>
> This sounds suboptimal especially from the point of view of WRITEs
> done by this client itself. I mean if another client has modified
> the file, then doing GETATTR after a second makes sense. But there
> should be some optimization to make sure our own WRITEs don't end
> up doing GETATTR and invalidate page cache (because cache contents
> are still valid).

Yeah, that sucks.

> I disabled ->auto_invalid_data and that seemed to result in 8-10%
> gain in performance for this workload.

Need to wrap my head around these caching issues.

Thanks,
Miklos


