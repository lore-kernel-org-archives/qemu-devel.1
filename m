Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA969C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 16:15:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 776F52054F
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 16:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776F52054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG3lg-0004Ff-J9
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 12:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iG3kn-0003gN-KZ
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 12:14:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iG3kl-0002YV-6S
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 12:14:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49912)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iG3kk-0002WY-TS
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 12:14:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8503818CB906;
 Thu,  3 Oct 2019 16:14:52 +0000 (UTC)
Received: from redhat.com (ovpn-116-84.ams2.redhat.com [10.36.116.84])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B745760C18;
 Thu,  3 Oct 2019 16:14:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v2] migration: Support gtree migration
In-Reply-To: <20191003145431.21154-1-eric.auger@redhat.com> (Eric Auger's
 message of "Thu, 3 Oct 2019 16:54:31 +0200")
References: <20191003145431.21154-1-eric.auger@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Thu, 03 Oct 2019 18:14:45 +0200
Message-ID: <87muehhklm.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Thu, 03 Oct 2019 16:14:52 +0000 (UTC)
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
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Auger <eric.auger@redhat.com> wrote:
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
             ^^

or.

> functions must be stored within the VMStateField in a new opaque
> pointer.

I am not fully convinced that the automatic mode is needed.  Especially
the ->data field.  I *fear* it being abused for other cases.

> Automatic allocation is needed for complex state save/restore.
> For instance the virtio-iommu uses a gtree of domain and each
> domain has a gtree of mappings.

There is a pre_load() function for the VMState that creates this.  it
can be used to initualize the field value, no?  That way the data part
is not needed.  I think this will make the code less complex, what do
you think?

> Special care was taken about direct key (ie. when the key is not
> a pointer to an object but is directly a value).

I am wondering if for this, it is better to add two VMSTATE (at least at
the macro level).  SIMPLE_TREE, and TREE, or whataver oyou want to call
it.  But I haven't fully looked into it.

The other general "consideration" that I have is that there is neither
of:
- marker between elements
- number of elements
- total size/size of elements.

That makes completelly impractical to "walk" the migration stream
without understanding exactyl what is there.  (Now, to be fair, there
are other parts of qemu that are like that.  PCI cames to mind.)

> Tests are added to test save/dump of structs containing gtrees
> including the virtio-iommu domain/mappings scenario.

Really nice to have the tests.  Thanks.

> Signed-off-by: Eric Auger <eric.auger@redhat.com>


> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 1fbfd099dd..4d9698eaab 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -171,6 +171,7 @@ struct VMStateField {
>      int version_id;
>      int struct_version_id;
>      bool (*field_exists)(void *opaque, int version_id);
> +    void *data;
>  };

This is the bit that I don't really like :p

>  
> +typedef struct GTreeInitData {
> +    GCompareDataFunc key_compare_func;
> +    gpointer key_compare_data;
> +    GDestroyNotify key_destroy_func;
> +    GDestroyNotify value_destroy_func;
> +} GTreeInitData;

My understanding is that if you do this on the pre_load() function, you
don't need this at all.

> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> index bee658a1b2..06c4663de6 100644
> --- a/migration/vmstate-types.c
> +++ b/migration/vmstate-types.c
> @@ -17,6 +17,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/queue.h"
>  #include "trace.h"
> +#include <glib.h>
>  
>  /* bool */
>  
> @@ -691,3 +692,135 @@ const VMStateInfo vmstate_info_qtailq = {
>      .get  = get_qtailq,
>      .put  = put_qtailq,
>  };
> +
> +struct put_gtree_data {
> +    QEMUFile *f;
> +    const VMStateField *field;
> +    QJSON *vmdesc;
> +};
> +
> +static gboolean put_gtree_elem(gpointer key, gpointer value, gpointer data)
> +{
> +    struct put_gtree_data *capsule = (struct put_gtree_data *)data;
> +    const VMStateField *field = capsule->field;
> +    QEMUFile *f = capsule->f;
> +    const VMStateDescription *key_vmsd = &field->vmsd[0];
> +    const VMStateDescription *data_vmsd = &field->vmsd[1];
> +
> +    qemu_put_byte(f, true);

Ok.  there is a marker O:-)

> +
> +    /* put the key */
> +    if (!key_vmsd->fields) {
> +        qemu_put_be32(f, GPOINTER_TO_UINT(key));
> +    } else {
> +        if (vmstate_save_state(f, key_vmsd, key, capsule->vmdesc)) {
> +            return true;
> +        }
> +    }

But it is magic to know if it is a simple or complex key.


> +    if (field->data) {
> +        init_data = (GTreeInitData *)field->data;
> +        tree = g_tree_new_full(init_data->key_compare_func,
> +                               init_data->key_compare_data,
> +                               init_data->key_destroy_func,
> +                               init_data->value_destroy_func);
> +        *pval = tree;
> +    } else {
> +        /* tree is externally allocated */
> +        tree = *pval;
> +    }

This can be simplified while we are at it.

> +    while (qemu_get_byte(f)) {

If we get out of sync, for any reason, we have no way to recover.  The
only way to recover is that we don't get a "false" in this position.


Later, Juan.

