Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F6CC10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 15:02:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43B832133F
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 15:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B832133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG2cB-0002kJ-S5
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 11:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39935)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iG2Z3-00019d-P5
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 10:58:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iG2Z1-0005Rc-Nk
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 10:58:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52198)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iG2Z1-0005RD-Hv
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 10:58:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8AB05309BF1C;
 Thu,  3 Oct 2019 14:58:42 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 99C35608A5;
 Thu,  3 Oct 2019 14:58:39 +0000 (UTC)
Date: Thu, 3 Oct 2019 15:58:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v2] migration: Support gtree migration
Message-ID: <20191003145837.GH7279@redhat.com>
References: <20191003145431.21154-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191003145431.21154-1-eric.auger@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 03 Oct 2019 14:58:42 +0000 (UTC)
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 03, 2019 at 04:54:31PM +0200, Eric Auger wrote:
> Introduce support for GTree migration. A custom save/restore
> is implemented. Each item is made of a key and a data. For that
> reason, 2 VMSD objects are passed into the GTree VMStateField.
> 
> When putting the items, the tree is traversed in sorted order by
> g_tree_foreach.
> 
> On the get() path, gtrees must be allocated using the proper
> key compare, key destroy and value destroy. This can be done
> externally of automatically. If done automatically, the set of
> functions must be stored within the VMStateField in a new opaque
> pointer.
> 
> Automatic allocation is needed for complex state save/restore.
> For instance the virtio-iommu uses a gtree of domain and each
> domain has a gtree of mappings.
> 
> Special care was taken about direct key (ie. when the key is not
> a pointer to an object but is directly a value).
> 
> Tests are added to test save/dump of structs containing gtrees
> including the virtio-iommu domain/mappings scenario.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> index bee658a1b2..06c4663de6 100644
> --- a/migration/vmstate-types.c
> +++ b/migration/vmstate-types.c
> @@ -17,6 +17,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/queue.h"
>  #include "trace.h"
> +#include <glib.h>

Not required, everything in QEMU includes this already.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

