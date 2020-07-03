Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FB1C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:10:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32BD5208E4
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BmJbtq6R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32BD5208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrLSk-0002ou-Ev
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 09:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrLRx-0001fI-B2
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:09:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33288
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrLRv-0006lD-Ny
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593781790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0xC+1tB/X3Hg9sPTKrM93ZST5q5wyY8bmlg2TtrHq2o=;
 b=BmJbtq6R2iqrHP3qUq84TKOv8hibrV39k9P3/+FMYDL5Us278i/mVWMrt3BwfN5nh7etIK
 GEGeBVuInrQ+KyTvHoBmlGlw4tVsbvEJXy2iXGv/icrmI45wHkXLJOAaGSUCCZW7ETdcnl
 FlwdhNnjsYR+vN50gtFdPspuDXNefB4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-Xvsl93xpOd2sTnl3GarNPg-1; Fri, 03 Jul 2020 09:09:49 -0400
X-MC-Unique: Xvsl93xpOd2sTnl3GarNPg-1
Received: by mail-wr1-f70.google.com with SMTP id 89so8059807wrr.15
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 06:09:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0xC+1tB/X3Hg9sPTKrM93ZST5q5wyY8bmlg2TtrHq2o=;
 b=tqFpE/nvjeJ4yHVI1IMMSTnFA5VKzOKP/2J4eYrUW3eambFYrjXz8eqU31/U9Kqk1i
 0k8rzHD04Vv5kHVIOjvx9RVjunXPHFIALn/GLhrQA0jW+NDDmlo9xd+/j7C/Zj8WF6pe
 tUM8feLJiBGdldPrSS+sRTrAwYa7kojCWGuqBI6a/5760pHRqoa1I8deWpqddrQaOi3I
 0s+kQHN+x7xC33qNO+wRXMizQ1rOtvKXSgrAC+osLCHCOwW12A2s5jsNRS9t2mGy96m1
 Ucb4ZbSuhylSYyZ7VYQiffEtSJni+zv4lrG2epiK9bQporyV5sjSmwUoKVZwrnvnwmd0
 RkHA==
X-Gm-Message-State: AOAM531cCSP/jfkpuEwUNt38Uz97DQMOoY55ggxL7nVFzflrAKWRkzTd
 TkBdtFKMCQHX8cGopg0sBq0jyamQeCoCm4J/Y4LqURIs17URwp3AHt6eAVof/g88ousXspTiX8X
 RWIURTDxXX+yj+G4=
X-Received: by 2002:adf:8091:: with SMTP id 17mr24659633wrl.13.1593781788235; 
 Fri, 03 Jul 2020 06:09:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQl0OKrVxp/Bblqsm5TBYh0ItlNoBRgDNSTQ3PdKPzujWzwrlNVsIvMYyrwAZ8rXFUz/33CA==
X-Received: by 2002:adf:8091:: with SMTP id 17mr24659588wrl.13.1593781787931; 
 Fri, 03 Jul 2020 06:09:47 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 r67sm14360833wmr.9.2020.07.03.06.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 06:09:47 -0700 (PDT)
Date: Fri, 3 Jul 2020 09:09:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v4 08/21] microvm/acpi: add minimal acpi support
Message-ID: <20200703084039-mutt-send-email-mst@kernel.org>
References: <20200702204859.9876-1-kraxel@redhat.com>
 <20200702204859.9876-9-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200702204859.9876-9-kraxel@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:17:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 02, 2020 at 10:48:46PM +0200, Gerd Hoffmann wrote:
> +    /* copy AML table into ACPI tables blob and patch header there */
> +    g_array_append_vals(table_data, dsdt->buf->data, dsdt->buf->len);
> +    build_header(linker, table_data,
> +        (void *)(table_data->data + table_data->len - dsdt->buf->len),
> +        "DSDT", dsdt->buf->len, 5, NULL, NULL);

Why 5? Just curious ...

-- 
MST


