Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0435C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 07:58:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C520223AC
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 07:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7z2KhiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C520223AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWxOe-0000h4-Vv
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 03:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kWxNx-0000E0-Eq
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 03:57:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21810)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kWxNv-0001IN-Mk
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 03:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603699062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EgyA620ZbDwDcM1+E0O5qURI9RWQuJVzwYvDSBgh7dw=;
 b=P7z2KhiKjwQVpNPbnkHLfoWQnOUY3k44GSbXmk+AzsWcRXpFiM1DMerz1Plj3xzQO9TgL3
 vkU2Dj7EFI4Egs170sIMThYFDuKhzqMvIKNncpSBD1OcFESHO0cNeQX532FgHp5cGnh7c8
 CgMplMr2uc3jjZtdAgeac2x+77pFqTE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-FI__EcOQMEeBdxYGXzXdMw-1; Mon, 26 Oct 2020 03:57:40 -0400
X-MC-Unique: FI__EcOQMEeBdxYGXzXdMw-1
Received: by mail-wr1-f69.google.com with SMTP id q15so7997999wrw.8
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 00:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EgyA620ZbDwDcM1+E0O5qURI9RWQuJVzwYvDSBgh7dw=;
 b=iakPsiMXUBqG7ZO7xta2KTpK9ZS8bETeZlct4rlBYTnXXM3EC9DIrWTNBPwTf0GcGa
 rEVGxzy9bRLRiC/nJtgkl05iCxJ+NG1uvrkxp/5EVihQH+0yCpn7Js7Cks4N/1baBNS0
 2KjtW75MUTHhELtlTM8w65SeagFZRPnWAcytw0IGGheX6nVOYut94ytvR+cjcuASvQJC
 Mp25jZ0tioBMkC0FHkPxwI6xwap6XjWQTFgWr8I2Mfk8yA9pp1Zb+4Acc0Lhgvuw+CXY
 ypi9tsSouKEJrAPGrwvg4HV2eDRdy3+AXjCZnyPJZmIOZgAVf2WUQ+hxrO8EfZYqKuOT
 o2DA==
X-Gm-Message-State: AOAM532HefH6C8KPCfd1GLiyAZlemKmXfitGkE9FVCp4tKnW/QTbNVbb
 AVlZiL1tz73O5rNwwzqrPME0cwzXPshPLhU52hk+POqMRsLJVBLfIWmTjBthA75Jl6rTT1uPFXm
 bcGSqSVm59qmcFGE=
X-Received: by 2002:a1c:a90e:: with SMTP id s14mr15109006wme.46.1603699059423; 
 Mon, 26 Oct 2020 00:57:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnn+xIjWbd/fBlNzm3FtnOBMA9jjSzHeeJVVrs6blCpU+V7Eg/vL0Agyj21WD4/0YLGXQKhQ==
X-Received: by 2002:a1c:a90e:: with SMTP id s14mr15108996wme.46.1603699059195; 
 Mon, 26 Oct 2020 00:57:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id y4sm18554358wmj.2.2020.10.26.00.57.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 00:57:38 -0700 (PDT)
Subject: Re: [PATCH] win32: boot broken when bind & data dir are the same
To: Sunil Muthuswamy <sunilmut@microsoft.com>,
 Markus Armbruster <armbru@redhat.com>
References: <SN4PR2101MB08802BF242C429A15DDB32ACC01B0@SN4PR2101MB0880.namprd21.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9a206344-aa59-fbba-938d-9def34b18c31@redhat.com>
Date: Mon, 26 Oct 2020 08:57:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <SN4PR2101MB08802BF242C429A15DDB32ACC01B0@SN4PR2101MB0880.namprd21.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/10/20 11:14, Sunil Muthuswamy wrote:
> With upstream commit#ea1edcd7da1a "vl: relocate paths to data
> directories", the data dir logic was unified between POSIX &
> Win32. That patch moved to using 'get_relocated_path()', to
> find the data dir. There is a latent bug in get_relocated_path
> which can cause it to spin indefinitely, when the bind dir is
> the same as the passed in dir (in this case, it was the data
> dir).
> 
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> ---
>  util/cutils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/cutils.c b/util/cutils.c
> index be4e43a9ef..c395974fab 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -949,7 +949,7 @@ char *get_relocated_path(const char *dir)
>          bindir += len_bindir;
>          dir = next_component(dir, &len_dir);
>          bindir = next_component(bindir, &len_bindir);
> -    } while (len_dir == len_bindir && !memcmp(dir, bindir, len_dir));
> +    } while (len_dir && len_dir == len_bindir && !memcmp(dir, bindir, len_dir));
>  
>      /* Ascend from bindir to the common prefix with dir.  */
>      while (len_bindir) {
> 

Queued, thanks.

Paolo


