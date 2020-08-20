Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A8DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:48:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A18FE22BF3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="YBdhcpp6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18FE22BF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8mnN-0003Te-Q9
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 11:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1k8mam-00081V-7m
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 11:35:05 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:4980)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1k8mae-0001Sh-IM
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 11:35:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1597937696;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=GT4Wl/D+4NhzJRaoMf/yM5omzEmXk23J2lRTjZHe4oQ=;
 b=YBdhcpp6N/lud/LqzT2Xy+iE0EHHkAoFdS5D+UFkmvcdJqN0rYKjbr6G
 sqUDkCPLxfW+sw7LpEdMp3vA4P/OIs0gk4cH4yP6cbHQarluL9erfgsuo
 Z0wmNVI9zjKA6NTJrP69Q25n20yUop24RheFtdZE7BvGgSC1zr+J6UKB0 8=;
Authentication-Results: esa6.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: Zt099DJFApclj8vBK3EbxfTbHrLBRGE14BoA8xltKpO25W33zkCj72eV0Olpza91OePjxE0FYW
 OrTPYmIzqH4DtAuz5K3mfPahXSEP/BPgnFGGDjDybb+BpcsToClwNtBXX85H6IBr2+EOojF4kU
 NqaIac/MbMAFXlhhkjCcO0Mz7kzdAjJ7AN6IZWk8iXyV5QyuI/qfBhkDnnRM0o6YOooVYSf8PE
 /cmdeR6IIv6MnhurE8kQOSveVbw6rViWYEgMv9Xpca5LYxkpt1bKCKWm4CE7Tpyjz6nne6M3wC
 Wpo=
X-SBRS: 2.7
X-MesageID: 25269797
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.76,333,1592884800"; d="scan'208";a="25269797"
Date: Thu, 20 Aug 2020 16:34:49 +0100
To: Eduardo Habkost <ehabkost@redhat.com>
CC: <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, 
 Paul Durrant <paul@xen.org>, <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v2 26/58] xen-legacy-backend: Add missing typedef
 XenLegacyDevice
Message-ID: <20200820153449.GG2024@perard.uk.xensource.com>
References: <20200820001236.1284548-1-ehabkost@redhat.com>
 <20200820001236.1284548-27-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200820001236.1284548-27-ehabkost@redhat.com>
Received-SPF: pass client-ip=216.71.155.175;
 envelope-from=anthony.perard@citrix.com; helo=esa6.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 11:34:52
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Anthony PERARD <anthony.perard@citrix.com>
From: Anthony PERARD via <qemu-devel@nongnu.org>

On Wed, Aug 19, 2020 at 08:12:04PM -0400, Eduardo Habkost wrote:
> The typedef was used in the XENBACKEND_DEVICE macro, but it was
> never defined.  Define the typedef close to the type checking
> macro.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD

