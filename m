Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B75C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 17:17:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C4F825342
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 17:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Djfkz1bS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4F825342
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSNvm-0004yZ-CM
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 13:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kSNv0-0004Ee-2Y
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 13:16:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46175)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kSNut-0000gy-In
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 13:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602609409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mbd51cFBxe+XUw/BaRsDfnw6Rspo0/0Cx5mNXVWCiAw=;
 b=Djfkz1bS24stcDLsrdTt4J/zyb/fZA259j+En9fHd9YjJwFhb79pUW44cDhLiPqdk8jt4O
 I6ed9McG7rwbHUd5HALTTkP0aaiewSMuNKam4rpSiZXTBkjWh/Fl1lrQJQh3rhOXBNvGhx
 2MFr9VM1wrwsJp2Waf57DNYq8F/6TYI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-RJW9Y4HMOg6qLRVL1F0Wmw-1; Tue, 13 Oct 2020 13:16:47 -0400
X-MC-Unique: RJW9Y4HMOg6qLRVL1F0Wmw-1
Received: by mail-wr1-f70.google.com with SMTP id k14so85224wrd.6
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 10:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mbd51cFBxe+XUw/BaRsDfnw6Rspo0/0Cx5mNXVWCiAw=;
 b=niwrDNziH9Xtw6T5Mpej4SkAr18rDf/FMacm+1fjopXsySOFxczaYRnXvxUvg2w/Pj
 RjOgHrti2LGbqmAMFNJePyZU60WPwnMbW8I9WXUllZ810fywW4Uc2atPAmApKDziIiDQ
 UdSngFVDXvCXIcw3FnBL7Yhg2gSvHK0H00/fZSr2GhdT5FK7t//+TO0w1U7s3ixe0qtY
 O53EDum7ZQVatgIjr1J3qV9owJrdaLE/9ffFQ/NYY7NiG8hc3FzHAjJbIYDk9V0uGn01
 cEG/xRO0NZV2Pqqj5OXg5MHTax/UDULndMXSDt66yG2LXJhPE1AArXaH91roTPyYE0lI
 ff8w==
X-Gm-Message-State: AOAM532WE/yIQL8Hxqm3uH/5Tk06Dnajdh/DXyv+At51X+0G/VbHFzUc
 KKvfSOxPyeEHN9jWzheWYqNNBOSmzage+ucU/KLaL9GPlAsn0CPe27Dy5XFuEzFqa1aIfnNHSfA
 c2ocZ+LfCnPS7WIc=
X-Received: by 2002:adf:ab50:: with SMTP id r16mr709723wrc.235.1602609406298; 
 Tue, 13 Oct 2020 10:16:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqvJcVbb6P2cHgVEVaTt5MgwUbDl0AbzF1nLxhSnu5jh3qcI8p8DLescv9YGK+kKeOV6PDXg==
X-Received: by 2002:adf:ab50:: with SMTP id r16mr709694wrc.235.1602609406080; 
 Tue, 13 Oct 2020 10:16:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:61dd:85cb:23fc:fd54?
 ([2001:b07:6468:f312:61dd:85cb:23fc:fd54])
 by smtp.gmail.com with ESMTPSA id h16sm276181wre.87.2020.10.13.10.16.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 10:16:44 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] Add Xen CpusAccel
To: Jason Andryuk <jandryuk@gmail.com>, qemu-devel@nongnu.org
References: <20201013140511.5681-1-jandryuk@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ddb5c9c2-c206-28d6-2d9d-7954e7022c23@redhat.com>
Date: Tue, 13 Oct 2020 19:16:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201013140511.5681-1-jandryuk@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Claudio Fontana <cfontana@suse.de>, Anthony Perard <anthony.perard@citrix.com>,
 xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/10/20 16:05, Jason Andryuk wrote:
> Xen was left behind when CpusAccel became mandatory and fails the assert
> in qemu_init_vcpu().  It relied on the same dummy cpu threads as qtest.
> Move the qtest cpu functions to a common location and reuse them for
> Xen.
> 
> v2:
>   New patch "accel: Remove _WIN32 ifdef from qtest-cpus.c"
>   Use accel/dummy-cpus.c for filename
>   Put prototype in include/sysemu/cpus.h
> 
> Jason Andryuk (3):
>   accel: Remove _WIN32 ifdef from qtest-cpus.c
>   accel: move qtest CpusAccel functions to a common location
>   accel: Add xen CpusAccel using dummy-cpus
> 
>  accel/{qtest/qtest-cpus.c => dummy-cpus.c} | 27 ++++------------------
>  accel/meson.build                          |  8 +++++++
>  accel/qtest/meson.build                    |  1 -
>  accel/qtest/qtest-cpus.h                   | 17 --------------
>  accel/qtest/qtest.c                        |  5 +++-
>  accel/xen/xen-all.c                        |  8 +++++++
>  include/sysemu/cpus.h                      |  3 +++
>  7 files changed, 27 insertions(+), 42 deletions(-)
>  rename accel/{qtest/qtest-cpus.c => dummy-cpus.c} (71%)
>  delete mode 100644 accel/qtest/qtest-cpus.h
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>


