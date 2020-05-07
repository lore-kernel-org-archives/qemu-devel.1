Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D11C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 10:16:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E38B2073A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 10:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G52f9Zs/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E38B2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWdZj-00033D-Jf
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 06:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jWdYe-00021K-Ce
 for qemu-devel@nongnu.org; Thu, 07 May 2020 06:15:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33261
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jWdYd-0007OD-K7
 for qemu-devel@nongnu.org; Thu, 07 May 2020 06:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588846511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y4JpuPa+Jb58i3S4vHZfo2CI4f9zgEgw+DvsIdLyUcw=;
 b=G52f9Zs/Pq2nhbElnzJEtGuMMpNLbSs18DjVI01DgHxhtYUOtKfp6pvODQyMSqInE1Gy2h
 h7fHleDCdpaGb0XX2VrdlX4TPo43NoHWa2NMOV9Y5secWvydtevDJHaVu7FX5N7IVz6kO2
 +atpNIbb+16A/PLW69iorGC7wJa8JG4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-EI28nb9KPM6QI0lYxCJ4NQ-1; Thu, 07 May 2020 06:15:05 -0400
X-MC-Unique: EI28nb9KPM6QI0lYxCJ4NQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B27761899526;
 Thu,  7 May 2020 10:15:04 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-33.ams2.redhat.com [10.36.113.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ACA37610FF;
 Thu,  7 May 2020 10:15:03 +0000 (UTC)
Date: Thu, 7 May 2020 12:15:02 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 0/9] More truncate improvements
Message-ID: <20200507101502.GB6019@linux.fritz.box>
References: <20200428202905.770727-1-eblake@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200428202905.770727-1-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:56:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 28.04.2020 um 22:28 hat Eric Blake geschrieben:
> Based-on: <20200424125448.63318-1-kwolf@redhat.com>
> [PATCH v7 00/10] block: Fix resize (extending) of short overlays
>=20
> After reviewing Kevin's work, I questioned if we had a redundancy with
> bdrv_has_zero_init_truncate.  It turns out we do, and this is the result.
>=20
> Patch 1 has been previously posted [1] and reviewed, the rest is new.
> I did not address Neils' comment that modern gluster also always
> 0-initializes [2], as I am not set up to verify it (my changes to the
> other drivers are semantic no-ops, so I don't feel as bad about
> posting them with less rigourous testing).
>=20
> [1] https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg08070.html
> [2] https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg04266.html

block/parallels.c: In function 'parallels_co_writev':
block/parallels.c:218:12: error: 'ret' may be used uninitialized in this fu=
nction [-Werror=3Dmaybe-uninitialized]
  218 |         if (ret < 0) {
      |            ^
block/parallels.c:169:9: note: 'ret' was declared here
  169 |     int ret;
      |         ^~~
cc1: all warnings being treated as errors

Apart from that, you can add:

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


