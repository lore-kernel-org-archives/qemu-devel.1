Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C13C388F7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 19:17:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 590B220867
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 19:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFHq+AaH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 590B220867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kakl5-0005NT-6c
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 14:17:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kakjb-0004iW-Pz
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 14:15:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46370)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kakja-0006wI-4I
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 14:15:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604603744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zfHkRg9lIDVW7VftAA3B1DAo0AYHo0uxnJbSHZqoR04=;
 b=MFHq+AaHVlqMVupDv2vj/eTiKI83O1a3ukEJsrUUQ8FjE3kgy7ISKm0pMoNZnpkuVnuQdF
 JjVNS1IL62Z/Q0sDsS5wq8Z7G66HoJXurQkT/W5r1qcYJzyjSmGVdLLRqAFyJla/IqfDkJ
 XVlJI+CvrM1JGmFGQxk687tjcuxIkHI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-FoViiBwNPuOqBCmGXpdhjQ-1; Thu, 05 Nov 2020 14:15:42 -0500
X-MC-Unique: FoViiBwNPuOqBCmGXpdhjQ-1
Received: by mail-wm1-f69.google.com with SMTP id s85so690568wme.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 11:15:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zfHkRg9lIDVW7VftAA3B1DAo0AYHo0uxnJbSHZqoR04=;
 b=WXrWhwNF9ScBg9T5HRWdS1z0nfpC39/j0qBIG83iAr+mp5SATaJipzSCoEdO/cxIco
 zqhxgap/nzH5fRd/oSwMgRHWjKgOahKblf2Q1VZ84OwLye+mSG0EkMnveVaIoQ1LffET
 DeeDfpTdAw37u8fpUKm6vbYPGB9yJTOroi8T510CLuYOKhCzf6t6h1sxK24meffTFXVn
 sXRHVChCg7ZoWLYUybMALCZdL4oyq/0+dz5tf0d6+kQnSCdFeyqJ3L6WF+z4lQ8U9Be5
 Uw2WRQ3PuQVNq5klFMXRgVXWY+ASOWLNBGifdOp/H49JLp+bmcDvPvrcnGR4I0c/k/W9
 bZeQ==
X-Gm-Message-State: AOAM532qtvsO8qzgFIjMX5ojZwVzo2gBRfv9J9xF+EUoD332TQ/zNPI5
 0LaucuADiUpWNlv0blBiWVpEbjQRFpt5LmFkfk4x8fESPCayt/gRZzdtMA9+MHUGsTepkMIYTUm
 ReOI/pSxWICZe1Qg=
X-Received: by 2002:adf:ef45:: with SMTP id c5mr5021790wrp.117.1604603741633; 
 Thu, 05 Nov 2020 11:15:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxjKHKzVkbOCoUNiT6e3SRf5UgENSEyZ68H6dNtmYVGkBBAE0Ev1sUGISelLf4x7w4/vZM17g==
X-Received: by 2002:adf:ef45:: with SMTP id c5mr5021766wrp.117.1604603741443; 
 Thu, 05 Nov 2020 11:15:41 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id l1sm4338333wrb.1.2020.11.05.11.15.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2020 11:15:40 -0800 (PST)
Subject: Re: [RFC PATCH 11/15] include/hw/xen.h: drop superfluous struct
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20201105175153.30489-1-alex.bennee@linaro.org>
 <20201105175153.30489-12-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <43ed2ab8-abee-fc88-46cd-ff8d531753fa@redhat.com>
Date: Thu, 5 Nov 2020 20:15:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201105175153.30489-12-alex.bennee@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, julien@xen.org,
 masami.hiramatsu@linaro.org, Paul Durrant <paul@xen.org>,
 andre.przywara@arm.com, stefano.stabellini@linaro.org,
 takahiro.akashi@linaro.org, Anthony Perard <anthony.perard@citrix.com>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>,
 stefano.stabellini@xilinx.com, stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/20 6:51 PM, Alex Bennée wrote:
> Chardev is already a typedef'ed struct.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  include/hw/xen/xen.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


