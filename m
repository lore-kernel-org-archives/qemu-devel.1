Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D5FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 14:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06C5B2078E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 14:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hCV3RSk2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C5B2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5VcB-0001q8-2b
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 10:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k5VbL-0001KJ-8X
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 10:50:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47239)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k5VbH-0005Yh-3B
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 10:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597157398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+mcR0YSpNfzoCNOfoOspUyIDAzLMStXOEsUjhKacxpw=;
 b=hCV3RSk2fEYfahzB6kLbhrJeQW0K1kYe03qbMPD6e1uOq9PAum5y5cn88PgDQ10ZSfzjCC
 Zf+xHgNMAql1GDPpx4z08XSWi0Dyc7qQC+g8ZRp2s/zZ1pDXISTM7ibeF8Er7r4uO+TlNy
 EWeyIihoubHpqum7f/Dn+8Wy7gVjAwQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-hmMvq977MqCG9TxDlMCecg-1; Tue, 11 Aug 2020 10:49:57 -0400
X-MC-Unique: hmMvq977MqCG9TxDlMCecg-1
Received: by mail-wm1-f69.google.com with SMTP id i15so1062654wmb.5
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 07:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+mcR0YSpNfzoCNOfoOspUyIDAzLMStXOEsUjhKacxpw=;
 b=CSDRyiNx/fk0Kz8t5YOCF3vPI/E+S3TinDNB6OEjRQsj7ybHJEgV3HnXXL7U74QlhX
 MgHlomxNXUfttvb8Ht8eiCPVPMOynPtuc1DHh8Hh0IOdxBKfDZyElzVOi8kVy5V31fMo
 texfV4L4S46gknZTZksGb0CCFVIc6ApnJl9ykgb9MbTMFYoEuTWVtwX2nCkxrXOwR5QT
 0Go/zH4sbxz/UPMIqAtiw9/jCcZ/NtqS51GYTmw/yK40YcRmwJ5kgRAWo4KWSZiqbr9Y
 E23TYGNTs0dSPMgAzZ0UhZ7NRididkQZN+YNr1wSEevJsEnA0hF5P4Tal3/wmnnPKpBV
 +fQQ==
X-Gm-Message-State: AOAM530tW1LX94KefQdIVcNmOWC3kCtSY564ggN54ojLNY0/4CL1FqMo
 yh+iOh9B07AX19+2e6zvl6LSGpQqrZ8RyKk2QqYWJTs/e2iV1aTR5YHOuymadh5+oNOoSrwWhzO
 H/RJYJuD4yWDX4UM=
X-Received: by 2002:a1c:f605:: with SMTP id w5mr4226032wmc.26.1597157395996;
 Tue, 11 Aug 2020 07:49:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwESjUvg3ZtGmR8tFEYPDG2mdGUWbhxJ9k0v2hx/wvji6m8VXP/4+bTLX6P8xSWtD7zlvVjAA==
X-Received: by 2002:a1c:f605:: with SMTP id w5mr4226008wmc.26.1597157395678;
 Tue, 11 Aug 2020 07:49:55 -0700 (PDT)
Received: from redhat.com ([147.161.12.106])
 by smtp.gmail.com with ESMTPSA id o2sm5196412wmh.5.2020.08.11.07.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 07:49:54 -0700 (PDT)
Date: Tue, 11 Aug 2020 10:49:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2] virtio-rng: return available data with O_NONBLOCK
Message-ID: <20200811104756-mutt-send-email-mst@kernel.org>
References: <20200715133255.10526-1-mwilck@suse.com>
 <7cfc4316-922b-8606-72ce-80205ef55572@redhat.com>
 <7affb721-9686-1262-b7cf-d9681646b602@redhat.com>
 <810451cf80032d131d5d3feb4fc8300549516f3d.camel@suse.com>
 <b764a4bb-b81f-b14f-9b7f-d6d087a8b1ea@redhat.com>
 <b8b19be7fd9b3fab629506eb30d9f0c820aa57d2.camel@suse.com>
 <085f699b-e391-7363-b63e-3b11cc04e50d@redhat.com>
 <20200811090814-mutt-send-email-mst@kernel.org>
 <a9179d2b-35fb-26ab-1afd-9952cc3ae008@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a9179d2b-35fb-26ab-1afd-9952cc3ae008@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 10:49:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Amit Shah <amit@kernel.org>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Martin Wilck <mwilck@suse.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 11, 2020 at 03:53:54PM +0200, Laurent Vivier wrote:
> On 11/08/2020 15:14, Michael S. Tsirkin wrote:
> > On Tue, Aug 11, 2020 at 03:00:14PM +0200, Laurent Vivier wrote:
> >> No problem. This code is tricky and it took me several months to really
> >> start to understand it ...
> > 
> > Oh great, we actually have someone who understands the code!
> > Maybe you can help me understand: virtio_read
> > takes the buf pointer and puts it in the vq.
> > It can then return to caller (e.g. on a signal).
> > Device can meanwhile write into the buffer.
> > 
> > It looks like if another call then happens, and that
> > other call uses a different buffer, virtio rng
> > will happily return the data written into the
> > original buf pointer, confusing the caller.
> > 
> > Is that right?
> > 
> 
> Yes.
> 
> hw_random core uses two bufers:
> 
> - rng_fillbuf that is used with a blocking access and protected by the
> reading_mutex. I think this cannot be interrupted by a kill because it's
> in  hwrng_fillfn() and it's kthread.
> 
> - rng_buffer that is used in rng_dev_read() and can be interrupted (it
> is also protected by reading_mutex)
> 
> But if rng_dev_read() is called with O_NONBLOCK or interrupted and then
> rng_fillbuf starts they can be mixed.
> 
> We have also the first use of rng_buffer in add_early_randomness() that
> use a different size than in rng_dev_read() with the same buffer (and
> this size is 16 whereas the hwrng read API says it must be at least 32...).
> 
> The problem here is core has been developped with synchronicity in mind,
> whereas virtio is asynchronous by definition.
> 
> I think we should add some internal buffers in virtio-rng backend. This
> would improve performance (we are at 1 MB/s, I sent a patch to improve
> that, but this doesn't fix the problems above), and allows hw_random
> core to use memory that doesn't need to be compatible with virt_to_page().
> 
> Thanks,
> Laurent

OK so just add a bunch of 32 bit buffers and pass them to hardware,
as they data gets consumed pass them to hardware again?


-- 
MST


