Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD151C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 21:36:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 967A42072A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 21:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A8kBDSNG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 967A42072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9xoU-0004qw-4C
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 16:13:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1j9xnh-0004AY-HK
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 16:13:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1j9xnc-000135-BC
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 16:12:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21156
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1j9xnc-00011D-7Y
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 16:12:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583442775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9FaFwJ8YTCR9x2/zuMJUZ3S12ukUihOBv5GfPznv3ic=;
 b=A8kBDSNG8puHy5WSmbJlzz3UPAKk4TSzN/QVsjI9Qs4WetVG0qj800L/5AJQtRR6U3J+nn
 S8bYLRN8wqJOrJ4GQnR2ugZprudFp5MjvzkOmBG4XxmuKaa4q9YI74a3IZf6/J9/eTVZ5a
 SVe52aew+FCq7u/r5u8hKr59gNKKTlU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-GONn9LG-PdOALPr61BenSw-1; Thu, 05 Mar 2020 16:12:38 -0500
X-MC-Unique: GONn9LG-PdOALPr61BenSw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EC92107BA99;
 Thu,  5 Mar 2020 21:12:37 +0000 (UTC)
Received: from localhost (ovpn-126-90.rdu2.redhat.com [10.10.126.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2EF878D57F;
 Thu,  5 Mar 2020 21:12:34 +0000 (UTC)
Date: Thu, 5 Mar 2020 16:12:33 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Moger, Babu" <Babu.Moger@amd.com>
Subject: Re: [PATCH v2 0/2] Add support for 2nd generation AMD EPYC processors
Message-ID: <20200305211233.GY4440@habkost.net>
References: <157314957337.23828.3860599077487615762.stgit@naples-babu.amd.com>
MIME-Version: 1.0
In-Reply-To: <157314957337.23828.3860599077487615762.stgit@naples-babu.amd.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 07, 2019 at 06:00:51PM +0000, Moger, Babu wrote:
> The following series adds the support for 2nd generation AMD EPYC Process=
ors
> on qemu guests. The model display name for 2nd generation will be EPYC-Ro=
me.
>=20
> Also fixes few missed cpu feature bits in 1st generation EPYC models.
>=20
> The Reference documents are available at
> https://developer.amd.com/wp-content/resources/55803_0.54-PUB.pdf
> https://www.amd.com/system/files/TechDocs/24594.pdf

Queued, thanks and sorry for taking so long to handle this.

--=20
Eduardo


