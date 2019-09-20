Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5615AC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 12:12:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C5A820644
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 12:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C5A820644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBHmR-00016I-8d
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 08:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43004)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iBHl5-0000Pn-OS
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 08:11:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iBHl4-00020v-HJ
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 08:11:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60954)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iBHl4-00020S-7n
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 08:11:30 -0400
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D633AC057FA6
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 12:11:28 +0000 (UTC)
Received: by mail-pl1-f198.google.com with SMTP id x5so4327790pln.5
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 05:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=m2JWJNWOUnEd2OvqBxvmVTfjWxdY7hLd6VBHQ5vZfus=;
 b=mWvsRIVeed59QWbzyLUBxOBrnvLMNBJLWJqKpiGlggVVrXxHYGiYQaKYy/dJQ41dn/
 +ZgKAbE1duh/nOoD3v8UUaYSyd9zJxNB/XpQYhQtq8e6aUuKfh08w3j4lfsV0yODFBmm
 Y7PJoxsrqb9mal84iohMbybZESyKTfLcg8rHCgpLpoMGSiucAx1eoGMOwhRueeWEqqkk
 A7J2KR3SMrSf+mWdCF0cd56J9R/PW10QqgPq9CItCBzeWXtKBFZtMmjzOU5hB0TLbzXs
 oJXIzcXW8jCv8RstnYl3fiyf0eMXYSTQisUdi3GUNVk2QJAWnzL0mOxy9FuQ4qBxJBSF
 vDJA==
X-Gm-Message-State: APjAAAWx0OmjAYc7g4S5UiupBlagP6nlgRrAgQ6MBp2UgpAQ5t8Ddz/O
 Q/hKQQoHCEKPKG5iVo9/jybu67zLs9qlfxei+eIbgzbS4aEyg+wvj+bmoeIzx2c4Q6b+NuQRYE5
 xTwJUh4YiSLRqvHA=
X-Received: by 2002:a17:902:a9c7:: with SMTP id
 b7mr16626915plr.133.1568981488423; 
 Fri, 20 Sep 2019 05:11:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxBPDJD16UIz3CYfiovKAnmYPkmTXxyHTxamJ2QTefedGiKTYYpTnhhOK1yZwSZLlR/KH8jnw==
X-Received: by 2002:a17:902:a9c7:: with SMTP id
 b7mr16626896plr.133.1568981488129; 
 Fri, 20 Sep 2019 05:11:28 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id e6sm5244663pfl.146.2019.09.20.05.11.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 05:11:27 -0700 (PDT)
Date: Fri, 20 Sep 2019 20:11:17 +0800
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] kvm: extract kvm_log_clear_one_slot
Message-ID: <20190920121117.GG12858@xz-x1>
References: <1568974882-7419-1-git-send-email-pbonzini@redhat.com>
 <1568974882-7419-2-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1568974882-7419-2-git-send-email-pbonzini@redhat.com>
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
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 20, 2019 at 12:21:21PM +0200, Paolo Bonzini wrote:
> We may need to clear the dirty bitmap for more than one KVM memslot.
> First do some code movement with no semantic change.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

