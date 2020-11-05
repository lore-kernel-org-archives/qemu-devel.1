Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA366C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 14:29:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40D3E20786
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 14:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NlTZD0Vc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D3E20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kagGs-0005JR-7Y
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 09:29:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kagFV-00040r-Sd
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 09:28:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39607)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kagEx-0003mS-N2
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 09:28:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604586470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H64/wAykqfUn6q/d76ZD+tObfQ4gIw5MXnjuos6fv3k=;
 b=NlTZD0Vc95gqxpKyGYn5D4ELbQG8ECNPNcfQ1D/5ojcSda98D8QEBZpp4XdUWi4AetZA6W
 ojq5x8KHINNxwxuuQyLFyEkN9qpxeYgHbItXNYp370yhzn7OiugUXZNilx/uJ1oCD55buO
 T6OK6HWb4FPWsLLaraDvRPqjuEHGVh4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-qm0ikdhyMo2eV0TDoKQKow-1; Thu, 05 Nov 2020 09:27:30 -0500
X-MC-Unique: qm0ikdhyMo2eV0TDoKQKow-1
Received: by mail-wr1-f72.google.com with SMTP id m4so767306wrq.23
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 06:27:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=H64/wAykqfUn6q/d76ZD+tObfQ4gIw5MXnjuos6fv3k=;
 b=qkGMh3qJJkrsPBitn+vr+d5aw0WXXx+68+06R3nXqKzaZMFJWlWyQjBercX6/X0+SA
 gY6cdQdBiFS/nD2T3ocKpmYsKFZqUeFu/zFDmcZwCSs14Y8+hVfDrBv3mVQSufS0MdOO
 jHrBDUDAf2/k+B+X3cS1LPUUOU8aAmmbwE5QY374e/gj3+cz+UVG9UQOjFgcKwqeXXxl
 XJ7X6PnHMCMAPN6G0n4oH/NToo7vAz3Bjm/iyNO402QAX3q9g9bSKZDxsm3d1n4PcF72
 ppVSLTPUwO65dcxuG3ADoM3QQ1uri+0pgKSmjkeBoEzGntd5b7VbZr8G1QTWJaujKYDq
 V2kg==
X-Gm-Message-State: AOAM530zPl5BrqFU0XHTDAfzKGsz4Rf0SWdTb/Chd2vSzuL3CDZYlz+T
 rhhBniZQ6Gcq9dR7MOi5K1hf2a3HmsJcOvbbdxb1ihNNC1pIUdOPbsQC0MWeBuLOP5xPItLfKs+
 U1QDjzctjFDTukAk=
X-Received: by 2002:a1c:8194:: with SMTP id c142mr2943446wmd.94.1604586448431; 
 Thu, 05 Nov 2020 06:27:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgBCWeEYUUot5qfWgSkGufLHfTbOGBndo2wsmwQQ0Ggropgnu/fx9jiJadhyk4rEGl9B6VOw==
X-Received: by 2002:a1c:8194:: with SMTP id c142mr2943431wmd.94.1604586448245; 
 Thu, 05 Nov 2020 06:27:28 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id x7sm2693100wrt.78.2020.11.05.06.27.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2020 06:27:27 -0800 (PST)
Subject: Re: [PATCH 2/6] usb-storage: add commandlog property
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20201105134112.25119-1-kraxel@redhat.com>
 <20201105134112.25119-3-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <67e82934-52a1-f7a1-03e6-af3fd7d6386e@redhat.com>
Date: Thu, 5 Nov 2020 15:27:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201105134112.25119-3-kraxel@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 01:14:53
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/20 2:41 PM, Gerd Hoffmann wrote:
> Add property so scsi command logging can be switched
> at runtime instead of compile time.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/usb/dev-storage.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


