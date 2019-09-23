Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D62C432C1
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 23:50:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6463F21A4C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 23:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6463F21A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCY6J-0007pS-KT
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 19:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42195)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iCY5R-00078m-2Y
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:49:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iCY5P-0006CY-8e
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:49:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40180)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iCY5P-0006C5-1G
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:49:43 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BD774C057EC0
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 23:49:41 +0000 (UTC)
Received: by mail-pl1-f200.google.com with SMTP id 99so3845225plc.18
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 16:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=YNpdlLY1UAQCN/2jCWcO/ooDRO7y3+FtLsm2ZjEvwsQ=;
 b=riIe/OL53KNmR2+Kwv61oW6rDvq84puGNw5DMtguB8diTy8OXwDtulPSDTmW21eS4/
 rwPekvxwwj2tO1wTh3vsBQBaXylMz6F4qHZmwIKnUKlunrhZQSDv5u2atEOi+lo7vNeT
 KORKsAmSP393V7Jrp1xCKvkOvR4O/foGLApo5QJLhLJZAnLpxOf7882BJsd5QG+KuXQI
 qKsh0WmskytFjioWl5GzkcpsJCW0eJlKUIQ5zeFKUBi2vJg+W/TwimeJpjKsBeyNFIHO
 blsgXdpImBffHlinomVXG9KE0hEEZhdyzm/7IuATprOq3uCMGdpSZvd969XryWBSGCGu
 nZbQ==
X-Gm-Message-State: APjAAAWQcziEaqWTduD0oXDfM2+ur7SHiFCw7czd5HRUS/VmqblgCGRH
 u5olXQRt8X9t35zxKHjAkTsuFzHRZe5ff9NwnRhNcFD7zJeXNI+o95CYkjtne7FU+r4NHgcKKXd
 QTfqR6EeARK4yzAU=
X-Received: by 2002:a17:90a:1c7:: with SMTP id 7mr2140747pjd.95.1569282581175; 
 Mon, 23 Sep 2019 16:49:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzsPExisAwArsGrDm3/gR9wCbl9mcXRIEawKE+4WTcWoYdXGq7PHWvgtbWNa279XHlmktHVYQ==
X-Received: by 2002:a17:90a:1c7:: with SMTP id 7mr2140732pjd.95.1569282580824; 
 Mon, 23 Sep 2019 16:49:40 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id w134sm21401194pfd.4.2019.09.23.16.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 16:49:40 -0700 (PDT)
Date: Tue, 24 Sep 2019 07:49:28 +0800
From: Peter Xu <peterx@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 1/2] vfio: Turn the container error into an Error handle
Message-ID: <20190923234928.GB28074@xz-x1>
References: <20190923065552.10602-1-eric.auger@redhat.com>
 <20190923065552.10602-2-eric.auger@redhat.com>
 <20190923075145.GA12806@xz-x1>
 <765755f6-4447-9322-d276-567d844ed50c@redhat.com>
 <20190923171043.4de13820@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190923171043.4de13820@x1.home>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: peter.maydell@linaro.org, mst@redhat.com, aik@ozlabs.ru,
 qemu-devel@nongnu.org, Auger Eric <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 pbonzini@redhat.com, david@gibson.dropbear.id.au, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 23, 2019 at 05:10:43PM -0600, Alex Williamson wrote:
> On Mon, 23 Sep 2019 13:43:08 +0200
> Auger Eric <eric.auger@redhat.com> wrote:
> 
> > On 9/23/19 9:51 AM, Peter Xu wrote:
> > > On Mon, Sep 23, 2019 at 08:55:51AM +0200, Eric Auger wrote:  
> > >> @@ -1308,9 +1319,9 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
> > >>                                       &address_space_memory);
> > >>              if (container->error) {
> > >>                  memory_listener_unregister(&container->prereg_listener);
> > >> -                ret = container->error;
> > >> -                error_setg(errp,
> > >> -                    "RAM memory listener initialization failed for container");
> > >> +                ret = -1;
> > >> +                error_propagate_prepend(errp, container->error,
> > >> +                    "RAM memory listener initialization failed: ");  
> > > 
> > > (I saw that we've got plenty of prepended prefixes for an error
> > >  messages.  For me I'll disgard quite a few of them because the errors
> > >  will directly be delivered to the top level user, but this might be
> > >  too personal as a comment)  
> > That's true we have a lot of prefix messages.
> > 
> > The output message now is:
> > 
> > "vfio 0000:89:00.0: failed
> > to setup container for group 2: memory listener initialization failed:
> > Region smmuv3-iommu-memory-region-0-6: device 01.00.0 requires iommu MAP
> > notifier which is not currently supported"
> > 
> > Alex, any opinion?
> 
> Peter, I don't really understand what the comment is here.  Is it the
> number of prepends on the error message?  I don't really have an
> opinion on that so long as the end message makes sense.  Seems like if
> we're familiar with the error generation it helps to unwind the
> context.  Thanks,

True, the only major difference of the error that this series is
working on is that the user can easily trigger this simply by plugging
a device hence I'm not sure whether that's too long (it's not really a
comment and that's why I put it in brackets :).  Let's just keep them.

Thanks,

-- 
Peter Xu

