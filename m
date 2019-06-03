Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CA0C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 10:09:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7795528081
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 10:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7795528081
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60826 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXjuf-0004UQ-LF
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 06:09:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hXjts-00048j-Az
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 06:09:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hXjtr-0002Ct-39
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 06:09:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hXjtq-0002As-RV
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 06:09:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id c2so11380366wrm.8
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 03:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=RiYB/REhoPHybRA+5Xv/TDkFsjvmQoctKO7/GIRG5MY=;
	b=AnA9AaC9vWdoTwyDd+/aLT5fRq+lpSm2x7qf9flWTzWs5HHpYq2qcWYosboTFAzZvV
	afnQgOfaTF+iXboy8rBIvunCCXsWjxZxVh2H/veh4H7YXoFvu6aoFceNrQgFYzmD9MfD
	ZpyHY9F7XSbfvxJGT2DBwunmgIplFzqeHvEh2n0ljI5/FSo0XlA/IYZm+8vZBIkdVbeo
	LXyyfUwUMLd/m88/THgSrmw7BcjEktPpDai0prBuBfAElJZ3wj1CxXUqRV4QK8lDpvYl
	8IP0ZOpNwDsmF/QQfoq/dVTczEshpSh5E5HrSY03RZ8qXxmpCSiUA85LMdTVf2SOvLHp
	13dA==
X-Gm-Message-State: APjAAAXn/XyUxliCOXVuXAMuuk8KVTh2L0BXzv3dXYbQznRc7kd98BsP
	CmM8yWgU8mwR8P5+TjMwH+GkGA==
X-Google-Smtp-Source: APXvYqzBDemzwcrMZsRm5r9nlvtPlYQopBeHO0Odz0Trw2Zha256e+0WX7DorKjSAR1JyMAKWq4Yeg==
X-Received: by 2002:a5d:6191:: with SMTP id j17mr1994579wru.172.1559556545113; 
	Mon, 03 Jun 2019 03:09:05 -0700 (PDT)
Received: from steredhat.homenet.telecomitalia.it
	(host253-229-dynamic.248-95-r.retail.telecomitalia.it.
	[95.248.229.253]) by smtp.gmail.com with ESMTPSA id
	88sm15216029wrl.68.2019.06.03.03.09.04
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 03 Jun 2019 03:09:04 -0700 (PDT)
Date: Mon, 3 Jun 2019 12:09:02 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <20190603100902.hfk2qo3436kvbevw@steredhat.homenet.telecomitalia.it>
References: <20190514121015.32190-1-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514121015.32190-1-anton.nefedov@virtuozzo.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v7 0/9] discard blockstats
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	Denis Lunev <den@virtuozzo.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 14, 2019 at 12:10:40PM +0000, Anton Nefedov wrote:
> hi,
> 
> yet another take for this patch series; please kindly consider these for 4.1
> 
> Just a few cosmetic comments were received for v6 so this is mostly
> a rebase+ping.
> 
> new in v7:
>     - general rebase
>     - since clauses -> 4.1
>     - patch 8: not completely trivial rebase: raw_account_discard moved to
>       common raw_do_pdiscard()
>     - patch 9: comment wording fixed
> 
> v6: http://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg06633.html
> v5: http://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg06828.html
> v4: http://lists.nongnu.org/archive/html/qemu-devel/2018-08/msg04308.html
> v3: http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg03688.html
> 

Hi Anton,
since qemu 4.0 added the discard support on virtio-blk, should we consider it
in this series?

If you prefer I can work on it and send you the patch.

Cheers,
Stefano

