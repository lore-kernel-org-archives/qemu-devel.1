Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C9BC28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 09:59:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19DD6208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 09:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19DD6208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50897 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVvMs-0001mg-DO
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 05:59:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.perard@citrix.com>) id 1hVvLp-0001Mg-Vg
	for qemu-devel@nongnu.org; Wed, 29 May 2019 05:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.perard@citrix.com>) id 1hVvLp-0005PN-2i
	for qemu-devel@nongnu.org; Wed, 29 May 2019 05:58:29 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:20827)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
	id 1hVvLo-0005Nj-Nd
	for qemu-devel@nongnu.org; Wed, 29 May 2019 05:58:29 -0400
Authentication-Results: esa1.hc3370-68.iphmx.com;
	dkim=none (message not signed) header.i=none;
	spf=None smtp.pra=anthony.perard@citrix.com;
	spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
	spf=None smtp.helo=postmaster@MIAPEX02MSOL02.citrite.net
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
	authenticity information available from domain of
	anthony.perard@citrix.com) identity=pra;
	client-ip=23.29.105.83; receiver=esa1.hc3370-68.iphmx.com;
	envelope-from="anthony.perard@citrix.com";
	x-sender="anthony.perard@citrix.com";
	x-conformance=sidf_compatible
Received-SPF: Pass (esa1.hc3370-68.iphmx.com: domain of
	anthony.perard@citrix.com designates 23.29.105.83 as
	permitted sender) identity=mailfrom; client-ip=23.29.105.83;
	receiver=esa1.hc3370-68.iphmx.com;
	envelope-from="anthony.perard@citrix.com";
	x-sender="anthony.perard@citrix.com";
	x-conformance=sidf_compatible; x-record-type="v=spf1";
	x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
	ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
	ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
	ip4:216.52.6.188 ip4:23.29.105.83 ip4:162.221.156.50 ~all"
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
	authenticity information available from domain of
	postmaster@MIAPEX02MSOL02.citrite.net) identity=helo;
	client-ip=23.29.105.83; receiver=esa1.hc3370-68.iphmx.com;
	envelope-from="anthony.perard@citrix.com";
	x-sender="postmaster@MIAPEX02MSOL02.citrite.net";
	x-conformance=sidf_compatible
IronPort-SDR: peefFG3ggqTVIXhO6GVoBlGvJPwavkaKbGp2HsyyE0bdBmtwZko5nKeaNbdBnX7SgOLYmHYL82
	1vx3YVI7ss1d4LSQAqcVKAahMOOJGyzKImq2ye7/0hruIen89m971VuCJYN0zbyyXCd6Ofm6PO
	z2OCqJFNBaFcEx+jNXqUIHQxQulyiVutQbKXVIEnLA5/vUsTQ+DMdj5/FL2IKxRfYNNkkNJjQC
	da6+mHSSiUgWu507UYeeE/kSbvahgPp3Ka1Yd52cLyAQgMiy7+Ho+AIAzw076lCIDjNMXB3EaY
	3yY=
X-SBRS: 2.7
X-MesageID: 1032738
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 23.29.105.83
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.60,526,1549947600"; 
   d="scan'208";a="1032738"
Date: Wed, 29 May 2019 10:58:23 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: Markus Armbruster <armbru@redhat.com>, Stefano Stabellini
	<sstabellini@kernel.org>
Message-ID: <20190529095823.GC2126@perard.uk.xensource.com>
References: <87lfyqla7r.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87lfyqla7r.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.145.142
Subject: Re: [Qemu-devel] Headers without multiple inclusion guards
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paul Durrant <paul.durrant@citrix.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 28, 2019 at 08:12:24PM +0200, Markus Armbruster wrote:
> Just in case: what's a multiple inclusion guard?  It's
> 
>     #ifndef UNIQUE_GUARD_SYMBOL_H
>     #define UNIQUE_GUARD_SYMBOL_H
>     ...
>     #endif
> 
> with nothing but comments outside the conditional, so that the header
> can safely be included more than once.


> Guest CPU Cores (Xen):
> ----------------------
> 
> X86
> M: Stefano Stabellini <sstabellini@kernel.org>
> M: Anthony Perard <anthony.perard@citrix.com>
> M: Paul Durrant <paul.durrant@citrix.com>
> include/hw/xen/io/ring.h

That file does have a guard, it's __XEN_PUBLIC_IO_RING_H__

Do you (or the checker) want it to be changed to XEN_PUBLIC_IO_RING_H ?

> virtio-9p
> M: Greg Kurz <groug@kaod.org>
> hw/9pfs/xen-9pfs.h

Stefano, is the missing inclusion guard was intentional? Otherwise, I
can send a patch for it.

Cheers,

-- 
Anthony PERARD

