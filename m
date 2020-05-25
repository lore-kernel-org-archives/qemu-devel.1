Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1DAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 14:30:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5323D206D5
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 14:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="issxxMLS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5323D206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdE7P-0004Ii-H2
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 10:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jdE6q-0003tC-F0
 for qemu-devel@nongnu.org; Mon, 25 May 2020 10:29:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43850
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jdE6p-0007Ri-6c
 for qemu-devel@nongnu.org; Mon, 25 May 2020 10:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590416982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QEV/Vgl4qzyh3Xtm2FM+tXbEp5WYG8OWB8NtZL2uF+U=;
 b=issxxMLS+jk+BzXnkt3CYIf28vBm6WTverHJ/xURLg0+PjVOzOIWqqtSftUO8rGMm0bRJ7
 aXr2EcvZjXrcmmcKI7pScBSPFE4pxGaPLIRaqRR0tzD0KcUvy3j55CF0fHKsECg+fhauUM
 I8aHHTZGWGBlFacUR8/s5zfTW9osKcI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-d3SBHuuxNIWJZaBZezanNw-1; Mon, 25 May 2020 10:29:39 -0400
X-MC-Unique: d3SBHuuxNIWJZaBZezanNw-1
Received: by mail-qk1-f200.google.com with SMTP id v6so18078249qkd.9
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 07:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QEV/Vgl4qzyh3Xtm2FM+tXbEp5WYG8OWB8NtZL2uF+U=;
 b=OkfKS896kOIJaaTi7eXP93TdvnWGBJ95OxDUgIIv6nJN+wOYvAk0Pf8VCCeYxji+Su
 DEcoVHT8RjV/nBjTBj+qQ6QupuliroBivGWGf5IqxA9neFTZzXnUvQJIuQeemOoi0/L2
 rPlLJxmUsXAL5e7/s2qP55wNytEMs3gIEI2rqoiBBgkRrTcmWtqKPB0goi/OR7Jk1HsG
 bUGqnaj/YnOrlyWp7m7vK5ki8/jXOIH+2P+LYbs1Y1GVt2O8mHO8J/B31mx58+lQiuJ5
 CgGxhPmdAqLl30pqoi8vui4Sy3VkZmOXc4wnS6YDrB0SEUm/YeaPKs0nm0oQ7S54CSd9
 lEXg==
X-Gm-Message-State: AOAM532RNEKhvOqAMewdRh8W7vEZLtE4XEi4tnLImgxmKOlwax1GZ/so
 0SVL6HDI5idtMlJLBLtMT923GRdKKVOenchaNoDFNiBynhfoTAA/36lW7oD+yQmN9piayZY/KGa
 iYLlmKhCqxACiihw=
X-Received: by 2002:a05:6214:1089:: with SMTP id
 o9mr15649496qvr.31.1590416978996; 
 Mon, 25 May 2020 07:29:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeWvSZ8IjbrbnqAWdXXfXhtTSf67VrLvNRxXw6B0OROVuOz7WcJ42aRXi7HvyYnNB5Y3LLWA==
X-Received: by 2002:a05:6214:1089:: with SMTP id
 o9mr15649479qvr.31.1590416978761; 
 Mon, 25 May 2020 07:29:38 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id h77sm5637070qke.37.2020.05.25.07.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 07:29:38 -0700 (PDT)
Date: Mon, 25 May 2020 10:29:36 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH RFC v3 01/11] linux-headers: Update
Message-ID: <20200525142936.GD1058657@xz-x1>
References: <20200523232035.1029349-1-peterx@redhat.com>
 <20200523232035.1029349-2-peterx@redhat.com>
 <CAFEAcA9jq6UbaZAT-itF5Kswy1YSAocKa8mVVh0hNF7DuLGBqA@mail.gmail.com>
 <20200524140655.GA1058657@xz-x1>
 <CAFEAcA9Sbo0hsmqoVcvv7wvvDVc9JdEep8n9mYgsnFFkmVckwQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Sbo0hsmqoVcvv7wvvDVc9JdEep8n9mYgsnFFkmVckwQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 01:44:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, May 24, 2020 at 06:50:28PM +0100, Peter Maydell wrote:
> On Sun, 24 May 2020 at 15:07, Peter Xu <peterx@redhat.com> wrote:
> >
> > Hi, Peter,
> >
> > On Sun, May 24, 2020 at 02:27:14PM +0100, Peter Maydell wrote:
> > > On Sun, 24 May 2020 at 00:21, Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > >
> > > Header updates should always include the upstream
> > > kernel commit against which you ran the scripts/update-linux-headers.sh
> > > script, please.
> >
> > This is based on a kernel series that hasn't yet been merged, so I didn't tag
> > it (so this is still a RFC series).  Will do when it's merged.
> 
> Ah, cool. (It's helpful to note in the commit message for the
> header-update patch if it's a not-yet-upstream set of changes.)

Sure.  I'll add that some into the commit message in my next post if the kernel
series is still unmerged (which is very likely).

Thanks,

-- 
Peter Xu


