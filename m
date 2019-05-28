Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF1CC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 17:46:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70B202173B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 17:46:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B202173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40377 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVgAv-00064t-NB
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 13:46:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hVgA5-0005iI-6H
	for qemu-devel@nongnu.org; Tue, 28 May 2019 13:45:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hVgA4-0001ED-6K
	for qemu-devel@nongnu.org; Tue, 28 May 2019 13:45:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hVgA3-0001By-Vq
	for qemu-devel@nongnu.org; Tue, 28 May 2019 13:45:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id d18so21206570wrs.5
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 10:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=kUoWpY6D/8N4tWxUgAqdicDiMlZGJsyNeAPTC//UWos=;
	b=pBfSdrXVX17QWgS35hj8kd/FXzSZMJ0k3vYExCAG8yiwkvoh7Abbw46x76prC4TNW+
	W8gcy3oiH82U4eXroB3XtA72qdOi2RVStJtt+tuxTXhIS9Vy3p5EEQBDicjGcP333pn8
	eHM6FseHz7q04NX/cTbZlGiSn+UY+h4msJHWmXlGy5QeAPM3kZTtPePgMzV9ri6HL31H
	YXq2rM2uV0eqULBjvHOwtm8CbV/7Ua1n4AdG+evBb39iPdgBUR6tftv+/WmQWDsTkRyN
	/I4ERHbl92TGkispmdGXSaTv1w7srERp/x9/qAasZWaLsjkvVeY+/jOLS07f2oENwziB
	emrw==
X-Gm-Message-State: APjAAAW9OzzprnyBtSvqvwOgTgK1BqO6C567Nd0Bwl7m/Ks9fvcP6cSu
	C18VeSs7/uS9z8Rz7lCsF2wtXg==
X-Google-Smtp-Source: APXvYqyhRnRv0iT0ZqXnv0s5nfr/2ljfGmTFEM/fldnDJSIVW1YkLybtzCu//G9xyamU4U2qyXW0jQ==
X-Received: by 2002:a5d:6a90:: with SMTP id s16mr10116381wru.288.1559065516150;
	Tue, 28 May 2019 10:45:16 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c92d:f9e8:f150:3553?
	([2001:b07:6468:f312:c92d:f9e8:f150:3553])
	by smtp.gmail.com with ESMTPSA id
	a124sm4842096wmh.3.2019.05.28.10.45.15
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 28 May 2019 10:45:15 -0700 (PDT)
To: Jie Wang <wangjie88@huawei.com>, qemu-devel@nongnu.org,
	qemu-block@nongnu.org
References: <1559048796-57016-1-git-send-email-wangjie88@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cac8ed16-7846-ca22-2463-c3c738066d61@redhat.com>
Date: Tue, 28 May 2019 19:45:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1559048796-57016-1-git-send-email-wangjie88@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] pr-manager-helper: fix pr
 process been killed when reconectting
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Michal Privoznik <mprivozn@redhat.com>, eric.fangyi@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/05/19 15:06, Jie Wang wrote:
> if pr-helper been killed and qemu send disconnect event to libvirt
> and libvirt started a new pr-helper process, the new pr-heleper
> been killed again when qemu is connectting to the new pr-helper,
> qemu will never send disconnect to libvirt, and libvirt will never
> receive connected event.

I think this would let a guest "spam" events just by sending a lot PR
commands.  Also, as you said, in this case QEMU has never sent a
"connected" event, so I'm not sure why it should send a disconnection event.

Does libvirt monitor at all the pr-helper to check if it dies?  Or does
it rely exclusively on QEMU's events?

Paolo


> Signed-off-by: Jie Wang <wangjie88@huawei.com>
> ---
>  scsi/pr-manager-helper.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scsi/pr-manager-helper.c b/scsi/pr-manager-helper.c
> index 438380fced..b7341b8f47 100644
> --- a/scsi/pr-manager-helper.c
> +++ b/scsi/pr-manager-helper.c
> @@ -120,6 +120,7 @@ static int pr_manager_helper_initialize(PRManagerHelper *pr_mgr,
>      if (local_err) {
>          object_unref(OBJECT(sioc));
>          error_propagate(errp, local_err);
> +        pr_manager_send_status_changed_event(pr_mgr);
>          return -ENOTCONN;
>      }
>  
> 


