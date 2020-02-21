Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7C4C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 18:05:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AA5B20722
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 18:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I749B3+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA5B20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5CgF-0004eA-FU
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 13:05:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45601)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j5CfQ-0003nb-Or
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 13:04:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j5CfO-0006wU-Qd
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 13:04:47 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48479
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j5CfO-0006vO-L3
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 13:04:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582308285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kpGXQkXHUeaMoHpMAQOGOZUE/N5imtyDcaBopDcc2Z0=;
 b=I749B3+aefbe0j1VAIidYMjrGnA09y0k1+vyjJ+NV06HTmwcNv6J6jKtOUh4xAXHztKNvC
 QkHmISDYEFDqSrRtaMiW0f0c7MpI3vEN3hIji1GH4CkS85XoirYYe84ah6ErrWe9i6Z1Rb
 CH4eVEXoFlI7obTKitsqkcO3LoJQXZ0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-Hzs0RTQXOZeq8s0E0qjXeQ-1; Fri, 21 Feb 2020 13:04:43 -0500
X-MC-Unique: Hzs0RTQXOZeq8s0E0qjXeQ-1
Received: by mail-qv1-f70.google.com with SMTP id v3so1879145qvm.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 10:04:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=W8peW3FQIPtTKF2cUwS2FUJ0ehcEM8fGHL7Yz9MFAtg=;
 b=XVUP6nv8gb1hOt20JVOdsWeyjrGubcrqUYHWGNuoyzQdM22P1ShpPpaR5pT6nLWRCJ
 8BM37hZr8xqgcYrkSc4iKcMGbeSr94OIk23J6AndfRTcbJmp03k+Iz5WZkZEhJdBmjWX
 6fImCra0QFU5kaRWij9sYwMCp/xIQyZH93qNN2494E+CRTzea1M25Z/myrM2RI6zk0mZ
 gVf+VuznHFZ5QjLFdBDDURZsF7V8MQbijxCBzMlXiFEo8L5iUsF4eDx0VCJcF2c+k3Kc
 KF15o4U3WJniWVnl1DgnpKo58BLgwJ/IVaE3BoUCdDufam+V8xmc8BKIlFiG4nA8FeCj
 GGCQ==
X-Gm-Message-State: APjAAAULYY2v4Eh1+gMuIvdJ9iz7dsCqOQ8yrsLucv+pV75HxYmDitgl
 8HhLx5qi2c7p5IMG3O4SWFAyGbfShmfnVOrr+B4UYJdd5I0UR+L7R65X2bJ48bry+WOpNhmjWLJ
 kYFrQdKqB4zhbVw4=
X-Received: by 2002:aed:3e53:: with SMTP id m19mr33422667qtf.387.1582308283191; 
 Fri, 21 Feb 2020 10:04:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqyCCxi4ySoGKe68p1tfsz7+cfluKfG07qA5l9L6U2zWmC3FkXe6CO8F1dL11k7nLoTimaUO7Q==
X-Received: by 2002:aed:3e53:: with SMTP id m19mr33422632qtf.387.1582308282918; 
 Fri, 21 Feb 2020 10:04:42 -0800 (PST)
Received: from xz-x1 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca.
 [72.137.123.47])
 by smtp.gmail.com with ESMTPSA id u12sm1973225qtj.84.2020.02.21.10.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 10:04:42 -0800 (PST)
Date: Fri, 21 Feb 2020 13:04:40 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 00/13] migrate/ram: Fix resizing RAM blocks while
 migrating
Message-ID: <20200221180440.GE37727@xz-x1>
References: <20200221164204.105570-1-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200221164204.105570-1-david@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paul Durrant <paul@xen.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Shannon Zhao <shannon.zhao@linaro.org>, Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 21, 2020 at 05:41:51PM +0100, David Hildenbrand wrote:
> I was now able to actually test resizing while migrating. I am using the
> prototype of virtio-mem to test (which also makes use of resizable
> allocations). Things I was able to reproduce:

The test cases cover quite a lot.  Thanks for doing that.

> - Resize while still running on the migration source. Migration is cancel=
ed
> -- Test case for "migraton/ram: Handle RAM block resizes during precopy"

> - Resize (grow+shrink) on the migration target during postcopy migration
>   (when syncing RAM blocks), while not yet running on the target
> -- Test case for "migration/ram: Discard new RAM when growing RAM blocks
>    and the VM is stopped", and overall RAM size synchronization. Seems to
>    work just fine.

This won't be able to trigger without virtio-mem, right?

And I'm also curious on how to test this even with virtio-mem.  Is
that a QMP command to extend/shrink virtio-mem?

> - Resize (grow+shrink) on the migration tagret during postcopy migration
>   while already running on the target.
> -- Test case for "migration/ram: Handle RAM block resizes during postcopy=
"
> -- Test case for "migration/ram: Tolerate partially changed mappings in
>    postcopy code" - I can see that -ENOENT is actually triggered and that
>    migration succeeds. Migration seems to work just fine.

Thanks,

--=20
Peter Xu


