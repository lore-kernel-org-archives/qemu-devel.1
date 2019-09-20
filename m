Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659A1C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 14:05:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AD3320644
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 14:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AD3320644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBJX9-0004aW-94
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 10:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58452)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iBJV4-0003dA-QA
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:03:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iBJV3-0007Pz-Rr
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:03:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52756)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iBJV3-0007PY-MI
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:03:05 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DF18B86668
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 14:03:04 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id n3so1270945wmf.3
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 07:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cLoiWjozIEej5d+FLXMIkj6zOMqsyfXL3YyshI0J/sY=;
 b=hnGBHCDfwuE1Xk1JYBJDrwVqNHSlRsGUul16v7Snr5Y1VMajXq/8OUkB19H3Kl/WpH
 VWYHQeSuZg71vb1A5ek72riIc2ala3BDET/XSPPBa7Ofxq+qeZbPkH62qSdQLbaIW3EG
 JJHt/RIj6eLhkdQKPn5mGEMllZjwMA9llNJOM8pPpXHEQJg74hnQfYJVwxlqX5yWh7nV
 SZzZEZYPSnF2XsZa7KLR9Vs9Z0iU60HV39Fut2B7+SIsCoFzmLAgjCghrLmQsSGJiIP+
 xaRXDILsyZ8MqhIQr66CsX9q+yZUwVnqZy8dVa6ek1geTzs0wtroKCDccIzWSFNesK1a
 mX9A==
X-Gm-Message-State: APjAAAXF+p0dIDOcp2G9dWLWcAlsufL7AfxF31eot3II6FNtCWWK9j+r
 zAnf0gD3IkrAiRmEd8XerAE4+wna6cy+WXZHKW2LZFC5AKF8N0M6OBwoHi2qKPrUpaE9Xt1nkV/
 dAE320EXB0JNFw+M=
X-Received: by 2002:adf:f112:: with SMTP id r18mr12693561wro.88.1568988183581; 
 Fri, 20 Sep 2019 07:03:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzkmkDs/Qr2cCV278FWpjxx4TxYqJHjlKw6FVMpwYVr/NC0XZ0iAAP2tujthTrPwPRnw3ynNw==
X-Received: by 2002:adf:f112:: with SMTP id r18mr12693529wro.88.1568988183288; 
 Fri, 20 Sep 2019 07:03:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c46c:2acb:d8d2:21d8?
 ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
 by smtp.gmail.com with ESMTPSA id l6sm2156950wmg.2.2019.09.20.07.03.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Sep 2019 07:03:02 -0700 (PDT)
Subject: Re: [PATCH 2/2] kvm: clear dirty bitmaps from all overlapping memslots
To: Peter Xu <peterx@redhat.com>
References: <1568974882-7419-1-git-send-email-pbonzini@redhat.com>
 <1568974882-7419-3-git-send-email-pbonzini@redhat.com>
 <20190920121813.GH12858@xz-x1>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <09f006cf-d1ee-4639-50c8-cf8eb95d4fc2@redhat.com>
Date: Fri, 20 Sep 2019 16:03:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190920121813.GH12858@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

On 20/09/19 14:18, Peter Xu wrote:
>   (1) memory region aliasing, hence multiple GPAs can point to the same
>       HVA/HPA so we need to clear the memslot dirty bits on all the
>       mapped GPAs, and,
> 
>   (2) large log_clear() request which can cover more than one valid
>       kvm memslots.  Note that in this case, the mem slots can really
>       be having different HVAs so imho it should be a different issue
>       comparing to (1)
> 
> The commit message says it's solving problem (1).  However for what I
> understand, we are actually doing well on issue (1) because in
> memory_region_clear_dirty_bitmap() we iterate over all the flat views
> so that we should have caught all the aliasing memory regions if there
> are any.

There could be two addresses pointing to the same HVA *in the same
flatview*.  See for example 0xe0000..0xfffff and 0xffffe000..0xffffffff
when a PC guest is started.  In this particular case
0xffffe000..0xffffffff is ROM, so it's not an issue, but in other cases
it may

> However this patch should perfectly fix problem (2).  Am I right?

I hadn't thought of problem (2).  I guess without Igor's work for s390
it does not exist?  But yes, it fixes it just the same.

Paolo

