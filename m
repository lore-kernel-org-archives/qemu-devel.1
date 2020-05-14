Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8306DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 11:00:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 427512065F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 11:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="URAvSbly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 427512065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZBbG-0001DM-ES
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 07:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jZBaR-0000iY-1M
 for qemu-devel@nongnu.org; Thu, 14 May 2020 06:59:35 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35354
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jZBaP-0000kB-OH
 for qemu-devel@nongnu.org; Thu, 14 May 2020 06:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589453972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tacLmm/DyOg0XAFvG5P52y9wQbd2aMoVXbp3p4+aJAE=;
 b=URAvSblyqgSL6XiuSSUd7NuskmXZmLduKaZaJFKaCD4gMOQ3fCE7qC7MZUmr5fJmGRSuFO
 xM5qjA4ppVczLUy6N1n2WsASdECgg1tYnq9vZFw9asap2ie004RxvwVQuey4Y0yql1yCst
 zKHtgmYzQLE6wkjTKd3db2uS+HijYsY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-RU_nzOwFMgaXquW3rFv8Uw-1; Thu, 14 May 2020 06:59:29 -0400
X-MC-Unique: RU_nzOwFMgaXquW3rFv8Uw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFDC0BFC0;
 Thu, 14 May 2020 10:59:27 +0000 (UTC)
Received: from gondolin (unknown [10.40.192.240])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B60A1057051;
 Thu, 14 May 2020 10:59:23 +0000 (UTC)
Date: Thu, 14 May 2020 12:59:20 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 0/8] pc-bios: s390x: Cleanup part 1
Message-ID: <20200514125920.03bc7121.cohuck@redhat.com>
In-Reply-To: <92c0d873-c9dc-e3df-7f8f-c377a486ec43@redhat.com>
References: <20200324150847.10476-1-frankja@linux.ibm.com>
 <6d7af967-7567-5e0b-e73a-a4eecc5ad7bf@linux.ibm.com>
 <92c0d873-c9dc-e3df-7f8f-c377a486ec43@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Apr 2020 16:50:25 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 29.04.20 14:11, Janosch Frank wrote:
> > On 3/24/20 4:08 PM, Janosch Frank wrote: =20
> >> The bios is in dire need for a cleanup as there are still a lot of
> >> magic constants being used throughout as well as duplicated code.
> >>
> >> In the first part of this series we consolidate constants and
> >> functions, as well as doing some minor cleanups and fixes.
> >>
> >> The patches are based on my protvirt branch and are available here:
> >> https://github.com/frankjaa/qemu/pull/new/cleanup_bios =20
> >=20
> > Ping
> > It's not urgent, but I don't want it to get buried and forgotten.
> >  =20
>=20
> Let's wait for Thomas, I currently don't have any capacity to review this=
.
>=20
>=20

From the feedback, I assume there will be a v2 anyway?


