Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD46C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:35:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0054F20759
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SeEZffDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0054F20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNe8J-00081S-Tt
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 11:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNe2K-00025T-TK
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 11:28:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48518)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNe2J-0007TQ-03
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 11:28:56 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601479734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nkg/iNElH/41BuhaHjok3qWaI6/KrpqcfILHPRGwptE=;
 b=SeEZffDnaNTElhm7vYMgQ6iNUk9li8x+EctlmWDk22pWQb1faaTVvIqD25TF8HVaYE1/1Z
 YlYsMcdIN7h1SleAtbG5GkwicnYEWc7hmaiDW8Es9jlRAoMBsoU1oRlE7TTEGa0+lWtUmD
 wKydVvt9IK04L0Pt9jAkuNpqJd8eWk4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-lYbv8nhqN_W5_vrwq1NKig-1; Wed, 30 Sep 2020 11:28:52 -0400
X-MC-Unique: lYbv8nhqN_W5_vrwq1NKig-1
Received: by mail-wr1-f70.google.com with SMTP id j7so745003wro.14
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 08:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=CPR1Z2wi3XdCj+AvGFyd5lsweOGNFfYjcoVY3kmRAVE=;
 b=R3ZKgYjx3zGjyNaA2qNyneZROMnT2L+dlRYp/TrsEmMTvlXlLeHOGtSE33QzAvKjyc
 Ny+AFmqOCk0FKrccj3DkzBRQp4xNPBEyuG4R5f0/YG1NoKtTtk39NznuhO7yhAnENj7u
 RZMDf1tDI1IOUfsZaIcvJt2VBjUYiwEEbqQZ9BqxGMcoEyw4JYHo4OsXnf53IOxaVvq5
 am8c91NMruG6+bhmLkD27LCAuU2UGdlR0+lTj9tiVtu0tRgQECYSjigfZJCa51To6El2
 YJtZv7EzVMY84WqlhoigfvI9iPznFfavgl2NknT6PjLnKOSDMsrfOHI2YiezLzWpKb5w
 PeCA==
X-Gm-Message-State: AOAM533GjClw/I4L3fg77XfM3FmnykKLXu9iSUiL+nT+0oOZEBPDW/e8
 nI8rUYlVR22SmmbQT3sgeJ+ZXL7b4CERtajsoqs13fxIFQM1MkmvsUSM5BOnL3Rd5clsrHepnEO
 rDy/beG650Q6G5Yk=
X-Received: by 2002:a1c:4909:: with SMTP id w9mr2114966wma.133.1601479730971; 
 Wed, 30 Sep 2020 08:28:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhMSfqFj0+tAtQ9jyH6BSJlUY6ned64V1wG8p1MVXL6/WcIii9JagAC/1PID4SJ67Iy5BwPQ==
X-Received: by 2002:a1c:4909:: with SMTP id w9mr2114941wma.133.1601479730719; 
 Wed, 30 Sep 2020 08:28:50 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id n4sm3563410wrp.61.2020.09.30.08.28.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 08:28:49 -0700 (PDT)
Date: Wed, 30 Sep 2020 11:28:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH v10 13/13] tests/acpi: add DSDT.hpbrroot DSDT table blob
 to test global i440fx hotplug
Message-ID: <20200930112631-mutt-send-email-mst@kernel.org>
References: <CAARzgwzdYfVn6Kdic+rj7xSxdvP6RAM48wr8Pt_MpDwuYvDSiw@mail.gmail.com>
 <20200929073523-mutt-send-email-mst@kernel.org>
 <CAARzgwyNHnG_dzhD9mZbico2V3-c=XL-fNo7xO=rP2jfVMqtdw@mail.gmail.com>
 <20200930033540-mutt-send-email-mst@kernel.org>
 <CAARzgwyAE1bL5VnkH7dKBeMEtwcsZBhuhtRxx+BUxYsd8ZRi_A@mail.gmail.com>
 <20200930034220-mutt-send-email-mst@kernel.org>
 <CAARzgwy_+kVWQs5sQo4qAYC3Gi5LhdLoMQDPzKadwRPZ1D8Brw@mail.gmail.com>
 <20200930040207-mutt-send-email-mst@kernel.org>
 <CAARzgwz1TJpyVZfxJF=yCoj4pBMsUxOvaVmZCCn0Dfni-dB5kw@mail.gmail.com>
 <CAARzgwzDdYnkKGBUdjr367qqZ3As4bqEhhWiaLqRzwXN2VKhHA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAARzgwzDdYnkKGBUdjr367qqZ3As4bqEhhWiaLqRzwXN2VKhHA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 30, 2020 at 03:00:56PM +0530, Ani Sinha wrote:
> 
>     > >     > Please let's not wait another week or so.
> 
>     > >
> 
>     > >
> 
>     > >
> 
>     > >
> 
>     > >
> 
>     > >     OK it's not too much work but ... could you please add
>     justification
> 
>     > >
> 
>     > >     about why adding this one unit test is needed so urgently?
> 
>     > >
> 
>     > >     That motivation would be quite helpful for the pull request.
> 
>     > >
> 
>     > >
> 
>     > > A patch without unit test doesn't complete the patch work. A unit test
>     makes
> 
>     > > sure that the change would not get broken by other changes that come in
>     later.
> 
>     > > Typically all code changes are accompanied by unit test in the same
>     patch.
> 
>     > > Hence since the main work has already been merged, the unit test should
>     merge
> 
>     > > ASAP so that no breakage can happen in between.
> 
>     > >
> 
>     > > Plus this completes an entire series of work which I've been working
>     for a
> 
>     > > while. I really would love to see it all merged cleanly and fully
>     completed.
> 
>     > >
> 
>     >
> 
>     > Absolutely, thanks for the great work!
> 
>     > I am not sure that's a good justification to rushing a pull request
> 
>     > though ... are you waiting to get paid and it hinges on the test, or are
> 
>     > under a deadline, or something like this? It's okay to say so if so.
> 
> 
> 
>     Yes I am under a deadline too. Unfortunately can't disclose more details.
> 
> 
> Thanks Michael. Very much appreciate your help here.
> 

OK Peter merged this. Hope this helps.
Let's not make this a pattern please.

-- 
MST


