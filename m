Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21455C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 14:19:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E01E620639
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 14:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="zrncOvEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01E620639
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8OwO-00072M-5Z
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 10:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1k8Ovo-0006O7-BI
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 10:19:12 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39813)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1k8Ovl-0007W8-VE
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 10:19:12 -0400
Received: by mail-wm1-x341.google.com with SMTP id g75so2384121wme.4
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 07:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:cc:subject:in-reply-to:references:from:date:message-id
 :mime-version; bh=1qYE4SExN0gkU7lSb9phftD5d5Xde3zv6H3XHYk5duk=;
 b=zrncOvEp/ocMZUxhqW+G1jzNxzj1MItt5lGwbjwdsY/4EZLoHwQymWoANeqoCHJajZ
 vljyXUdBayYTYRNCMhd3NtoXHDVCakZHmiVD1GlZDKtG9WyQjIbHONlbEbumjgxfkOOX
 F3Ezn6XNb9OwUpG9w+gx1zeWVBcsIv4/qiCKpB5bMu+hz8xOdr8/VBS3yAOUfIGClOuK
 BwVE6S8hiJKB0j3g/qw407fLJBzvkUhUwu8x9Uj4fccLjKcEtn02meLOUc5LH4p7mlOq
 9KjWeB6DjSMyZepRSzy0WPqxTfOIUKy5sn3FoNMz9jlQ2Dnx3t1nvEH8uSCOMRG8WdHc
 kX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
 :message-id:mime-version;
 bh=1qYE4SExN0gkU7lSb9phftD5d5Xde3zv6H3XHYk5duk=;
 b=b4bm3P0U+c3SeWjCWbN9MBRK9KIIkjPwO/L97MXu2eMCLdLPgewml6wzVUM1S7qdjJ
 aftOJ9fbmq9/9iflC0zSV1+GmMiSPE8BSokn3LhkC0LF+eP7/1Ia5whIKkJPBffZm039
 CgOKgkHQn8uJP5qhZLLBVD73wfyZj1vItYFUNJY8wecO0rupVoQYTKi9wEa1DpQmGh4X
 Wg1NC81bRlT1LkhPAddpql45zeTCypeMbDBLCd5GTK7l5KnH2UjqrfW8zm4oWZHQ8A/5
 OZ9LERtXvqSg2OtK2qnTAundGJhaP5hlurBh1SDaJtZbA/Yt3uhBFrgBtcKBvqcLdXfb
 lBrg==
X-Gm-Message-State: AOAM531Dz1biI2yI3kuxlrfakVLbatyY4lzEuf5OQIojipXuz+DbQMeJ
 4ByhM1oUHfb+bZgrwgJcam0llA==
X-Google-Smtp-Source: ABdhPJyfO6pGmbh/1H0iroYj0/uZpaBgVNoLHUgKxyb8DJpyXInzCcNubDYaFLMUwF/ZgdSKXtmm7Q==
X-Received: by 2002:a7b:c4ce:: with SMTP id g14mr5409846wmk.51.1597846747439; 
 Wed, 19 Aug 2020 07:19:07 -0700 (PDT)
Received: from disaster-area.hh.sledj.net
 (8.a.e.d.0.0.0.0.0.0.0.0.4.6.0.0.0.4.1.7.1.7.b.b.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:bb71:7140:64::dea8])
 by smtp.gmail.com with ESMTPSA id d11sm40544927wrw.77.2020.08.19.07.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2020 07:19:06 -0700 (PDT)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 15d97fdb;
 Wed, 19 Aug 2020 14:19:05 +0000 (UTC)
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC PATCH 0/9] block/curl: Add caching of data downloaded from
 the remote server
In-Reply-To: <20200819141137.GC366841@stefanha-x1.localdomain>
References: <20200818110845.3825105-1-david.edmondson@oracle.com>
 <20200819141137.GC366841@stefanha-x1.localdomain>
X-HGTTG: heart-of-gold
From: David Edmondson <dme@dme.org>
Date: Wed, 19 Aug 2020 15:19:05 +0100
Message-ID: <m2ft8ivhuu.fsf@dme.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: neutral client-ip=2a00:1450:4864:20::341;
 envelope-from=dme@dme.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779, UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wednesday, 2020-08-19 at 15:11:37 +01, Stefan Hajnoczi wrote:

> On Tue, Aug 18, 2020 at 12:08:36PM +0100, David Edmondson wrote:
>> When using qemu-img to convert an image that is hosted on an HTTP
>> server to some faster local (or pseudo-local) storage, the overall
>> performance can be improved by reading data from the HTTP server in
>> larger blocks and by caching and re-using blocks already read. This
>> set of patches implements both of these, and adds a further patch
>> allowing an offset to be added to all of the HTTP requests.
>
> Hi David,
> Thanks for posting this! Kevin and Max are the maintainers in this area,
> but I wanted to ask an initial question:
>
> Is caching curl-specific or could this be implemented as a block filter
> driver so that it can be stacked on top of other network protocols too?

This implementation is curl specific, as you probably surmised. I will
look at implementing something similar as a block filter.

dme.
-- 
Facts don't do what I want them to.

