Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E5CC388F2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 16:49:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6AEF2151B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 16:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vit5hs35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6AEF2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb4ve-0008RW-QS
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 11:49:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kb4uU-00075Y-8E
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 11:48:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35088)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kb4uR-00051h-Hl
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 11:48:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604681295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FxRn1SV0tEERrwfDvB8iMmSyym/77PXUc9iRMHBPQhY=;
 b=Vit5hs35IqAM8dT3bdW32uo91clzeFf+IOMbHIKJl1iP3jCheAo+g9mBazkiEWhLpqJ4b6
 7k0HBlaXwKPQuz9LK+5xELlhMcPJnAbEhz/iWPiywtI6G+UGkiowupY5QOnYLp8zC3m1RY
 HdK0YM5VtP/Ah3JqojdB3R0kLONnIEg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-wgxfYwDxOBWiNIwDLO1PJQ-1; Fri, 06 Nov 2020 11:48:13 -0500
X-MC-Unique: wgxfYwDxOBWiNIwDLO1PJQ-1
Received: by mail-wm1-f71.google.com with SMTP id h2so664702wmm.0
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 08:48:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FxRn1SV0tEERrwfDvB8iMmSyym/77PXUc9iRMHBPQhY=;
 b=rmY3RK1PL+pf/17GogyqGqYZsZbbvjyLpZeuUs7c1S7XUdST7iWK1lXaDz0MSxW5l8
 gmtJy2ltgFUQ3tupBZwIjstR7wBn5J6vS55csivZmdM2uvmUD/dUYPDVtTvjSlXRCPwO
 kO4/nhvVDrHnTfW00pLgTYF+MafHV8vlluXSTkOScWh5jLoTLKs3BlxG0S1W74wixVwD
 1TM16Ni4A37RsrA8c3h82hgata8X5FDkdP6jxldG8GEPWumhb5oJHtqZt4Y72/gt0D+e
 Dn4xzSOavpDgcsF0mUZ92Peo7K3VWgoOlNjFlVSmpVnPQ+U/ABzlRG0LiydzboOCAkQa
 MCMQ==
X-Gm-Message-State: AOAM531oyuDQlnYABMPkbLKJg+TpHYr+ZPHVaIs9xa+87l08NU9ilaWD
 dbE6mnzYA/NAdtNoL17CD4SsKKiFlJA4+6PlbcduNs5j/D33Ary7q3J+YRZnKan74eZJc0m2jCg
 dCnmER1Vmw+31wGw=
X-Received: by 2002:a7b:c349:: with SMTP id l9mr500938wmj.148.1604681292796;
 Fri, 06 Nov 2020 08:48:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzGR/VYM9Jni3hg/PS84G3gpDxwNqpYSpe3OrH4azJ4WWJv51OR9Vs+r4mtinyWoi6YndSTWg==
X-Received: by 2002:a7b:c349:: with SMTP id l9mr500915wmj.148.1604681292592;
 Fri, 06 Nov 2020 08:48:12 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id h4sm2855871wrp.52.2020.11.06.08.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 08:48:10 -0800 (PST)
Date: Fri, 6 Nov 2020 11:48:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] CODING_STYLE.rst: Be less strict about 80 character limit
Message-ID: <20201106114740-mutt-send-email-mst@kernel.org>
References: <20201106112940.31300-1-peter.maydell@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20201106112940.31300-1-peter.maydell@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 07:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, Gan Qixin <ganqixin@huawei.com>,
 "Chenqun \(kuhn\)" <kuhn.chenqun@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 06, 2020 at 11:29:40AM +0000, Peter Maydell wrote:
> Relax the wording about line lengths a little bit; this goes with the
> checkpatch changes to warn at 100 characters rather than 80.
> 
> (Compare the Linux kernel commit bdc48fa11e46f8; our coding style is
> not theirs, but the rationale is good and applies to us too.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  CODING_STYLE.rst | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/CODING_STYLE.rst b/CODING_STYLE.rst
> index 8b13ef0669e..7bf4e39d487 100644
> --- a/CODING_STYLE.rst
> +++ b/CODING_STYLE.rst
> @@ -85,8 +85,13 @@ Line width
>  Lines should be 80 characters; try not to make them longer.
>  
>  Sometimes it is hard to do, especially when dealing with QEMU subsystems
> -that use long function or symbol names.  Even in that case, do not make
> -lines much longer than 80 characters.
> +that use long function or symbol names. If wrapping the line at 80 columns
> +is obviously less readable and more awkward, prefer not to wrap it; better
> +to have an 85 character line than one which is awkwardly wrapped.
> +
> +Even in that case, try not to make lines much longer than 80 characters.
> +(The checkpatch script will warn at 100 characters, but this is intended
> +as a guard against obviously-overlength lines, not a target.)
>  
>  Rationale:
>  
> -- 
> 2.20.1


