Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490AEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 08:43:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13967206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 08:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K7XligPt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13967206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ9Sg-0008Rd-8p
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 04:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jZ9S8-0007wg-CO
 for qemu-devel@nongnu.org; Thu, 14 May 2020 04:42:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51678
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jZ9S7-00044u-33
 for qemu-devel@nongnu.org; Thu, 14 May 2020 04:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589445769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=41hCNC0zKhFhQIr7dbPjm2Wc0AOVgS1xf7yXchCS628=;
 b=K7XligPtyXAS8MwmN/A7LRi6eqB//M8YOCozYfblR5ydGIn9qVZFb6+ztFgmqFawiqszmm
 zdAUus2nWYpOtFjlWd57SGI9O7s+EzvPCrwFdExzQjsiuwAc1rEvzkw1Cj7gnkb+PWbkf3
 XsAehcdvNnCoXMwYAT56blKZOqMI1SY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-Na7NUB-fN1G837pF0p0PTA-1; Thu, 14 May 2020 04:42:47 -0400
X-MC-Unique: Na7NUB-fN1G837pF0p0PTA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB19D80058A;
 Thu, 14 May 2020 08:42:46 +0000 (UTC)
Received: from work-vm (ovpn-114-247.ams2.redhat.com [10.36.114.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DB5C60C05;
 Thu, 14 May 2020 08:42:44 +0000 (UTC)
Date: Thu, 14 May 2020 09:42:42 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [RFC v2] migration: Add migrate-set-bitmap-node-mapping
Message-ID: <20200514084242.GB2787@work-vm>
References: <20200513145610.1484567-1-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200513145610.1484567-1-mreitz@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01 autolearn=_AUTOLEARN
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Max Reitz (mreitz@redhat.com) wrote:

<snip>

> +void qmp_migrate_set_bitmap_node_mapping(MigrationBlockNodeMappingList *mapping,
> +                                         Error **errp)
> +{
> +    QDict *in_mapping = qdict_new();
> +    QDict *out_mapping = qdict_new();
> +
> +    for (; mapping; mapping = mapping->next) {
> +        MigrationBlockNodeMapping *entry = mapping->value;
> +
> +        if (qdict_haskey(out_mapping, entry->node_name)) {
> +            error_setg(errp, "Cannot map node name '%s' twice",
> +                       entry->node_name);
> +            goto fail;
> +        }

I'm not too clear exactly which case this is protecting against;
I think that's protecting against mapping

  'src1'->'dst1' and 'src1'->'dst2'
which is a good check.s (or maybe it's checking against dst2 twice?)

What about cases where there is no mapping - e.g. imagine
that we have b1/b2 on the source and b2/b3 on the dest; now
if we add just a mapping:

  b1->b2

then we end up with:

  b1 -> b2
  b2 -> b2  (non-mapped)
        b3

so we have a clash there - are we protected against that?

Dave

> +        if (qdict_haskey(in_mapping, entry->alias)) {
> +            error_setg(errp, "Cannot use alias '%s' twice",
> +                       entry->alias);
> +            goto fail;
> +        }
> +
> +        qdict_put_str(in_mapping, entry->alias, entry->node_name);
> +        qdict_put_str(out_mapping, entry->node_name, entry->alias);
> +    }
> +
> +    qobject_unref(dirty_bitmap_mig_state.node_in_mapping);
> +    qobject_unref(dirty_bitmap_mig_state.node_out_mapping);
> +
> +    dirty_bitmap_mig_state.node_in_mapping = in_mapping;
> +    dirty_bitmap_mig_state.node_out_mapping = out_mapping;
> +
> +    return;
> +
> +fail:
> +    qobject_unref(in_mapping);
> +    qobject_unref(out_mapping);
> +}
> +
>  static SaveVMHandlers savevm_dirty_bitmap_handlers = {
>      .save_setup = dirty_bitmap_save_setup,
>      .save_live_complete_postcopy = dirty_bitmap_save_complete,
> -- 
> 2.26.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


