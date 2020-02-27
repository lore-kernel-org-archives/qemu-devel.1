Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF46C4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:20:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A647424699
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="MNNU7bHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A647424699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7I9i-0003DP-OB
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 07:20:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1j7I7c-0000qk-UN
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:18:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1j7I7b-0001yV-RX
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:18:32 -0500
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:65003)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1j7I7b-0001xK-JR; Thu, 27 Feb 2020 07:18:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1582805912;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=leJlT/PogD+4eEMLNXJBwg3gOe8mb22nIY33UNBkSvg=;
 b=MNNU7bHgYFmq7r7HXiL5sdA6ZVhQxb+yzvqmOE4whHbz/9g0GBqoLWhu
 3nD1ZyTQTEPc5tyNn992jROSqXbfOnJEUbwAsTpeupIFD1mAhPIr5s0Tx
 H3NOK7bmFRTsn1OT+u38y9++eSmbcr41+cPsbFE6NZpyYi8hV7gilN9Iw M=;
Authentication-Results: esa1.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa1.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
 ip4:168.245.78.127 ~all"
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: EZcnnE8ANHumrgCk71hvQ1MXqxkdFYtqR8fspKhUhtBHUwmitLzR+F+5/cs9t0beQWMM1mtcbv
 tD9Yq2Lxv0ta67YvabechDPL8+baFjNJITKLsI3utX36OLiVkwSkHFVQ3iALXoRfPckMbZMa/D
 Xd1FVZWLcZslqlJ9JwgJT6ZPg0lyb9gQumXeorVq9YRQhH0axUJ5krVgN23Wdkg24XSELvb+MZ
 Nc/FDZLGMmJYbPBMBL8GXdhb1OdxdXvXOzs21jK0Wcvi05X43VaBubDZqGrOD/cXxlMgsc4oPR
 ww4=
X-SBRS: 2.7
X-MesageID: 13277810
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.70,492,1574139600"; d="scan'208";a="13277810"
Date: Thu, 27 Feb 2020 12:18:25 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
To: Paul Durrant <pdurrant@gmail.com>
Subject: Re: [PATCH 08/20] hw/xen/xen_pt_load_rom: Remove unused includes
Message-ID: <20200227121825.GE2193@perard.uk.xensource.com>
References: <20191014142246.4538-1-philmd@redhat.com>
 <20191014142246.4538-9-philmd@redhat.com>
 <CACCGGhCaC5-K+q+fJpTt5aZQ=-XurNAWwNDvKunBLaFHvu7yow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACCGGhCaC5-K+q+fJpTt5aZQ=-XurNAWwNDvKunBLaFHvu7yow@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.145.142
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Paul Durrant <paul@xen.org>,
 qemu-devel@nongnu.org, Gerd
 Hoffmann <kraxel@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org, Helge
 Deller <deller@gmx.de>, David Hildenbrand <david@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 xen-devel <xen-devel@lists.xenproject.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 14, 2019 at 03:29:42PM +0100, Paul Durrant wrote:
> On Mon, 14 Oct 2019 at 15:27, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
> >
> > xen_pt_load_rom.c does not use any of these includes, remove them.
> >
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Reviewed-by: Paul Durrant <paul@xen.org>

Hi,

I've added this patch to a pull requests for the xen.

Cheers,

-- 
Anthony PERARD

