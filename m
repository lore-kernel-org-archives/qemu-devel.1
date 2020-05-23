Return-Path: <SRS0=y3lU=7F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E980C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 20:31:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68B0420727
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 20:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dbdof5Wj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B0420727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcany-0003FG-KD
	for qemu-devel@archiver.kernel.org; Sat, 23 May 2020 16:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jcamr-0002Ia-72
 for qemu-devel@nongnu.org; Sat, 23 May 2020 16:30:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41775
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jcamp-0004Gr-LE
 for qemu-devel@nongnu.org; Sat, 23 May 2020 16:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590265825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nGcad5pWFYfjZmglb3DNBIiOXHIWoo7uoa/PGC96jUE=;
 b=Dbdof5WjuOsEXEm+UNOgFYN4/mcRn8jsihKdpTnuzCIMo2NIXcsWs7XV5lMROHO0AgXxMW
 A51RrxaRbu5fJ1qmKAiiq2sTkQeUsu7+FmRxxnfVnAKJF+/BHCfUvlK4p4gjQ6G+skLPDT
 5gajxqIuUPpC2TwU5NZxhxG+hd7DgBI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-Ak_hhMYCOhmd1xisy6v1qw-1; Sat, 23 May 2020 16:30:22 -0400
X-MC-Unique: Ak_hhMYCOhmd1xisy6v1qw-1
Received: by mail-qt1-f198.google.com with SMTP id g8so15658198qtc.22
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 13:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nGcad5pWFYfjZmglb3DNBIiOXHIWoo7uoa/PGC96jUE=;
 b=gC6WOCqEb1dLve8SHke1VfdlN02ffr/sjNL/wIdXoQDt+Uu5mGiBD+LuzID4wHKfDF
 o6zbXr9dgpef3o9CoO5EShQZCumD7opz5pox+SWwKRb0d34we+p/XsW/Z6Xgdu/bRkKI
 fu5SVYQZCYqEKieCp3fRRTicwgBqhAHQz/JOl3ZIIAFaQFinCW6HjU3Wv69G8U0kQCnY
 u5fBqWh08JzJ1wndIFVwnsKTbLahmsXEL5sFEbL0H/Jrtfww41WW1OwyPRIPJgpQaRhG
 VYTflKcZXxAxmxuhlal1smCwGr6+cN1DyPrwu9U/NoA3v6ngU93u6deHyoGj578Jmu0P
 D2kQ==
X-Gm-Message-State: AOAM531uBfMnfcCYUTZfRIPeIWirxagU3Mf5CuYiYPUKy70Gk0kE7FOL
 MRJO95SAcyYSRmISup4wlMnko8ZZCmEED9HksEKUShJuaHm3VmFr1vbjObKnMqkS+tranhPUqz3
 22yJ1vYa28KP/+9E=
X-Received: by 2002:ac8:4088:: with SMTP id p8mr9444896qtl.119.1590265821589; 
 Sat, 23 May 2020 13:30:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7kMlkvwlAJiVUKY+kwwLPtPrh5aHk37KwWVnLzOh0SHWdsQLzXrrmgGkwVs4ccCMTMsg7cA==
X-Received: by 2002:ac8:4088:: with SMTP id p8mr9444883qtl.119.1590265821380; 
 Sat, 23 May 2020 13:30:21 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id 70sm7270064qkk.10.2020.05.23.13.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2020 13:30:20 -0700 (PDT)
Date: Sat, 23 May 2020 16:30:18 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/8] memory: Sanity checks memory transaction when
 releasing BQL
Message-ID: <20200523203018.GJ766834@xz-x1>
References: <20200421162108.594796-1-peterx@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200421162108.594796-1-peterx@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/23 16:30:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 21, 2020 at 12:21:00PM -0400, Peter Xu wrote:
> This is a continuous work of previous discussion on memory transactions [1].
> It should be helpful to fail QEMU far earlier if there's misuse of BQL against
> the QEMU memory model.
> 
> One example is run_on_cpu() during memory commit.  That'll work previously, but
> it'll fail with very strange errors (like KVM ioctl failure due to memslot
> already existed, and it's not guaranteed to trigger constantly).  Now it'll
> directly fail when run_on_cpu() is called.
> 
> Please have a look, thanks.
> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg03205.html

Still think it as something good to have...  Any comments?  Thanks,

-- 
Peter Xu


