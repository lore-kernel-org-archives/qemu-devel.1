Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95777C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 04:49:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C8A52072E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 04:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTwXIFRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C8A52072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnxLt-00006u-Fn
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 00:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jnxLD-000892-Ca
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 00:48:55 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35751)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jnxLB-0002Zb-Ux
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 00:48:55 -0400
Received: by mail-pg1-x544.google.com with SMTP id f3so794282pgr.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 21:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=LAtkqBRisIrUC5UCuL6YQwvlnXd8YOVNAkeKZSNwSbI=;
 b=PTwXIFRonjw/QJdVDYXneC3MdQ3/rwjrtd0UZ+umF9Fyd1qrEVRr1I3/o7cPT+fdSm
 /b3THgwe1iylngup4QQUy1oUfe7TskmvTgqqmlCAnYVa9maiNiqDLy80iwsZE5T+T1Mp
 H6bWD9KzKWhKLQwVCgoEyYVUALur9E9WiV7M8CIxI8DMKICWyizN5rRn9+RYwWHmna5i
 pA4fUPbT5S27hff286Jl0jtFj9vvj7XblBIcPjNuQkjvi0eQopTkXkOlhFkycNF1GfZW
 GWpJB7tEbHI1RA5eDBA9CMhgMRGZKQFI8frCBcC0KwjachwjlCkSp/upchuGwCAm0A/s
 wSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LAtkqBRisIrUC5UCuL6YQwvlnXd8YOVNAkeKZSNwSbI=;
 b=B7bGKmlFE82KTxfXztTHZGjosKHXSejgxgEC+n6ldAoBZZ+FzCl3SGhYYzF30lhX+b
 RGeG+V6TSeKJOXBckidIF+Nzwre349EfXHeSha5xUrwo8Y9snM24l6//ErSXw5Y6h5JJ
 GAjo/6P2surcx741LTP4Xa2pkctM5qaxK37rAdnUvRACPBnR6kB2zuph/kP8nR4lCCuJ
 9JZsTkf8gHww6+Z1SpJpBhdpPcG3HN3zQpCARBgyS750OqCZ1YELRCRnRVnDx5o//3ZY
 0OqJwgevZpAFHhRxkO6BsjWPpC4R6HqLHWyQLNfnvBPOjhFw2MxQ/TjSwWkwXJp+cCHR
 gyRg==
X-Gm-Message-State: AOAM531jxrKIOMDW6D4C+ZGxqRUqpk2yrNUuEdX9v8YeQ57C97oz7ZFt
 cp3xZEU1KQSdhLhLloddQY0=
X-Google-Smtp-Source: ABdhPJyP6iH7rXFL4H6xqGlI8E9R1XXHIRSeahHxXbze7PK25mvmOhwvkCrAWPfEQQVh1H6KIu8kxQ==
X-Received: by 2002:a65:4807:: with SMTP id h7mr20681067pgs.123.1592974132097; 
 Tue, 23 Jun 2020 21:48:52 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
 by smtp.gmail.com with ESMTPSA id i22sm18594101pfo.92.2020.06.23.21.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 21:48:51 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Wed, 24 Jun 2020 12:48:45 +0800
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v9 0/5] vhost-user block device backend implementation
Message-ID: <20200624044845.4l5fovex7s6urwks@Rk>
References: <20200614183907.514282-1-coiby.xu@gmail.com>
 <20200619120746.GA2422025@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200619120746.GA2422025@stefanha-x1.localdomain>
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=coiby.xu@gmail.com; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 19, 2020 at 01:07:46PM +0100, Stefan Hajnoczi wrote:
>On Mon, Jun 15, 2020 at 02:39:02AM +0800, Coiby Xu wrote:
>> v9
>>  - move logical block size check function to a utility function
>>  - fix issues regarding license, coding style, memory deallocation, etc.
>
>I have replied with patches that you can consider squashing into your
>series. I was testing this patch series and decided it was easier to
>send code than to go back and write review comments since I was already
>on a git branch.
>
>My patches can be combined into your original patches using "git rebase
>-i" and the "fixup" or "squash" directive.
>
>Please add my Signed-off-by: line to affected patches when squashing
>patches so that the git log records that I have confirmed that I have
>permission to contribute this code.

I was thinking on how to incorporate your work while reading the emails.
You just provide the instruction! Thank you!


--
Best regards,
Coiby

