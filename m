Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BC7C11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 14:54:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40AD4208C4
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 14:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HH12a7Lk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40AD4208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4nDq-0007kQ-Bh
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 09:54:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44201)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j4nCE-0005nW-La
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 09:52:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j4nCC-00036Z-O3
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 09:52:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59640
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j4nCC-00035S-CO
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 09:52:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582210375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=57Aerk872s4YludKFjNkLSM4358cbd1qLJBcsOLk5yk=;
 b=HH12a7LkG8kSTpQDaMp27yRneQoKrD4sV3+8wUF7rMfMREOjruR/AQPH43r3gNYzS3OIbN
 hm515k1Oo4EOoV9DCVkz/AyfdYNqGUHhYq1P4Nx95ZWZxHzA21jQ+8oht/iyd1ptqeYVlG
 knWrm3wtsMRxjY46s/LBCOuwJgQCce4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-Fj4MtdeoM4yrVvKqpybAdw-1; Thu, 20 Feb 2020 09:52:53 -0500
Received: by mail-wm1-f70.google.com with SMTP id u11so925332wmb.4
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 06:52:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=57Aerk872s4YludKFjNkLSM4358cbd1qLJBcsOLk5yk=;
 b=hAvha6P2fh1mkKEeSobmlrsxc+It/jj0m1wPVXZtPSYNuPLPrP3tOaYSW9S1R5sizz
 xK/jYG6N3oziCDUL8hx197Fa/2yC0EcBdMqy+3nci9aG3Qmo4XppmJCqVmYP2WBDBDhJ
 X/Q57J9XZgSpJAcRy3iRI+wV2JQNc7iTjDOW9GMsbXTUXaH0AvZXHBz+NjFXSscpyCJO
 qouzwV4w0689m2V4AJQ+07w8GC93HdlPQSbRJBllcH5yl4FIoNRb8toXgnF+yydwvmyu
 AGdKuwO6Yjk9Lkqp38I02az+3bVP76Ol3/9ktn1WaTX06l6B6IxBXbri/Hw1ec8svH0z
 BgEg==
X-Gm-Message-State: APjAAAUZkE0/uPkaIOA5c8gejOIdtgQ9ge1hK0ou8hMvw5yS+FOoOGa8
 mhYLdCzgJez8iqC70m7l/VdlPeBB6VPGX7zslgvL4HyeiSzOo7ZbPO9Fk0aFP1dAQcqAxHnpati
 aB2DLdDHRJl9YmfQ=
X-Received: by 2002:a1c:1984:: with SMTP id 126mr5149393wmz.78.1582210370980; 
 Thu, 20 Feb 2020 06:52:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqyjOhFwW+klCqY7CAgFZahQ2wh4rYk/aeQpfOhJQ2xl+JSRtr2OGAMHjE6elb8tKn/OUpAXPw==
X-Received: by 2002:a1c:1984:: with SMTP id 126mr5149367wmz.78.1582210370722; 
 Thu, 20 Feb 2020 06:52:50 -0800 (PST)
Received: from [10.201.49.12] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
 by smtp.gmail.com with ESMTPSA id g19sm4813268wmh.36.2020.02.20.06.52.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2020 06:52:50 -0800 (PST)
Subject: Re: [PATCH v3 2/2] qemu-cpu-models.rst: Document -noTSX, mds-no,
 taa-no, and tsx-ctrl
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
References: <20200220142001.20774-1-kchamart@redhat.com>
 <20200220142001.20774-3-kchamart@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4c3f3d85-9499-2e48-124b-18cc0dc36c8a@redhat.com>
Date: Thu, 20 Feb 2020 15:52:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200220142001.20774-3-kchamart@redhat.com>
Content-Language: en-US
X-MC-Unique: Fj4MtdeoM4yrVvKqpybAdw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, berrange@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Two small changes...

On 20/02/20 15:20, Kashyap Chamarthy wrote:
> +  Recommended to inform the guest that it can disable the Intel TSX
> +  (Transactional Synchronization Extensions) feature; or, if the
> +  processor is vulnerable, use the Intel VERW instruction (a
> +  processor-level instruction that performs checks on memory access) as
> +  a mitigation for the TAA vulnerability.  (For details, refer to this
> +  `Intel's deep-dive into
> +  MDS <https://software.intel.com/security-software-guidance/insights/deep-dive-intel-analysis-microarchitectural-data-sampling>`_.)

... refer to Intel's `deep dive into MDS <...>`_.

(I don't know what the trailing underscore is for.  I reaffirm my
definition of rST as the Perl of markup formats).

> +
> +  Expose this to the guest OS if and only if: (a) the host has TSX
> +  enabled; *and* (b) the guest has ``rtm`` CPU flag enabled.
> +
> +  By disabling TSX, KVM-based guests can avoid paying the price of
> +  mitigting TSX-based attacks.

"mitigating"

Paolo


