Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F46EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:11:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A3F5206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GsrHhrBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3F5206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj74F-0005sd-Hg
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 16:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jj735-0004Ur-4L
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:10:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52436
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jj734-0001nB-67
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591819809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6kXX9XcHSUq0Yc5kL9bLb+/VifdWxLkMzeoHH3wJ1l8=;
 b=GsrHhrBy7yCnA0zCcxujawKbv/erHFNSeHxx01YyS2iNFubS9dEqg1px7BoMH0yo8vOk1J
 GoVr0aSu5SNhAPlHt+kUH7+XiZ6Y1OxLrp9k1GgDdGgRgGTjEUwIbpCDVnPhHuaV4YLQ+r
 LERStIijpfyYVPcldqqwhaxgVWlXCu0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-LKndFYnzPrqBLFuNAt0joA-1; Wed, 10 Jun 2020 16:10:07 -0400
X-MC-Unique: LKndFYnzPrqBLFuNAt0joA-1
Received: by mail-wr1-f69.google.com with SMTP id r5so1547096wrt.9
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 13:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6kXX9XcHSUq0Yc5kL9bLb+/VifdWxLkMzeoHH3wJ1l8=;
 b=WpUq3JTm8fwR+CbTqiCUYR6gqVdATCaqFO9AOdrqxNSqjufH+yoL1K19zDBv3kYu72
 LPx2LkLfVQnhzEOvepG3MV6lNRYBofyIfpkFUH+QC923iy9dpJcYy16B33d8MWLqmmU5
 kFCi9+ewD9gMkUc0qynR41kKvF8bfhrLT+UrNpO1dhSEMCoH3sa31LiBtpri2Vu2hC+l
 RyTKPugMlRCI+OLEDg7c03RduF20azpU4WgdVHzkEF0xvS7Cdwh+erOQVi98uSFEILQ1
 x9wDh3lpsil8cPqibx255kB4lGBpuAIGRFiuzdfULmeqpVH9oX6M08MPMll8wWDaMog1
 c/0Q==
X-Gm-Message-State: AOAM530lboeYNgOt9Wqs0tOd+w7eqGnFFczlCSQDEFPCQjc81HsSBTCd
 ae/1HPzBrV09ES5JqmEW41vL4OtpncIMqlWBgZ/jolW1HuYsDUZHp/io/o+/PV8hvJAignrQSmy
 yTmJIyQAEea6Cijc=
X-Received: by 2002:a5d:68cb:: with SMTP id p11mr5289080wrw.379.1591819806104; 
 Wed, 10 Jun 2020 13:10:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw07RSkNA+82/zN/tCm9tvGf+UVFMrBsO4+7oJzGjV9lgQHeKMvYmf8JCwxkIWE7+XDN6FbLQ==
X-Received: by 2002:a5d:68cb:: with SMTP id p11mr5289054wrw.379.1591819805863; 
 Wed, 10 Jun 2020 13:10:05 -0700 (PDT)
Received: from redhat.com ([212.92.121.57])
 by smtp.gmail.com with ESMTPSA id h18sm1227509wru.7.2020.06.10.13.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 13:10:05 -0700 (PDT)
Date: Wed, 10 Jun 2020 16:10:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v7 0/9] acpi: i386 tweaks
Message-ID: <20200610160946-mutt-send-email-mst@kernel.org>
References: <20200610094131.13346-1-kraxel@redhat.com>
 <20200610134002.6461b40a@redhat.com>
 <20200610105405-mutt-send-email-mst@kernel.org>
 <20200610155346.qwqwxr6v22xi4wn5@sirius.home.kraxel.org>
MIME-Version: 1.0
In-Reply-To: <20200610155346.qwqwxr6v22xi4wn5@sirius.home.kraxel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 15:44:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 10, 2020 at 05:53:46PM +0200, Gerd Hoffmann wrote:
> On Wed, Jun 10, 2020 at 10:54:26AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Jun 10, 2020 at 01:40:02PM +0200, Igor Mammedov wrote:
> > > On Wed, 10 Jun 2020 11:41:22 +0200
> > > Gerd Hoffmann <kraxel@redhat.com> wrote:
> > > 
> > > > First batch of microvm patches, some generic acpi stuff.
> > > > Split the acpi-build.c monster, specifically split the
> > > > pc and q35 and pci bits into a separate file which we
> > > > can skip building at some point in the future.
> > > > 
> > > It looks like series is missing patch to whitelist changed ACPI tables in
> > > bios-table-test.
> > 
> > Right. Does it pass make check?
> 
> No, but after 'git cherry-pick 9b20a3365d73dad4ad144eab9c5827dbbb2e9f21' it does.


OK pls post a complete series, ok?

> > > Do we already have test case for microvm in bios-table-test,
> > > if not it's probably time to add it.
> > 
> > Separately :)
> 
> Especially as this series is just preparing cleanups and doesn't
> actually add acpi support to microvm yet.
> 
> But, yes, adding a testcase sounds useful.
> 
> take care,
>   Gerd


