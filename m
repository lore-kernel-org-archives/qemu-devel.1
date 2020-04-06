Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8638C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 14:35:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB1212419A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 14:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pdkdQ5UR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB1212419A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLSr0-0001Td-Sd
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 10:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xadimgnik@gmail.com>) id 1jLSqC-0000Pa-3a
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 10:35:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xadimgnik@gmail.com>) id 1jLSqA-0006am-SC
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 10:35:08 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:33640)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <xadimgnik@gmail.com>)
 id 1jLSq7-0006YP-7T; Mon, 06 Apr 2020 10:35:03 -0400
Received: by mail-ed1-x541.google.com with SMTP id z65so19535543ede.0;
 Mon, 06 Apr 2020 07:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
 :mime-version:content-transfer-encoding:content-language
 :thread-index; bh=r6CtmB4j4V2k6M3wBOMBHNekQuJS84n0cWUZYh7Xr0s=;
 b=pdkdQ5URjzKugWUK7rOnvbHEaUCOEJXeYvpH3jkGjwv3zAkjCOLid1O5lPDqlfAhrl
 FheawOsD6wLlZI6bgbMmM579MLQqy5eXjkVO8BVXtFKPxagQCTqdg3CptY8ot2vk8CW1
 4yZogXe7f2uIMYGVprtEQZnVmpbqt77vyHw/2jAAcFb6jpRAnsP7Ac6RBhMQ9wxkrsv5
 3Y2okln5rTfDBGrYtxqSdSot+kSxlpUpwBdPAbvRcHxgae2LGVYw0gUbA8Zc1oAcruKZ
 H7WO8SxvltFZbISarudq56eGPMAVasZhrayHHox61ZbYn6dR1CUiGL3PKikWZkNGEAiE
 B17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
 :subject:date:message-id:mime-version:content-transfer-encoding
 :content-language:thread-index;
 bh=r6CtmB4j4V2k6M3wBOMBHNekQuJS84n0cWUZYh7Xr0s=;
 b=ps4a8//X34ghU+G+x8HHqieUZ57vd5UTy7Gnssr2c0X5f2IYUETTO+Nrtckj5EbVcc
 DK1OCBATtRYC5eWZAEghVHxS1g/TvGqljQovB6PUFQrgwzVq9kzH85+ai0/aT9YluIRQ
 HZJrqdKykR6100C9m51dKiWtcp++NHy4LrXfHQA6cMwzIenOfPoYSOry4edUoHZ5SZFf
 YPLLcVhTpeg2im1zSgBnqRy2doc2ai0KV0BG8ERX7ECkZmAir+tHmN1QMiZQGLExRNN+
 x3CgcDvOAzd2/znzLSG98ESk13wtOXG/bGMBxWHJyPOrsjTGQeJmdzC2euC51gKCdmuE
 eIbQ==
X-Gm-Message-State: AGi0PuajbTVV/sDNOc75IvlttMlLo+loijiw7rnGhbYGq5nzRygcHPz/
 U4TxwseM7cvxW2S+yRNcSVo=
X-Google-Smtp-Source: APiQypKcJbxoUZFcZkGGrcOhxkkoYgyDyAYDNNzeMEuP8jE+elB+gIFwl7Rnnr6glCfhHrKy1rzmFw==
X-Received: by 2002:aa7:c609:: with SMTP id h9mr19021258edq.93.1586183701711; 
 Mon, 06 Apr 2020 07:35:01 -0700 (PDT)
Received: from CBGR90WXYV0 (54-240-197-238.amazon.com. [54.240.197.238])
 by smtp.gmail.com with ESMTPSA id t25sm2427160edi.11.2020.04.06.07.35.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 Apr 2020 07:35:01 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
To: "'Anthony PERARD'" <anthony.perard@citrix.com>,
	<qemu-devel@nongnu.org>
References: <20200406105954.GT4088@perard.uk.xensource.com>
 <20200406140217.1441858-1-anthony.perard@citrix.com>
In-Reply-To: <20200406140217.1441858-1-anthony.perard@citrix.com>
Subject: RE: [PATCH v2 for-5.0] xen-block: Fix double qlist remove and request
 leak
Date: Mon, 6 Apr 2020 15:34:59 +0100
Message-ID: <002901d60c20$8dcc94d0$a965be70$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQId5Ykq0Zul8aMjLjRNg1HUybzDSQHmJUNIp81CgpA=
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::541
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
Reply-To: paul@xen.org
Cc: 'Kevin Wolf' <kwolf@redhat.com>,
 'Stefano Stabellini' <sstabellini@kernel.org>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, 'Max Reitz' <mreitz@redhat.com>,
 'Stefan Hajnoczi' <stefanha@redhat.com>, xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Anthony PERARD <anthony.perard@citrix.com>
> Sent: 06 April 2020 15:02
> To: qemu-devel@nongnu.org
> Cc: qemu-stable@nongnu.org; Anthony PERARD <anthony.perard@citrix.com>; Stefano Stabellini
> <sstabellini@kernel.org>; Paul Durrant <paul@xen.org>; Stefan Hajnoczi <stefanha@redhat.com>; Kevin
> Wolf <kwolf@redhat.com>; Max Reitz <mreitz@redhat.com>; xen-devel@lists.xenproject.org; qemu-
> block@nongnu.org
> Subject: [PATCH v2 for-5.0] xen-block: Fix double qlist remove and request leak
> 
> Commit a31ca6801c02 ("qemu/queue.h: clear linked list pointers on
> remove") revealed that a request was removed twice from a list, once
> in xen_block_finish_request() and a second time in
> xen_block_release_request() when both function are called from
> xen_block_complete_aio(). But also, the `requests_inflight' counter is
> decreased twice, and thus became negative.
> 
> This is a bug that was introduced in bfd0d6366043

NIT: I guess you should quote the patch title here as well.

> , where a `finished'
> list was removed.
> 
> That commit also introduced a leak of request in xen_block_do_aio().
> That function calls xen_block_finish_request() but the request is
> never released after that.
> 
> To fix both issue, we do two changes:
> - we squash finish_request() and release_request() together as we want
>   to remove a request from 'inflight' list to add it to 'freelist'.
> - before releasing a request, we need to let now the result to the
>   other end,

"we need to let the other end know the result"

> thus we should call xen_block_send_response() before
>   releasing a request.
> 
> The first change fix the double QLIST_REMOVE() as we remove the extra

s/fix/fixes

> call. The second change makes the leak go away because if we want to
> call finish_request(), we need to call a function that do all of

s/do/does

> finish, send response, and release.
> 
> Fixes: bfd0d6366043 ("xen-block: improve response latency")
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>

The code looks ok, so with the cosmetic fixes...

Reviewed-by: Paul Durrant <paul@xen.org>


