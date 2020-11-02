Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4D4C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 14:11:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB7E02465D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 14:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UGP3y5j0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7E02465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZaYK-0005Wh-Os
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 09:11:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZaXi-0004ye-9F
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 09:10:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33443)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZaXg-0001l1-Jl
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 09:10:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604326239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qp9Y2vnhGdnuDqvombI5JGQg3DjaP/IrqDIn1C/i9Hs=;
 b=UGP3y5j0Pb4s4OrY6TlgjLZ3wF+LFtv2qoL1ZyvgCUbDwbFkP3gk0XlNgPkXP91HsDqf07
 JbM/JLg4Opi5zjRsucnQ1OY+Npt3rccBRzCgdw/EYgRvNmbW63AVih32AdHQi4aDXdG0Gw
 cy/wvOgKHLxfxGma7KLAj5mZsbHQU4s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-sHp2lrvJOx67v7zoe_K4dQ-1; Mon, 02 Nov 2020 09:10:38 -0500
X-MC-Unique: sHp2lrvJOx67v7zoe_K4dQ-1
Received: by mail-wr1-f70.google.com with SMTP id t14so6525433wrs.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 06:10:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qp9Y2vnhGdnuDqvombI5JGQg3DjaP/IrqDIn1C/i9Hs=;
 b=GZboB1fOBZDti58+8G99IxVtaYEpEAC3CrfhTY9zInUNZVgJlXNv9brpepWezG+VQK
 HkZaYC1NaGOhqvtiUO7xzzaoHdJRdMlpNC9gd8LoMiy1bR96f6+o056ASVbC3P45tNky
 umeBpWypn1nQsDnOYR2SivxuvY/t1Umi3pPnoOTCtD9W6sfmPgXubzwqz+GHdcFsWhjq
 HFb8np5kk3bA03G3heRP1TO75w1AlzS2XVXDbEVspwgioARl5hqwUt4NqRNEn6yp3NE9
 kE3S/dz9VEkCDcWl9BtZabTwcGbk4hESGclCoZc0aO2FkdE/6drfWmR/z9I1Ee8CwIZl
 b0cA==
X-Gm-Message-State: AOAM531bXrxyz6ImEhmZdwMjRqkOF1rvIb1IUPUYCMw4krP/59RSys5V
 ByRUamS/oOhXcjI9/efIYpUnbUK4VdocwnKO5CGJESZTgDZ9ltHjP3U2XzsQiKm4JtTaOfGsoeh
 KctRIUUSjFKjllMI=
X-Received: by 2002:adf:f247:: with SMTP id b7mr21994668wrp.56.1604326236939; 
 Mon, 02 Nov 2020 06:10:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz2+OYcCcCoLst2FhZq3Czyz4fBrJW/kpvdNYF1oTV3lcRljgqzLaBVncxGJBwEYKQiAwEf8A==
X-Received: by 2002:adf:f247:: with SMTP id b7mr21994639wrp.56.1604326236738; 
 Mon, 02 Nov 2020 06:10:36 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id o3sm21639513wru.15.2020.11.02.06.10.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 06:10:36 -0800 (PST)
Subject: Re: [PATCH v2 01/11] test-util-sockets: Plug file descriptor leak
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20201102094422.173975-1-armbru@redhat.com>
 <20201102094422.173975-2-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <dd6a2fa0-ccb4-9971-5b77-450a4d3e4db1@redhat.com>
Date: Mon, 2 Nov 2020 15:10:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201102094422.173975-2-armbru@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
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
Cc: kwolf@redhat.com, berrange@redhat.com, zxq_yx_007@163.com,
 kraxel@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 10:44 AM, Markus Armbruster wrote:
> Fixes: 4d3a329af59ef8acd076f99f05e82531d8129b34
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-util-sockets.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


