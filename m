Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A13C433E8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:11:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3866822BEA
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjdLBVgG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3866822BEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0ogA-00046u-G5
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 12:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k0ofR-00039F-Jb; Wed, 29 Jul 2020 12:10:57 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34398)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k0ofP-00029W-Uc; Wed, 29 Jul 2020 12:10:57 -0400
Received: by mail-pg1-x543.google.com with SMTP id t6so14494909pgq.1;
 Wed, 29 Jul 2020 09:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=6VlteQIR5hamU+sbAzhLAfC6Zan+9VrHdIHrzKJwS+E=;
 b=CjdLBVgGDGrk7sniHS2VU5UzMXH/pBIhvnpfZCPy+X9xdQ/q8YElCBWagYSudCsCd1
 IDyqPfOA/qybRVTXHynuug7P0SmzfFxJPiZk2FzZA4rxo1yL29klt3bCmx9YK9nJK2QA
 MZfgbyQFiocQtzGErue29Thhg2eGFnLDPKObY0bSFEldTX/MsU3tjIxNW5sJF2wEbwoV
 +LTPlU2xfhTb/ZkfEYqTteOk+JogfstZHuDjZ/gKwpzwjEkYMmRnf+w4/ONe1LkseKU1
 bIwXFWHBV9YrUrr8EdKSBBHemVf5cwq6nW9ACy8uGhWWLxwWWhRzMcl5Rpcg8GmytxzZ
 WWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=6VlteQIR5hamU+sbAzhLAfC6Zan+9VrHdIHrzKJwS+E=;
 b=HPbxjljUrr02QzE5ah4VCaJaC0IyRTAwEQtx5TUgOaGVuXqMA27senDd7HtyI8Mpmw
 mgBtcS0yyozqhBi83gmEnsjnXwt+MDbPcmXk+QAyFpT2jYTtSWN8LUCyMka4OmCcZ3aF
 9DppxuKLAPQKd9VRsWtaDlN5xUgJfp0jAfWl4SJIhzuiV/Fc1Z5QWnkxc9frdbMBgcFk
 6Godc+KeDuzq986QK/w7fKIo19TUNvocvcznl1JqDgVZA0t8u5qrT/1tic8LzEJf2Mrh
 w7kTK9+tapQGRC2zszN37GOQLjtfCEYOsaPZ//DAE+X0tHKgaPvKpYIOJpy5MgzA9QWs
 FJ3Q==
X-Gm-Message-State: AOAM531RXawDqZ4qOUvrX5M069i1DH2gjp4k8zYuKaPrNLJxJujriTfv
 0GygZpbf2xToz+IGtirsQuo=
X-Google-Smtp-Source: ABdhPJzg7HGE/I/+Z/FMb/yltCGmniw3pAy8SZvTe3nfbIfv1fqchk9DY64HwlcSCEtisAJGnrE9XQ==
X-Received: by 2002:a05:6a00:2b0:: with SMTP id
 q16mr31936546pfs.79.1596039054203; 
 Wed, 29 Jul 2020 09:10:54 -0700 (PDT)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id z20sm2485069pjr.43.2020.07.29.09.10.53
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 29 Jul 2020 09:10:53 -0700 (PDT)
Date: Thu, 30 Jul 2020 01:10:51 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH 15/16] hw/block/nvme: remove NvmeCmd parameter
Message-ID: <20200729161051.GN14876@localhost.localdomain>
References: <20200720113748.322965-1-its@irrelevant.dk>
 <20200720113748.322965-16-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200720113748.322965-16-its@irrelevant.dk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20-07-20 13:37:47, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Keep a copy of the raw nvme command in the NvmeRequest and remove the
> now redundant NvmeCmd parameter.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>

I would really have suggested this change from 13th patch!

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>

Thanks,

