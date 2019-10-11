Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09644C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 18:09:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D284520659
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 18:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D284520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIzLy-0004uD-SS
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 14:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iIy4e-0003vI-0J
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iIy4b-00051b-TU
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:47:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54638)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iIy4b-000519-Nm
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:47:25 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 396CB3172D8A;
 Fri, 11 Oct 2019 16:47:24 +0000 (UTC)
Received: from redhat.com (ovpn-116-51.ams2.redhat.com [10.36.116.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DC4410016EB;
 Fri, 11 Oct 2019 16:47:17 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v6] migration: Support gtree migration
In-Reply-To: <20191011121724.433-1-eric.auger@redhat.com> (Eric Auger's
 message of "Fri, 11 Oct 2019 14:17:24 +0200")
References: <20191011121724.433-1-eric.auger@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Fri, 11 Oct 2019 18:47:14 +0200
Message-ID: <87v9svut4d.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 11 Oct 2019 16:47:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Reply-To: quintela@redhat.com
Cc: peterx@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Auger <eric.auger@redhat.com> wrote:
> Introduce support for GTree migration. A custom save/restore
> is implemented. Each item is made of a key and a data.
>
> If the key is a pointer to an object, 2 VMSDs are passed into
> the GTree VMStateField.
>
> When putting the items, the tree is traversed in sorted order by
> g_tree_foreach.
>
> On the get() path, gtrees must be allocated using the proper
> key compare, key destroy and value destroy. This must be handled
> beforehand, for example in a pre_load method.
>
> Tests are added to test save/dump of structs containing gtrees
> including the virtio-iommu domain/mappings scenario.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

