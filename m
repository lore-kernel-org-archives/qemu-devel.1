Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64722C54E8D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:12:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 303A720674
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SeFS3Ocm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 303A720674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYWZk-0004Y4-5e
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 11:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jYWYG-0002gG-J5
 for qemu-devel@nongnu.org; Tue, 12 May 2020 11:10:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29111
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jYWYF-00057R-4S
 for qemu-devel@nongnu.org; Tue, 12 May 2020 11:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589296233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TO1wCtmEG0kb28A1Vn6uR3VPtKNbRZgagbaGz6SP6fM=;
 b=SeFS3OcmiUFq3tSHOBo9fGrFmrCZBFLlyY9ie7u/jOBva6t86eiXkaiER2gN18OzF/d+Ct
 cROWMHD7ExgRm6K+2KhIpHdHBmEf0smpuLO/WiQJah2OhXH37oNWUWM8oKL5dpsTMdAWlv
 EqtBAIh7LaX6yXKOwP/9QxSeSVW4Ynk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-Y0zOODp1M4WPn2dzUfC1Dg-1; Tue, 12 May 2020 11:10:32 -0400
X-MC-Unique: Y0zOODp1M4WPn2dzUfC1Dg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13A2D835B41;
 Tue, 12 May 2020 15:10:31 +0000 (UTC)
Received: from gondolin (ovpn-112-176.ams2.redhat.com [10.36.112.176])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D00C26E6E6;
 Tue, 12 May 2020 15:10:28 +0000 (UTC)
Date: Tue, 12 May 2020 17:08:28 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] travis.yml: Improve the --disable-tcg test on s390x
Message-ID: <20200512170828.3450ca9a.cohuck@redhat.com>
In-Reply-To: <20200512133849.10624-1-thuth@redhat.com>
References: <20200512133849.10624-1-thuth@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Philippe =?UTF-8?B?TWF0?= =?UTF-8?B?aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 qemu-s390x@nongnu.org, Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 12 May 2020 15:38:49 +0200
Thomas Huth <thuth@redhat.com> wrote:

> Since the s390x containers do not allow KVM, we only compile-test
> the --disable-tcg build on s390x and do not run the qtests. Thus,
> it does not make sense to install genisoimage here, and it also does
> not make sense to build the s390-ccw.img here again - it is simply
> not used without the qtests.
> On the other hand, if we do not build the s390-ccw.img anymore, we
> can also compile with Clang - so let's use that compiler here to
> get some additional test coverage.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .travis.yml | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


