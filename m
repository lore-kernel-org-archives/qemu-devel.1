Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FE2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:36:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9E1922DBF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cov/DVUi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E1922DBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3f8T-00067m-R7
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 08:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k3f7h-0005iU-PA
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 08:35:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38996
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k3f7e-000407-LQ
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 08:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596717349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=54v2+OFuMScPSFMg5//+5c3o3IrHWAAbMIzT5ahqI50=;
 b=cov/DVUipIQpZBMGl9j09iyaZC1JeCG3XLQEvvt6/YuVCKpIlBbHQoqreRlhCUIfzHxCVy
 OfVe7XPHXnZHjqp5Gra6yGJUduE8ZHXHaDOI8aKzk0TEDm/VoOewybKjfovEoaTKUybdqq
 xHexkR2/Jr7/3jbAJQil5CZUr1hHEWo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-QrirXUdvPWCSz6J7dsmbLg-1; Thu, 06 Aug 2020 08:35:46 -0400
X-MC-Unique: QrirXUdvPWCSz6J7dsmbLg-1
Received: by mail-wr1-f70.google.com with SMTP id j2so12129321wrr.14
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 05:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=54v2+OFuMScPSFMg5//+5c3o3IrHWAAbMIzT5ahqI50=;
 b=m08d5rmMY5gx3q0tG6mxdsne7xWGqMINvSs21+MEn08ksjOEyNJR++p9/WMgwKmGwE
 99mq1XAurfF+2bXX0taenDtSIdYr0Gwa/bhsfmKRq7nsa3fYqowsI9OvjAb7+WL+MuDf
 Qm+SObndHNMYBp3qOtP07O9RxqC4mZ2jsdElTo9Al9FRu/OIaS2DjJ2NzKL3GOuhFffN
 rtcdBGTI+88umwg4SUaMhPAZPO6V0+F8I7ZqlTFLIbzE5fQiyEWg86ERDFVmySS/ssyb
 gqbrbwzjux+/yeGJ5kP24bDkZ82v/7pTRw9Ox+5K9/LG2gQOZa9BsgbXZdA5XtreUki3
 G+tA==
X-Gm-Message-State: AOAM5330cf4jVWZwXEwzCMIw9Vlh+MOUSQ58b6ZqyJtIqGfN29aOoJWT
 Cwd1S21wk8e/64uwVW2MTjKyaUcR9s22gYFG5rOQpy7xG0+YqAXM4HUx2UCNJhkxbuQ6TTB4i5T
 +1MsJ3gUPWLiplW8=
X-Received: by 2002:adf:f341:: with SMTP id e1mr7733038wrp.207.1596717345201; 
 Thu, 06 Aug 2020 05:35:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQ0WzR0x0fyvEGQYspZDpFK6rpiq49lXy4zNak3widMNOkiANfEqDRV1M/HsNf7/viXPXvsw==
X-Received: by 2002:adf:f341:: with SMTP id e1mr7733014wrp.207.1596717344879; 
 Thu, 06 Aug 2020 05:35:44 -0700 (PDT)
Received: from redhat.com (bzq-79-178-123-8.red.bezeqint.net. [79.178.123.8])
 by smtp.gmail.com with ESMTPSA id
 q5sm6348967wrp.60.2020.08.06.05.35.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 05:35:44 -0700 (PDT)
Date: Thu, 6 Aug 2020 08:35:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alyssa Ross <hi@alyssa.is>
Subject: Re: vhost-user protocol feature negotiation
Message-ID: <20200806083450-mutt-send-email-mst@kernel.org>
References: <87sgd1ktx9.fsf@alyssa.is>
 <20200805181352-mutt-send-email-mst@kernel.org>
 <87lfis2lr6.fsf@alyssa.is>
 <20200806054622-mutt-send-email-mst@kernel.org>
 <87zh7810fo.fsf@alyssa.is>
MIME-Version: 1.0
In-Reply-To: <87zh7810fo.fsf@alyssa.is>
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

