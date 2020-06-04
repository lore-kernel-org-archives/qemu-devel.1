Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A35C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:23:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4DED206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDd/cVxO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4DED206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgtaU-0004KB-4V
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 13:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jgtZu-0003rq-PN
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 13:22:54 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:33520)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jgtZu-0002M8-3E
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 13:22:54 -0400
Received: by mail-pj1-x1042.google.com with SMTP id b7so2367385pju.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 10:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=EScYkzlCeq/2Iz26DYMc8Mnk60M8ahPIrsD4E2F0OPQ=;
 b=iDd/cVxOxeADQ+3yBASLyvXAPjBvy4qi02Dy4wcJ6rv1TNaG0GufKEbK9L1ihDuRFb
 wlQcAVHwFgbyirTsSlGv96w6P7dRMhzbOuMCBhocA6albNqM3ncU6BeTtj/FzAvfkVZr
 ca2z6KKCvgt9vmtMb+4nBK8LtUC6o8fjuHDt6C/m16ry7TZTrYHQU3umvmstYJbuoafm
 KzHUJoG1jLFhJPPiJXF9wB6YCBP2v4D0+6nnt9rTnyYJuARNfGW19lD8XNUzDtm3dyIj
 lwXQBFiqAo/2gPCD+kEcZAgAYAyjmZCok4hGMO/ffRGcduIaAmxO1LDRP5Bq5Rq1M8QK
 K3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EScYkzlCeq/2Iz26DYMc8Mnk60M8ahPIrsD4E2F0OPQ=;
 b=LhVLpYHwaZGqy+Aoqo5lCANwo1u6GQ5jcAE2fMoc4rQf3BHlKtR/xwoMM5KSbB/V4r
 rZn+/8c8u7OQO5nYnU+lsjj/L6veoVueB0mRIQMcYcO968TwW86py/SXY/wddOhd/JHK
 x4o4WWpVgBX+wDBLWRKfW7aMPz1iEG9x4ZB4ZIwxzhNVuD7JGMD3EZpJhSB6mAtuNz/g
 ugvHUauWArmlsObz4mPb0yx5USp1TLGsCtmFsUSfRf6H8qPpYkQAK0ZzLj9875WcQWws
 MY2jutHgLHxDTHdZ91jyy+YncQgnJ/Q+m20dAZoxT68hBFlBdVYJKcKnrHwvs2vQ/F6e
 fecg==
X-Gm-Message-State: AOAM530BHKmFnKUjWlNkPx9DXtI/ehOPTXYacgj1SkEcwGkWTcVCNcrE
 Aavm4H+j6R+UkjwG4T7nxcg=
X-Google-Smtp-Source: ABdhPJzAZnAFESTcg9mBl2/4e7AyE7yEBg6fapSfqptWuG5svzqaTTdba9t8cW56QlA8IkWcxyDR7Q==
X-Received: by 2002:a17:90a:cc09:: with SMTP id
 b9mr4085060pju.223.1591291372728; 
 Thu, 04 Jun 2020 10:22:52 -0700 (PDT)
Received: from localhost (tunnel570486-pt.tunnel.tserv25.sin1.ipv6.he.net.
 [2001:470:35:3d5::2])
 by smtp.gmail.com with ESMTPSA id i21sm4579164pgn.20.2020.06.04.10.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 10:22:52 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Fri, 5 Jun 2020 01:22:48 +0800
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v6 4/4] new qTest case to test the vhost-user-blk-server
Message-ID: <20200604172248.hmscade63ckj57r2@r>
References: <20200530171441.660814-1-coiby.xu@gmail.com>
 <20200530171441.660814-5-coiby.xu@gmail.com>
 <e28c954b-3125-223a-441b-c713a7a6e644@redhat.com>
 <697a22d3-0987-4ebf-9fe0-b6c341f48cc6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <697a22d3-0987-4ebf-9fe0-b6c341f48cc6@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=coiby.xu@gmail.com; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 04, 2020 at 03:49:13PM +0200, Thomas Huth wrote:
>On 04/06/2020 15.42, Thomas Huth wrote:
>>> + * Copyright (c) 2018 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
>>
>> Don't you want to add a remark here for you, too?
>>
>>> + * This library is free software; you can redistribute it and/or
>>> + * modify it under the terms of the GNU Lesser General Public
>>> + * License version 2 as published by the Free Software Foundation.
>>
>> Could you please change "version 2" into "verion 2.1" ? There never was
>> a "version 2" of the LGPL, only version 2.1 (or 3.x).
>
>I meant, there never was a version 2 of the "Lesser GPL". Version 2.0 of
>the license was still called "Library GPL" instead.
>
> Thomas

Thanks for reviewing this work! Just missed this email while submitting
v7. I will fix them in v8.

