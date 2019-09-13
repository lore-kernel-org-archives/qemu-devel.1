Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A8CC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 07:15:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 714E620830
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 07:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 714E620830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8fne-0001ND-Hv
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 03:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60552)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i8flu-0000XB-FH
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 03:13:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i8flt-0006Qi-II
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 03:13:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33960)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i8flt-0006QN-DQ
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 03:13:33 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7239BC0568FA
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 07:13:32 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id o16so1642473wru.10
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 00:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ALRhzYi7NQhezxi+FdiSFqO5Bxaj6dfkdNWFaHyJ5OE=;
 b=kQIClVOpoff31BUoVkA1r1QXqWsqXhRWKJfCeJAwsWYPgsFRdc7ASJeMNSaUhNfbnc
 EzK7WP8Cloou9ExEqsqNEj+xdeh0LAkZ9XWB+CYMJ5/vs38noKKKwuB2YuE4U/glLMl4
 9tjJLJSfiChWbyQjwmPden1hVzbypa2GKoebaJpySToMpGo+Pmam9NIoX5kbdR/fd198
 p1j+iCC0qKW+RIThQUP0pGavlFo5XGey12p/tbmMNJF7PFwoYr6LeDg+hknfU7gQ8o8M
 /vOWJdPX0u82ZoZLFghPThs133l/tYb0T82F6Iznp2JBNGhapeVhl5p6p1CgSnFglHVb
 fONw==
X-Gm-Message-State: APjAAAWc3iKYNk3649XzRvpzVYgMdQNG3hy2yq8aoHIMesllhDNFYqry
 ks9+D0sU4BjnzTzSfxPA23flKcG4miXeyjVAz/aKwLs/iPBPwnBqnbqbkBA7rzNY/W/SJqTCmr6
 OkRuV7PZY9VBC680=
X-Received: by 2002:a5d:4444:: with SMTP id x4mr36899092wrr.11.1568358811086; 
 Fri, 13 Sep 2019 00:13:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyWnd+OzkumlkQoGzfrglxQFyWjVqLgslbWjhtbg1jTpLmmnvBWsDLs9lyI3NSygZP3PsiF3g==
X-Received: by 2002:a5d:4444:: with SMTP id x4mr36899071wrr.11.1568358810802; 
 Fri, 13 Sep 2019 00:13:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3166:d768:e1a7:aab8?
 ([2001:b07:6468:f312:3166:d768:e1a7:aab8])
 by smtp.gmail.com with ESMTPSA id r18sm1673905wme.48.2019.09.13.00.13.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Sep 2019 00:13:30 -0700 (PDT)
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20190911190622.7629-1-dgilbert@redhat.com>
 <20190911190622.7629-2-dgilbert@redhat.com>
 <e8802180-3c9a-97b9-dae1-5e07d7843de3@redhat.com>
 <20190912174524.GD2722@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <cfead2da-0ccd-b629-4e5d-05cdffa34698@redhat.com>
Date: Fri, 13 Sep 2019 09:13:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190912174524.GD2722@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/5] rcu: Add automatically released
 rcu_read_lock variant
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
Cc: quintela@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/09/19 19:45, Dr. David Alan Gilbert wrote:
> Do you think it's best to use the block version for all cases
> or to use the non-block version by taste?
> The block version is quite nice, but that turns most of the patches
> into 'indent everything'.

I don't really know myself.

On first glance I didn't like too much the non-block version and thought
it was because our coding standards does not include variables declared
in the middle of a block.  However, I think what really bothering me is
"AUTO" in the name.  What do you think about "RCU_READ_LOCK_GUARD()"?
The block version would have the additional prefix "WITH_".

We could also add LOCK_GUARD(lock) and WITH_LOCK_GUARD(lock), using
QemuLockable for polymorphism.  I even had patches a while ago (though
they used something like LOCK_GUARD(guard_var, lock).  I think we
dropped them because of fear that the API was a bit over-engineered.

Paolo

