Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28614C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 12:59:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC131206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 12:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AYYGdOD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC131206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5TsT-0006A6-4q
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 08:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k5Trs-0005e5-QQ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 08:59:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51574
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k5Trq-0000LH-CQ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 08:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597150741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XY6Krjx9fNxb2tYLQci1GnykiFY2uJIiO6IhhjYHzy4=;
 b=AYYGdOD20HAlyhWo5WxAlDTii48Kd+mZZoolW13ShcnWExnJe8YiN0CuVVhom/YxkI59dF
 Ces0dAktaNZNDx1xAW18SYRDZgkDd65mNrmGHy/5usdqilw/ERBKgjoaoXe6YCQ4+JP8f+
 /2e1HHKZ2qGU3fJdWzWvOU1vkQGFO7c=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-3ORlGVt-O0-rHAsGHMEfyA-1; Tue, 11 Aug 2020 08:58:59 -0400
X-MC-Unique: 3ORlGVt-O0-rHAsGHMEfyA-1
Received: by mail-ej1-f70.google.com with SMTP id g18so5133665ejm.4
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 05:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XY6Krjx9fNxb2tYLQci1GnykiFY2uJIiO6IhhjYHzy4=;
 b=KhoRfGRig2gRbOUDo1kxA9DkK37kyAbr9Mj41EFkGRiM6GZ/8hTu8cCcFY9MAGQHXP
 Mda1jzGk/p3AIIas3YAEEtord7utdBrDYSBzDx9kViqAHlc4sLlXDTQnl8Qm7GmQ1RML
 2R6/FbeLMJurMsqsA/5fMsDbcQjvJWBslgsaWP1RPSQzsFdlnaEYM1IEWBHMjV5rFfQf
 5luobj/6JvOj7sWBRhOv2m2cHjyatK9tQjZxvqJ+2eQHl3MgDWebHOVcps+awsQ82uZa
 +PErTdbsdaWqnrd2L5/syZBXPCeXnre2HnDD/nENhg0C8TA4xe/ebQXEr0B3qGUKp4dJ
 n8yg==
X-Gm-Message-State: AOAM530W2J+C8a/ivQvn3gwL4x6YYZBO49VF8ytsYJPa4ceFjF9ZccR5
 Sg4TzoqUBEvoqKP8KHaSyqJyvk60fgGNwCSm598+qujqJlk9sX/g5qRs3cUpyhJ0hrh6J/MUecs
 tvTNYJT6gkTq2wWY=
X-Received: by 2002:a50:fc82:: with SMTP id f2mr25547287edq.53.1597150738531; 
 Tue, 11 Aug 2020 05:58:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxu507B2txHo7qll2eVfkDWwWhsXTijvB8coAcYpqYfqn7X/fo1vbqOSlKjJ1YbZ8pIOcBhyw==
X-Received: by 2002:a50:fc82:: with SMTP id f2mr25547275edq.53.1597150738260; 
 Tue, 11 Aug 2020 05:58:58 -0700 (PDT)
Received: from redhat.com ([147.161.12.106])
 by smtp.gmail.com with ESMTPSA id b9sm15115760ejz.57.2020.08.11.05.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 05:58:56 -0700 (PDT)
Date: Tue, 11 Aug 2020 08:58:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH v2] virtio-rng: return available data with O_NONBLOCK
Message-ID: <20200811084616-mutt-send-email-mst@kernel.org>
References: <20200715133255.10526-1-mwilck@suse.com>
 <20200811071726-mutt-send-email-mst@kernel.org>
 <e75b3cd527bae4c6762af17a0a32f57c61191274.camel@suse.com>
MIME-Version: 1.0
In-Reply-To: <e75b3cd527bae4c6762af17a0a32f57c61191274.camel@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 04:41:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 11, 2020 at 02:07:23PM +0200, Martin Wilck wrote:
> On Tue, 2020-08-11 at 07:26 -0400, Michael S. Tsirkin wrote:
> > On Wed, Jul 15, 2020 at 03:32:55PM +0200, mwilck@suse.com wrote:
> > >  drivers/char/hw_random/virtio-rng.c | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > > 
> > > diff --git a/drivers/char/hw_random/virtio-rng.c
> > > b/drivers/char/hw_random/virtio-rng.c
> > > index 79a6e47b5fbc..984713b35892 100644
> > > --- a/drivers/char/hw_random/virtio-rng.c
> > > +++ b/drivers/char/hw_random/virtio-rng.c
> > > @@ -59,6 +59,20 @@ static int virtio_read(struct hwrng *rng, void
> > > *buf, size_t size, bool wait)
> > >  	if (vi->hwrng_removed)
> > >  		return -ENODEV;
> > >  
> > > +	/*
> > > +	 * If the previous call was non-blocking, we may have got some
> > > +	 * randomness already.
> > > +	 */
> > > +	if (vi->busy && completion_done(&vi->have_data)) {
> > > +		unsigned int len;
> > > +
> > > +		vi->busy = false;
> > > +		len = vi->data_avail > size ? size : vi->data_avail;
> > > +		vi->data_avail -= len;
> > 
> > I wonder what purpose does this line serve: busy is false
> > which basically means data_avail is invalid, right?
> > A following non blocking call will not enter here.
> 
> Well, I thought this is just how reading data normally works. But
> you're right, the remainder will not be used. I can remove the line, or
> reset data_avail to 0 at this point. What do you prefer?
> 
> Regards,
> Martin

Removing seems cleaner.

But looking at it, it is using the API in a very strange way:
a buffer is placed in the ring by one call, and *assumed*
to still be there in the next call.

which it might not be if one call is from userspace and the
next one is from fill kthread.

I guess this is why it's returning 0: yes it knows there's
data, but it does not know where it is.

-- 
MST


