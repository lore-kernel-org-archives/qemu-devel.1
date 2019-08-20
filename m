Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8FEC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 06:36:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EE07214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 06:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE07214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzxkU-0002Xr-Jo
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 02:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1hzxjs-00029N-Kj
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 02:35:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hzxjr-0004kb-HA
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 02:35:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39716)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hzxjr-0004ix-93
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 02:35:27 -0400
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 37DF7C0546F2
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 06:35:26 +0000 (UTC)
Received: by mail-pf1-f198.google.com with SMTP id q67so4129164pfc.10
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 23:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=tVNIhJm5IyxV1sfiuxj2bvkpXtX85HxXE4bh5ouPduE=;
 b=gLtnx3lIGiSh1Z5BQ89ftUhRCD6mVkI7MqYI8bSv/DBNaQr/SUP9pDRU3cKIH+tqLy
 2CbONuFNZAOp6CH27l77BjFIZ6IcXC6S/w9pURm8zVccTntwqm41gHpT/QnEPui1+LEg
 1F4h4Dn9/dDPHcxsMImpJ3afkaUpaXB9TepL5fe8q2pprQW+N/yR6EZsGmxhiakS2fub
 RiU9/W7uc399UxC0X0ucmh5KfXM4nI34kl9EbhmmPRNefjq61ZTLNEKQN5BmFm85zWDe
 EljHgtigPBI1C3mI9gM14rwiavYecdBK0KaZyF6rc/+i1Q4W/egi3SyTwP/sVXnd/IeR
 KRpA==
X-Gm-Message-State: APjAAAX67Vo/S7uBZwx/5V5vu4TqiM47vhFq3kSNMqrDhaGOoIl8fpdh
 YjbRKxMjb6vTP0m0zBK3ezZlJoQbPcg+dDPbkjz3oagnBL+wmA3GRzKNfumdatZB4UjdbcYjguz
 wEd3hZe3A88K0cNU=
X-Received: by 2002:a63:4404:: with SMTP id r4mr14897703pga.245.1566282925652; 
 Mon, 19 Aug 2019 23:35:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyhrlsxMujujaj8fAQfSm24dUiLrynMcJH3AtRvX6VtvV/LX5CoQHUdBa5QxwUSxFD+FaHC7Q==
X-Received: by 2002:a63:4404:: with SMTP id r4mr14897689pga.245.1566282925316; 
 Mon, 19 Aug 2019 23:35:25 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id k5sm22150395pfg.167.2019.08.19.23.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 23:35:24 -0700 (PDT)
Date: Tue, 20 Aug 2019 14:35:15 +0800
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190820063515.GH13560@xz-x1>
References: <20190820051615.1210-1-peterx@redhat.com>
 <20190820051615.1210-3-peterx@redhat.com>
 <800a4208-627f-9089-8291-c6f4329cd4d5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <800a4208-627f-9089-8291-c6f4329cd4d5@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/2] memory: Split zones when do
 coalesced_io_del()
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 20, 2019 at 08:24:12AM +0200, Paolo Bonzini wrote:
> On 20/08/19 07:16, Peter Xu wrote:
> > It is a workaround of current KVM's KVM_UNREGISTER_COALESCED_MMIO
> > interface.  The kernel interface only allows to unregister an mmio
> > device with exactly the zone size when registered, or any smaller zone
> > that is included in the device mmio zone.  It does not support the
> > userspace to specify a very large zone to remove all the small mmio
> > devices within the zone covered.
> > 
> > Logically speaking it would be nicer to fix this from KVM side, though
> > in all cases we still need to coop with old kernels so let's do this.
> > 
> > This patch has nothing to do with 3ac7d43a6fbb5d4a3 because this is
> > probably broken from the very beginning when the
> > KVM_UNREGISTER_COALESCED_MMIO interface is introduced in kernel.
> > However to make the backport to stables easier, I'm still using the
> > commit 3ac7d43a6fbb5d4a3 to track this problem because this will
> > depend on that otherwise even additions of mmio devices won't work.
> > 
> > Fixes: 3ac7d43a6fbb5d4a3
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> What about my comments to this patch? :)

I thought that comment was for patch 1 but wrongly replied to this
patch 2... :)

Isn't that comment only valid if we still use the old patch 1?  With
your suggestion, is that still needed to keep mr->coalesced untouched?

Regards,

-- 
Peter Xu

