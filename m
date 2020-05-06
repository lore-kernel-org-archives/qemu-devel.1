Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E43FC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 16:03:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0766D2068E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 16:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hPD8+5DJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0766D2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWMVi-0006CB-6S
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 12:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jWMU7-0003iZ-G5
 for qemu-devel@nongnu.org; Wed, 06 May 2020 12:01:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40598
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jWMU6-0002tB-01
 for qemu-devel@nongnu.org; Wed, 06 May 2020 12:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588780881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8VDCkaXcyoxW7fY0Lm8yCASCn4j9uzmsrJwnbaMylDo=;
 b=hPD8+5DJbn0SmCNtoKdJGtMrg50DkhQqkPOjtlyjWhz5gkwJEzqb1hmyfTzG8uxsr1mtSN
 xRbN8hl6QSazZnCpNQPOfo0f6wh3Tdc9ZOg/P847cInSVhW5MrQ6Iul2UIKcKZgTiXh4N+
 xNVfSsitKJNMWkk/NM1P5e9sS3IgsSk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-Q-2YaqwwMLucH9bPXORVYg-1; Wed, 06 May 2020 12:01:16 -0400
X-MC-Unique: Q-2YaqwwMLucH9bPXORVYg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D53A78014C0;
 Wed,  6 May 2020 16:01:14 +0000 (UTC)
Received: from gondolin (ovpn-112-211.ams2.redhat.com [10.36.112.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6FA0D4233;
 Wed,  6 May 2020 16:01:13 +0000 (UTC)
Date: Wed, 6 May 2020 18:01:10 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH v4 6/6] vfio-ccw: Add support for the CRW region and IRQ
Message-ID: <20200506180110.106bd1b0.cohuck@redhat.com>
In-Reply-To: <20200505125757.98209-7-farman@linux.ibm.com>
References: <20200505125757.98209-1-farman@linux.ibm.com>
 <20200505125757.98209-7-farman@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 04:02:22
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Jared Rossi <jrossi@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue,  5 May 2020 14:57:57 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> From: Farhan Ali <alifm@linux.ibm.com>
> 
> The crw region can be used to obtain information about
> Channel Report Words (CRW) from vfio-ccw driver.
> 
> Currently only channel-path related CRWs are passed to
> QEMU from vfio-ccw driver.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
> 
> Notes:
>     v3->v4:
>      - Merge region patch into IRQ patch [CH]
>      - Rework the testing/clearing notifier and reading region [CH]
>     
>     v2->v3:
>      - Remove "size==0" check in CRW notifier [CH]
>      - Remove intermediate rsc/erc variables, use css_queue_crw_cont() [CH]
>      - s/crw0/crw/ [CH]
>     
>     v1->v2:
>      - Add a loop to continually read region while data is
>        present, queueing CRWs as found [CH]
>     
>     v0->v1: [EF]
>      - Fixed copy/paste error in error message (s/schib/CRW)
>      - Check vcdev->crw_region before registering the irq,
>        in case host kernel does not have matching support
>      - Split the refactoring changes to an earlier (new) patch
>        (and don't remove the "num_irqs" check in the register
>        routine, but adjust it to the check the input variable)
>      - Don't revert the cool vfio_set_irq_signaling() stuff
>      - Unregister CRW IRQ before IO IRQ in unrealize
>      - s/crw1/crw0/
> 
>  hw/vfio/ccw.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


