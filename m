Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91ED6C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 13:04:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58A0020724
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 13:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zl4TFo3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A0020724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEYMj-0003BZ-Fh
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 09:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1jEYLj-0002KJ-Fi
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 09:03:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1jEYLe-0007QQ-Ev
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 09:03:07 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:47439)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1jEYLe-0007PD-Ad
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 09:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584536581;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+LKqOv+TLLunOvptQM/mEAkFG0GNOS+iJLaiL+Wlspw=;
 b=Zl4TFo3sXAj+XKZJFgyBwg8StGqmO7uju1EMhqV8NH0HYJpjCI8mbQlhlIM/irrtfnAq5l
 1lspWsO5MOW3yhw3QfKACI2dkmpTNbobCWxVt/8MZ8YmAJiZ6rbEWfRWGNx55OfVAW2qIR
 QJ5V9QzLWo8M+4BklDBc5N5eT3Xo0Tc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-zGiDA1K3Ox--DvYdx3bpFA-1; Wed, 18 Mar 2020 09:03:00 -0400
X-MC-Unique: zGiDA1K3Ox--DvYdx3bpFA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6A6E100DFDA;
 Wed, 18 Mar 2020 13:02:58 +0000 (UTC)
Received: from redhat.com (ovpn-114-9.ams2.redhat.com [10.36.114.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F400F91296;
 Wed, 18 Mar 2020 13:02:41 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH v5 6/7] vmstate.h: provide VMSTATE_VARRAY_UINT16_ALLOC
 macro
In-Reply-To: <20200318091525.27044-7-yuri.benditovich@daynix.com> (Yuri
 Benditovich's message of "Wed, 18 Mar 2020 11:15:24 +0200")
References: <20200318091525.27044-1-yuri.benditovich@daynix.com>
 <20200318091525.27044-7-yuri.benditovich@daynix.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Wed, 18 Mar 2020 14:02:37 +0100
Message-ID: <87d099g6j6.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Reply-To: quintela@redhat.com
Cc: yan@daynix.com, jasowang@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yuri Benditovich <yuri.benditovich@daynix.com> wrote:
> Similar to VMSTATE_VARRAY_UINT32_ALLOC, but the size is
> 16-bit field.
>
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Same caveat about attribution to MST.

Once told tha, I don't understand why you are using a unit16_t.
You define indirections_len as:

+    uint16_t indirections_len;

But its maximum value right now is:

+#define VIRTIO_NET_RSS_MAX_TABLE_LEN    128

So, are we planning to increase that value in the next future, or we
just want to give enough space?

Later, Juan.


