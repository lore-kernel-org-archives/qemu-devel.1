Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D745CC10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:42:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFA6A2054F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA6A2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIWqP-0005I3-8u
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 07:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50565)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iIWjc-0005Ai-PO
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:35:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iIWjb-0006MX-Fw
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:35:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33918)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iIWjb-0006M9-7v
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:35:55 -0400
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4CB3661281
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 11:35:54 +0000 (UTC)
Received: by mail-pf1-f197.google.com with SMTP id 22so4517458pfx.8
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 04:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=bntsp8UeI7UIflIBn5CDwCk5Njh2bSlxcyhgBtVVICc=;
 b=aeP58MO07AHSdkDV76iQjSC9tXau03ckIiR9tk+kCYTuKG/VhixQv86Ixh3bRgmAH0
 7qH7RTmiqqtPfxAdEmMTra/+UHLt2csmZbcmm+yG65VS7aAI3dBEjJwIdWNfy7QRMnQc
 xB8v3aXSCeBN8nsHrTdSOJilOt++tFIPQoXuxWGiVyLHvJKpTzfJbyQfjZ3bWYfAWUXV
 LbnAJMRsnELlbHjR/rFiign/pk10Kg+ZUsFUEWLDedpQEASu5BADxOLzEtpZG+qU4Y6L
 lRXjW+Ef+e968lcoNJzyeusvgPnX3jpPNspoeKrWLHvvK8NdOYmCS4EcCkI41Eq/RnIi
 JpqA==
X-Gm-Message-State: APjAAAVmPO6kW1amqPIhWBbb80rdvAr+KEsrgSKMegRNVyBA4Jg9Jwma
 BSVQio4glijuCqs6GAe5RY6FTT29jc9h59bN18MOyRzHPmcCUZdjZq88HUSNEoEZTq6lRw6zb5z
 et416S3WtCGmDMmk=
X-Received: by 2002:a62:5bc1:: with SMTP id p184mr9847794pfb.139.1570707353803; 
 Thu, 10 Oct 2019 04:35:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxSKtYpra1QnKa2PsvVf1Hvv/F1oguTW8hVFvMmQXSgjyhPNyLi13+8QfltLoSaaRAAVjo3dg==
X-Received: by 2002:a62:5bc1:: with SMTP id p184mr9847768pfb.139.1570707353396; 
 Thu, 10 Oct 2019 04:35:53 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id p11sm5693166pgs.51.2019.10.10.04.35.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2019 04:35:52 -0700 (PDT)
Date: Thu, 10 Oct 2019 19:35:41 +0800
From: Peter Xu <peterx@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v3] migration: Support gtree migration
Message-ID: <20191010113541.GG18958@xz-x1>
References: <20191004112025.28868-1-eric.auger@redhat.com>
 <20191009062852.GB1039@xz-x1>
 <27d37e80-31d8-006a-b2a8-c61c5129c7c4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27d37e80-31d8-006a-b2a8-c61c5129c7c4@redhat.com>
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

On Thu, Oct 10, 2019 at 09:57:01AM +0200, Auger Eric wrote:
> >> +static gboolean put_gtree_elem(gpointer key, gpointer value, gpointer data)
> >> +{
> >> +    struct put_gtree_data *capsule = (struct put_gtree_data *)data;
> >> +    QEMUFile *f = capsule->f;
> >> +    int ret;
> >> +
> >> +    qemu_put_byte(f, true);
> >> +
> >> +    /* put the key */
> >> +    if (!capsule->key_vmsd) {
> >> +        qemu_put_be32(f, GPOINTER_TO_UINT(key)); /* direct key */
> > 
> > This is special code path for direct key case.  Can we simply define
> > VMSTATE_GTREE_DIRECT_KEY_V() somehow better so that it just uses the
> > VMSTATE_UINT32_V() as the key vmsd?  Then iiuc vmstate_save_state()
> > could work well with that too.
> if the key_vmsd is a VMSTATE_UINT32_V then I understand
> vmstate_save_state(f, capsule->key_vmsd, key, capsule->vmdesc)
> expects key to be a pointer to a uint32. But in that case of direct key,
> it is a uint32. I don't figure out how to use vmstate_save_state in your
> proposal.

Ah I see the point.  And indeed I can't think of a better way now
(e.g., maybe I will always try to use GTrees with malloc()ed keys to
be simple when I want to migrate a gtree, but yeah that's not a reason
to refuse this patch :).

Though we should be very careful on defining vmsds for GTrees in the
future with the help of this patch, and we must have the type (either
direct or not) to match the real usage of the tree otherwise QEMU can
potentially unreference the constant as a pointer.

> 
> > 
> > Also, should we avoid using UINT in all cases?  But of course if we
> > start to use VMSTATE_UINT32_V then we don't have this issue.
> Depending on the clarification of above point, maybe I can rename
> VMSTATE_GTREE_DIRECT_KEY_V into VMSTATE_GTREE_DIRECT_UINT_KEY_V
> 
> direct keys seem to be more common for hash tables actually.
> https://developer.gnome.org/glib/stable/glib-Hash-Tables.html#g-hash-table-new-full
> 
> There are stand conversion macros to/from int, uint, size
> https://developer.gnome.org/glib/stable/glib-Type-Conversion-Macros.html

Yeh it's fine to use direct keys.  Though my question was more about
"unsigned int" - here when we put, we cast a pointer into unsigned
int, which can be 2/4 bytes, IIUC.  I'm thinking whether at least we
should use direct cast (e.g., (uint32_t)ptr) to replace
GPOINTER_TO_UINT() to make sure it's 4 bytes.  Futher, maybe we should
start with uint64_t here in the migration stream, otherwise we should
probably drop the high 32 bits if we migrate a gtree whose key is 64
bits long (and since we're working with migration we won't be able to
change that in the future for compatibility reasons...).

Summary:

Maybe we can replace:

    qemu_put_be32(f, GPOINTER_TO_UINT(key)); /* direct key */

To:

    qemu_put_be64(f, (uint64_t)key); /* direct key */

And apply similar thing to get() side?

Thanks,

-- 
Peter Xu

