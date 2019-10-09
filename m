Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984D1C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:19:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D87D206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D87D206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIFc5-0007TM-56
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 13:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33708)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iI5TC-0003aC-Pn
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 02:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iI5TA-0000cv-Jj
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 02:29:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39868)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iI5TA-0000YF-An
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 02:29:08 -0400
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 52631C004E8D
 for <qemu-devel@nongnu.org>; Wed,  9 Oct 2019 06:29:06 +0000 (UTC)
Received: by mail-pf1-f200.google.com with SMTP id b13so1113427pfp.6
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 23:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=5MC/xpOVeO48b6oFuZVrop2DdqL+1eMShZ/UYESNK3c=;
 b=RuQ6ZN2FsXg+2C+gZBM3F4atZ58/VzzaCr1uwIDW2tjQIVImoLeL9njPFnVZN9QxY7
 MmfdPtFkjh/FMmSLKxsyw3U1U7HU3AXuz4kA+TDczG0pAsY+k+eOf3VcLWHt9OLOkixw
 DOrH9VdxMqJGoZMAymAccnV3lTWkl8DanN1hQBFZcxE6s8jUgU9i5Kzf26tOqhg0h8m8
 3kkMzFYYPf6JcO8pSHCpln/g5AYQQIDskvLCXlP6sp6l2Pj7AaZTXUFcwcn24o2BUBQM
 voAuTEPxknmUfg9jgK2RaKDPsECemcWgRD6EwbW23USwrd9od2S1wx1rCI5zEWq0J8su
 W4sA==
X-Gm-Message-State: APjAAAXBqjssDah78ot2S44q7NrsSz6pBwl9fAja5+gxOa08Rp3BUGii
 flY8g5q7c8VpP8xs/N6YhXAMZMYvviyuNEy/CVOJFHq5cpKAthglwejAV9eeaKC8f3Xr63WtBbx
 VTDmpihw8Ioix41o=
X-Received: by 2002:a62:3441:: with SMTP id b62mr2056526pfa.12.1570602545690; 
 Tue, 08 Oct 2019 23:29:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzVjsJgR6qN7WADec/Z0SLYVrBWhXr7sjrmz3ltEy1nB8F9VSzDJEZVxVK9sswQxutbT1Sa3A==
X-Received: by 2002:a62:3441:: with SMTP id b62mr2056511pfa.12.1570602545403; 
 Tue, 08 Oct 2019 23:29:05 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id c11sm1599271pfj.114.2019.10.08.23.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 23:29:04 -0700 (PDT)
Date: Wed, 9 Oct 2019 14:28:53 +0800
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v3] migration: Support gtree migration
Message-ID: <20191009062852.GB1039@xz-x1>
References: <20191004112025.28868-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191004112025.28868-1-eric.auger@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
Cc: quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 04, 2019 at 01:20:25PM +0200, Eric Auger wrote:
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

Mostly looks sane to me (with Juan's comment fixed).  Some more
trivial comments below.

> +/*
> + * For migrating a GTree whose key is a pointer to _key_type and the
> + * value, a pointer to _val_type
> + * The target tree must have been properly initialized
> + * _vmsd: Start address of the 2 element array containing the key vmsd
> + *        and the data vmsd
> + * _key_type: type of the key
> + * _val_type: type of the value
> + */
> +#define VMSTATE_GTREE_V(_field, _state, _version, _vmsd,                       \
> +                        _key_type, _val_type)                                  \
> +{                                                                              \
> +    .name         = (stringify(_field)),                                       \
> +    .version_id   = (_version),                                                \
> +    .vmsd         = (_vmsd),                                                   \
> +    .info         = &vmstate_info_gtree,                                       \
> +    .start        = sizeof(_key_type),                                         \

Nitpick: Are we reusing the "start" field to store the size just to
avoid defining new field in VMStateField?  If so, not sure whether we
can start to use unions to both keep VMStateField small while keep the
code clean.  Like:

  union {
    struct {
      size_t key_size;
      size_t value_size;
    };
    struct {
      size_t start;
      size_t size;
    };
  }

?

This can of course also be done on top of this patch no matter what.

[...]

> +static gboolean put_gtree_elem(gpointer key, gpointer value, gpointer data)
> +{
> +    struct put_gtree_data *capsule = (struct put_gtree_data *)data;
> +    QEMUFile *f = capsule->f;
> +    int ret;
> +
> +    qemu_put_byte(f, true);
> +
> +    /* put the key */
> +    if (!capsule->key_vmsd) {
> +        qemu_put_be32(f, GPOINTER_TO_UINT(key)); /* direct key */

This is special code path for direct key case.  Can we simply define
VMSTATE_GTREE_DIRECT_KEY_V() somehow better so that it just uses the
VMSTATE_UINT32_V() as the key vmsd?  Then iiuc vmstate_save_state()
could work well with that too.

Also, should we avoid using UINT in all cases?  But of course if we
start to use VMSTATE_UINT32_V then we don't have this issue.

Thanks,

> +    } else {
> +        ret = vmstate_save_state(f, capsule->key_vmsd, key, capsule->vmdesc);
> +        if (ret) {
> +            capsule->ret = ret;
> +            return true;
> +        }
> +    }
> +
> +    /* put the data */
> +    ret = vmstate_save_state(f, capsule->val_vmsd, value, capsule->vmdesc);
> +    if (ret) {
> +        capsule->ret = ret;
> +        return true;
> +    }
> +    return false;
> +}

-- 
Peter Xu