On Thu, Aug 06, 2020 at 11:24:59AM +0000, Alyssa Ross wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Thu, Aug 06, 2020 at 08:59:09AM +0000, Alyssa Ross wrote:
> >> "Michael S. Tsirkin" <mst@redhat.com> writes:
> >> 
> >> > On Wed, Aug 05, 2020 at 03:13:06PM +0000, Alyssa Ross wrote:
> >> >> Quoting from the definition of VHOST_USER_SET_PROTOCOL_FEATURES in
> >> >> vhost-user.rst:
> >> >> 
> >> >> >   Only legal if feature bit ``VHOST_USER_F_PROTOCOL_FEATURES`` is present in
> >> >> >   ``VHOST_USER_GET_FEATURES``.
> >> >> > 
> >> >> > .. Note::
> >> >> >    Slave that reported ``VHOST_USER_F_PROTOCOL_FEATURES`` must support
> >> >> >    this message even before ``VHOST_USER_SET_FEATURES`` was called.
> >> >> 
> >> >> To me, this could mean either of two things:
> >> >> 
> >> >> (1) If VHOST_USER_F_PROTOCOL_FEATURES hasn't been set, upon receiving
> >> >>     VHOST_USER_SET_PROTOCOL_FEATURES, a backend should enable the
> >> >>     protocol features immediately.
> >> >> 
> >> >> (2) If VHOST_USER_F_PROTOCOL_FEATURES hasn't been set, upon receiving
> >> >>     VHOST_USER_SET_PROTOCOL_FEATURES, a backend should store those
> >> >>     feature bits, but not actually consider them to be enabled until
> >> >>     after VHOST_USER_SET_FEATURES has been received (presumably
> >> >>     containing VHOST_USER_F_PROTOCOL_FEATURES).
> >> >> 
> >> >> The reason I bring this up is that QEMU appears to interpret it as (1),
> >> >> while the vhost-user-net backend in Intel's cloud-hypervisor[1]
> >> >> interprets it as (2).  So I'm looking for a clarification.
> >> >> 
> >> >> [1]: https://github.com/cloud-hypervisor/cloud-hypervisor
> >> >> 
> >> >> Thanks in advance.
> >> >
> >> >
> >> > IMHO the intent was this: VHOST_USER_F_PROTOCOL_FEATURES bit in
> >> > VHOST_USER_GET_FEATURES means that qemu can send
> >> > VHOST_USER_GET_PROTOCOL_FEATURES and VHOST_USER_SET_PROTOCOL_FEATURES.
> >> >
> >> > With most feature bits in VHOST_USER_GET_FEATURES, the
> >> > specific functionality needs to only be enabled after
> >> > VHOST_USER_SET_FEATURES.
> >> >
> >> > However, this is for functionality dealing with guest activity.
> >> > VHOST_USER_SET_PROTOCOL_FEATURES has nothing to do with guest directly,
> >> > it's about negotiation between qemu and backend: it is only in
> >> > VHOST_USER_GET_FEATURES for the reason that this is the only message
> >> > (very) old backends reported.  Thus, the backend should not check
> >> > whether VHOST_USER_SET_FEATURES sets VHOST_USER_F_PROTOCOL_FEATURES,
> >> > instead it should simply always be ready to receive
> >> > VHOST_USER_GET_PROTOCOL_FEATURES and VHOST_USER_SET_PROTOCOL_FEATURES.
> >> >
> >> > Backend that isn't always ready to handle
> >> > VHOST_USER_GET_PROTOCOL_FEATURES and VHOST_USER_SET_PROTOCOL_FEATURES
> >> > should not set VHOST_USER_F_PROTOCOL_FEATURES in
> >> > VHOST_USER_GET_FEATURES.
> >> 
> >> Thanks for the explanation.  That matches what I had in mind with (1).
> >> 
> >> > This appears to be closer to (1), but if qemu can't distinguish
> >> > then we don't care, right? For example, VHOST_USER_PROTOCOL_F_REPLY_ACK
> >> > enables acks on arbitrary messages. Does the backend in question
> >> > ignore the affected bit until SET_FEATURES? If yes won't this
> >> > make qemu hang?
> >> 
> >> Yes.  That was my motivation for asking what the correct behaviour was,
> >> so that I could fix the incorrect one. :)  I suspect that up to this point,
> >> the cloud-hypervisor vhost-user-net backend has only been used with
> >> cloud-hypervisor, and so this incompatibilty with QEMU was not noticed.
> >> 
> >> > How would you suggest clarifying the wording?
> >> 
> >> Do you think this communicates everything required?
> >> 
> >> ---
> >> diff --git i/docs/interop/vhost-user.rst w/docs/interop/vhost-user.rst
> >> index 10e3e3475e..72724d292a 100644
> >> --- i/docs/interop/vhost-user.rst
> >> +++ w/docs/interop/vhost-user.rst
> >> @@ -854,9 +854,8 @@ Master message types
> >>    ``VHOST_USER_GET_FEATURES``.
> >>  
> >>  .. Note::
> >> -   Slave that reported ``VHOST_USER_F_PROTOCOL_FEATURES`` must
> >> -   support this message even before ``VHOST_USER_SET_FEATURES`` was
> >> -   called.
> >> +   ``VHOST_USER_F_PROTOCOL_FEATURES`` does not need to be acknowledged
> >> +   with ``VHOST_USER_SET_FEATURES``.
> >>  
> >>  ``VHOST_USER_SET_PROTOCOL_FEATURES``
> >>    :id: 16
> >
> > Hmm I find this confusing. I think it's a good policy to ask qemu to
> > acknowledge it. It's just that the client should not wait for
> > VHOST_USER_SET_FEATURES before handling VHOST_USER_SET_PROTOCOL_FEATURES
> > or VHOST_USER_GET_PROTOCOL_FEATURES.
> 
> To me, it's confusing that a frontend is expected to ack
> VHOST_USER_F_PROTOCOL_FEATURES even though the ack can't have any effect
> (because VHOST_USER_GET_PROTOCOL_FEATURES and
> VHOST_USER_SET_PROTOCOL_FEATURES both have to work even if the ack
> hasn't been received yet).
> 
> But, if the frontend is supposed to ack anyway, how about:
> 
> Signed-off-by: Alyssa Ross <hi@alysas.is>
> 
> ---
> diff --git i/docs/interop/vhost-user.rst w/docs/interop/vhost-user.rst
> index 10e3e3475e..bc78c9947f 100644
> --- i/docs/interop/vhost-user.rst
> +++ w/docs/interop/vhost-user.rst
> @@ -854,9 +854,9 @@ Master message types
>    ``VHOST_USER_GET_FEATURES``.
>  
>  .. Note::
> -   Slave that reported ``VHOST_USER_F_PROTOCOL_FEATURES`` must
> -   support this message even before ``VHOST_USER_SET_FEATURES`` was
> -   called.
> +   While QEMU should acknowledge ``VHOST_USER_F_PROTOCOL_FEATURES``, a
> +   backend must allow ``VHOST_USER_GET_PROTOCOL_FEATURES`` even if
> +   ``VHOST_USER_F_PROTOCOL_FEATURES`` has not been acknowledged yet.
>  
>  ``VHOST_USER_SET_PROTOCOL_FEATURES``
>    :id: 16
> @@ -869,8 +869,12 @@ Master message types
>    ``VHOST_USER_GET_FEATURES``.
>  
>  .. Note::
> -   Slave that reported ``VHOST_USER_F_PROTOCOL_FEATURES`` must support
> -   this message even before ``VHOST_USER_SET_FEATURES`` was called.
> +   While QEMU should acknowledge ``VHOST_USER_F_PROTOCOL_FEATURES``, a
> +   backend must allow ``VHOST_USER_SET_PROTOCOL_FEATURES`` even if
> +   ``VHOST_USER_F_PROTOCOL_FEATURES`` has not been acknowledged yet.
> +   The backend must not wait for ``VHOST_USER_SET_FEATURES`` before
> +   enabling protocol features requested with
> +   ``VHOST_USER_SET_PROTOCOL_FEATURES``.
>  
>  ``VHOST_USER_SET_OWNER``
>    :id: 3



That looks good to me.
Pls post a patch on list, preferably after qemu is released.


