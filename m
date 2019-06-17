Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFBEC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:36:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1CBF2084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1CBF2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50458 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcvYg-00050n-2Q
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 13:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45271)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hcvUa-0001FC-Pj
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:32:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hcvUX-0007Ev-C6
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:32:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42749)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hcvUU-00071f-U4
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:32:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id x17so10869255wrl.9
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 10:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=50udD58EtmrbCgif3dBnVsBwZbty4gDnaAsePtKXdZw=;
 b=MPDcP7hUgBqBn+sgeG1FWknzAhAnJPyrwCxqevxIb2+Xtuy6PrL7TPHDJFID6R4tPf
 mRNoqySaiQ/+YKnVaR4e5yP/tc/FktxvE4+CRav6K4/Uhaq/SKzcQ0hkN8PYvC1wVdJv
 +AJ9VpiK4t8ISNbQISFq5sOkJL/9A6IK4JwO3VabxVuMmKKMGej6wKsNpCb5xkby5/i9
 JSuFN/FjDhRExYmGuZh55hX/nDNOKhGakPfYjAIMkWv+Ht/7wkoRqqgQSraP4DE3iiTX
 PFUjXZSigWm+fTTRMAybucbFlnTuAlmhaTMGgnoeE+ClZkPT6NB254asUOmxVNWrsVi9
 2/rQ==
X-Gm-Message-State: APjAAAUtDnew/bFEnCNLPvRifrQukaJYTd/1iiYype7ynyPrq6L0vQx3
 QdgSHvwwFYNrwZZIDY78JubFnw==
X-Google-Smtp-Source: APXvYqyZIR+ggNlNMRXYovSi3YxQPhwjBCC8Rox3bQ2TsHxhlo1gzhmPNnzp+WSHIUPdRZYFUA8mLw==
X-Received: by 2002:a5d:63c9:: with SMTP id c9mr31974890wrw.81.1560792727573; 
 Mon, 17 Jun 2019 10:32:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:51c0:d03f:68e:1f6d?
 ([2001:b07:6468:f312:51c0:d03f:68e:1f6d])
 by smtp.gmail.com with ESMTPSA id 139sm16234466wmb.19.2019.06.17.10.32.06
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 10:32:07 -0700 (PDT)
To: Liran Alon <liran.alon@oracle.com>
References: <20190615004256.16367-1-pbonzini@redhat.com>
 <20190615004256.16367-5-pbonzini@redhat.com>
 <829F36FB-3551-4682-9E69-50CC479DAC09@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d61b72cd-95df-c3b7-2f10-8b8ac1364479@redhat.com>
Date: Mon, 17 Jun 2019 19:32:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <829F36FB-3551-4682-9E69-50CC479DAC09@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH 4/7] linux-headers: import improved
 definition of KVM_GET/SET_NESTED_STATE structs
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
Cc: qemu-devel@nongnu.org, nikita.leshchenko@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/06/19 10:29, Liran Alon wrote:
> 
> I think this is cleaner.
> 
> -Liran

Yes, it is.  I'll post it to kvm@vger.kernel.org.  Are you going to send
v2 of this series or shall I?

Paolo

