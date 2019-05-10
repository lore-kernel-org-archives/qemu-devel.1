Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531A7C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:34:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27780208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27780208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46392 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP8TG-0004dq-9z
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 12:34:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hP8Gy-0008AA-JO
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:21:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hP8Gx-0005JX-F6
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:21:24 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hP8Gx-0005JH-Am
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:21:23 -0400
Received: by mail-qk1-f194.google.com with SMTP id w20so4000895qka.7
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 09:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=Pq8EQnGmHZ7vcLmT/c+CCq6p/+Ah0urV54Z8VVHTOS0=;
	b=p33VfzluoJqgf8o02ULOYAxPJ2KxNXfFVBZd1HBEob0tVPgTjC/Q4jvEDTp+sErSM9
	cVFCNYzDWe0HLj1DueSUGxxwxtZjywRliy7FnD1FiqUbIYOumlQpVxS0qseWUHT0qvW8
	ORSts91kKvNNZAB57kLYTlNKWwg7ZBXTJK5CttOuRxjl6nXJVRMkW3loPPrEHiREw0KL
	Mz55hrY42Wu2uEQocI7YbIRiBqSmhrhQSYr2xeq4hHF9QHsqNoiETbXPOOxc2+dFaM9+
	M2t4h6SqVCbRlYa2PkSKpbqZjv8R+7LSiB4Vln244W08UoVusnYr6ikRXTOvPQmxLNmc
	z0eg==
X-Gm-Message-State: APjAAAUz5h15m25YCucVb2MMMgNkGEbgLpSdNDuQG9axH4/jIjqWhbNY
	RrxZSHxiOz8dyMjrbrK8QkH9Iw==
X-Google-Smtp-Source: APXvYqx2QqnXOiTlT0vPdlB1ep0UKVKnhXS3Yy+lvb8Jin3Cb3Oe0gTOUl2ZLfe+DdJTGafTMdlRcQ==
X-Received: by 2002:ae9:df44:: with SMTP id t65mr9538151qkf.126.1557505282756; 
	Fri, 10 May 2019 09:21:22 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71])
	by smtp.gmail.com with ESMTPSA id p6sm2969264qkc.13.2019.05.10.09.21.21
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 10 May 2019 09:21:21 -0700 (PDT)
Date: Fri, 10 May 2019 12:21:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190510121939-mutt-send-email-mst@kernel.org>
References: <20190510134203.24012-1-lvivier@redhat.com>
	<20190510134203.24012-2-lvivier@redhat.com>
	<20190510121135-mutt-send-email-mst@kernel.org>
	<20190510161644.GP7671@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190510161644.GP7671@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.194
Subject: Re: [Qemu-devel] [PATCH v3 1/3] VirtIO-RNG: Update default entropy
 source to `/dev/urandom`
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>,
	Kashyap Chamarthy <kchamart@redhat.com>, Amit Shah <amit@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	"Richard W . M . Jones" <rjones@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 10, 2019 at 05:16:44PM +0100, Daniel P. Berrangé wrote:
> On Fri, May 10, 2019 at 12:12:41PM -0400, Michael S. Tsirkin wrote:
> > On Fri, May 10, 2019 at 03:42:01PM +0200, Laurent Vivier wrote:
> > > From: Kashyap Chamarthy <kchamart@redhat.com>
> > > 
> > > When QEMU exposes a VirtIO-RNG device to the guest, that device needs a
> > > source of entropy, and that source needs to be "non-blocking", like
> > > `/dev/urandom`.  However, currently QEMU defaults to the problematic
> > > `/dev/random`, which is "blocking" (as in, it waits until sufficient
> > > entropy is available).
> > > 
> > > Why prefer `/dev/urandom` over `/dev/random`?
> > > ---------------------------------------------
> > > 
> > > The man pages of urandom(4) and random(4) state:
> > > 
> > >     "The /dev/random device is a legacy interface which dates back to a
> > >     time where the cryptographic primitives used in the implementation
> > >     of /dev/urandom were not widely trusted.  It will return random
> > >     bytes only within the estimated number of bits of fresh noise in the
> > >     entropy pool, blocking if necessary.  /dev/random is suitable for
> > >     applications that need high quality randomness, and can afford
> > >     indeterminate delays."
> > > 
> > > Further, the "Usage" section of the said man pages state:
> > > 
> > >     "The /dev/random interface is considered a legacy interface, and
> > >     /dev/urandom is preferred and sufficient in all use cases, with the
> > >     exception of applications which require randomness during early boot
> > >     time; for these applications, getrandom(2) must be used instead,
> > >     because it will block until the entropy pool is initialized.
> > 
> > So how about just using getrandom then?
> 
> The 3rd patch in this series addresses that.

It seems to use qemu_guest_getrandom which in turn
with patch 1 calls /dev/urandom...
Did I miss something?

> 
> Regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

