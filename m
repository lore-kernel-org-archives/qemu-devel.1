Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7561C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 14:30:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 180002083B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 14:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+fWdaJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 180002083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kagHO-00063E-Sv
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 09:30:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kagFq-0004TN-1o
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 09:28:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25895)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kagFn-00043J-Mx
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 09:28:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604586522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1JrqMR42wthF6XW+e2mzn6VUVWmFWeb1d+kdctR7h3I=;
 b=Y+fWdaJ5DvQ3Ks5eNvfeLCmbrdOq7QpWfTCMfHU336PDZdQWuZ+G497kaa4C0JPYecbhyJ
 iO9nb9yKbqBfE5a14qUEZJXGaMQRa9VLa1RZgK4oJuYeHOAvAzAil+6DT6TcHF19HptlHT
 n9SPDn+lYKLPipTrJw3zmuKICafxuPE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-z6JzhcYcOYqW1uDHOuUICg-1; Thu, 05 Nov 2020 09:28:40 -0500
X-MC-Unique: z6JzhcYcOYqW1uDHOuUICg-1
Received: by mail-wm1-f72.google.com with SMTP id c10so684226wmh.6
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 06:28:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1JrqMR42wthF6XW+e2mzn6VUVWmFWeb1d+kdctR7h3I=;
 b=OmDeTmbzD9z+leHj3Qmc9WLpaEvmU/M/iJUoWxbEMlIvltMo/0Mn9hBl4PvyxnTrOC
 MrrSqeWwGJvn63Rx/HsVNWflyz18Kv1wWrTg/gZPzFrSElUBqYkSXGLgU79+EgGcmSxV
 7GXA5/2mFxqoy0pFQGO4BkbnoMTchjTyjS4rKuJU/a5Fam8YhQ6KopOOjFIYIdMjreHP
 IWoFzej1bTKn1g90lsSQejwrZ2WPjCQT+ZQvVgV6MPxo9OLjiLo+jhcBUMm/Z1sF7w6T
 EDHGMKTKEQb81PXyJcBjVwtzGHGO3Pskip0q1Wxjd8K5bW+Ay06rz+KLrTsCacG2of0M
 TSag==
X-Gm-Message-State: AOAM532PMnIdueHvUFBpOVFgBjLji3gb3KjnPK40mJUCu4SYvI/nl2kE
 b4CuQ/qY/qTGkamwDvf483LyCb5DMJe/p3zdR8EnPHG/CTSaA+44NpjKzRpqLLKoCnVpVylmqeu
 0QYEs5kzlCA9CeSM=
X-Received: by 2002:a05:600c:2282:: with SMTP id
 2mr3248214wmf.154.1604586518463; 
 Thu, 05 Nov 2020 06:28:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzfGpEXYubYBTsPorqQiJhFOnXzW13I9wIp7aDW9lJzbJtOwR0ng8QfVG0q2+Egf4+JkrjxSg==
X-Received: by 2002:a05:600c:2282:: with SMTP id
 2mr3248202wmf.154.1604586518355; 
 Thu, 05 Nov 2020 06:28:38 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id b1sm3080669wmd.43.2020.11.05.06.28.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2020 06:28:37 -0800 (PST)
Subject: Re: [PATCH 5/6] xhci: fix guest triggerable assert
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20201105134112.25119-1-kraxel@redhat.com>
 <20201105134112.25119-6-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b9ce6e4c-2ae4-2c18-fa3b-2f1a0713dd15@redhat.com>
Date: Thu, 5 Nov 2020 15:28:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201105134112.25119-6-kraxel@redhat.com>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/20 2:41 PM, Gerd Hoffmann wrote:
> We didn't start any work yet so we can just return
> at that point instead of asserting.
> 
> Buglink: https://bugs.launchpad.net/qemu/+bug/1883732
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/usb/hcd-xhci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


