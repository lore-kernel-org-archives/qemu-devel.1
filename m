Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6778C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:45:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDCD1221FE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xh6vhJMB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDCD1221FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQZyY-00016q-MF
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 13:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kQZxb-0000Bj-T2
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:44:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28107)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kQZxY-0002cG-JK
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602179042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z5hS/8gZzlQfHyKryqUpDqJo343u1ugJwRjUMyYdO0w=;
 b=Xh6vhJMBHuqkZZreEm+Mm3BnLn6THuLVmt8i3zzoFeEM3gfPsHwV5yZN+Sg8t9KddenkYY
 /bFKPBZKGxfQzSfqFXty6klFrcEqRCybo0TJqmE89oC3mmz+dDNGHg4LNtYaDjkJePMBlA
 LIElFS56Q7iHznRNSlDGiFu3R5p6qHk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-3iVcBFy2OWKMpTyTAMEL7g-1; Thu, 08 Oct 2020 13:43:58 -0400
X-MC-Unique: 3iVcBFy2OWKMpTyTAMEL7g-1
Received: by mail-qk1-f198.google.com with SMTP id f126so4501642qke.17
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 10:43:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=z5hS/8gZzlQfHyKryqUpDqJo343u1ugJwRjUMyYdO0w=;
 b=C84Ial6CtIuL9UQzcGn/StOZfPUh79f9VB654tKdZ3sLPKjDc1oRm1B7WfodC+IM43
 Ah6TbkLSfcvL8IlceVDj260K0N4XDMu/8KfhUw/F1H22SiazKpSr0+U0v5DuhrOm2weC
 i9a90yNeP4EJ4jU4D+KmzBr2GsvGfrlSf9klTGg34cHdrOXC7enhBmC8umMOVynFnk4K
 C1G5JJHsuAhOoDBwtQ0c+9pmKQwJkdk8X/Vcbg39hNjI6tzk2SA+yKIeOjopkEJqms9+
 B6Vcv4na71qBDZmu/aiN60Y2BpEKIBKF1X7K2F3Z/xrMQAMwRXChPqY3i8XEwbWNcdAn
 A7BQ==
X-Gm-Message-State: AOAM532tQQ/ydcqADP98cyxKJf6xV38T64ik7KZpRZyW3vZ9spS5IOHl
 iyzLdJmH4+5h+XrRbD9xyMlQYwy81kgN+crg4HL07RScZFyUzGvAEqx6V4jwufcYAkoCDbzFMSQ
 /Gf6BT21dc8iktn4=
X-Received: by 2002:a05:620a:4b:: with SMTP id
 t11mr9419458qkt.96.1602179038277; 
 Thu, 08 Oct 2020 10:43:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxw1EUVKjueTySRWRZ6XBS9hwqopisvvGJL9BKQ6voa86Yf7ruOgeyIZYt8bdG4yxkgFlcuXw==
X-Received: by 2002:a05:620a:4b:: with SMTP id
 t11mr9419434qkt.96.1602179037968; 
 Thu, 08 Oct 2020 10:43:57 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca.
 [174.95.215.133])
 by smtp.gmail.com with ESMTPSA id 198sm4475209qki.117.2020.10.08.10.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 10:43:57 -0700 (PDT)
Date: Thu, 8 Oct 2020 13:43:55 -0400
From: Peter Xu <peterx@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PULL 00/10] migration queue
Message-ID: <20201008174355.GH6026@xz-x1>
References: <20201007155600.337316-1-dgilbert@redhat.com>
 <CAFEAcA9fjk5gpuV5Pq46DS8gux0gkY1fkhn=GU6W=B9jdAKBdg@mail.gmail.com>
 <9a226239-5041-c3fb-1e19-10148cfbe8f7@redhat.com>
MIME-Version: 1.0
In-Reply-To: <9a226239-5041-c3fb-1e19-10148cfbe8f7@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>, zhengchuan@huawei.com,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 08, 2020 at 12:09:15PM -0500, Eric Blake wrote:
> On 10/8/20 11:18 AM, Peter Maydell wrote:
> 
> > 
> > Compile failure, windows crossbuilds:
> > 
> > ../../migration/migration.c: In function 'page_request_addr_cmp':
> > ../../migration/migration.c:148:23: error: cast from pointer to
> > integer of different size [-Werror=pointer-to-int-cast]
> >      unsigned long a = (unsigned long) ap, b = (unsigned long) bp;
> >                        ^
> 
> 'unsigned long' is platform specific; so is uintptr_t, but it may fit
> more naturally.  Or maybe you are better off with a specific 32- or
> 64-bit type, but even so, may need a double cast (first to uintptr_t
> then to your real target) to shut up warnings?

Sorry for that.

When I was initially trying to fix the 32bit build failure I did use double
cast, but I (obviously, wrongly) thought sizeof(unsigned long) should always be
the same size as sizeof(void *), so I explicitly removed that, since at least
my 32bit compile didn't complaint.

But obviously Windows/mingw is probably different on that..

I'll find a mingw environment soon and verify.  It would take some more time
after docker stopped to work on my current host due to cgroup versions, however
shouldn't be long.

Thanks,

-- 
Peter Xu


