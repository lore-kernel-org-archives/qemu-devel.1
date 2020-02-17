Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159CEC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 16:05:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D702620679
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 16:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VYk9axS+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D702620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3iu2-0000PV-3l
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 11:05:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j3itD-0007uj-Tz
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 11:04:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j3itC-0004Q1-EX
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 11:04:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46744
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j3itC-0004PS-9s
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 11:04:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581955492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a5oVjeOBJ4QOW7kLeXrNISE7Hu1omiVhrvZx7eDDs/4=;
 b=VYk9axS+ki1HP5Q/e+DJ6Qouei2Td3HyZ38QMVmieqw/brn+WJekBDi2wgwzyxH8lGZpye
 qvm0tLjGCAQoFDaBgbm9CI7HOPYDPiOzKgJX4TRuLPx7nFa3+rtkJpG3paDgvQZ1u+6mk9
 Yg7yIkvZA8UHDLIwyoK4mgZImeVck0U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-B8OMeyDXOs2vL0NpUi338Q-1; Mon, 17 Feb 2020 11:04:50 -0500
Received: by mail-wr1-f72.google.com with SMTP id o6so9131209wrp.8
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 08:04:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=a5oVjeOBJ4QOW7kLeXrNISE7Hu1omiVhrvZx7eDDs/4=;
 b=W563UcfvGemwrNotvH1ejLsuOhk1yEqBSRXDhGWqAC2289ujB79xiYch9Z70zu5XHd
 Zl/Q9BfnlQNTwsDvB2BnDSyLXAr38dJFnjAfmZcCt6MnYf6YSHTb/+aAMk8O8DF/OzVX
 AMboJDqk1WTpqoHlByY3fd+lmk2JMmnc8Fg1Gb107aVgn3vG6pTh1x046OVKKIke9H2u
 VPUP33HrCqgVUTrnz5h6o/TZegZsZP2RzNRzxm4gsZT8E/0HdpzbUiXjER5tA/0vPlrL
 dypuGzAGAtPbv01q6+gS/F/M4YNKeWhHS4O/7aTFJxkCZmlCLepG7kMrPvGdDUncl5d5
 oJYw==
X-Gm-Message-State: APjAAAXHkqgiXzyvjtcgMvo2Kyq9eOtX4HvCZm4FGhJJcVELF+YjYIj0
 WXiZ84543n+dqejm/l7M4gzGq5LwhjiT1pDHEjsPKyUgoYAxhOkmqL/tLxlQKhxjbaVDWsDsduS
 pcTUWEazFmJrt6n0=
X-Received: by 2002:a5d:6a52:: with SMTP id t18mr21985705wrw.335.1581955489217; 
 Mon, 17 Feb 2020 08:04:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqzVuekGgXpYqKEzhcJC20VxerGYYDncHaCOKFO4NUqHtVz9mfEghjWcsE0lAZQUK2psIVrSEQ==
X-Received: by 2002:a5d:6a52:: with SMTP id t18mr21985677wrw.335.1581955488934; 
 Mon, 17 Feb 2020 08:04:48 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:59c7:c3ee:2dec:d2b4?
 ([2001:b07:6468:f312:59c7:c3ee:2dec:d2b4])
 by smtp.gmail.com with ESMTPSA id a16sm1564527wrx.87.2020.02.17.08.04.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 08:04:48 -0800 (PST)
Subject: Re: [PATCH 0/3] docs: Create a 'tools' manual
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200217155415.30949-1-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1865c4e9-a0b5-0c50-adb8-e46da1b0d8a9@redhat.com>
Date: Mon, 17 Feb 2020 17:04:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200217155415.30949-1-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: B8OMeyDXOs2vL0NpUi338Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/02/20 16:54, Peter Maydell wrote:
> This patchset creates the new 'tools' manual that we've
> decided we should have, and moves 5 existing documents to it:
> 
>  docs/interop/qemu-img.rst
>  docs/interop/qemu-nbd.rst
>  docs/interop/virtfs-proxy-helper.rst
>  docs/interop/qemu-trace-stap.rst
>  docs/interop/virtiofsd.rst
> 
> This change will conflict with the QAPI-doc-comment-to-rST
> patchset because they both change the docs/interop makefile
> rules, but I expect this one to get in to master first;
> the other needs a respin at some point anyhow.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

We can move them back to the system manual once it's converted to rST,
but for now it's the best solution.

(In fact, I am willing to do the conversion from texi to rST if: 1)
someone else helps with the .hx parts; 2) we accept that the current
structure of the manual isn't great but we agree to reorganize
everything after the conversion).

Paolo


