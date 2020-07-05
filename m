Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3C8C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 11:49:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A728520723
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 11:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AB1fSki6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A728520723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js38m-0002mK-Vt
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 07:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1js38E-0002GC-DU
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 07:48:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47729
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1js38C-0008Do-9c
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 07:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593949702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lZKE5ibmmhD5CoUCw8ft6VuFKZl2+IRVJsKFBAgOpXg=;
 b=AB1fSki6NI2IC6j6EbrZxyhP2qV2maiajOZuNtNdXB9j3xaTs/XGZDA+T5wn9aKf+51Y+f
 d50BIAvh5FhZYc52aOsSzQhrV2Z+f3GYvBMQEsjKwbuklIrVKqe/CrDKq3kPJt9ij2pTDN
 8+4830O8ojcmanhso7aXSmqx+ryG+fU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-o4tTGj0nPXyyyaEj8nnpXQ-1; Sun, 05 Jul 2020 07:48:20 -0400
X-MC-Unique: o4tTGj0nPXyyyaEj8nnpXQ-1
Received: by mail-wm1-f70.google.com with SMTP id e15so41493322wme.8
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2020 04:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lZKE5ibmmhD5CoUCw8ft6VuFKZl2+IRVJsKFBAgOpXg=;
 b=jdiWoD3D2zfyp/xxq1t7KB5D/IPMHNvY1Gw82G5KA3O3dPvbfA0uBsBodanUlAIpeb
 wpYzgrnI38z9GzvHL9oCePPRx4EWRRQqmx8E+6Q11m4sYM8Ao8ge9udrnqALukQFHdjt
 pZzCBQZPHL6yyNCoNusqfpgiK6UoOlQ61zOdO0VN2afZoI4/4rWik6jA/PHgDuidvzOb
 yhCKWr58wojG3HZWCJZeBbhsYim1NHGDZeV+rq5U42SOv4pHMJGLtp18dJak1718J4YW
 oGZaHyNT3AO7V8MRNcqIdpUxSk3ffXtTtXtEELti6IG/r+1EFkBN91iPwfL5Ys+RUPkw
 orFw==
X-Gm-Message-State: AOAM532uleha0sCdFBbESHLjzwbZdrqWl2JixiOZZeypIE0mKjT0vu64
 V/o1KARDm6S3OBfeiFYKopxD9ScnDhNYY0/TVFsNTnohmi1yts71HB5ifK4Fam09eA6IQVOETCY
 WOnUP5D/RrC19J+U=
X-Received: by 2002:adf:f3cd:: with SMTP id g13mr42135508wrp.45.1593949699399; 
 Sun, 05 Jul 2020 04:48:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxZ7kkRmqaAGVw+XCHJvhze8OibQl4KugR9vza8eK6nbSE3pjAmnBIRqqQXXN5vtllvHv1Yw==
X-Received: by 2002:adf:f3cd:: with SMTP id g13mr42135475wrp.45.1593949698782; 
 Sun, 05 Jul 2020 04:48:18 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 t16sm21374048wru.9.2020.07.05.04.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 04:48:17 -0700 (PDT)
Date: Sun, 5 Jul 2020 07:48:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v4 08/21] microvm/acpi: add minimal acpi support
Message-ID: <20200704053018-mutt-send-email-mst@kernel.org>
References: <20200702204859.9876-1-kraxel@redhat.com>
 <20200702204859.9876-9-kraxel@redhat.com>
 <20200703084039-mutt-send-email-mst@kernel.org>
 <20200703192510.laaeku6kvudcs4g2@sirius.home.kraxel.org>
MIME-Version: 1.0
In-Reply-To: <20200703192510.laaeku6kvudcs4g2@sirius.home.kraxel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 05:57:33
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

On Fri, Jul 03, 2020 at 09:25:10PM +0200, Gerd Hoffmann wrote:
> On Fri, Jul 03, 2020 at 09:09:43AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Jul 02, 2020 at 10:48:46PM +0200, Gerd Hoffmann wrote:
> > > +    /* copy AML table into ACPI tables blob and patch header there */
> > > +    g_array_append_vals(table_data, dsdt->buf->data, dsdt->buf->len);
> > > +    build_header(linker, table_data,
> > > +        (void *)(table_data->data + table_data->len - dsdt->buf->len),
> > > +        "DSDT", dsdt->buf->len, 5, NULL, NULL);
> > 
> > Why 5? Just curious ...
> 
> IIRC because the hw reduced hardware profile needs acpi 5+ ...
> 
> take care,
>   Gerd

Well ACPI spec 5 says revision value is 2.


Let's use standard practice in ACPI code, and add comments near each
value documenting earliest spec revision where this appeared, chapter
where they came from and some verbatim text that both explains and can
be searched for in later spec revisions.

In fact, same applies to a bunch of other code in this patchset
which just uses macros which does not help all that much
as they don't appear in spec as is. Can you pls go over it
and add such comments where appropriate?

-- 
MST


