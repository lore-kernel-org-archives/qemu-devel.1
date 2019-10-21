Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3285CCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 10:03:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6AD520684
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 10:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P993QeFs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6AD520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMUWl-0007OK-3U
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 06:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iMUVT-0006CK-4o
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iMUVO-00008K-B8
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:01:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43797
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iMUVO-00007W-6s
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571652096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3mvXCDSA+f5gIlB/2sbNJxvBl3iNdUuyEhWwp2M9wIg=;
 b=P993QeFsY57HPsZdfamraHfRuQcJEmSfQw/bQhHo5oqj8jmB18iLiEbkIW9/fPPtUCH1Ux
 66Vb4TBP6hH0XoyZfHF5/19/6itqJgj9kZUXafzWiMn1CvyNylPLKO/HXk9Lj+6SI6G+pb
 Bzh/XUYa1Kvamunx82ORCVJvw9XJY2A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-KahwqqlCPQieVeqVKL5ZOQ-1; Mon, 21 Oct 2019 06:01:32 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A34C8100550E;
 Mon, 21 Oct 2019 10:01:31 +0000 (UTC)
Received: from gondolin (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF5CC1001938;
 Mon, 21 Oct 2019 10:01:27 +0000 (UTC)
Date: Mon, 21 Oct 2019 12:01:25 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1] s390x/kvm: Set default cpu model for all machine
 classes
Message-ID: <20191021120125.19ca110f.cohuck@redhat.com>
In-Reply-To: <6404748d-1711-b6d7-f13b-10250d74dc92@redhat.com>
References: <20191021093456.6168-1-david@redhat.com>
 <96381cf8-a6cf-9583-7eb2-92ad9d333c1b@redhat.com>
 <e8ef32ee-de10-0015-6a45-de3d5bba4ff8@redhat.com>
 <6404748d-1711-b6d7-f13b-10250d74dc92@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: KahwqqlCPQieVeqVKL5ZOQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 21 Oct 2019 11:58:35 +0200
David Hildenbrand <david@redhat.com> wrote:

> > query-machines probes with the "none" machine all other machines.
> > Current code only fixes up the active machine.
> >  =20
>=20
> To be more precise, libvirt probes with "-machine none,accel=3Dkvm:tcg"=
=20
> all other machines.

Add that to the patch description?

>=20
> > (that's why you won't notice when starting a machine - you will always
> > get "host" for the active one)
> >  =20
> >>
> >> Anyway, your patch sounds fine, so (with "klass" replaced by "oc"):

Respin with that? Makes it easier to pick up :)

> >>
> >> Reviewed-by: Thomas Huth <thuth@redhat.com>
> >> =20
> >=20
> >  =20
>=20
>=20


