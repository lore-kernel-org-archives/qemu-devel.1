Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F69FC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 10:33:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8AD022BE8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 10:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8AD022BE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqxXo-0001Ap-W6
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 06:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45126)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hqxXa-0000ng-S6
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 06:33:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hqxXX-0001Hl-RQ
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 06:33:32 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:44880)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hqxXX-00012n-Gx
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 06:33:31 -0400
Received: by mail-wr1-f52.google.com with SMTP id p17so53870057wrf.11
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 03:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WEZZ/cBY8h7ri+PPBFXP50LbjKsNtDJvH8IqQZGVd1o=;
 b=o5ixlZRSQ6IZzDtMquNXr9v4Zj/dWcfVMC0gIE2rIC/IpYEifz/s3ljqg5mOPUwetV
 LMdF3+Y0PJTG6yvlhDvD5VrYebsDRx057oaZZaQG5hix0YSyV6/gaFPYqmodY1bbpBlH
 /AzkOQwy/3S3X2HOHa6NQXHlnIArHOv4M2oNVJSX2+iSitjuhNGjxj89c6r0QreD6emc
 KhIMVBi8OqhDh9A6kJW23948KToW3rCpwMMz8JtclCNNDdLpgY0TXqnp2TzBVhJIu4k4
 97d95wlvpWbryUtcjaUuPujpRY1p7cg+cELWuOkFlUmoGycdMy96tCWJqFq7ANcxXX75
 EJHA==
X-Gm-Message-State: APjAAAWGDrjt5CquLup9CsjGIQDNjabFWOcxIvZT5FMd57DCXmEWW/NO
 YKlM8oPZ/vWxYY7nyZXM+2uEHA==
X-Google-Smtp-Source: APXvYqzRuxTVjNdABALIyZUwU3MXJSynNgTQBtAk6gCn6SPIshAi9qJzo8IDf8+Y+tpo13gIkkLOgg==
X-Received: by 2002:adf:e552:: with SMTP id z18mr103608356wrm.45.1564137208047; 
 Fri, 26 Jul 2019 03:33:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cc23:f353:392:d2ee?
 ([2001:b07:6468:f312:cc23:f353:392:d2ee])
 by smtp.gmail.com with ESMTPSA id h14sm50110654wrs.66.2019.07.26.03.33.26
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jul 2019 03:33:27 -0700 (PDT)
To: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190725032321.12721-1-alxndr@bu.edu>
 <20190725032321.12721-4-alxndr@bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <9c699f01-7c2c-668f-2efb-dd8a3f59aff3@redhat.com>
Date: Fri, 26 Jul 2019 12:33:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725032321.12721-4-alxndr@bu.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.52
Subject: Re: [Qemu-devel] [RFC 03/19] fuzz: add fuzz accelerator
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
Cc: "bsd@redhat.com" <bsd@redhat.com>,
 "superirishdonkey@gmail.com" <superirishdonkey@gmail.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/07/19 05:23, Oleinik, Alexander wrote:
> +#ifdef CONFIG_FUZZ
> +/* Both the client and the server have qtest_init's, Rename on of them... */
> +void qtest_init_server(const char *qtest_chrdev, const char *qtest_log, Error **errp);

Just rename it in qtest.c and vl.c.

> +void qtest_server_recv(GString *inbuf); /* Client sends commands using this */

Please define this in this patch already.

> +#else
>  void qtest_init(const char *qtest_chrdev, const char *qtest_log, Error **errp);
> +#endif
>  


