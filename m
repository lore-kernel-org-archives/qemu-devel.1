Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15891CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:17:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA5E52064A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA5E52064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNEeB-0004WX-Ri
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 07:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iNE3F-0002ET-BB
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:39:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iNE38-00038Y-JQ
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:39:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33104)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iNE38-000376-3t
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:39:30 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E9E42368CF
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 10:39:28 +0000 (UTC)
Received: by mail-pf1-f199.google.com with SMTP id a2so15819268pfo.12
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 03:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=yKoXBzPSInXw7cjhLnujJEafH/ygkaHp1DRwDQJH9cc=;
 b=NlO6RJcO7zuZT25PYApmnVqQkQHP8RSGefgrUb5GL/xHCuKiWh/YtYhRn5xst2NYgL
 e7kakH1sXLgSNICPhXQdUWoFu83httHxkhbVio+ypfkqAi3SF8iZ3FCXdhCd/fkb/V+V
 Naqqz/FFMlSYdG0Ikws5koYCqW3pvkO0kiSnpS99l6JzOMZ9s8jy4xD+KuPcIu0u7LKz
 AUFkgVQtZhBIQ4V+mttSmX2wekXqGEcKWYcdJByqsWbSGiWdvHoT2piEadofXd6aqOn9
 5SFdNeXuwhfN6GOjbwJEcLG6k3oNhRM89mXn7wXc8W8tCE/YlW94hA6iZxBAL3vZfeBS
 ZvEw==
X-Gm-Message-State: APjAAAX8ZN2h4V+vnVMPzDuUaircKcF8WUNQ9Ekte4urBLKBq+DndgeC
 ClsPUNqsxFuOsgRzJThQ9mF/1XSlFw6ZEkV+P8uIHQqBvVcsX2MHxBWjNGXc898s8yRiCrUoUXB
 b3h4sMqNcSrz81ac=
X-Received: by 2002:a17:902:8c96:: with SMTP id
 t22mr8745660plo.290.1571827168383; 
 Wed, 23 Oct 2019 03:39:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxgmQgsqTIcYPYmD1iSWQlo4PBd0zza8H2OcY7/eRbyHN3dfbLY39uTaLkwF+yYtxbuSFq0SA==
X-Received: by 2002:a17:902:8c96:: with SMTP id
 t22mr8745635plo.290.1571827168163; 
 Wed, 23 Oct 2019 03:39:28 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id c9sm3122781pfb.114.2019.10.23.03.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 03:39:27 -0700 (PDT)
Date: Wed, 23 Oct 2019 18:39:17 +0800
From: Peter Xu <peterx@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v2 0/4] apic: Fix migration breakage of >255 vcpus
Message-ID: <20191023103917.GD18443@xz-x1>
References: <20191016022933.7276-1-peterx@redhat.com>
 <20191016144001.GE4084@habkost.net> <20191019034153.GB9478@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191019034153.GB9478@xz-x1>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Oct 19, 2019 at 11:41:53AM +0800, Peter Xu wrote:
> On Wed, Oct 16, 2019 at 11:40:01AM -0300, Eduardo Habkost wrote:
> > On Wed, Oct 16, 2019 at 10:29:29AM +0800, Peter Xu wrote:
> > > v2:
> > > - use uint32_t rather than int64_t [Juan]
> > > - one more patch (patch 4) to check dup SaveStateEntry [Dave]
> > > - one more patch to define a macro (patch 1) to simplify patch 2
> > > 
> > > Please review, thanks.
> > 
> > I wonder how hard it is to write a simple test case to reproduce
> > the original bug.  We can extend tests/migration-test.c or
> > tests/acceptance/migration.py.  If using -device with explicit
> > apic-id, we probably don't even need to create >255 VCPUs.
> 
> I can give it a shot next week. :)

When I was playing with it, I noticed that it's not that easy at least
for the migration-test.  We need to do these:

- add one specific CPU with apic-id>255, this is easy by using
  "-device qemu64-x86_64-cpu,..."

- enable x2apic in the guest code, read apic-id on the special vcpu to
  make sure it's correct even after migration, but before that...

- I failed to find a way to use apic-id>255 as the BSP of system but I
  can only create APs with apic-id>255, so we need to add initial MP
  support for the migration guest code, then run that apic-id check
  code on the new AP

- I also probably found that q35 bug on bootstraping the 512B disk, so
  we probably need to workaround that too until fixed

Unless someone has better idea on this, I'll simply stop here because
I'm afraid it does not worth the effort so far... (or until we have
some other requirement to enrich the migration qtest framework)

-- 
Peter Xu

