Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB90C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 09:49:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB41B2071B
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 09:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OkLRYD4U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB41B2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY5Z3-0003hq-0p
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 04:49:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iY5Wm-00025O-8H
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 04:47:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iY5Wi-0007ZF-Sj
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 04:46:57 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41471
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iY5Wi-0007YE-F3
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 04:46:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574416015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d+YgBon9Y58Gjyer3aW8ZGjvpG0D9rPYPH8ch88IHKU=;
 b=OkLRYD4U2FysKdMwb6iOM5C/90nGLgZ+8qiZj6MVApgCDdfktZoIow31mSgi9+UMgyaMBT
 AIOgsO3okGVkcB35VoFm6eE6YnaJCBAbPBa00wMoFtvmOT7AyPjYc2OjW227PYTVJHJGCr
 B4wJlD9oHnLvaglZGZZNPTcRcgFRPvk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-aUhJzbZhMGmxQo4tEla9uQ-1; Fri, 22 Nov 2019 04:46:52 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26D38107ACC9;
 Fri, 22 Nov 2019 09:46:51 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D404C1036C8A;
 Fri, 22 Nov 2019 09:46:48 +0000 (UTC)
Date: Fri, 22 Nov 2019 09:46:46 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH 0/4] colo: Introduce resource agent and high-level test
Message-ID: <20191122094646.GA2785@work-vm>
References: <cover.1574356137.git.lukasstraub2@web.de>
MIME-Version: 1.0
In-Reply-To: <cover.1574356137.git.lukasstraub2@web.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: aUhJzbZhMGmxQo4tEla9uQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: "Zhang, Chen" <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Alberto Garcia <berto@igalia.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Lukas Straub (lukasstraub2@web.de) wrote:
> Hello Everyone,
> These patches introduce a resource agent for use with the Pacemaker CRM a=
nd a
> high-level test utilizing it for testing qemu COLO.
>=20
> The resource agent manages qemu COLO including continuous replication.
>=20
> Currently the second test case (where the peer qemu is frozen) fails on p=
rimary
> failover, because qemu hangs while removing the replication related block=
 nodes.
> Note that this also happens in real world test when cutting power to the =
peer
> host, so this needs to be fixed.

Do you understand why that happens? Is this it's trying to finish a
read/write to the dead partner?

Dave

> Based-on: <cover.1571925699.git.lukasstraub2@web.de>
> ([PATCH v7 0/4] colo: Add support for continuous replication)
>=20
> Lukas Straub (4):
>   block/quorum.c: stable children names
>   colo: Introduce resource agent
>   colo: Introduce high-level test
>   MAINTAINERS: Add myself as maintainer for COLO resource agent
>=20
>  MAINTAINERS                            |    6 +
>  block/quorum.c                         |    6 +
>  scripts/colo-resource-agent/colo       | 1026 ++++++++++++++++++++++++
>  scripts/colo-resource-agent/crm_master |   44 +
>  tests/acceptance/colo.py               |  444 ++++++++++
>  5 files changed, 1526 insertions(+)
>  create mode 100755 scripts/colo-resource-agent/colo
>  create mode 100755 scripts/colo-resource-agent/crm_master
>  create mode 100644 tests/acceptance/colo.py
>=20
> --
> 2.20.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


