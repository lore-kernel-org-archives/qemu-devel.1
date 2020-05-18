Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFBDC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 14:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 990B720756
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 14:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="COWQ5XX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990B720756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jahCC-0004XD-PT
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 10:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jahBf-0003zN-Lc
 for qemu-devel@nongnu.org; Mon, 18 May 2020 10:56:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22226
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jahBf-0008S5-2Z
 for qemu-devel@nongnu.org; Mon, 18 May 2020 10:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589813774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0+Xvld+XPLrs6+fhATzUuKbN7iEzX72iseBceL8Tt/c=;
 b=COWQ5XX5OkwgnlH8RvzWzxibOQ2AFiO0ssILm397t5icIpBLSJrT4Pg3e6M9ML2RdDb9RZ
 QxcQ+krUIE1/9xko0KGqZIZh0f1yJRdtzZOGw3m2sji7g8VS25eqFlopUjK4RtwC9aYWgN
 yxv8p2MjrxftsYdQTJ2cHjrzIyLVF5I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-roPRvyibMyeQxL5KuzkkdA-1; Mon, 18 May 2020 10:56:10 -0400
X-MC-Unique: roPRvyibMyeQxL5KuzkkdA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88525100CCC0;
 Mon, 18 May 2020 14:56:09 +0000 (UTC)
Received: from gondolin (ovpn-113-28.ams2.redhat.com [10.36.113.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F43C7958D;
 Mon, 18 May 2020 14:56:08 +0000 (UTC)
Date: Mon, 18 May 2020 16:56:05 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Jared Rossi <jrossi@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] vfio-ccw: allow non-prefetch ORBs
Message-ID: <20200518165605.0975f9f4.cohuck@redhat.com>
In-Reply-To: <20200512181535.18630-2-jrossi@linux.ibm.com>
References: <20200512181535.18630-1-jrossi@linux.ibm.com>
 <20200512181535.18630-2-jrossi@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 23:32:08
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
Cc: Eric Farman <farman@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 12 May 2020 14:15:35 -0400
Jared Rossi <jrossi@linux.ibm.com> wrote:

> Remove the explicit prefetch check when using vfio-ccw devices.
> This check does not trigger in practice as all Linux channel programs
> are intended to use prefetch.
> 
> It is no longer required to force the PFCH flag when using vfio-ccw
> devices.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  hw/vfio/ccw.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)

Thanks, applied (with updated commit message.)


