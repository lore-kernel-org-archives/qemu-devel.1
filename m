Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD153C35280
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 22:02:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8649220725
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 22:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IHziE/OE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8649220725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWobP-0001YP-Oe
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 18:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWoaN-0000VR-U4
 for qemu-devel@nongnu.org; Thu, 07 May 2020 18:01:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36897
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWoaN-0006SG-6Z
 for qemu-devel@nongnu.org; Thu, 07 May 2020 18:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588888902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SCNh4zNLMNVaFfynRGLRmrU7w0TS4VnQShEMilshfSE=;
 b=IHziE/OESBVRU4WDfioNdoVebKgH718TxsuhBpJH33EEpNXhzoon8bpShA1wWYW9yBZrgC
 WWWjsunERum/tHdEKvmnWijM2p0CldcR9pnLJtHWdtwvo67P+dipGzY2p/Ff8Yeow5aH2s
 ZbQl3HaSZWB9WnF0ny9nHaaN1xRRfbw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-r02m9KanNBmyawz1oDrQdQ-1; Thu, 07 May 2020 18:01:37 -0400
X-MC-Unique: r02m9KanNBmyawz1oDrQdQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35C47107ACCD;
 Thu,  7 May 2020 22:01:36 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 406651001B07;
 Thu,  7 May 2020 22:01:33 +0000 (UTC)
Subject: Re: [PATCH v2] Fix parameter type in vhost migration log path
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>, mst@redhat.com
References: <CAFubqFtqNZw=Y-ar3N=3zTQi6LkKg_G-7W7OOHHbE7Y1fV7HAQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <cd284109-eb68-24aa-5a9a-19a39b5d4eb3@redhat.com>
Date: Thu, 7 May 2020 17:01:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFubqFtqNZw=Y-ar3N=3zTQi6LkKg_G-7W7OOHHbE7Y1fV7HAQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 00:55:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/20 4:37 PM, Raphael Norwitz wrote:
> The =E2=80=98enable=E2=80=99 parameter to the vhost_migraion_log() functi=
on is given as

typo: migration

Presumably, the maintainer can fix this rather than needing you to send=20
a v3...

> an int, but "true"/"false" values are passed in wherever it is invoked.
> Inside the function itself it is only ever compared with bool values.
> Therefore the parameter value itself should be changed to bool.
>=20
> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> ---
>   hw/virtio/vhost.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


