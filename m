Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91964C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:29:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C795922206
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iudSYD/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C795922206
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKm6d-0001Zu-Mm
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 13:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKm4z-0000rM-8m
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:27:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21143
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKm4x-00023t-3l
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600795665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cC4vNo1CO1QG+EAvLuU0GIE7LU6JKUJNQ2JWRq7ZBKk=;
 b=iudSYD/UsjzG7N+syfuEKypsCQHqq35+LIP2XLVOCALQGwslScIhXZVDdsii31MsFsSU6w
 gzvh5QpC9b7IHYnxlTUDJWHlMDGQP5I7886O9MkXZSTjl2Ch2odzxSEyI+iVWkAua5i743
 lcdRksv5iumcJ2RDnLZbPIrhdfhgHBU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-YOQGn28fPKia3jQjMxlKtA-1; Tue, 22 Sep 2020 13:26:45 -0400
X-MC-Unique: YOQGn28fPKia3jQjMxlKtA-1
Received: by mail-wr1-f72.google.com with SMTP id l9so7664255wrq.20
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 10:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cC4vNo1CO1QG+EAvLuU0GIE7LU6JKUJNQ2JWRq7ZBKk=;
 b=VQ7cVRzkwp0H0zgvoRtLG64BrQX2EXVA/d9aK+jB5BiArSIapzPYJqdF02wH1kzpup
 K+mbl6+pzRhX1WBsN+TnEkuBoEyPDBUA6jcj6vi64cWtM9BRxReN1SpbYa/PwgTkLhok
 MbflBfGuLNvEo/bcUiglq6HW12JZDPZCMRvbta6/eYfT6I1z6lzpVI4rUxQKbfMtMur/
 +H1ZMDJkzgrV4vw4oDEebRkfKZqXeBS1kq7Xw6m9Cw0fobP5TpoZvUEodVo6ddQ/H4+t
 cdjVwZe8/22fjYmVuoBRor4dbFT2o08NrzxlfwHoTQPLF+mpHFifBmCtIuV2QUfzZ1sA
 xRSA==
X-Gm-Message-State: AOAM530fG+rwWxnHOYyIb62ew9spR5EBdnYyHW4A8WQaPLDpME3g3nd7
 FcDXNX9w3klNivpTISHM0zNiPuW/zDTE3JV7LZ2fUDTxE78ffjjeeJRNtq1cWPsQpoMKtqOHLJ8
 2kIST8gSmq8/A6lg=
X-Received: by 2002:a5d:5281:: with SMTP id c1mr6523680wrv.184.1600795604403; 
 Tue, 22 Sep 2020 10:26:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzf78yXN9H1JnVlY2+AexGoxAZKl2EPY6g9RFBEDnRWEM1a5qJL0n4COjK00SE5kH31DZ3Lig==
X-Received: by 2002:a5d:5281:: with SMTP id c1mr6523659wrv.184.1600795604218; 
 Tue, 22 Sep 2020 10:26:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec2c:90a9:1236:ebc6?
 ([2001:b07:6468:f312:ec2c:90a9:1236:ebc6])
 by smtp.gmail.com with ESMTPSA id e13sm31243921wre.60.2020.09.22.10.26.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2020 10:26:43 -0700 (PDT)
Subject: Re: [PATCH] i386: Don't try to set MSR_KVM_ASYNC_PF_EN if
 kernel-irqchip=off
To: Eduardo Habkost <ehabkost@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20200922151455.1763896-1-ehabkost@redhat.com>
 <87v9g5es9n.fsf@vitty.brq.redhat.com> <20200922161055.GY57321@habkost.net>
 <87pn6depau.fsf@vitty.brq.redhat.com> <20200922172229.GB57321@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b22127f4-9a68-99b8-bf55-b6ede236dee0@redhat.com>
Date: Tue, 22 Sep 2020 19:26:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200922172229.GB57321@habkost.net>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 12:04:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, 1896263@bugs.launchpad.net,
 kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/09/20 19:22, Eduardo Habkost wrote:
> If it was possible, did KVM break live migration of
> kernel-irqchip=off guests that enabled APF?  This would mean my
> patch is replacing a crash with a silent migration bug.  Not nice
> either way.

Let's drop kernel-irqchip=off completely so migration is not broken. :)

I'm actually serious, I don't think we need a deprecation period even.

Paolo


