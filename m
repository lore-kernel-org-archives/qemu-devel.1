Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A698EC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 10:00:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E7F8206E6
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 10:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7F8206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIrDr-0007P4-LK
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 06:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luwei.kang@intel.com>) id 1jIr9d-00035C-Cv
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 05:56:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luwei.kang@intel.com>) id 1jIr9b-0000RB-JM
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 05:56:24 -0400
Received: from mga09.intel.com ([134.134.136.24]:24106)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luwei.kang@intel.com>)
 id 1jIr9b-0000L0-BW
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 05:56:23 -0400
IronPort-SDR: T5XbUJXt7UrzDFHV3f49zyI2PO77EDfs2ViUN7T2UFHrds+FoFjt2igY+4+2gv1Uv2Zdlg1IIj
 I/nj2c9VZoSg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2020 02:56:13 -0700
IronPort-SDR: R6HBIbP6dLAiDJJMOiKujf3QPy9LetriWDWomibQv3w8ASgpRpz5UApj76jp6PgkE5rot1JN6M
 AXhaSzQ5GC2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,323,1580803200"; d="scan'208";a="448212290"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by fmsmga005.fm.intel.com with ESMTP; 30 Mar 2020 02:56:13 -0700
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Mar 2020 02:56:13 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Mar 2020 02:56:12 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.129]) with mapi id 14.03.0439.000;
 Mon, 30 Mar 2020 17:56:09 +0800
From: "Kang, Luwei" <luwei.kang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net"
 <rth@twiddle.net>, "ehabkost@redhat.com" <ehabkost@redhat.com>
Subject: RE: [PATCH v1 0/3] Remove the limitation of Intel PT CPUID info
Thread-Topic: [PATCH v1 0/3] Remove the limitation of Intel PT CPUID info
Thread-Index: AQHV6xfqjs/57yfCb0eiFZpFzYKOh6hhHEKQ
Date: Mon, 30 Mar 2020 09:56:09 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E1738B07FF@SHSMSX104.ccr.corp.intel.com>
References: <1582580312-19864-1-git-send-email-luwei.kang@intel.com>
In-Reply-To: <1582580312-19864-1-git-send-email-luwei.kang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.24
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Strong,
 Beeman" <beeman.strong@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Kang, Luwei <luwei.kang@intel.com>
> Sent: Tuesday, February 25, 2020 5:38 AM
> To: pbonzini@redhat.com; rth@twiddle.net; ehabkost@redhat.com
> Cc: qemu-devel@nongnu.org; Strong, Beeman <beeman.strong@intel.com>;
> Kang, Luwei <luwei.kang@intel.com>
> Subject: [PATCH v1 0/3] Remove the limitation of Intel PT CPUID info
>=20
> The Intel PT feature includes some sub-features(CPUID.(EAX=3D14H,ECX=3D0H=
))
> and these sub-features are different on different HW platforms. To make t=
he
> live migration safety(get the same CPUID info with same cpu model on
> different HW platform), the current Intel PT CPUID information is set to =
a
> constant value(from ICELAKE Server).
>=20
> It will block the new feature in the later HW platform. what's more, the =
support
> of "IP payloads" will disable the Intel PT in KVM guest(patch 1) but it w=
ill come
> soon.
>=20
> This patchset remove this limitation and expose all the capabilities to K=
VM
> guest. As it will break the live migration safe, Intel PT will be masked =
as
> unmigratable.

Ping.

Thanks,
Luwei Kang

>=20
> Luwei Kang (3):
>   i386: Remove the limitation of IP payloads for Intel PT
>   i386: Remove the CPUID limitation of Intel PT
>   i386: Mark the 'INTEL_PT' CPUID bit as unmigratable
>=20
>  target/i386/cpu.c | 69 ++++---------------------------------------------=
------
>  1 file changed, 5 insertions(+), 64 deletions(-)
>=20
> --
> 1.8.3.1


