Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EC1C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 10:31:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05E662075F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 10:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q710I7yP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E662075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k15q4-0007jg-9x
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 06:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k15on-0006hv-Rs; Thu, 30 Jul 2020 06:29:45 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:39575)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k15om-0005YY-7f; Thu, 30 Jul 2020 06:29:45 -0400
Received: by mail-pl1-x644.google.com with SMTP id b9so13671312plx.6;
 Thu, 30 Jul 2020 03:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Jy+ha8CYOjsmo0wOQekdGO8fQhvKZDyH8gNMZVIBGiw=;
 b=q710I7yPt3F2WRpWqehVkhMvtn3ttTdC9Lp/CN6VT+XWerVLRVmiDUFjqw4d7BVkxb
 qy8bcPKl5E/zbXmHBETQ9H+HuVDNS0xxEqVgCvpDjcvJ+2PIUf+uIt1+QeKGdjp6F+sf
 SAuMoG+4fYYgATAOs0qRozmib3jJkk5Rm0HXDlVXZgV6KIHcKx1I+cmeKokcbYfwPrm+
 rW+QfUzmjQ40gsxuYdcht7V3fsDD+SJ6Q/Ft/b8g0f/dGwkYlghaV4azZNQcVeENzGIg
 uLokaKbkbxIqv1hh4RPOcLUErG9b28Q4nUkI14rjdhzaQQhkRjlXG95oKHCXUqJBnXya
 6J7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Jy+ha8CYOjsmo0wOQekdGO8fQhvKZDyH8gNMZVIBGiw=;
 b=HasA0MJRIXOtY3YVx8hbuK9F4o/greSJ+bKRX77tnxSxWfLT+BGuzeajDTgAZ0plYP
 CHpEzPHb/XMbG5vMl4mJ2+fv4Yfgws2EjCM+/4Vxic6v2K1/HUjRMgTecOcSF37M8Amt
 gPmnutAovC+bstXqqj6qV5/1m0/DssXjbAbik70kPp/JIIrNimNEzupf4pW5yctwUPk6
 uIlIK9G1oe4L0ncqEPZufx3W+8IJwCjENCPLYC/aDSQeqYXxSDjE1YdOtXIi2UpKnshx
 sPbisJXd5rXDHRhBHN0DluFQdvkACKgKefBC62DlqkFhR871IY3Q5zRnjiemQmdVr+7B
 d+Hw==
X-Gm-Message-State: AOAM533XFW49b42xQtpu2jpPLvR1wVWbYDtDEx03fbTTmP7gP6HZZ63A
 mi1XVLkXKer0trKa3piRpEg=
X-Google-Smtp-Source: ABdhPJy/TpFqrJjlxsM1gmKB8wPLEDK6mHfs8qll3nEPGbOjk+98r8ep/i/EP9z73geNa4AI8zoX8g==
X-Received: by 2002:a17:90b:358e:: with SMTP id
 mm14mr14846648pjb.54.1596104982055; 
 Thu, 30 Jul 2020 03:29:42 -0700 (PDT)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id q6sm5486701pfg.76.2020.07.30.03.29.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 30 Jul 2020 03:29:41 -0700 (PDT)
Date: Thu, 30 Jul 2020 19:29:39 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v2 15/16] hw/block/nvme: use preallocated qsg/iov in
 nvme_dma_prp
Message-ID: <20200730102939.bw2hpdfqzmvo3v5z@localhost.localdomain>
References: <20200729220638.344477-1-its@irrelevant.dk>
 <20200729220638.344477-16-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200729220638.344477-16-its@irrelevant.dk>
User-Agent: NeoMutt/20171215
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pl1-x644.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
 Keith Busch <kbusch@kernel.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20-07-30 00:06:37, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Since clean up of the request qsg/iov is now always done post-use, there
> is no need to use a stack-allocated qsg/iov in nvme_dma_prp.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Acked-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>

