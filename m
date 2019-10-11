Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A64CC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 10:20:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B88C2196E
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 10:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B88C2196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIs2X-00043H-Gc
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 06:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iIs08-0001gW-GW
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 06:18:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iIs06-0006If-B2
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 06:18:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59338)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iIs06-0006IS-2g
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 06:18:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 431363090FD6;
 Fri, 11 Oct 2019 10:18:21 +0000 (UTC)
Received: from redhat.com (ovpn-117-120.ams2.redhat.com [10.36.117.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 332DB6092F;
 Fri, 11 Oct 2019 10:18:15 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v4] migration: Support gtree migration
In-Reply-To: <20191010205242.711-1-eric.auger@redhat.com> (Eric Auger's
 message of "Thu, 10 Oct 2019 22:52:42 +0200")
References: <20191010205242.711-1-eric.auger@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Fri, 11 Oct 2019 12:18:13 +0200
Message-ID: <87k19bwpp6.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 11 Oct 2019 10:18:21 +0000 (UTC)
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

I found a bug, you have to respin, go to BUG
(here was a reviewed-by)

But, ....

I didn't noticed on the 1st look

> +    const VMStateDescription *key_vmsd = direct_key ? NULL : &field->vmsd[0];
> +    const VMStateDescription *val_vmsd = direct_key ? &field->vmsd[0] :
> +                                                      &field->vmsd[1];
> +    const char *key_vmsd_name = direct_key ? "direct" : key_vmsd->name;

This is ugly as hell.
We are using a pointer to pass to mean an array, and abuse it.

But once told that, it is not trivial to do this in a proper way.

On the other hand, if you have to respin for any other reason, please
consider changing the meaning of vmsd[0] and [1].

vmsd[0] -> val_t
vmsd[1] -> key_t

if (vmsd[1] == NULL)
   direct_key = true;

    const VMStateDescription *val_vmsd = &field->vmsd[0];
    const VMStateDescription *key_vmsd = &field->vmsd[1]
    const char *key_vmsd_name = key_vmsd ? "direct" : key_vmsd->name;

Same for get_gtree().


> +        if (direct_key) {
> +            key = (void *)(uintptr_t)qemu_get_be64(f);

no g_malloc().

> +        } else {
> +            key = g_malloc0(key_size);
> +            ret = vmstate_load_state(f, key_vmsd, key, version_id);
> +            if (ret) {
> +                error_report("%s : failed to load %s (%d)",
> +                             field->name, key_vmsd->name, ret);
> +                g_free(key);
> +                return ret;
> +            }
> +        }
> +        val = g_malloc0(val_size);
> +        ret = vmstate_load_state(f, val_vmsd, val, version_id);
> +        if (ret) {
> +            error_report("%s : failed to load %s (%d)",
> +                         field->name, val_vmsd->name, ret);
> +            g_free(key);

BUG: Allways free.  This need to be protected by a direct_key(), no?

> +            g_free(val);
> +            return ret;
> +        }
> +        g_tree_insert(tree, key, val);
> +    }
> +    if (count != nnodes) {
> +        error_report("%s inconsistent stream when loading the gtree",
> +                     field->name);

BUG2:  we need to return an error here, right?

> +    }
> +    trace_get_gtree_end(field->name, key_vmsd_name, val_vmsd->name, ret);
> +    return ret;
> +}
> +

Later, Juan.

