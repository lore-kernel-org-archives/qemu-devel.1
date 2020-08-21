Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9057C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:36:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83CC02078B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXMlSuvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83CC02078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k95LL-0001dV-Qf
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 07:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k94h9-0005EB-0K
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:54:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25077
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k94h6-0005Pe-Iq
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598007285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vjIFOpL3ubt0uIfiU0XJuS81GqiSnva5vzGuU5tQtlE=;
 b=WXMlSuvlGsF7H4rAC7II07ioA89+H1d1avcES+enkJoyedVWyXGpgE7JXaXop5yYmFx0J5
 6POSdG6Ao/vq7MXu0pCUZ5SQnoHpAM0+YZAVpeDY8VI+C9oRG0+Ip+GGoDUi5SBKm8xGFE
 2wWuP6+ywnk+36vXqhwy+1E6TxMqzy8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-rjKOS0FkNKSemgtN0O5beg-1; Fri, 21 Aug 2020 06:54:43 -0400
X-MC-Unique: rjKOS0FkNKSemgtN0O5beg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BF7F81F02D;
 Fri, 21 Aug 2020 10:54:42 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-251.ams2.redhat.com [10.36.113.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A06B77A431;
 Fri, 21 Aug 2020 10:54:40 +0000 (UTC)
Date: Fri, 21 Aug 2020 12:54:39 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] configure: add support for pseudo-"in source tree"
 builds
Message-ID: <20200821105439.GE5153@linux.fritz.box>
References: <20200820173124.243984-1-berrange@redhat.com>
 <814594a0-391c-01fb-a418-234e477793d3@redhat.com>
 <20200821100426.GB5153@linux.fritz.box>
 <df28e5c2-ee4a-23d6-dcb2-04003a5d2757@redhat.com>
MIME-Version: 1.0
In-Reply-To: <df28e5c2-ee4a-23d6-dcb2-04003a5d2757@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 01:00:15
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 21.08.2020 um 12:15 hat Paolo Bonzini geschrieben:
> On 21/08/20 12:04, Kevin Wolf wrote:
> >> So I'm not sure why the first build gets as far as it does, but does NOT
> >> complete things and yet does not fail make, but my advice is that you should
> >> NOT try to an incremental build on in-tree build when crossing the meson
> >> epoch.  If you are a fan of in-tree convenience, you need a ONE-TIME
> >> distclean when pulling in these changes (the fact that you HAVE to clean up
> >> trace.h files to merge in the meson stuff should be a hint for that).  After
> >> that has been done, you can go back to pretending meson supports in-tree.
> > Sounds like it will be painful to switch between branches based on make
> > and branches based on meson. By extension, it will also be painful to
> > check out and build old versions for comparison, or doing that even more
> > than once during git bisect. :-(
> 
> Not if you switch to out-of-tree builds...

I don't see what out-of-tree builds change about this unless I delete
and reconfigure them after each step? Even in those cases where I use
out-of-tree builds, I often reuse the same directory.

Kevin


