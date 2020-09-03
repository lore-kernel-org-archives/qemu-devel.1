Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226E8C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:35:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCDE9206EB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="diU1N5Sk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCDE9206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDoT5-0001bC-U0
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 08:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDoMx-0001bW-5B
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:29:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26873
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDoMv-0007vh-FB
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599136172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sA8VJPNfETXiQjTbASMRFVSvXM/GPwXWZEC4rxHulmg=;
 b=diU1N5SkxHmI/M7RcJV3vQmvKcqzo21QPOVPMNZEtfa2KRhDJR7EbFemE3TWme5sLxQdgY
 M3BSojLOmcVHLxqMO5vkHDEz2wNdZVDK9VwE8kCGG4hg6p6si9vlnpB3Ek90qvxmpv1gG2
 WuTuj9jwT2G0c0TCalTTNmMJ9hDYJgA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-5Ci63RO-NLay5yOViGBbnA-1; Thu, 03 Sep 2020 08:29:30 -0400
X-MC-Unique: 5Ci63RO-NLay5yOViGBbnA-1
Received: by mail-wm1-f69.google.com with SMTP id m25so934237wmi.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 05:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sA8VJPNfETXiQjTbASMRFVSvXM/GPwXWZEC4rxHulmg=;
 b=AcWs0lfN1TNDkVXkCgSOah9AVniv1A4XpXg3jMbIeE4XOGICCBClX+LaPqXTdMRh9G
 ZuVIud7aykvtHDu+zSxuUvbFJMIXb7RjbMKJhUIKibJko0EHDhsyGD84yvnS9Zi4cBM1
 owp5khh8TMjtMaJqsbuhINkg82Z27Uf/BcCKON645+ZHwizumYIgX42GX+VBEIK2xuIl
 iBIMUaRnCY/LFh9k5XYGEFS0e1ncUbmcoI/2KumQ5YokFcEEX4palwrwXAeHS5OJ3XYF
 echNxPx/OxYkTDj+Xx53/USo9g6P2frVdSrneX/+TjF4BdH95PU+zSqy/PahbD+gy//l
 iIeQ==
X-Gm-Message-State: AOAM530eZykXSlZKOsNYZZWfmGwpMi2sf8E+PhR/VxZUKu6MMpmLTJs7
 GK5/VTS1WjQqamKx0BfNyAXXIxQWvKwLj138g7C2ldNULNbHuZeOo2vpEn8w/O5jmNljfaanGZz
 CvpysQ3s7nNa7RfQ=
X-Received: by 2002:a1c:7405:: with SMTP id p5mr2255203wmc.35.1599136168566;
 Thu, 03 Sep 2020 05:29:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYjtIq+I1Iic3y+odjmdm7NFQFCl+1XeSG3cHD9o/uZMUf1ODgKJEsf0iutx37FQ47A4ayRg==
X-Received: by 2002:a1c:7405:: with SMTP id p5mr2255188wmc.35.1599136168372;
 Thu, 03 Sep 2020 05:29:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:197c:daa0:48d1:20b2?
 ([2001:b07:6468:f312:197c:daa0:48d1:20b2])
 by smtp.gmail.com with ESMTPSA id z14sm4666531wre.34.2020.09.03.05.29.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 05:29:27 -0700 (PDT)
Subject: Re: flatview_write_continue global mutex deadlock
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel <qemu-devel@nongnu.org>
References: <3abe8579-3540-72fd-c452-3cc52d7fcf26@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d8bb04e7-6edd-8b3d-8896-31c4d4075006@redhat.com>
Date: Thu, 3 Sep 2020 14:29:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <3abe8579-3540-72fd-c452-3cc52d7fcf26@virtuozzo.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:58:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.403, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/09/20 13:16, Vladimir Sementsov-Ogievskiy wrote:
> (gdb) info thr
>   Id   Target Id                                            Frame
> * 1    Thread 0x7fb9f0f39e00 (LWP 215115) "qemu-system-x86"
> 0x00007fb9d784f54d in __lll_lock_wait () from /lib64/libpthread.so.0
> [...]
> #1  0x000056069bfbd3f1 in qemu_poll_ns (fds=0x7fb9401dcdf0, nfds=1,
> timeout=542076652475) at ../util/qemu-timer.c:347
> #2  0x000056069bfd949f in fdmon_poll_wait (ctx=0x56069e6864c0,
> ready_list=0x7fb9481fc200, timeout=542076652475) at ../util/fdmon-poll.c:79
> #3  0x000056069bfcdf4c in aio_poll (ctx=0x56069e6864c0, blocking=true)
> at ../util/aio-posix.c:601
> #4  0x000056069be80cf3 in bdrv_do_drained_begin (bs=0x56069e6c0950,
> recursive=false, parent=0x0, ignore_bds_parents=false, poll=true) at
> ../block/io.c:427
> #5  0x000056069be80ddb in bdrv_drained_begin (bs=0x56069e6c0950) at
> ../block/io.c:433
> #6  0x000056069bf1e5b4 in blk_drain (blk=0x56069e6adb50) at
> ../block/block-backend.c:1718
> #7  0x000056069ba40fb5 in ide_cancel_dma_sync (s=0x56069f0d1548) at
> ../hw/ide/core.c:723
> [...]
> #13 0x000056069bd965e2 in flatview_write_continue (fv=0x7fb9401ce100,
> addr=49152, attrs=..., ptr=0x7fb9f0f87000, len=1, addr1=0, l=1,
> mr=0x56069f0d2420) at ../exec.c:3176

So this is a vCPU thread.  The question is, why is the reconnect timer
not on the same AioContext?  If it were, aio_poll would execute it.

Paolo


