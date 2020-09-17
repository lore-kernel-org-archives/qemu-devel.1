Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779BDC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 11:42:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1E0921D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 11:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3Xq28nO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E0921D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIsJF-0002vb-MF
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 07:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kIsIK-0002UG-AQ
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 07:41:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22666)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kIsIG-0006el-Vw
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 07:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600342898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M2vCKio4W2BuVGJinba+V4eiJMAq0dLJcbf4HxLk9Jo=;
 b=R3Xq28nOopNbU/5iI5QZ5M8rlu9czhlMwe2uXx7jtBPsxYzTnVVW26TZGwbIpQXau58Yo3
 i/xDmmR7HZNMK+YyMV0j/JXYTgNec0DUmstaHMxdQs2oRihUsDbAY31U+Jrm1oEdOOm070
 KzPlrOC4avmykvpDNrZtA5aoZiWjQYU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-q-FOfCemNGG3Yq9iIcRlXQ-1; Thu, 17 Sep 2020 07:41:33 -0400
X-MC-Unique: q-FOfCemNGG3Yq9iIcRlXQ-1
Received: by mail-wr1-f69.google.com with SMTP id n15so762880wrv.23
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 04:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=M2vCKio4W2BuVGJinba+V4eiJMAq0dLJcbf4HxLk9Jo=;
 b=RMiestVOHTM516mNZHGDIs9wtVtLc0Jujx5eep/l6fbZYNqDigvq8uJSou/ZCh2lNk
 aDzDZBrIAAWa0ipsn9Xx45YRxereHE/MJpOVztS45v/RzYLGIAPYyOYz/6+usIVln6iV
 a5vATU9cu1JISBMcFzig5ie9TCcmlv47AFfxkrkT3mqOVE3nfAQmA+V2QUuyEh0i6UmF
 +Q4cKZBVVf5bV38kY24dFFj9WWtXqTZkB/CTIImM8JDL7Em9DDwddU7ypszb8HQ7rHbv
 +0wH31sZG8HjEjjwVl8OsNCHhXaFWIcJ3eQ1yFQazI9ew09rtZ90PTLHqk7k6rngma/F
 ktDw==
X-Gm-Message-State: AOAM531tz/VAzELXRNfZe86dVGu1zUFXB9OF32+dMW0hMHq05VKTZACv
 rgZ4/pawHYkAESCHOQFH5i94Eoleb8qz78fsUavWavoHkF12Mvy67d+8jZk5fyBJ77BVHmt06lG
 bDZkKvYZvv/6pnAs=
X-Received: by 2002:adf:d4c7:: with SMTP id w7mr32315499wrk.263.1600342892207; 
 Thu, 17 Sep 2020 04:41:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGLIbIm4oeOmzB25QjRiv+2KDBF4My/GXHNglablUWSbiUbE20iO57KYCaS8bP8bffHTxRVQ==
X-Received: by 2002:adf:d4c7:: with SMTP id w7mr32315481wrk.263.1600342892015; 
 Thu, 17 Sep 2020 04:41:32 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id a11sm10586864wmm.18.2020.09.17.04.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 04:41:31 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org,
Subject: Re: [PATCH] target/i386: always create kvmclock device
In-Reply-To: <160034151689.8478.18235018336121752129@66eaa9a8a123>
References: <160034151689.8478.18235018336121752129@66eaa9a8a123>
Date: Thu, 17 Sep 2020 13:41:30 +0200
Message-ID: <87imcchbpx.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 20:51:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
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
Cc: antoine.damhet@blade-group.com, pbonzini@redhat.com, mtosatti@redhat.com,
 ehabkost@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

no-reply@patchew.org writes:

> Patchew URL: https://patchew.org/QEMU/20200917111306.819263-1-vkuznets@redhat.com/
>
>
>
> Hi,
>
> This series seems to have some coding style problems. See output below for
> more information:
>
> N/A. Internal error while reading log file

error: copy-fd: write returned No space left on device
fatal: failed to copy file to '/var/tmp/patchew-tester-tmp-h4pn40by/src/.git/objects/pack/pack-614a2d933aa3d31ccd9f7bddf2f28bf8fae5e07c.pack': No space left on device
fatal: The remote end hung up unexpectedly

does not look like something I can fix. No idea why 'no space left' is
called a 'coding style problem' btw :-)

-- 
Vitaly


