Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E25C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 19:55:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 424E422C7E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 19:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424E422C7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr6Iv-0003Sm-Eh
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 15:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53577)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hr6Il-00034E-JY
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 15:54:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hr6Ik-0002Br-Mt
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 15:54:51 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:36764)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hr6Ik-0002AG-Gw
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 15:54:50 -0400
Received: by mail-wr1-f43.google.com with SMTP id n4so55643228wrs.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 12:54:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Btbnb2p01cRw6q1F+Qx4SupYjcVsXD9XxmPPy6RbYWM=;
 b=mW+1qlvrTMk52/UyeOjTqQrVC0g3jUiySONfTjMT6KY7Ziz3luVYurhZYQgEYoH0Xs
 8Zac2N7H5FGGxj9o0RvsXAD4cjPrd7b76v26WMUyLdnMP5dNfpkxolhuPohgtyICNEOQ
 NFTf2e9iTT1WYnn3JHgC1duST+jnjwO1wR/sDcH17Vv/WeSVYbJFJRn6uVjeiu3Mo/3d
 428qqHDBK63/E0CFYnIHzmgqt7rQjsxUd31DRACOcjhGEBOskkwsQ30Wppk/O4o5haa+
 rZDpw+48ofPWB4cFphM5X5HbxsSiuinE2xcC9R46p4o7QDfkpKYQ1cD/4Z+LEPR2HeKu
 1ySw==
X-Gm-Message-State: APjAAAUqjLD8/IothkHhK/I1p6ij3E80KYdczzbVQTmrLw0yYDNrxnH4
 cY3EzIfNa+QZceDIWmvKDuJwrQ==
X-Google-Smtp-Source: APXvYqwxNIWKWbfYlE2cXaHxeroN/GxdIlVpoWX37V2ODAQ7BnCgUKtUghn5+rmqCW/F0rSVlMSyyA==
X-Received: by 2002:adf:dcc6:: with SMTP id x6mr74753831wrm.322.1564170888802; 
 Fri, 26 Jul 2019 12:54:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cc23:f353:392:d2ee?
 ([2001:b07:6468:f312:cc23:f353:392:d2ee])
 by smtp.gmail.com with ESMTPSA id t6sm59815900wmb.29.2019.07.26.12.54.47
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jul 2019 12:54:48 -0700 (PDT)
To: "Oleinik, Alexander" <alxndr@bu.edu>, Stefan Hajnoczi <stefanha@gmail.com>
References: <20190725032321.12721-1-alxndr@bu.edu>
 <20190725032321.12721-7-alxndr@bu.edu>
 <20190726124745.GC25977@stefanha-x1.localdomain>
 <0f5f2119-bfae-c88b-c67a-5018e6e364f0@bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <b1509aa9-6177-fca8-196a-1f1eebbc8a48@redhat.com>
Date: Fri, 26 Jul 2019 21:54:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0f5f2119-bfae-c88b-c67a-5018e6e364f0@bu.edu>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.43
Subject: Re: [Qemu-devel] [RFC 06/19] fuzz: Add ramfile for fast
 vmstate/vmload
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "superirishdonkey@gmail.com" <superirishdonkey@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/07/19 21:36, Oleinik, Alexander wrote:
>>
>> Please add the ram file to qemu-file.c instead of duplicating QEMUFile.
>>
> I think we should be able to replace all of this simply by using 
> memfd_create. Since it acts as a regular file, it will work with the 
> existing code (likely with performance gains).

That wouldn't be portable to non-Linux, so having RAMFile is better.

Paolo

