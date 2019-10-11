Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A65ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 05:32:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D11462196E
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 05:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11462196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iInXs-0001qF-V6
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 01:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iInWk-0000zs-Mj
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 01:31:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iInWi-0004b3-Ml
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 01:31:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54778)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iInWg-0004Z7-WC
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 01:31:43 -0400
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DEAFC81F18
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 05:31:39 +0000 (UTC)
Received: by mail-pf1-f200.google.com with SMTP id u12so6585929pfn.19
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 22:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=H9bA6QK0EBrDU5ltSz2ubl2ZhEbSDjCZK8/wlmDxg50=;
 b=lbQUMCK89sUlcRChQleRwZEldEi8kbVcmrkp23uwq4qBwls9woQX5/KvNER5Fi8jBZ
 QTmMAjsP4JD7obZ+ydpOzGD6ylXx4uVLlVv5ifK13pLcITE7yJCI44vAmrMUpCBp+yVL
 eqEq/fMH08E7TFM1R3otEiAxxKErWdP9h1rDfEVuLswzws10JRNFJG/ANfxsNlXi0nAM
 jc5aT05DOdKPghiQp5ePRc1y9oYyATijYiUqSGT+0TaZhftY2kaQt1Ehy47phUkfOft/
 Jpvpst1QiO8QBHOSJQy4zIzwktFkgsXTRtYDWLWCsNY4M1AVb2EX215YlNNs9okZjO6J
 vESw==
X-Gm-Message-State: APjAAAVPtoNlF4jvewOgynCnDWRpZ8IqjRwibaKHIFFBtpsJbeTsOfdq
 5ZYq3FcGGV7ZOvy53LuuLDXpNizC94Fdkeconq64KDGbT82mjupdsoOdleJcyAsKPdYsbQF+op8
 1dfMZ6j3gdyjij1U=
X-Received: by 2002:a63:734a:: with SMTP id d10mr12671513pgn.334.1570771899351; 
 Thu, 10 Oct 2019 22:31:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxokpEfIY3e8aTZceoP75AFXV83qAEIajOiz9W7HrU+tNvZ9SBxOOYcc1JSDxtHqploCfpbTg==
X-Received: by 2002:a63:734a:: with SMTP id d10mr12671489pgn.334.1570771899005; 
 Thu, 10 Oct 2019 22:31:39 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id a21sm8416081pfi.0.2019.10.10.22.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2019 22:31:38 -0700 (PDT)
Date: Fri, 11 Oct 2019 13:31:29 +0800
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v4] migration: Support gtree migration
Message-ID: <20191011053129.GA31941@xz-x1>
References: <20191010205242.711-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191010205242.711-1-eric.auger@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
Cc: quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 10, 2019 at 10:52:42PM +0200, Eric Auger wrote:
> Introduce support for GTree migration. A custom save/restore
> is implemented. Each item is made of a key and a data.
> 
> If the key is a pointer to an object, 2 VMSDs are passed into
> the GTree VMStateField.
> 
> When putting the items, the tree is traversed in sorted order by
> g_tree_foreach.
> 
> On the get() path, gtrees must be allocated using the proper
> key compare, key destroy and value destroy. This must be handled
> beforehand, for example in a pre_load method.
> 
> Tests are added to test save/dump of structs containing gtrees
> including the virtio-iommu domain/mappings scenario.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

