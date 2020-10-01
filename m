Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2949BC4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 08:04:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D79420872
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 08:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imOcekMO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D79420872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNtZY-0000KN-1b
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 04:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1kNtYp-0008K8-6e
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 04:03:31 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39238)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1kNtYn-0007tu-7t
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 04:03:30 -0400
Received: by mail-wr1-x444.google.com with SMTP id k10so4521776wru.6
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 01:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
 :mime-version:content-transfer-encoding:content-language
 :thread-index; bh=OTrEnhNBN5R4+dyvqauB0Y5OwRj53IzJUx91Bcl+i78=;
 b=imOcekMOnoMaah3UJlqcpTJVMYjVhigkPyz40HYVmXhEJ4xWp4/P1BNO1ZVr9chui+
 +7spsDUSjId3ROYCISatnycAeCmnB5oOcaliX8csdcJswDj4+NH+z5Ohvk7XiF0OkzTz
 OSI3COJMjpjLSEzPBcyVgJVXNjY1duYV1xTSTjMmCgkSNIAY9ESlRqo/TLU4ftp7leDD
 0jJsmgC0EyDWxq2Uzx//u2JmVSZ1n2dRFb2FR1Jsrr4NjkNUPyuw14gS+/5m7juQi6Xl
 a5+POY0TW6Opv4xfeLe/6oniu0rGle8XxdIYJpdgK/NJDvPc205QeL+Q3l+rH85YCNp3
 jvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
 :subject:date:message-id:mime-version:content-transfer-encoding
 :content-language:thread-index;
 bh=OTrEnhNBN5R4+dyvqauB0Y5OwRj53IzJUx91Bcl+i78=;
 b=h2KdviHkdDixLYqMUkiIs5kX0f0YScQAdcN2tSmMqxDIDTAUoJBYu5Tcw343K+ihJX
 aNwTfZVcJGPp/KiTeDC4Z4+FvEOzKyQAZI9CPjbQVq+GNbJAXJ7rNbtHleqzA9W5LUBG
 R/9wDXDZEyZB9OpAIY12SFSSbjsO9Crd8kZMVXSdadoG2cdTe0p2XkRKtLxo5eWjeWNf
 thOqc8sVZkENDUZ9xAfiJ+n2XGp+yeNV3CVqdhZGNuII/7l93BckVCOO4/c/TxoWwkX4
 lwJ4h5qGjN+PKDDYxZbgzdyPCGS0zk8Ku2QDKeVFagoCych5xks+uPVhJ5H98kZkt+5d
 F7Sw==
X-Gm-Message-State: AOAM5325W+/iD7z0305sYwSiTsrkv0WIl9fP6/OwDhMZDGiFoBdpSkj/
 h/MCyJhPcphq9kuCuuSen6s=
X-Google-Smtp-Source: ABdhPJwan3nlRJEN7HKE69zar2eImtVpRpYFlhfsKXozjX7PA3CNyjJoF03MdM73/nxESr0z2OvvMw==
X-Received: by 2002:a5d:5583:: with SMTP id i3mr7158520wrv.119.1601539407387; 
 Thu, 01 Oct 2020 01:03:27 -0700 (PDT)
Received: from CBGR90WXYV0 (54-240-197-224.amazon.com. [54.240.197.224])
 by smtp.gmail.com with ESMTPSA id l5sm3022012wrv.24.2020.10.01.01.03.26
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Oct 2020 01:03:26 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
To: "'Anthony PERARD'" <anthony.perard@citrix.com>
References: <20200923155731.29528-1-paul@xen.org>
 <20200930114235.GL2024@perard.uk.xensource.com>
In-Reply-To: <20200930114235.GL2024@perard.uk.xensource.com>
Subject: RE: [PATCH] xen-bus: reduce scope of backend watch
Date: Thu, 1 Oct 2020 09:03:25 +0100
Message-ID: <008c01d697c9$579520a0$06bf61e0$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQFwzHOYQKlt73iXJ/fB9mI5UZbIzgHcxvtVqj8StGA=
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: paul@xen.org
Cc: 'Stefano Stabellini' <sstabellini@kernel.org>,
 'Paul Durrant' <pdurrant@amazon.com>, qemu-devel@nongnu.org,
 'Jerome Leseinne' <jerome.leseinne@gmail.com>,
 'Edwin Torok' <edvin.torok@citrix.com>, xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Anthony PERARD <anthony.perard@citrix.com>
> Sent: 30 September 2020 12:43
> To: Paul Durrant <paul@xen.org>
> Cc: xen-devel@lists.xenproject.org; qemu-devel@nongnu.org; Paul Durrant <pdurrant@amazon.com>; Jerome
> Leseinne <jerome.leseinne@gmail.com>; Edwin Torok <edvin.torok@citrix.com>; Stefano Stabellini
> <sstabellini@kernel.org>
> Subject: Re: [PATCH] xen-bus: reduce scope of backend watch
> 
> On Wed, Sep 23, 2020 at 04:57:31PM +0100, Paul Durrant wrote:
> > From: Paul Durrant <pdurrant@amazon.com>
> >
> > Currently a single watch on /local/domain/X/backend is registered by each
> > QEMU process running in service domain X (where X is usually 0). The purpose
> > of this watch is to ensure that QEMU is notified when the Xen toolstack
> > creates a new device backend area.
> > Such a backend area is specific to a single frontend area created for a
> > specific guest domain and, since each QEMU process is also created to service
> > a specfic guest domain, it is unnecessary and inefficient to notify all QEMU
> > processes.
> > Only the QEMU process associated with the same guest domain need
> > receive the notification. This patch re-factors the watch registration code
> > such that notifications are targetted appropriately.
> >
> > Reported-by: Jerome Leseinne <jerome.leseinne@gmail.com>
> > Signed-off-by: Paul Durrant <pdurrant@amazon.com>
> >
> > diff --git a/hw/xen/xen-backend.c b/hw/xen/xen-backend.c
> > index 10199fb58d..f2711fe4a7 100644
> > --- a/hw/xen/xen-backend.c
> > +++ b/hw/xen/xen-backend.c
> > @@ -41,6 +41,11 @@ static void xen_backend_table_add(XenBackendImpl *impl)
> >      g_hash_table_insert(xen_backend_table_get(), (void *)impl->type, impl);
> >  }
> >
> > +static void **xen_backend_table_keys(unsigned int *count)
> > +{
> > +    return g_hash_table_get_keys_as_array(xen_backend_table_get(), count);
> 
> That could be cast to (const gchar **) as the GLib doc suggest, or (const
> char **) since gchar and char are the same.
> https://developer.gnome.org/glib/stable/glib-Hash-Tables.html#g-hash-table-get-keys-as-array
> 

Ok, I'll re-arrange the const-ing to cast at the inner level.

> > +}
> > +
> >  static const XenBackendImpl *xen_backend_table_lookup(const char *type)
> >  {
> >      return g_hash_table_lookup(xen_backend_table_get(), type);
> > diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
> > index 9ce1c9540b..c83da93bf3 100644
> > --- a/hw/xen/xen-bus.c
> > +++ b/hw/xen/xen-bus.c
> > @@ -430,7 +430,13 @@ static void xen_bus_unrealize(BusState *bus)
> >      trace_xen_bus_unrealize();
> >
> >      if (xenbus->backend_watch) {
> > -        xen_bus_remove_watch(xenbus, xenbus->backend_watch, NULL);
> > +        unsigned int i;
> > +
> > +        for (i = 0; i < xenbus->backend_types; i++) {
> > +            xen_bus_remove_watch(xenbus, xenbus->backend_watch[i], NULL);
> 
> We should check if backend_watch[i] is NULL.
> 

Yes, I'll add a check.

> > +        }
> > +
> > +        g_free(xenbus->backend_watch);
> >          xenbus->backend_watch = NULL;
> >      }
> >
> 
> The rest of the patch looks fine. Next improvement is to only look at
> only one backend type in xen_bus_backend_changed() since there is now a
> watch per backend type :-), but that would be for another day.
> 

Might not be too tricky. I'll see if I can come up with a follow-up patch.

  Paul

> Cheers,
> 
> --
> Anthony PERARD


