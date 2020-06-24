Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FF9C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 03:37:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D74B82084D
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 03:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldAA6+38"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D74B82084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnwDp-0001LO-0Z
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 23:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jnwD3-0000tU-Vm
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 23:36:26 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:36862)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1jnwD2-0004so-DJ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 23:36:25 -0400
Received: by mail-pl1-x643.google.com with SMTP id j4so456638plk.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 20:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=c9utmbIY3ZlPV6up26oejoTQJ+XzZFR7zidn9/r+ZGw=;
 b=ldAA6+380QCgBdBQJ1vTUVErU4s0L+teCfD70ANfLghn01wzz6kk1xkjhZKKUT6AgH
 yK9ebLR9R20PrYzc0gcrkT8QreqvjWdaSsRBtMjFFoq6piw73WIR4RX7bbLlTtJd0/8o
 7Q8f2nlox7Oy2fnTqSsGzrReQxLzA9gkezrzhoZQhPJmvrEBfsjD1wz0F6fyIKyWHm/e
 BOPxhozw5KI/0dzjJiciSQdeO2OIpmlkVVzd1znZfWg4aza6JTnAztXp9MnmVUKfN6sa
 QooAcY+en8T7f3unJLqBd71z7aC6EEj4gEY6VoCGhTosGBBAmr0BJUtg3c2gBZQZqwqL
 JJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=c9utmbIY3ZlPV6up26oejoTQJ+XzZFR7zidn9/r+ZGw=;
 b=PGCzyEfh/Vjs4eS1550iIjdpkMQ+SkPOyLIosb+jzujpUNS/9SdHPiAj2eBgegqLtE
 PXGoQFbKHoBhaK1TlA0LeBjp1iOSai64ANO45APDxHkaKgRq1nY+LtDk0+af9chgCvLF
 zRo8UvOy1NeA30puKXKpimkth2hBgMZr+t/KaYLudJzqh1FrZsGbEoWKDjhCsq8IGnNd
 K2KGBP7LuWoCDqbndRqXRcF7NYroNxR9movBrgYgp2z2RiXk9LAmgBKhxo3V18rL6sIu
 8Y1XBDRk/l/lyy6wbnHBtP7meRJ7Embm5f73FZe4H3CVXKlaVkNLjR53UQ5Xx18O60w2
 xv/w==
X-Gm-Message-State: AOAM530gxfaaO92jT3AUqA7MXbJ3Z3aTOmT2OAvzp+p5nv2SB8V1CICC
 KvgSvT7nn9Dr43qywzVp/fI=
X-Google-Smtp-Source: ABdhPJwWH+5jUQPI5J2T4N77/5wMd0jSrUk0Pfl7auycsF8ZC69vPNBRom4iYR6gKkG3E/J8YoHskw==
X-Received: by 2002:a17:90a:f011:: with SMTP id
 bt17mr26504826pjb.179.1592969782539; 
 Tue, 23 Jun 2020 20:36:22 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
 by smtp.gmail.com with ESMTPSA id s41sm3921770pjc.51.2020.06.23.20.36.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 20:36:21 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Wed, 24 Jun 2020 11:36:15 +0800
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v9 1/5] Allow vu_message_read to be replaced
Message-ID: <20200624033615.u7u7c4bjeugqa4l3@Rk>
References: <20200614183907.514282-1-coiby.xu@gmail.com>
 <20200614183907.514282-2-coiby.xu@gmail.com>
 <20200618104347.GB6012@linux.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200618104347.GB6012@linux.fritz.box>
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=coiby.xu@gmail.com; helo=mail-pl1-x643.google.com
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
Cc: bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 18, 2020 at 12:43:47PM +0200, Kevin Wolf wrote:
>Am 14.06.2020 um 20:39 hat Coiby Xu geschrieben:
>> Allow vu_message_read to be replaced by one which will make use of the
>> QIOChannel functions. Thus reading vhost-user message won't stall the
>> guest.
>>
>> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>
>_vu_queue_notify() still has a direct call of vu_message_read() instead
>of using the pointer. Is this intentional?

This is a mistake. Thank you for reminding me!

>Renaming the function would make sure that such semantic merge conflicts
>don't stay unnoticed.

Thank you for this tip! Do you suggest renaming the function only for
the purpose of testing or should I adopt a name when submitting the
patch? For the latter case, I will change it to vu_message_read_default
then.

>> @@ -1704,6 +1702,7 @@ vu_deinit(VuDev *dev)
>>          }
>>
>>          if (vq->kick_fd != -1) {
>> +            dev->remove_watch(dev, vq->kick_fd);
>>              close(vq->kick_fd);
>>              vq->kick_fd = -1;
>>          }
>
>This hunk looks unrelated.

In v4, I made the comment to explain why it's needed. But libvhost-user
is supposed to be independent from QEMU, so Stefan suggested to remove it,

> > @@ -1627,6 +1647,12 @@ vu_deinit(VuDev *dev)
> >          }
> >
> >          if (vq->kick_fd != -1) {
> > +            /* remove watch for kick_fd
> > +             * When client process is running in gdb and
> > +             * quit command is run in gdb, QEMU will still dispatch the event
> > +             * which will cause segment fault in the callback function
> > +             */
>
> Code and comments in libvhost-user should not refer to QEMU specifics.
> Removing the watch is a good idea regardless of the application or event
> loop implementation.  No comment is needed here.
> +            /* remove watch for kick_fd
> +             * When client process is running in gdb and
> +             * quit command is run in gdb, QEMU will still dispatch the event
> +             * which will cause segment fault in the callback function
> +             */
> +            dev->remove_watch(dev, vq->kick_fd);

--
Best regards,
Coiby

