Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EC5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:52:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1FAA20679
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1FAA20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgWcu-00062D-59
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 12:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roger.pau@citrix.com>)
 id 1jgWcE-0005Mm-6w
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:51:46 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:5501)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roger.pau@citrix.com>)
 id 1jgWcD-0003qn-0f
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:51:45 -0400
Authentication-Results: esa5.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: 4decgFsKWVfn1fWOoLwMQVuM72S682hSoKwo8se4vZ+1DVD4ts/5dVGfITtwNzfl+5JVQGgS34
 B79x6y2Nw2Vkal3x6wnsBCOQX3JfUHDOZZpaEEL4O5cTQa0XEmolumQ1UMkCaLdHy95vw67HOh
 IKuxQbsUto2Yk2AlzO+fGHE7jr6QcCnpiSfSSXpHBDLyt9YWCvxCDlL/GCcXBvTIjTNcPe3Jt5
 HfoCkTjys8DX/p7u2o9orlu69ySp80ehc3kQyFaJOr7G5aZm/tp6wW48H3y8yeOljyNkZk3DkD
 SBw=
X-SBRS: 2.7
X-MesageID: 19395688
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.73,468,1583211600"; d="scan'208";a="19395688"
Date: Wed, 3 Jun 2020 18:51:34 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Anthony PERARD <anthony.perard@citrix.com>
Subject: Re: [PATCH v3] xen: fix build without pci passthrough
Message-ID: <20200603165134.GG1195@Air-de-Roger>
References: <20200603160442.3151170-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200603160442.3151170-1-anthony.perard@citrix.com>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Received-SPF: pass client-ip=216.71.155.168; envelope-from=roger.pau@citrix.com;
 helo=esa5.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 12:51:41
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, FROM_EXCESS_BASE64=0.979,
 KHOP_DYNAMIC=0.001, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paul Durrant <paul@xen.org>, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 03, 2020 at 05:04:42PM +0100, Anthony PERARD wrote:
> From: Roger Pau Monne <roger.pau@citrix.com>
> 
> Xen PCI passthrough support may not be available and thus the global
> variable "has_igd_gfx_passthru" might be compiled out. Common code
> should not access it in that case.
> 
> Unfortunately, we can't use CONFIG_XEN_PCI_PASSTHROUGH directly in
> xen-common.c so this patch instead move access to the
> has_igd_gfx_passthru variable via function and those functions are
> also implemented as stubs. The stubs will be used when QEMU is built
> without passthrough support.
> 
> Now, when one will want to enable igd-passthru via the -machine
> property, they will get an error message if QEMU is built without
> passthrough support.
> 
> Fixes: 46472d82322d0 ('xen: convert "-machine igd-passthru" to an accelerator property')
> Reported-by: Roger Pau Monné <roger.pau@citrix.com>
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>

Tested-by: Roger Pau Monné <roger.pau@citrix.com>

Fixes the build for me on FreeBSD without pci-passthrough.

Thanks!

