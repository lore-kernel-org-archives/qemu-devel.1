Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221D8C4332E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 18:40:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3FFE20409
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 18:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PbomdD3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3FFE20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGRzv-0001Jw-0D
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 14:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36381)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jGRzE-0000tE-TQ
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 14:39:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jGRzD-0000tO-RN
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 14:39:44 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:20240)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jGRzD-0000sw-Nq
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 14:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584988783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/beeETV3XZAVkc1/ClToIXL8Z1ql+ujvGfIaYNbXc8w=;
 b=PbomdD3+DM7p9VMxMz8L5/DVOOkeSnHRuS58vA84pQ1gYkMBfTb1XnXPUZrZvDb5mWJBoO
 2IXbReQZhiXe0FegzpA1gZlK7wQphkPb3HUgUwicDewpXA5oy2oGaQEkOqBg7tmV4p1llX
 rFWwGwHd/cwUORogoyotBePizwWS7FU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-_tVY6hVSN4qSUjhgPcjioA-1; Mon, 23 Mar 2020 14:39:39 -0400
X-MC-Unique: _tVY6hVSN4qSUjhgPcjioA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CB6B1922960;
 Mon, 23 Mar 2020 18:39:38 +0000 (UTC)
Received: from localhost (ovpn-121-105.rdu2.redhat.com [10.10.121.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A4D99B932;
 Mon, 23 Mar 2020 18:39:37 +0000 (UTC)
Date: Mon, 23 Mar 2020 14:39:36 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH v2] target/i386: Add ARCH_CAPABILITIES related bits into
 Icelake-Server CPU model
Message-ID: <20200323183936.GA3784@habkost.net>
References: <20200316095605.12318-1-xiaoyao.li@intel.com>
 <38253eb8-059c-5020-50cd-e90f7e8e4ae5@intel.com>
 <8324d641-4a1d-cf64-5da5-9410eddc983c@intel.com>
MIME-Version: 1.0
In-Reply-To: <8324d641-4a1d-cf64-5da5-9410eddc983c@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tao Xu <tao3.xu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 23, 2020 at 10:58:16AM +0800, Xiaoyao Li wrote:
> On 3/23/2020 10:32 AM, Tao Xu wrote:
> > Hi Xiaoyao,
> >=20
> > May be you can add .note for this new version.
> >=20
> > for example:
> >=20
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .version =3D 3,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .note =3D "ARCH_CAPABILI=
TIES",
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .props =3D (PropValue[])=
 {
>=20
> Hi Paolo and Eduardo,
>=20
> Need I spin a new version to add the .note ?
> Maybe you can add it when queue?

Please send a follow up patch so we don't hold a bug fix because
of something that's just cosmetic.  I will queue this patch.  We
still need a new version of "target/i386: Add notes for versioned
CPU models"[1], don't we?

[1] https://lore.kernel.org/qemu-devel/20200228215253.GB494511@habkost.net/

--=20
Eduardo


