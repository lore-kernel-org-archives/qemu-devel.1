Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4126AC76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 07:50:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1727721738
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 07:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1727721738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnIEa-0001Ap-CB
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 03:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52891)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <zhexu@redhat.com>) id 1hnIEQ-0000mI-5Z
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 03:50:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhexu@redhat.com>) id 1hnIEP-0002Wz-7a
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 03:50:38 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41483)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <zhexu@redhat.com>) id 1hnIEP-0002WU-1s
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 03:50:37 -0400
Received: by mail-pl1-f196.google.com with SMTP id m9so9625268pls.8
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 00:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=XEhzBzTzfYlQQq1A/2SAGyBPHtUjsp5jkPdpj8xF+4k=;
 b=oMTLqnUeM0UJOTu/3CWF634P8F1GOdNETksPJhqZp5QbOevekB0OG455D6cSZ09byx
 mqayEqw4dTBZ/bp3W3eDoE75EBJnTmdB0eVRZbwA7QJX049K2v0QfWhvbRNqKomLmIVu
 h2u8uuR/5lYqKHFKvk+mJBfnzb9OjcZsb81i/Jqz6fN9bNzlfr/U0GDLeRNILlmrAorP
 MRiqQc3bbjBTHXK6wDhnlCSDNo1mpw6d7paTsHJA7zQbGhKkrYenwoJXY0j20tSWo1TQ
 3LaeYdbntB76LW3kOc462JC1EE5PBw5vsm0PszBI9e2dWyaaFbqa2b2rzmT0M1QC9YFG
 vOMA==
X-Gm-Message-State: APjAAAVVfsaHEjahoMXhj+4EJLW3aEr+LDnSLnAVDTCsy4VVVjPuub79
 jQydonGm0JSOacPQKQFHzQbJ9g==
X-Google-Smtp-Source: APXvYqy/nOOZ+mdBzdqRBBy8MoSL8ARf52BmWucHEabnLalI1WCJMofkfmgpC8zI76eHripweh0QFw==
X-Received: by 2002:a17:902:b20d:: with SMTP id
 t13mr31891723plr.229.1563263436220; 
 Tue, 16 Jul 2019 00:50:36 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id n19sm20325877pfa.11.2019.07.16.00.50.32
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 16 Jul 2019 00:50:35 -0700 (PDT)
From: Peter Xu <zhexu@redhat.com>
X-Google-Original-From: Peter Xu <peterx@redhat.com>
Date: Tue, 16 Jul 2019 15:50:25 +0800
To: Yan Zhao <yan.y.zhao@intel.com>
Message-ID: <20190716075025.GB30980@xz-x1>
References: <1563261042-15974-1-git-send-email-yan.y.zhao@intel.com>
 <20190716072315.GA30980@xz-x1>
 <20190716072919.GA8912@joy-OptiPlex-7040>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190716072919.GA8912@joy-OptiPlex-7040>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.196
Subject: Re: [Qemu-devel] [PATCH] migration: notify runstate immediately
 before vcpu stops
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
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "crosthwaite.peter@gmail.com" <crosthwaite.peter@gmail.com>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Xu <zhexu@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 16, 2019 at 03:29:19AM -0400, Yan Zhao wrote:
> On Tue, Jul 16, 2019 at 03:23:16PM +0800, Peter Xu wrote:
> > On Tue, Jul 16, 2019 at 03:10:42PM +0800, Yan Zhao wrote:
> > > for some devices to do live migration, it is needed to do something
> > > immediately before vcpu stops. add a notification here.
> > 
> > Hi, Yan,
> > 
> > Could I ask for a more detailed commit message here?  E.g., what is
> > "some devices"?  And, what's the problem behind?
> >
> hi Peter,
> 
> Some devices refer to assigned devices, like NICs.
> For assigned devices to do live migration, it is sometimes required that
> source device is stopped before stopping source vcpus. vcpus can do some
> final cleanups (like handling interrupt) in that case.

I see, so this is a prerequisite of another work?

IMHO it would make more sense to have this patch to be with that
patchset, then it'll justify itself with reasoning.  Unless I
misunderstood - this single patch seems to help nothing if as a
standalone one.

Thanks,

-- 
Peter Xu

