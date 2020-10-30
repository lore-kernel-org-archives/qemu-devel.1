Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7978C56202
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 07:53:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B4FA20719
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 07:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I+jVVoaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B4FA20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYPE6-0007Wf-T2
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 03:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYPCg-0006eZ-Hz
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 03:52:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44223)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYPCe-0003Zi-Pd
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 03:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604044322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iJCdG32GGfN0WQ/wlQmPi99CRvTx0WAN6+aga6ukpJw=;
 b=I+jVVoaAPeOWlx1PoPJ7cG3GaJ4g4Vd8PH8OU0f4iVgQncFIEdHtfx6BJ7AxJQi1Q0lVEn
 4/0fPN0//vTqMJiPlmhdVLlfKoPaMG3aevn+4f8oI04Pj55cNZAHTh3L+2c7OLIMwyrczY
 025ZeLk+R0AW9B5uyZzSlueAKXJmH/I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-o1QbmXDpNJ2HxDRi8_wgbA-1; Fri, 30 Oct 2020 03:52:00 -0400
X-MC-Unique: o1QbmXDpNJ2HxDRi8_wgbA-1
Received: by mail-wr1-f69.google.com with SMTP id j13so2353035wrn.4
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 00:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iJCdG32GGfN0WQ/wlQmPi99CRvTx0WAN6+aga6ukpJw=;
 b=gzDMXvk20Jhhq8VqU3z6y5nb/CE60W+Lje+EXmTS73DW7lY2fWEPJWagm30Z9wgHdK
 Ai2OuXUjyfNxyd335MtDiOlX9gWWA7zGXfL/J4ewUUVc29YkBZrA+Q5MGYErxvEqkZgW
 cVnGJThKm5HJi+iW2+6ArmpZAkdbbLsNU30EY21JB4Quk22ifE+OIz5BQ7mY4T5fGZ3x
 /gwZ7/x9TjfteM+1BX7bvjV7Z2ZUkWywOBX9ey6bwBqRDU3bYWtZCcHLNuebRTVFMgET
 7lojvlWNNPbiIPo1zYXzzJINf+YWNa9fHYO/CNs40u2w4Y3TT2miBy/cu8o6Kif1tG8N
 8U7A==
X-Gm-Message-State: AOAM530rnTfJu/eqbFLP3SqZHo9OQ0AehKz4vLM2rSYVcm9UcUEdjqjc
 CBGEmzXkj+MTpPpXaUeqyk5KksB5wcBpGgG2g41qBncAgCmBBBHduLSTMoqlamI6qZyjNZzWW+f
 qP7yEzO64ptXlCUo=
X-Received: by 2002:a1c:81d7:: with SMTP id c206mr1086995wmd.140.1604044319409; 
 Fri, 30 Oct 2020 00:51:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycpxlC9YkQ8AC8lWMX/YvRVRAeNAr4MiCT3Z8p8yJANlHFDLZ+cYmejXnygpXTG4XKVe3Sfg==
X-Received: by 2002:a1c:81d7:: with SMTP id c206mr1086952wmd.140.1604044319171; 
 Fri, 30 Oct 2020 00:51:59 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id y4sm9501533wrp.74.2020.10.30.00.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 00:51:58 -0700 (PDT)
Date: Fri, 30 Oct 2020 03:51:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: Out-of-Process Device Emulation session at KVM Forum 2020
Message-ID: <20201030032011-mutt-send-email-mst@kernel.org>
References: <20201027151400.GA138065@stefanha-x1.localdomain>
 <CAJSP0QWrmNN1Ci-M-4WDFZBOGHyeZvF71utg0w2ajCbOLtynJw@mail.gmail.com>
 <c4e5b631-1607-a0ec-ee88-6c5a9493e3de@redhat.com>
 <20201029083130.0617a28f@w520.home>
 <b85405de-d525-bf59-826c-737fa7bbdfef@redhat.com>
 <20201029094603.15382476@w520.home>
 <d4f7df42-7b02-6505-c2c7-245bf813b513@redhat.com>
 <20201029210407.33d6f008@x1.home>
MIME-Version: 1.0
In-Reply-To: <20201029210407.33d6f008@x1.home>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Janosch Frank <frankja@linux.vnet.ibm.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Yan Vugenfirer <yan@daynix.com>,
 Jag Raman <jag.raman@oracle.com>, Anup Patel <anup@brainfault.org>,
 Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Roman Kagan <rkagan@virtuozzo.com>, Felipe Franciosi <felipe@nutanix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Jens Freimann <jfreimann@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Liran Alon <liran.alon@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Halil Pasic <pasic@linux.vnet.ibm.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, fam <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> A migration compatibility interface has not been determined for vfio.
> We currently rely on the vendor drivers to provide their own internal
> validation and harmlessly reject migration from an incompatible device.
> It would be great if we could make progress on this, but it's a
> difficult problem, and one that I hope we can further address once we
> have a base level of migration support.
> 
> It's great to revisit ideas, but proclaiming a uAPI is bad solely
> because the data transfer is opaque, without defining why that's bad,


That makes sense.

I feel what is missing from all of these discussions is comparison
with an existing Out-of-Process solution - namely vhost-user.
As a result I feel the proposals tend to forget some of the
lessons learned designing that interface.

In particular I personally see cross-version and cross vendor
migration as a litmus test: it is a hard problem, one that
1. I do not believe vendors will be motivated enough to solve by themselves
2. I don't believe QEMU will be able to add after the fact
for the reason that "supporting QEMU" will come to not imply any level
of compatibility whatsoever.

That was a hard learned lesson and that's the reason I (and maybe Jason,
too) keep harping on that, not that it's so burningly important by
itself.


I think at this point we have an opportunity to make people document
their interfaces up to a point and also actually somewhat standardize
them, using upstream inclusion as a carrot. Some big vendors will
probably ignore it, small ones hopefully won't. After X years margins
become thin, vendors lose interest, and we are at that point glad we
have standards and documentation.


> evaluating the feasibility and implementation of defining a well
> specified data format rather than protocol, including cross-vendor
> support, or proposing any sort of alternative is not so helpful imo.



For example, with a registry of supported device/vendor/subsystem tuples
and a list of compatibility features and a documented migration data format for
each, maintained in QEMU, with a handshake validating that would create
a kind of a registry documenting what is compatible with what.

That could then serve for debugging, validation, and also
help push people towards more standard interfaces.

That is just one idea.

> Note that we also migrate guest memory as opaque data; we don't require
> knowing the data structures it holds or how regions are used, we simply
> look for changes and transfer the new data.  That's not so different
> from a vendor driver passing us a blob of data as "information it needs
> to replicate the device state at the target."


I don't really understand this argument. At the device level we know
exactly how is each region used: some are IO, some are RAM.
In fact one can migrate between systems released years apart.

-- 
MST


