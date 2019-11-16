Return-Path: <SRS0=i/12=ZI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC02EC432C3
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 01:49:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 925CD20723
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 01:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gr+WYgb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 925CD20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVnDJ-0002gP-NM
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 20:49:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iVnCG-0001yr-Nt
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 20:48:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iVnCE-0007lp-Bq
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 20:48:19 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49068
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iVnCD-0007l2-M5
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 20:48:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573868896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=36Q409Fwy0ueCJOw8wC0Yf0RBYykAraB2iQndIHmOf4=;
 b=gr+WYgb4jRyICE8+EP0K/wJ/2l8UbsMZHw8jCfXPYLIEOYIOFRj2HLQjAJRc43OLEdyHB9
 EGS6E6G1OGj695ZUep6TNnvrUB5JW3t0SXtjvbTnZSuc8lXxMS7layOzOgWIK9JiXW84n3
 LrxM2NaE6d1buEJdQ6SrSphCj1iK/j0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-tnVss1U3Oxmyi4Ep8rdeNA-1; Fri, 15 Nov 2019 20:48:12 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E19521802CE3;
 Sat, 16 Nov 2019 01:48:10 +0000 (UTC)
Received: from localhost (ovpn-116-6.gru2.redhat.com [10.97.116.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 252E26609C;
 Sat, 16 Nov 2019 01:48:07 +0000 (UTC)
Date: Fri, 15 Nov 2019 22:48:05 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] hw: add compat machines for 5.0
Message-ID: <20191116014805.GZ3812@habkost.net>
References: <20191112104811.30323-1-cohuck@redhat.com>
 <20191115090757-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191115090757-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: tnVss1U3Oxmyi4Ep8rdeNA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Jiri Denemark <jdenemar@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CCing Jiri.

On Fri, Nov 15, 2019 at 09:08:37AM -0500, Michael S. Tsirkin wrote:
> On Tue, Nov 12, 2019 at 11:48:11AM +0100, Cornelia Huck wrote:
> > Add 5.0 machine types for arm/i440fx/q35/s390x/spapr.
> >=20
> > For i440fx and q35, unversioned cpu models are still translated
> > to -v1; I'll leave changing this (if desired) to the respective
> > maintainers.
> >=20
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >=20
> > also pushed out to https://github.com/cohuck/qemu machine-5.0
> >=20
> > x86 folks: if you want to change the cpu model versioning, I
> > can do it in this patch, or just do it on top yourselves

Thanks for taking care of this, Cornelia!

>=20
>=20
> Seems a bit cleaner in the same patch. Eduardo what's your take?

The plan is to eventually set
default_cpu_version=3DCPU_VERSION_LATEST, but we won't change
default_cpu_version in QEMU 5.0 yet.

We need to keep default_cpu_version=3D1 for a few releases, until
management software adapts.  See the "Runnability guarantee of
CPU models" section at qemu-deprecated.texi.

--=20
Eduardo


