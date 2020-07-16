Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0FDC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 08:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E930D2074B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 08:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VEK2jFiY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E930D2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvzig-0008Cv-8P
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 04:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jvzhi-000745-SK
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 04:57:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28659
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jvzhh-0001ek-4E
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 04:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594889840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JXdgY4+AO/NuFMF0MdRystsH1T0wbpekMNWpHSsOXe8=;
 b=VEK2jFiYP/ipuwBWZgG6YQySS1keAAm4zFgmw5YtZwbKhPCX17K+R3hgcJQGRw7fhL1z1A
 FWI/ACOxwKw8L13i2lyTZ0Eabj+KP7jx8GQ2pmgE/GXSHeOR4gKUI2fBOXfkteIAM9LU+8
 f00fUr9hjrK6p7faaRT8REFRlJDN+L4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-u_JyYMIXMdqOmVxLEapqxQ-1; Thu, 16 Jul 2020 04:57:16 -0400
X-MC-Unique: u_JyYMIXMdqOmVxLEapqxQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EAF418A1DF2;
 Thu, 16 Jul 2020 08:57:15 +0000 (UTC)
Received: from work-vm (ovpn-112-11.ams2.redhat.com [10.36.112.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 690176FEF6;
 Thu, 16 Jul 2020 08:57:04 +0000 (UTC)
Date: Thu, 16 Jul 2020 09:56:56 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: introduce cve or security quotient field
Message-ID: <20200716085656.GA7813@work-vm>
References: <20200714083631.888605-1-ppandit@redhat.com>
 <20200714083631.888605-2-ppandit@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200714083631.888605-2-ppandit@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 01:59:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* P J P (ppandit@redhat.com) wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> QEMU supports numerous virtualisation and emulation use cases.
> It also offers many features to support guest's function(s).
> 
> All of these use cases and features are not always security relevant.
> Because some maybe used in trusted environments only. Some may still
> be in experimental stage. While other could be very old and not
> used or maintained actively.
> 
> For security bug analysis we generally consider use cases wherein
> QEMU is used in conjunction with the KVM hypervisor, which enables
> guest to use hardware processor's virtualisation features.
> 
> The CVE (or Security or Trust) Quotient field tries to capture this
> sensitivity pertaining to a feature or section of the code.
> 
> It indicates whether a potential issue should be treated as a security
> one OR it could be fixed as a regular non-security bug.
> 
> Suggested-by: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  MAINTAINERS | 324 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 324 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe8139f367..badf1dab6e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -33,6 +33,14 @@ Descriptions of section entries:
>  	   Obsolete:	Old code. Something tagged obsolete generally means
>  			it has been replaced by a better system and you
>  			should be using that.
> +	C: CVE/Security/Trust Quotient
> +	   H:High - Feature (or code) is meant to be safe and used by untrusted
> +	            guests. So any potential security issue must be processed with
> +	            due care and be considered as a CVE issue.
> +	   L:Low  - Feature (or code) is not meant to be safe OR is experimental
> +	            OR is used in trusted environments only OR is not well
> +	            maintained. So any potential security issue can be processed
> +	            and fixed as regular non-security bug. No need for a CVE.

That's a lot of OR's and it causes problems;
....

>  QMP
>  M: Markus Armbruster <armbru@redhat.com>
>  S: Supported
> +C: Low
>  F: monitor/monitor-internal.h
>  F: monitor/qmp*
>  F: monitor/misc.c

QMP is critical to many uses, so you wouldn't want to exclude it from a secure build;
any security issue with it (e.g. misparsing an argument) would be very
serious and would need to be looked at; but QMP is expected to be
talking to another trusted endpoint.

Dave
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


