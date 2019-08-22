Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1617BC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 16:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB73E233FD
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 16:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB73E233FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0q9H-0002jn-2r
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 12:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0q7n-0001g3-Mh
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 12:39:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0q7m-0000d2-Ii
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 12:39:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57422)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0q7m-0000cZ-9N
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 12:39:46 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2F809C057FA6
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 16:39:45 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id t9so3463265wrx.9
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 09:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SpX3ut6lI999gVdn81kmIakC3FjE1qZ82bbAOhbR8g0=;
 b=eZX8f7b9u1cgKFhQLHLRNNLgPwe0jY9h0XeXG0QJTx8eg8wGsHfl8sYC6R5CsCQlQs
 O22dQgUFq41uA+hX8iSjFJLGCmsoWdcAzviEsIDSyonf/6NUxPopiaFcCi1GlPCC+9yP
 19mIc9KA27LOEUx8Gs610Igd1ym1A5OKLxRfKgwI4YUQHfo/rTpqToVNpC50DcBDAHhX
 RD9brfulF+A5L2FaOo1U15coBC4NjTmmTBTAJKkthPCyzBnnZK44ne57bbtuVSHLRy+0
 4RGag4RNisojkVBml1KfX/Z5tInPBoAhrwl7JUP2bS0hZHI74oYjTFDqzZlTR7mOkxIr
 LoSA==
X-Gm-Message-State: APjAAAX4h/1vquxIat2FAVh5LYQOID6mLAIO+cq9BwrjgETtUCkAzcqY
 PaeVl3OnNX0jWn1/UMjz0VM1Jvh0DqAPdT3hodi8jX2Ook+6bZtIyyYn1+grPfPxikQkurclVry
 ppGhRijKAnp4hXrg=
X-Received: by 2002:a05:600c:228f:: with SMTP id
 15mr7080761wmf.160.1566491983855; 
 Thu, 22 Aug 2019 09:39:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwxfBp3IL8H6Ax2DMiXMZ25YugWbgUkyYZnIhYjOLxmVEWBNc+Pk6B6HqciWnHCgXZcGkueIA==
X-Received: by 2002:a05:600c:228f:: with SMTP id
 15mr7080733wmf.160.1566491983562; 
 Thu, 22 Aug 2019 09:39:43 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:21b9:ff1f:a96c:9fb3?
 ([2001:b07:6468:f312:21b9:ff1f:a96c:9fb3])
 by smtp.gmail.com with ESMTPSA id r17sm147613wrg.93.2019.08.22.09.39.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2019 09:39:42 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190822133846.10923-1-armbru@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d5a993f3-0793-182b-f1ff-658801455cfd@redhat.com>
Date: Thu, 22 Aug 2019 18:39:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822133846.10923-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] pr-manager: Fix invalid g_free() crash bug
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-stable@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/08/19 15:38, Markus Armbruster wrote:
> pr_manager_worker() passes its @opaque argument to g_free().  Wrong;
> it points to pr_manager_worker()'s automatic @data.  Broken when
> commit 2f3a7ab39be converted @data from heap- to stack-allocated.  Fix
> by deleting the g_free().
> 
> Fixes: 2f3a7ab39bec4ba8022dc4d42ea641165b004e3e
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scsi/pr-manager.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/scsi/pr-manager.c b/scsi/pr-manager.c
> index ee43663576..0c866e8698 100644
> --- a/scsi/pr-manager.c
> +++ b/scsi/pr-manager.c
> @@ -39,7 +39,6 @@ static int pr_manager_worker(void *opaque)
>      int fd = data->fd;
>      int r;
>  
> -    g_free(data);
>      trace_pr_manager_run(fd, hdr->cmdp[0], hdr->cmdp[1]);
>  
>      /* The reference was taken in pr_manager_execute.  */
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Since I am disappearing soon, I wouldn't mind if the block layer people
picked this up.

Paolo

