Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE73C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 19:03:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9C5E2184E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 19:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C5E2184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59023 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUFTE-0004LG-79
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 15:03:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hUFDt-0000J5-Lb
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:47:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hUFDs-0007Rm-Mj
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:47:21 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:36271)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hUFDs-0007RN-G9
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:47:20 -0400
Received: by mail-wm1-f46.google.com with SMTP id v22so2925944wml.1
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 11:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ppoMF4oTxBx2jS9wycnCKEgo15pl05Sn2PrdMglnwlI=;
	b=p57ZS29gwOOcJo7eXbz4z11OXX/b0n2Hp25boAnTqQjQo3VLSa5QwLnKdersv9F3uy
	wy6GfadW8rCGYOErjJKP53YGflwz0CdUmu4fQpwQEkXp2+LVEH/dULhb3cKHg/oqvVxF
	++VN4nxhriy+LiXFYPwyg6cerR66OGBM+LXui0Als9eTiX+Ne3DLnTRGWoZusuxMztZe
	zIaIKXzRIO3iIpgxNyCkZdJ7cgIV6/70sSBR3XGTD+LebJXInpa4tH3LPaq87m+c8qNr
	kjVNmZuleG+qCx2J1SANKti7/1LuvyHY0+vyNK+eq1FxmXZVXMBF6hQXKKFJxwB2TSZ6
	4rlA==
X-Gm-Message-State: APjAAAVe6lUK0eVFX/+YEE67Nmf1fCJHs8oa0NenBsCWy6gO7tpUr7tx
	h8eyDiP4Ff+OKdIilIJhvG80fQ==
X-Google-Smtp-Source: APXvYqz5Xb3qJq59nSTjB7crFXEEyZjF1xMbL65NcTgJtt874VemqJsrHGvwFqhJeRUMIT3ujMJiZw==
X-Received: by 2002:a7b:c8d1:: with SMTP id f17mr8778658wml.45.1558723639313; 
	Fri, 24 May 2019 11:47:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4d53:18d:3ffd:370?
	([2001:b07:6468:f312:4d53:18d:3ffd:370])
	by smtp.gmail.com with ESMTPSA id
	b194sm2292692wmb.23.2019.05.24.11.47.18
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 May 2019 11:47:18 -0700 (PDT)
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20190524183638.20745-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <24b93cc5-edb1-a197-14be-e63ac356325d@redhat.com>
Date: Fri, 24 May 2019 20:47:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524183638.20745-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.46
Subject: Re: [Qemu-devel] [RFC v3 0/3] scsi: restart dma after vm change
 state handlers
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/05/19 20:36, Stefan Hajnoczi wrote:
> v3:
>  * Fix s/k->vmstate_change/vdc->vmstate_change/
>  * Still RFC, waiting for customer to confirm this fixes the issue
> v2:
>  * Do it properly with a clean API instead of deferring to a BH!
>    Thanks for encouraging me to do this, Kevin.
> 
> These patches solve a deadlock when the 'cont' command is used and there are
> failed requests on a virtio-scsi device with iothreads.  The deadlock itself is
> actually not the thing we need to fix because we should never reach that case
> anyway.  Instead we need to make sure DMA restart is only performed after the
> virtio-scsi iothread is re-initialized.

custom_dma_restart is a bit ugly...  Do you think it would make sense to
order the VMStateChange handlers using some kind of enum (with the order
unspecified within the category)?

We could start with

	VMSTATECHANGE_PRIO_UNKNOWN  = 0  (if needed?)
	VMSTATECHANGE_PRIO_IOTHREAD = 100
        VMSTATECHANGE_PRIO_DEVICE   = 200

where higher priorities run first on stop and last on resume.

Paolo

