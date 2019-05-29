Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2E1C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 13:00:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02412208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 13:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02412208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54005 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVyC3-0001XF-Vh
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 09:00:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.perard@citrix.com>) id 1hVyB9-0001Ds-QA
	for qemu-devel@nongnu.org; Wed, 29 May 2019 08:59:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.perard@citrix.com>) id 1hVyB8-0001Xi-I9
	for qemu-devel@nongnu.org; Wed, 29 May 2019 08:59:39 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:8338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
	id 1hVyB8-0001P1-A7
	for qemu-devel@nongnu.org; Wed, 29 May 2019 08:59:38 -0400
Authentication-Results: esa4.hc3370-68.iphmx.com;
	dkim=none (message not signed) header.i=none;
	spf=None smtp.pra=anthony.perard@citrix.com;
	spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
	spf=None smtp.helo=postmaster@MIAPEX02MSOL02.citrite.net
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
	authenticity information available from domain of
	anthony.perard@citrix.com) identity=pra;
	client-ip=23.29.105.83; receiver=esa4.hc3370-68.iphmx.com;
	envelope-from="anthony.perard@citrix.com";
	x-sender="anthony.perard@citrix.com";
	x-conformance=sidf_compatible
Received-SPF: Pass (esa4.hc3370-68.iphmx.com: domain of
	anthony.perard@citrix.com designates 23.29.105.83 as
	permitted sender) identity=mailfrom; client-ip=23.29.105.83;
	receiver=esa4.hc3370-68.iphmx.com;
	envelope-from="anthony.perard@citrix.com";
	x-sender="anthony.perard@citrix.com";
	x-conformance=sidf_compatible; x-record-type="v=spf1";
	x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
	ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
	ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
	ip4:216.52.6.188 ip4:23.29.105.83 ip4:162.221.156.50 ~all"
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
	authenticity information available from domain of
	postmaster@MIAPEX02MSOL02.citrite.net) identity=helo;
	client-ip=23.29.105.83; receiver=esa4.hc3370-68.iphmx.com;
	envelope-from="anthony.perard@citrix.com";
	x-sender="postmaster@MIAPEX02MSOL02.citrite.net";
	x-conformance=sidf_compatible
IronPort-SDR: M1Tbe5RgAptWFKlJeN4paoCcBoEc5v6VMU0aUdJLWvN2AgIYnH8rpsx4lBjT+fFax44/N9N7Uq
	ORzVVYgUIXqwVOUpDpr7J42ZRmPkhwwKslFWlOSi58TDHnZyYdaUtxU91p3pKW6jGo3fmIu+Vj
	L7l85aftqgh2FiyHULdL+G7ZpZsRmaHU12fuTOF06DZQWwkzOw76hpqGkYt2DXQBVoYE68+C0j
	RSTGxNM/9C76kNasQgSHj4PlWrRhpGQp/Q8C8b7YyKR922egIxAsmcLrYDa1B1xAX+gqO+2yVQ
	MLg=
X-SBRS: 2.7
X-MesageID: 1036967
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 23.29.105.83
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.60,527,1549947600"; 
   d="scan'208";a="1036967"
Date: Wed, 29 May 2019 13:59:26 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190529125926.GD2126@perard.uk.xensource.com>
References: <155912548463.2019004.3515830305299809902.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <155912548463.2019004.3515830305299809902.stgit@bahia.lan>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.155.144
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Change maintership of Xen
 code under hw/9pfs
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org,
	Paul Durrant <paul.durrant@citrix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 29, 2019 at 12:24:44PM +0200, Greg Kurz wrote:
> Xen folks are the actual maintainers for this.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  MAINTAINERS |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1f5f8b7a2c37..d00380641796 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -411,7 +411,7 @@ M: Paul Durrant <paul.durrant@citrix.com>
>  L: xen-devel@lists.xenproject.org
>  S: Supported
>  F: */xen*
> -F: hw/9pfs/xen-9p-backend.c
> +F: hw/9pfs/xen-9p*
>  F: hw/char/xen_console.c
>  F: hw/display/xenfb.c
>  F: hw/net/xen_nic.c
> @@ -1505,6 +1505,7 @@ virtio-9p
>  M: Greg Kurz <groug@kaod.org>
>  S: Supported
>  F: hw/9pfs/
> +X: hw/9pfs/xen-9p*
>  F: fsdev/
>  F: tests/virtio-9p-test.c
>  T: git https://github.com/gkurz/qemu.git 9p-next
> 

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD

