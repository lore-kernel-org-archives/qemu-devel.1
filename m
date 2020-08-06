Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68426C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:24:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4359D22D03
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2hPibe/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4359D22D03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3cXI-0004Ow-7c
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 05:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k3cWi-0003xW-Qi
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 05:49:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26178
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k3cWf-0000aQ-Ik
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 05:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596707367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uRXqjSTJguqkJgZ6GjdgmssHqoMjhP+xFdyXktR2E4I=;
 b=H2hPibe/vE5Y1qRIQxVcMvujBoU5BM7bxq0D/sF/6gaYIlmZrUGBzh2pkE/SGzOxvXi40p
 DBZCz5yEMRMCJqQzywh4ettAusgr43csKOvDjiRDhewJaBh1OFCcDVHmNi1u+U4bV629b+
 ctg4USg+YF/d28WadvQ9atTngr0KiC0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-aVDo9asBNMeUR7gYIs4mgg-1; Thu, 06 Aug 2020 05:49:18 -0400
X-MC-Unique: aVDo9asBNMeUR7gYIs4mgg-1
Received: by mail-wr1-f70.google.com with SMTP id w1so12592205wro.4
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 02:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uRXqjSTJguqkJgZ6GjdgmssHqoMjhP+xFdyXktR2E4I=;
 b=cZ3A5FQvuw9PT5QHO7jxfOM98aKGpGxs9MGd4NzJqjHY6yVpk7obyxwwxIp/WrCjBF
 38Lj45z6vz11IKUjFEwFs1DobiZsFVfO2H0QwOUNCRaWRsz/uPtOvZhJSNHZABHrmq+T
 c10HA2K7UL+05Qypv33gobr3396vHD5Zy6U4g/fZcDdYkbhwiqyVEvA75NfwARxFDNud
 uLINkUQfzduocJ4xGG/4VExh96Hbfva11gO6GvYLEe6ICE2d5isKRhK1Ug3Lc7neA45G
 7PA1OL/ETjS5hxf2lVTvHNaw7c1mwJIocGC0SQ3CUE84+l3NFmCpgKJaA8ih+2oK4OsR
 sjAQ==
X-Gm-Message-State: AOAM530OoGwcxfrq7gGLbL84THxQmmOME/aTJsKRnqOw9yuf8l8ZZva9
 dQ3yyw0G4f94MuFsJGxM6LSiaAVdfGcFs4fiZmEDWTf9vbWNcamOotnJ9TPVvDuj7RwkX+0KbJS
 MLc/OIwO5Q3w1ZbM=
X-Received: by 2002:a1c:f605:: with SMTP id w5mr6977600wmc.26.1596707357392;
 Thu, 06 Aug 2020 02:49:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+bnyy+GxLSleWZG55fjT23rrPNEi9E1Tlg7YgLh6vruM8ZeHg+yhMqgdi5x76fqkK3uXyTQ==
X-Received: by 2002:a1c:f605:: with SMTP id w5mr6977572wmc.26.1596707357108;
 Thu, 06 Aug 2020 02:49:17 -0700 (PDT)
Received: from redhat.com (bzq-79-178-123-8.red.bezeqint.net. [79.178.123.8])
 by smtp.gmail.com with ESMTPSA id
 i6sm5677889wrp.92.2020.08.06.02.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 02:49:16 -0700 (PDT)
Date: Thu, 6 Aug 2020 05:49:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alyssa Ross <hi@alyssa.is>
Subject: Re: vhost-user protocol feature negotiation
Message-ID: <20200806054622-mutt-send-email-mst@kernel.org>
References: <87sgd1ktx9.fsf@alyssa.is>
 <20200805181352-mutt-send-email-mst@kernel.org>
 <87lfis2lr6.fsf@alyssa.is>
MIME-Version: 1.0
In-Reply-To: <87lfis2lr6.fsf@alyssa.is>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:07:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 06, 2020 at 08:59:09AM +0000, Alyssa Ross wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Wed, Aug 05, 2020 at 03:13:06PM +0000, Alyssa Ross wrote:
> >> Quoting from the definition of VHOST_USER_SET_PROTOCOL_FEATURES in
> >> vhost-user.rst:
> >> 
> >> >   Only legal if feature bit ``VHOST_USER_F_PROTOCOL_FEATURES`` is present in
> >> >   ``VHOST_USER_GET_FEATURES``.
> >> > 
> >> > .. Note::
> >> >    Slave that reported ``VHOST_USER_F_PROTOCOL_FEATURES`` must support
> >> >    this message even before ``VHOST_USER_SET_FEATURES`` was called.
> >> 
> >> To me, this could mean either of two things:
> >> 
> >> (1) If VHOST_USER_F_PROTOCOL_FEATURES hasn't been set, upon receiving
> >>     VHOST_USER_SET_PROTOCOL_FEATURES, a backend should enable the
> >>     protocol features immediately.
> >> 
> >> (2) If VHOST_USER_F_PROTOCOL_FEATURES hasn't been set, upon receiving
> >>     VHOST_USER_SET_PROTOCOL_FEATURES, a backend should store those
> >>     feature bits, but not actually consider them to be enabled until
> >>     after VHOST_USER_SET_FEATURES has been received (presumably
> >>     containing VHOST_USER_F_PROTOCOL_FEATURES).
> >> 
> >> The reason I bring this up is that QEMU appears to interpret it as (1),
> >> while the vhost-user-net backend in Intel's cloud-hypervisor[1]
> >> interprets it as (2).  So I'm looking for a clarification.
> >> 
> >> [1]: https://github.com/cloud-hypervisor/cloud-hypervisor
> >> 
> >> Thanks in advance.
> >
> >
> > IMHO the intent was this: VHOST_USER_F_PROTOCOL_FEATURES bit in
> > VHOST_USER_GET_FEATURES means that qemu can send
> > VHOST_USER_GET_PROTOCOL_FEATURES and VHOST_USER_SET_PROTOCOL_FEATURES.
> >
> > With most feature bits in VHOST_USER_GET_FEATURES, the
> > specific functionality needs to only be enabled after
> > VHOST_USER_SET_FEATURES.
> >
> > However, this is for functionality dealing with guest activity.
> > VHOST_USER_SET_PROTOCOL_FEATURES has nothing to do with guest directly,
> > it's about negotiation between qemu and backend: it is only in
> > VHOST_USER_GET_FEATURES for the reason that this is the only message
> > (very) old backends reported.  Thus, the backend should not check
> > whether VHOST_USER_SET_FEATURES sets VHOST_USER_F_PROTOCOL_FEATURES,
> > instead it should simply always be ready to receive
> > VHOST_USER_GET_PROTOCOL_FEATURES and VHOST_USER_SET_PROTOCOL_FEATURES.
> >
> > Backend that isn't always ready to handle
> > VHOST_USER_GET_PROTOCOL_FEATURES and VHOST_USER_SET_PROTOCOL_FEATURES
> > should not set VHOST_USER_F_PROTOCOL_FEATURES in
> > VHOST_USER_GET_FEATURES.
> 
> Thanks for the explanation.  That matches what I had in mind with (1).
> 
> > This appears to be closer to (1), but if qemu can't distinguish
> > then we don't care, right? For example, VHOST_USER_PROTOCOL_F_REPLY_ACK
> > enables acks on arbitrary messages. Does the backend in question
> > ignore the affected bit until SET_FEATURES? If yes won't this
> > make qemu hang?
> 
> Yes.  That was my motivation for asking what the correct behaviour was,
> so that I could fix the incorrect one. :)  I suspect that up to this point,
> the cloud-hypervisor vhost-user-net backend has only been used with
> cloud-hypervisor, and so this incompatibilty with QEMU was not noticed.
> 
> > How would you suggest clarifying the wording?
> 
> Do you think this communicates everything required?
> 
> ---
> diff --git i/docs/interop/vhost-user.rst w/docs/interop/vhost-user.rst
> index 10e3e3475e..72724d292a 100644
> --- i/docs/interop/vhost-user.rst
> +++ w/docs/interop/vhost-user.rst
> @@ -854,9 +854,8 @@ Master message types
>    ``VHOST_USER_GET_FEATURES``.
>  
>  .. Note::
> -   Slave that reported ``VHOST_USER_F_PROTOCOL_FEATURES`` must
> -   support this message even before ``VHOST_USER_SET_FEATURES`` was
> -   called.
> +   ``VHOST_USER_F_PROTOCOL_FEATURES`` does not need to be acknowledged
> +   with ``VHOST_USER_SET_FEATURES``.
>  
>  ``VHOST_USER_SET_PROTOCOL_FEATURES``
>    :id: 16

Hmm I find this confusing. I think it's a good policy to ask qemu to
acknowledge it. It's just that the client should not wait for
VHOST_USER_SET_FEATURES before handling VHOST_USER_SET_PROTOCOL_FEATURES
or VHOST_USER_GET_PROTOCOL_FEATURES.


> @@ -869,8 +868,8 @@ Master message types
>    ``VHOST_USER_GET_FEATURES``.
>  
>  .. Note::
> -   Slave that reported ``VHOST_USER_F_PROTOCOL_FEATURES`` must support
> -   this message even before ``VHOST_USER_SET_FEATURES`` was called.
> +   ``VHOST_USER_F_PROTOCOL_FEATURES`` does not need to be acknowledged
> +   with ``VHOST_USER_SET_FEATURES``.
>  
>  ``VHOST_USER_SET_OWNER``
>    :id: 3


