Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6D4C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 13:23:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8093F21783
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 13:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8093F21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFeb3-00039F-Nz
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 09:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iFeaQ-0002k3-TO
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 09:22:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iFeaQ-0005ea-12
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 09:22:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43904)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iFeaP-0005eN-Rm
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 09:22:33 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ED4C310B78
 for <qemu-devel@nongnu.org>; Wed,  2 Oct 2019 13:22:32 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id k67so2095604wmf.3
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 06:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v041aeae/REJlKY9J0es/gefaxByjqbEmIGtMYMeRgA=;
 b=S16c/tIV1+z48AxCYVpxGdWMZL2LeucuOstuSqfFMhDASZsQCJAT94v0yBberSBkbs
 Z/unhzAvV9Na5LH/oE74hgY2u4Vr00gSTgQKxEQ6T9MapzMqdObpbaawzpyfBW43JzAe
 SaqaPoOdRb2p63z7UZeVmV9sseUpRjyGKQu01HmRGBjE0cBAz513nHhL1+9ljQyD0x4v
 fvV8mKv9egHKHGb/VL7hC1Wtpq3EaMlcxTvy+rCpC4Y+6E9fOBpSgfff095ujJx9flq/
 7gzupK5EdBQ1+NI0vadKj2owwgWCvGSQ6vz6qGtHtGKdo7d4AmnBpMgToIUA4GfSV2fe
 7X+w==
X-Gm-Message-State: APjAAAUaWYDlEDyB65uaHK7rAFi0bPhUGSkK4MvCY50X127/253eeGbi
 e2I8Bohx5cq2GtVScHQlG+7a6NNSqeOqKaUAHa/64gLgT+CCGehViIQPe19hKGm+Ei2xRr6FZNJ
 IzoPUACXmBwfM2b8=
X-Received: by 2002:a1c:1aca:: with SMTP id a193mr3001916wma.120.1570022551513; 
 Wed, 02 Oct 2019 06:22:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy3BS8hDw0wiy6KbvSF/VoVF49MXglMLuF9JyFQsIZl/RdLEL6UcMD5wGR2ZsSScd24oag2mA==
X-Received: by 2002:a1c:1aca:: with SMTP id a193mr3001892wma.120.1570022551260; 
 Wed, 02 Oct 2019 06:22:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b903:6d6f:a447:e464?
 ([2001:b07:6468:f312:b903:6d6f:a447:e464])
 by smtp.gmail.com with ESMTPSA id l9sm6057610wme.45.2019.10.02.06.22.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Oct 2019 06:22:30 -0700 (PDT)
Subject: Re: [PATCH v5 09/10] docs/microvm.rst: document the new microvm
 machine type
To: Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
References: <20191002113103.45023-1-slp@redhat.com>
 <20191002113103.45023-10-slp@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f604f346-b799-4465-d5ed-0a0f6ff719cd@redhat.com>
Date: Wed, 2 Oct 2019 15:22:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191002113103.45023-10-slp@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, mst@redhat.com, lersek@redhat.com, kraxel@redhat.com,
 imammedo@redhat.com, sgarzare@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/10/19 13:31, Sergio Lopez wrote:
> +- LAPIC (in userspace by default)

Note that LAPIC should be in kernel by default.  The userspace LAPIC is
slow (cannot use APIC virtualization in recent Intel and AMD processors)
and probably somewhat buggy.

Paolo

> +- IOAPIC (in userspace by default)


