Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20889C54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 16:05:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB4CD2068F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 16:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="coRWtQIx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB4CD2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQvOg-00079k-Rn
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 12:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jQvNB-0005oV-6h
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:03:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jQvN9-0004Te-Hn
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:03:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32098
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jQvN8-0004Rc-Tr
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587485021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UNhZfMZLfUpkrSJ6F0fZJwxj64l3eDG3YGO1ZPSsYy0=;
 b=coRWtQIxdJZoMCFEDZPmggvlWbo3f7ju08NRglGYGzVBrVtpDXnZZ3j5RUQmrkDtKQziaa
 iGLt5FHMlPKgnCUfE1nQKxaEoxBHwEodF0Mr8xHhBHX3bAuE7KhCTCc/rN1CmxnhoZUxih
 1ac5IEkVWt7TJ0bf2GaQ/tPcAWxD2gk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-zhHIp4cCO7qgQswcXFrW0w-1; Tue, 21 Apr 2020 12:03:39 -0400
X-MC-Unique: zhHIp4cCO7qgQswcXFrW0w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93F78102C864;
 Tue, 21 Apr 2020 16:03:38 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-155.ams2.redhat.com [10.36.112.155])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E40BF5C1B2;
 Tue, 21 Apr 2020 16:03:36 +0000 (UTC)
Date: Tue, 21 Apr 2020 18:03:35 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v3 04/10] iotests/check: move QEMU_VXHS_PROG to common.rc
Message-ID: <20200421160335.GD22440@linux.fritz.box>
References: <20200421073601.28710-1-vsementsov@virtuozzo.com>
 <20200421073601.28710-5-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200421073601.28710-5-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 11:47:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 21.04.2020 um 09:35 hat Vladimir Sementsov-Ogievskiy geschrieben:
> QEMU_VXHS_PROG is used only in common.rc. So, move it to common.rc,
> simplifying a bit further conversion of check into python
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This feels inconsistent when every other QEMU_*_PROG stays in check. Is
QEMU_VXHS_PROG really so different?

Kevin


