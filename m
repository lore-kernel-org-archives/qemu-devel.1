Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE43C5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:36:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E673C214D8
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E673C214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSitr-0004Rv-H9
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 09:36:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iSirG-0002XR-K6
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:33:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iSirF-0004Z0-52
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:33:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58400)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iSirE-0004Xa-Vl
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:33:57 -0500
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7C82D83F51
 for <qemu-devel@nongnu.org>; Thu,  7 Nov 2019 14:33:54 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id n34so2798691qta.12
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 06:33:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9HSE5ZuAXC5YiDXu6y1UbCk6sQ/94YLKVuqTAkvyQ6c=;
 b=T8x0+sQbm7tmfRvZzEqAuixpuF4RsRvWFJPpKIjekIUDkTmUVEct3lDqvPk1ycOv82
 /4GccjcF8ICHI9Er+CC6uJkffvRAqZMVKEVtX/uP9Ag6xYP7j+7Qba1mr/pop3TtyMpw
 77cMnvvTytII4s9vvEKFkO3keSJzO+522KBK4zjo0GEE4KEqxZh5DMndirSYrkmYT0Et
 OVYtge8OzE2ijX6hLaeWMd+QN9pTgJLDmywZMRZ10nq0w/BpV1tU9wv0qUdIIseomEdv
 Iky9hXQt1Q/WyS2v7uVDKav9B3kLPuElnK6XHeZAy5QJH8gn2Xsgqur35pBwfsN89ARf
 U5Rw==
X-Gm-Message-State: APjAAAXoI64SryniL+/Y5Xc5uaVjAcNtnaFM8CFi3Rktybi6boJUerL2
 4/ZKJXzwf+HfTo9M2l7AbXRW07C3gs7gN1fgczDrHHtIOwh0Nip1x23yB5PZ5/tsbvfbG7+i4RJ
 1XhRwlW2dd32FzpM=
X-Received: by 2002:a37:6891:: with SMTP id d139mr3030813qkc.213.1573137233717; 
 Thu, 07 Nov 2019 06:33:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqzfsw04CApFbnOvlS4xHZ5T/zK3j3K/3BzYoxg9I5FboHAT8hcghTuZUER2XKRDFEqdlkFPRA==
X-Received: by 2002:a37:6891:: with SMTP id d139mr3030766qkc.213.1573137233425; 
 Thu, 07 Nov 2019 06:33:53 -0800 (PST)
Received: from redhat.com (bzq-79-178-12-128.red.bezeqint.net. [79.178.12.128])
 by smtp.gmail.com with ESMTPSA id t127sm1293370qkf.43.2019.11.07.06.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2019 06:33:52 -0800 (PST)
Date: Thu, 7 Nov 2019 09:33:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC v4 PATCH 49/49] multi-process: add configure and usage
 information
Message-ID: <20191107093059-mutt-send-email-mst@kernel.org>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <2736d12f29d2c9051966864b5d865ab0f392b8d1.1571905346.git.jag.raman@oracle.com>
 <20191107140220.GI365089@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107140220.GI365089@stefanha-x1.localdomain>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 qemu-devel@nongnu.org, kraxel@redhat.com,
 Jagannathan Raman <jag.raman@oracle.com>, quintela@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 07, 2019 at 03:02:20PM +0100, Stefan Hajnoczi wrote:
> This documentation suggests that QEMU spawns the remote processes.  How
> do this work with unprivileged QEMU?  Is there an additional step where
> QEMU drops privileges after having spawned remote processes?
> 
> Remote processes require accesses to resources that the main QEMU
> process does not need access to, so I'm wondering how this process model
> ensures that each process has only the privileges it needs.

I guess you have something like capabilities in mind?

When using something like selinux, priviledges are per binary
so the order of startup doesn't matter.

-- 
MST

