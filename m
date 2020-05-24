Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB77C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 14:07:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D415206DD
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 14:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WzR7cT/R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D415206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcrHs-0006ZB-Fj
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 10:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jcrHL-00063c-Cb
 for qemu-devel@nongnu.org; Sun, 24 May 2020 10:07:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22219
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jcrHJ-0003Rw-Qk
 for qemu-devel@nongnu.org; Sun, 24 May 2020 10:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590329219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MbtOBfxFSHvxdibJ2/FtG6DlwZlMJNXMU85dBhN7ITc=;
 b=WzR7cT/R3Gzv5rmCR/78xIgdKLts0ETVawhew/dCoZSaQXpBokbT4IP2qVhcAFQfNRdya9
 1f5zJPdkFUROPPdlRSzTIoX9PCe/zEZyjY5sArjySxK09ZdS9psB6I30cqPYfCN+ddFvd6
 9lQ6s/flaYhB0cBTCyuhT8sQMJuuyIM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-HpU90LfwOuqcjmJnHIILnQ-1; Sun, 24 May 2020 10:06:57 -0400
X-MC-Unique: HpU90LfwOuqcjmJnHIILnQ-1
Received: by mail-qv1-f70.google.com with SMTP id n36so15270124qvg.22
 for <qemu-devel@nongnu.org>; Sun, 24 May 2020 07:06:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MbtOBfxFSHvxdibJ2/FtG6DlwZlMJNXMU85dBhN7ITc=;
 b=mUVn6QttdOQt2l6bXx9hG+vIxX8fMS40QAkir6qSiG+tMdH3pUNLRnvwA+aDAUjqRW
 TdFmWFOulhnx8b8/Zdw2MsoArNkGZEzz0Y29jvVmUSr/x6+C6+OOt0ZbywWJOwFP8hdt
 kovCUXSa5Jdy9h0kdXpOp9Izygi9r2TeHjK/3d/zrwUBTls/t7epksp8pOwpCmmfZsSv
 8w6+PqfJt/XufsVQc/JSUk14jHdOf3QRwLKksZKj2GEipgJZdAYommlRqGCsNMMFogq/
 viE306iipHB4SbbpM6ponSQKDuuSrzciEW14wycYAsLPXUiSjPyboRLvSopftFbWtzUm
 hktQ==
X-Gm-Message-State: AOAM530iOC3A3QcfYp0ksq2KWJJOCjMX3tjdDMuVtpueR2mczxpXdWVw
 eOwbmStDFGxG+sdV13liVJesNcQJFkxhcF+Qy6Ig3iRM97QrQJIpV+IgidgT8z8r8IGX+ocxwE6
 J8iop3YXLwYyaLYk=
X-Received: by 2002:a37:9cb:: with SMTP id 194mr8852789qkj.456.1590329217302; 
 Sun, 24 May 2020 07:06:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4kbfJe3EP+dCAaLnCfQ1MKWrQRuXmQILygctQ0hl5j4pjElIrwhkDdhEqp8ZRb3XXuhbTLw==
X-Received: by 2002:a37:9cb:: with SMTP id 194mr8852766qkj.456.1590329217017; 
 Sun, 24 May 2020 07:06:57 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id g19sm12510811qke.32.2020.05.24.07.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 07:06:56 -0700 (PDT)
Date: Sun, 24 May 2020 10:06:55 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH RFC v3 01/11] linux-headers: Update
Message-ID: <20200524140655.GA1058657@xz-x1>
References: <20200523232035.1029349-1-peterx@redhat.com>
 <20200523232035.1029349-2-peterx@redhat.com>
 <CAFEAcA9jq6UbaZAT-itF5Kswy1YSAocKa8mVVh0hNF7DuLGBqA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9jq6UbaZAT-itF5Kswy1YSAocKa8mVVh0hNF7DuLGBqA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/24 06:30:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Hi, Peter,

On Sun, May 24, 2020 at 02:27:14PM +0100, Peter Maydell wrote:
> On Sun, 24 May 2020 at 00:21, Peter Xu <peterx@redhat.com> wrote:
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Header updates should always include the upstream
> kernel commit against which you ran the scripts/update-linux-headers.sh
> script, please.

This is based on a kernel series that hasn't yet been merged, so I didn't tag
it (so this is still a RFC series).  Will do when it's merged.

> 
>  linux-headers/asm-x86/kvm.h |  1 +
>  linux-headers/linux/kvm.h   | 53 +++++++++++++++++++++++++++++++++++++
> 
> Are these really the only files which had changes? It looks
> a suspiciously short list...

I didn't check, but I did use the script all the time..

Thanks,

-- 
Peter Xu


