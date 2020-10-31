Return-Path: <SRS0=iivN=EG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3664EC388F7
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 14:59:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 901DE206E9
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 14:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g1fUHcWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 901DE206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYsM5-0000mv-N4
	for qemu-devel@archiver.kernel.org; Sat, 31 Oct 2020 10:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kYsKo-0008RY-Dh
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 10:58:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46743)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kYsKj-0004xN-59
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 10:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604156300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H6/TIwrKN199Hqu/RMOB5UcPBufI+HtrWBOUpNDaYN4=;
 b=g1fUHcWBQr+5gi2E/f5zmwIxMIfGI7WAHAfzvsSRA6CIjU1Y7SKgU5nFha7ayWYqA+QtgP
 Lk2gC+ym1rFaAskCj+LcXceDEc+vpXXkF3OQn8kbUrVpPFXyF/8Xoc6Yff+KvwAaV5qRd8
 0RGv9Y5h2XkmgF42YxhJ9yRJGor1Dck=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-Ar1ps6ZDMHSMDKD_xj8a7A-1; Sat, 31 Oct 2020 10:58:18 -0400
X-MC-Unique: Ar1ps6ZDMHSMDKD_xj8a7A-1
Received: by mail-wr1-f70.google.com with SMTP id t14so4124338wrs.2
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2020 07:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=H6/TIwrKN199Hqu/RMOB5UcPBufI+HtrWBOUpNDaYN4=;
 b=P68LnE77xjHxyrzLdTxJix5X0eGf2v9slf70DlPJWEiOUwWvCISc8HI5W88sDUDzgj
 VdYpVrUgNWMXUp3wb7FO7ex7cfVm7bYThKLWsIc3BjWhkVB5wUxvuLIMa3RUuPWBkJ8w
 mPMRmNvdI11NulvgAiYkZfkCfnQ2yRnpiT9lab38mPZovY/JLdn4Cu4AGDo2PlYvAtps
 K6Ig09b5ozg4c1ch5UriDIQ0k9ffP4+sf9h6udNJicR1RluWtg4G90kVpDjhAJVLcp/4
 OhsZzUPexSZ0Q26CpriKbTTs1wqCJV1EtO+nU2D8M4RnA/mRDTgRmT7YC/vNrPBBRJO8
 ohuw==
X-Gm-Message-State: AOAM532sdkqLTgAs6f6nL7RMD6/TmTnXh7HuH/OUwE92eww3NqArD0hP
 mNi1XagYEJscatM34wDgvks4VyzZ/P85Rkehjy496NzO0uIIgtPv7VdnHncJ+hQtdfYLG/UiFPj
 elMqruAfaqsoM23I=
X-Received: by 2002:a5d:6086:: with SMTP id w6mr9414265wrt.231.1604156296878; 
 Sat, 31 Oct 2020 07:58:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwawXjzI26XmUjmv4hlTDs4nBsjRBNz+ALvRVYCuStI1XmaCad2auE6nxf6RniCSWOgy+pedg==
X-Received: by 2002:a5d:6086:: with SMTP id w6mr9414256wrt.231.1604156296728; 
 Sat, 31 Oct 2020 07:58:16 -0700 (PDT)
Received: from [192.168.178.64] ([151.20.250.56])
 by smtp.gmail.com with ESMTPSA id f17sm8470173wmh.10.2020.10.31.07.58.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 31 Oct 2020 07:58:16 -0700 (PDT)
Subject: Re: [PATCH 0/2] docs: Fix building with Sphinx 3.2
To: Peter Maydell <peter.maydell@linaro.org>
References: <20201030174700.7204-1-peter.maydell@linaro.org>
 <7ef49ead-40e1-1705-afc3-e94cac2bf5c9@redhat.com>
 <CAFEAcA-qOWGvuzyvht+J_kmj+gBvqPdhiMPVj67R4ds50PjfPQ@mail.gmail.com>
 <CAFEAcA_7dbapFgDQeWObejCTqZOUQ9TxaKfwyELGsKMh+dUQuw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6c1bf7ce-1bfa-ec49-8b9c-098c2a0bf37c@redhat.com>
Date: Sat, 31 Oct 2020 15:58:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_7dbapFgDQeWObejCTqZOUQ9TxaKfwyELGsKMh+dUQuw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/31 08:00:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.257, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/10/20 21:02, Peter Maydell wrote:
> Having actually looked at the current state of the kernel's
> kernel-doc script I see somebody has already done the
> necessary updates for Sphinx 3 compatibility. So we have
> two choices for 5.2:
>  * take this patch 1 as a minimal fix
>  * do the sync of the kernel's version of the script
> 
> I'll have a look at how painful or otherwise the sync is, I guess.
> We only use the kerneldoc stuff in the 'devel' manual which
> is not really userfacing anyway.

Oh nice! I had a slightly older Linux checkout and it wasn't there yet.
 I think you can go ahead with these two patches, I'll take care of the
sync for 6.0.

Here are our two patches.

https://lore.kernel.org/linux-doc/20201030144713.201372-1-pbonzini@redhat.com/T/#t


