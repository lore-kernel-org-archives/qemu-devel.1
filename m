Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9066AC3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 21:54:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 594432469F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 21:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMLTPU+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594432469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7naC-0002lz-HF
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 16:54:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40196)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1j7nZU-0001rA-RB
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 16:53:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1j7nZT-00044q-Rv
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 16:53:24 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54508
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1j7nZS-00044Z-UN
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 16:53:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582926802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VtcBgiUP6YF3xw456D2bZmeIQvT1gA8IwRiD4BKGCBU=;
 b=BMLTPU+0ZedT1xe1sqXTl0cD4N7R5XxrkmCiokQlVkLXVw/zrLzSqXUtSG72FuHHSJfgps
 XhwZ9hrZJYeDViFZhpGikxU7ROByOH9CbpVRggitQg6GXFJrixL4AEgsi9K3jUnA1JGKKV
 cgEM86cRJDovMEudPEcS6JJlJxSO1Ao=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-0dLK5_9XNO-IsAzEnC9VcA-1; Fri, 28 Feb 2020 16:53:19 -0500
X-MC-Unique: 0dLK5_9XNO-IsAzEnC9VcA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAD6413E6;
 Fri, 28 Feb 2020 21:53:18 +0000 (UTC)
Received: from localhost (unused-10-15-17-6.yyz.redhat.com [10.15.17.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E66A90CC8;
 Fri, 28 Feb 2020 21:53:18 +0000 (UTC)
Date: Fri, 28 Feb 2020 16:53:17 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v3 3/4] target/i386: Add new property note to versioned
 CPU models
Message-ID: <20200228215317.GC494511@habkost.net>
References: <20200212081328.7385-1-tao3.xu@intel.com>
 <20200212081328.7385-4-tao3.xu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20200212081328.7385-4-tao3.xu@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 12, 2020 at 04:13:27PM +0800, Tao Xu wrote:
> Add additional information for -cpu help to indicate the changes in this
> version of CPU model.
>=20
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>

Queued, thanks!

--=20
Eduardo


