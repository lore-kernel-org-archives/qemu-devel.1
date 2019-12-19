Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AE2C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:43:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2EA4227BF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MtPlgZsN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2EA4227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihv9M-0007ta-Eu
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:43:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33105)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihurK-0008A6-Mf
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihurI-0000Hd-Tv
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:50 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40928
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihurI-0000Fc-IN
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:24:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zsmK9xAv8GxtmUqDynV1b/bI8SHS04jJTtkdRAwM1GI=;
 b=MtPlgZsNIQUaOsXFCLt7EU4RFm+uXKUu9HX326YE+o3kyy8hL0qucDlSyZsYHZxM7qq+1G
 jh4336Kypgc9mUTLPrjiNm90V4WvBkx3t+GXjHSRK9iyjAIQhAHEE/fVPWtfP85SgAvXLd
 lngdAiT3x0lNMHLlw0dwvCGJVM/SnKA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-pnI79cj7OwGCuiTdf-GFyA-1; Thu, 19 Dec 2019 07:24:44 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA2E6800EBF;
 Thu, 19 Dec 2019 12:24:43 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 23AC0808CE;
 Thu, 19 Dec 2019 12:24:42 +0000 (UTC)
Date: Thu, 19 Dec 2019 13:24:40 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH 0/2] iotests: Minor fixes
Message-ID: <20191219122440.GI5230@linux.fritz.box>
References: <20191218104855.42566-1-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191218104855.42566-1-mreitz@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: pnI79cj7OwGCuiTdf-GFyA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 18.12.2019 um 11:48 hat Max Reitz geschrieben:
> Hi,
>=20
> These are just two minor fixes for things I noticed recently.

Thanks, applied to the block branch.

Kevin


