Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB01C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 05:02:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83E4C2176B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 05:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxzlT4th"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83E4C2176B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ8XL-0003pj-C7
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 01:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1kJ8WF-0003Nt-3h
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 01:01:11 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030]:56085)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1kJ8WB-0001bO-U9
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 01:01:10 -0400
Received: by mail-pj1-x1030.google.com with SMTP id q4so2506302pjh.5
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 22:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=GB/NNWVADKGiSFzQSluKPkBW8smqq4Tm7yftcdpXe2I=;
 b=LxzlT4thum+4dZ+WLnbX/h2ZzvBkp8M3RdVGSSZ5CcTsRFI8huNYbIQ3cfEdpItYir
 nuraVtApM14iAwJWOchYOC+aUVRXfcPApKYu/8P+Ox5AUtRgqedhJBEGWMJLIMT6dPcA
 /PGfba48nZAUxkWXkuUebpMLqjdPAl79sj5Mr2n492TwiouHrXcT9ZMWwqmq9YQNXak3
 brieR6qU7DrRfGqyh8cNjdHpjviwAq0VketnMyhWk7iWQHgkABMydL0bxe2mi7UHkIUA
 3RazHwIm+TTm+k06QU6ShPlEiH8sHl+PUiTqtKnUX8cKh+GNnHePewE5IEjqHjp70veo
 RRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GB/NNWVADKGiSFzQSluKPkBW8smqq4Tm7yftcdpXe2I=;
 b=OMbyJ6FUKZ+vOTVz2fE55r9GSk9LxzPo5CoE4f2ZhyPAx/ttPhuwRvqIop/qNZtbsT
 HmxV9oJ7Ykjs0Z/FIwA/PMNlKVA7JqNAovQGMiNUHpAKYQVHvEe6bE7RwuEtHn84iKzJ
 PW+SY6dt1mvnZ0nbKw34UVMvkJSbYxnD96HDxirLLZbQjAOHtt039WsQOvbjMM+FK3jK
 nPxUo/SpYoEGvjlwMPBcaJA/2zATaem0eZwxds+vegabo4wcHKD6i9itJKH/bsifbAip
 YFzBMS485h6h7Zj8nMAMol34UXSCet4iWSrj9G0BvkJTzp/AqanDIdDtbIRECSFtoW6K
 YCUQ==
X-Gm-Message-State: AOAM530U7QETQN8qHQUtGyglzGpiLgsLCD2fABwIB1EtR7FMlP0iTfTz
 wgD113hQMztszAZj2PcC2EY=
X-Google-Smtp-Source: ABdhPJx94tI6Gs9eVrIKHd+ZwBY0ZOnw63E78sHC7KZIBzXsggywtTFeicBCavtjP9NsHAcR2a1xAw==
X-Received: by 2002:a17:90a:fc8:: with SMTP id
 66mr11639213pjz.217.1600405265819; 
 Thu, 17 Sep 2020 22:01:05 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
 by smtp.gmail.com with ESMTPSA id u6sm1306307pjy.37.2020.09.17.22.01.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 22:01:04 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Fri, 18 Sep 2020 13:00:55 +0800
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: Should I delete created coroutines manually?
Message-ID: <20200918050055.hbyg7xqla2wm7p7o@Rk>
References: <20200817131319.hqhchbgkjofbvsuj@Rk>
 <CAJSP0QVCKovhA_ZJPMO52F3Wc_pCGK=_A4BX9wZsKC-51AL4NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJSP0QVCKovhA_ZJPMO52F3Wc_pCGK=_A4BX9wZsKC-51AL4NA@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=coiby.xu@gmail.com; helo=mail-pj1-x1030.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 18, 2020 at 04:19:58PM +0100, Stefan Hajnoczi wrote:
>On Mon, Aug 17, 2020 at 2:13 PM Coiby Xu <coiby.xu@gmail.com> wrote:
>> I'm working on vhost-user block device backend [1]. When I tested my
>> patches on the latest version of QEMU (commit
>> d0ed6a69d399ae193959225cdeaa9382746c91cc) with --enable-sanitizer turned
>> on, the follow error will be thrown out,
>>
>>      ==46631==ERROR: LeakSanitizer: detected memory leaks
>>
>>      Direct leak of 312 byte(s) in 1 object(s) allocated from:
>>          #0 0x55d0a7813921 in calloc (qemu/qemu-storage-daemon+0x646921)
>>          #1 0x7f8bd6f7b591 in g_malloc0 (/usr/lib/libglib-2.0.so.0+0x4f591)
>>          #2 0x55d0a815f3fb in qemu_coroutine_create qemu/util/qemu-coroutine.c:75:14
>>          #3 0x55d0a817321e in vu_client_start qemu/util/vhost-user-server.c:225:23
>>          #4 0x55d0a816fcf3 in vu_accept qemu/util/vhost-user-server.c:341:5
>>          #5 0x55d0a7f1293f in qio_net_listener_channel_func qemu/io/net-listener.c:54:9
>>          #6 0x55d0a7efb0f3 in qio_channel_fd_source_dispatch qemu/io/channel-watch.c:84:12
>>          #7 0x7f8bd6f7e33f in g_main_context_dispatch (/usr/lib/libglib-2.0.so.0+0x5233f)
>>
>> I have to call qemu_coroutine_delete to eliminate this kind of errors.
>
>qemu_coroutine_delete() is an internal API and shouldn't be called directly.
>
>If you are sure that the coroutine terminated (returned from its entry
>function) then the leak is probably caused by the following:

Thank you for this clue! Yesterday I realized the execution of coroutine
has been yielded since qio_channel_yield is called. Now I give the socket
server enough time to do the clean-up work after the client socket is
closed and the issue is gone.

>
>util/qemu-coroutine.c has a pool of Coroutine objects that are reused.
>It's likely that the "leaked" object is in that pool.
>
>I'm surprised that this issue hasn't been reported before, but
>release_pool should be cleaned up when the program terminates.

I still can't figure out why the issue hasn't been reported before. I guess
I have to put it aside.
>
>Stefan

--
Best regards,
Coiby

