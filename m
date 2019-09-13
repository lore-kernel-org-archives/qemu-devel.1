Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03E1C4CEC7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 09:13:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B1B9214AF
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 09:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1B9214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8hdb-0006Ip-Ll
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 05:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i8hch-0005HX-0x
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 05:12:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i8hcf-0000u8-4V
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 05:12:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42902)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i8hcd-0000t6-NI
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 05:12:08 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BAF5A811DE
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 09:12:06 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id x1so13456014wrn.11
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 02:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4Gq+G6d1mZHeefh6VGlHW7lUNDZ7Ouzv37mU22cSs4w=;
 b=q5SNlf7I8sluTRJ34CnlK6JyE73NP1c29o1lgEdWzRxPYQyfkwtPGKRaC74ll+Fxn3
 8JR6dm+9rTc+8KzyzkvNLXx+YaUUnaNFPnQDdnoZ0PTt1/hN0mCAkMd/QSRpE5ARwQAb
 gi+aYcThgTjoyXx0ocmplyzKjAaJiGlZyXPO67NdMaoNcx8SB68McntV3Xh+QnaecSRt
 jve2AuFioVh2toRmsZhyweT7E20VnksvultW7Wt2dj6zpjUbexBWr0fBo3IW+IN+46Lo
 mGX/ijcixfY4MQAv1FQkG8J0dpBX7wSyxSFvL6W82SnIGM4sbc+HPesPdRlrqE4c4dH+
 qOcg==
X-Gm-Message-State: APjAAAWtxUDqU1SF0pYRKPmzlZWBm5nB2yR2VNhUag86Jbfd3F6COaL2
 tAAXo45sGdiGbi0OMbaRVVApuSh3qL2eA2NIK1xiH84uVm0/f5xp1z3P80LzVIPMu88pQeRRqWV
 e9mdGAGC8vSTVzzg=
X-Received: by 2002:adf:e292:: with SMTP id v18mr2913006wri.232.1568365925461; 
 Fri, 13 Sep 2019 02:12:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqykCeGmm2OyJuGD+ZAtXKZ1ym75SUyTE3u1r7IepLc8PF5kiELgL4XXdVaW5EjJGSYcchKy6w==
X-Received: by 2002:adf:e292:: with SMTP id v18mr2912995wri.232.1568365925222; 
 Fri, 13 Sep 2019 02:12:05 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3166:d768:e1a7:aab8?
 ([2001:b07:6468:f312:3166:d768:e1a7:aab8])
 by smtp.gmail.com with ESMTPSA id r9sm43908272wra.19.2019.09.13.02.12.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Sep 2019 02:12:04 -0700 (PDT)
To: Wei Yang <richard.weiyang@gmail.com>
References: <20190321082555.21118-1-richardw.yang@linux.intel.com>
 <20190321082555.21118-3-richardw.yang@linux.intel.com>
 <d5fb9e01-acb9-06ab-edf9-57e2b80bd880@redhat.com>
 <20190823010750.GA21179@richard> <20190912025150.GA25169@richard>
 <c9f18d8e-b7cc-b9d1-1e10-ddbbb4cfd43a@redhat.com>
 <20190912230244.6puc4hwfxxwejx6m@master>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <20793db8-7cfc-2a9d-aa60-5020e84a5950@redhat.com>
Date: Fri, 13 Sep 2019 11:12:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190912230244.6puc4hwfxxwejx6m@master>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/6] exec.c: remove an unnecessary assert
 on PHYS_MAP_NODE_NIL in phys_map_node_alloc()
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
Cc: qemu-devel@nongnu.org, mst@redhat.com,
 Wei Yang <richardw.yang@linux.intel.com>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/09/19 01:02, Wei Yang wrote:
> It shows PHYS_MAP_NODE_NIL may represents more node the tree could hold.

Which is good, it means the assert can trigger.

> The assert here is not harmful, while maybe we can have a better way to handle
> it?

I don't know... The assert just says "careful, someone treats
PHYS_MAP_NODE_NIL specially!".  It's documentation too.

Paolo

