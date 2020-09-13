Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2568C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 14:09:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ED6D208FE
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 14:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SNNtgywV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED6D208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHSgx-00052G-4R
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 10:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kHSgL-0004YY-5O
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 10:08:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31496
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kHSgJ-000341-FW
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 10:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600006118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dkyaZCGkIGWDkLtVBwvumGi4awgPJzwn11MCV+1TxLU=;
 b=SNNtgywVeImzJE+z3TV7+QyQcKpJEqP6vpIE9aF9wVdsBy/Y7fTdXYDE90ySRC2c8P6QP0
 JTvL7q44ERoODuRivmRXcCCjmX12wwYMedh+UGu78PTCAVs+C/8bQUl3qZF/MfXsW9EKvu
 VmbDpiEhE0FstGg490Rb78IfUxgrfGA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-bHK1CNruMFOAImfbZSG2RQ-1; Sun, 13 Sep 2020 10:08:36 -0400
X-MC-Unique: bHK1CNruMFOAImfbZSG2RQ-1
Received: by mail-ed1-f72.google.com with SMTP id r8so8272530edy.17
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 07:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dkyaZCGkIGWDkLtVBwvumGi4awgPJzwn11MCV+1TxLU=;
 b=FXoLH3+yIfo0T0WTtEalYCLLzQYXRZ5BK0EzoQJ3dNqT+Zz54y4HR7EHVjm8sgoTLE
 rqN1AiB7dvyxoIvtb6EU6zM1gmo6OL7pv5vIeYPHDo6IsVzZRW4vMRtuNgy48MJ3znZc
 B0rKNMdnVsI5Vp0iFH3abGUGt7yXXtPrTqiMvoD7+zOjdbHejmMvj2jg8bVdpv5PvaUj
 Qa1AzAVvuAX7MpIBGiA9vX89KYvl7c4voajQD2uHhqd/d0C25/dseJAc+LaxfJZVzf/I
 O8K6WtYaCk6faylofWukKh/pyBysSWdm1HL+5kytEpXKQGDfsxUK12ufKLedMWfDZOUj
 kjqw==
X-Gm-Message-State: AOAM530vC4K9gKMRGqLGksNivCaDNniPdF/tW9VJq2ZXIKZht/UNwPLP
 /vWmNVtcVaYRhRuy/GvrtSJLsQOwwY5xmJHH60dMRQMZRH8uZrc+sEJF/lCxlnB7fiZV4I/0S4m
 wJ1JzW3kr8Z+SjTE=
X-Received: by 2002:a17:906:f6c9:: with SMTP id
 jo9mr10351250ejb.233.1600006115136; 
 Sun, 13 Sep 2020 07:08:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzl9gSq/DoW3lurrpW1ehD10clRMUxbtYGy+cpZEVFoTFy8hF1vtBAuf4Lw/qHefDkyLYJ5uw==
X-Received: by 2002:a17:906:f6c9:: with SMTP id
 jo9mr10351222ejb.233.1600006114947; 
 Sun, 13 Sep 2020 07:08:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:edca:afb8:6969:492b?
 ([2001:b07:6468:f312:edca:afb8:6969:492b])
 by smtp.gmail.com with ESMTPSA id q11sm6735971eds.16.2020.09.13.07.08.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2020 07:08:34 -0700 (PDT)
Subject: Re: [PATCH v8 27/27] Revert "configure: add --ninja option"
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20200912224431.1428-1-luoyonggang@gmail.com>
 <20200912224431.1428-28-luoyonggang@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <34306ec4-bafb-20dc-f90f-ff320fa4b575@redhat.com>
Date: Sun, 13 Sep 2020 16:08:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200912224431.1428-28-luoyonggang@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 07:31:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/09/20 00:44, Yonggang Luo wrote:
> This reverts commit 48328880fddf0145bdccc499160fb24dfabfbd41.
> 
> The --ninja option doesn't need anymore because of upgrade meson to 0.55.2
> At that version we can use ninjatool

We might actually get rid of ninjatool before QEMU 5.2 goes out, if we
decide to make Ninja a mandatory build dependency.  So we can hold on
patches 26 and 27.  Thanks for testing though!

I'm also not sure about patch 16, since that's not my area, but Daniel
and Ed both reviewed it so that's okay.

Finally, instead of checking !_WIN32 it's better to check CONFIG_POSIX
or CONFIG_WIN32.  That can be changed on commit though.

Everything else seems okay.  I'll wait a couple days and queue the whole
bunch up to patch 25.

Paolo


