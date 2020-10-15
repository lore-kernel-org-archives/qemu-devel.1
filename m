Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FA0C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CEF72225C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 13:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SFm87F20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CEF72225C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT2xM-0000LP-1b
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 09:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kT2wY-0008CV-5f
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:05:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45257)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kT2wV-0003yL-E5
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602767110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IuU+RpyrNylL9VwXhvkrKA2tJA8LQ/mL1xMDSnfMDf0=;
 b=SFm87F20AC3DTkAqvDqkvyT1huAA9CtBvnLJh9qDaPYgOBYW9SDPmQA39+mcX1b6paqECc
 4lBoKJzPH7VHCncqyHsvPvJsnvs5d/CBDGQN3vKEDPeqo+hZAfcej/k7E3odhvI9RuaGxq
 lnGdtFJcMdqBq0MWR5n4v3/3kvRL4pE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-Z2gz2bDePqyjm_UG0SgG6w-1; Thu, 15 Oct 2020 09:05:09 -0400
X-MC-Unique: Z2gz2bDePqyjm_UG0SgG6w-1
Received: by mail-wm1-f70.google.com with SMTP id f26so1160573wml.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 06:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=h3BtlsIGDOnG5Ndkst8Dr9yG4mdDkWppATbdEleWpsI=;
 b=tMTzgm/s/fpdcbTCJ5Zn2hXprhYb1IgHXopniDT8f3Cx6glhaWTGPGcHIxF6VKpGo0
 yVDjYntbvJW4hydE+Va/BfXjzIMkkOi9DWAa3fY+rslvcAOEvqQxzEK+aZjpoW2BczLA
 mwh+Z8FOyn+rdAEZd6xymK9Iz90P/9WJe2YvBLiHnIVvVuQG4ZWdPG7hZf/+8tSKY1gn
 GUQsNm+0487xWyZarRhcma7BFlaf//XYH9RZbbRNMnDtNU7Y0LoCNcAi+OY4uDhw25DN
 H+xOb27GXYzwIreTrqlX3HwnOOvCZ4AyKftRCUVUms2Qrth8DnYD7SiNiLHBVKZg/M7b
 d2TQ==
X-Gm-Message-State: AOAM5337Z3p4ubHWvEz6r0soAo+OVHOFPF7cHXy7b4PTOAoHUMiOXKYU
 J5NWbSToxqJD6nDSgqiTrifoZ0cXzCdioU6FcpCk/3omZ6liA+gaPO8pyhZ6eNdXG5Gw9Lw0Zlw
 +yK6akZxDm35uDEk=
X-Received: by 2002:adf:9793:: with SMTP id s19mr4352168wrb.139.1602767107804; 
 Thu, 15 Oct 2020 06:05:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3/jhTrFT3bv6DtoKUFI87CeS6xXMFFxro0GoTYleZrqyKkKqfj7gF5VIeyI8P4pnLBztyOA==
X-Received: by 2002:adf:9793:: with SMTP id s19mr4352127wrb.139.1602767107486; 
 Thu, 15 Oct 2020 06:05:07 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id e25sm2324162wra.71.2020.10.15.06.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 06:05:06 -0700 (PDT)
Date: Thu, 15 Oct 2020 09:05:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH v5] Add a comment in bios-tables-test.c to clarify the
 reason behind approach
Message-ID: <20201015090450-mutt-send-email-mst@kernel.org>
References: <20200929142501.1057-1-ani@anisinha.ca>
 <105B94CB-1345-49FB-B296-F5236E448BC3@anisinha.ca>
 <72e35a9d-21f4-095d-1ae9-9ed33842dd24@redhat.com>
 <CAARzgwyJ2Cy286wWoo6G+mMZbGQRVyChxEQV++oLpVY+_MOU+g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAARzgwyJ2Cy286wWoo6G+mMZbGQRVyChxEQV++oLpVY+_MOU+g@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 15, 2020 at 04:58:37PM +0530, Ani Sinha wrote:
> 
> 
> On Mon, Oct 12, 2020 at 19:43 Thomas Huth <thuth@redhat.com> wrote:
> 
>     On 12/10/2020 16.07, Ani Sinha wrote:
>     > Request to queue this patch with the next pull.
> 
>     I can take it via qtest-next in case Michael / Igor do not plan to send a
>     pull request any time soon.
> 
> 
> Michael or Igor, care to comment?

Go ahead

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> 
> 
> 
>      Thomas
> 
> 


