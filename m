Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D891C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 08:34:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 599A8206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 08:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bU5vUWoc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 599A8206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izcc6-0003jX-KE
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 03:34:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34055)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1izcbJ-0002rM-4k
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 03:33:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1izcbH-0002y0-MA
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 03:33:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38703
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1izcbH-0002xD-HD
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 03:33:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580978006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yhYeol3Vwi9Z2OFUE53T9KG1Z4jGFFOHq6qUN28RQu0=;
 b=bU5vUWocNzWuhfo+tVnn5AzCsWMPUz6C9OxCPtWdHO/+3ePgPTYQzBThawJiTYN9nVaIPy
 u0AXScq0ILsNprMwgILYK1UcJNnZJ8irFKxDkAr4DEWmggcEOgHzmC5AYkUiKzRE1JWrYl
 odRt2eurWLPuyJ4+CdO3xEMygdfDa/M=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-YZWx5gcoPdykSg5qqBD1uA-1; Thu, 06 Feb 2020 03:33:18 -0500
Received: by mail-qk1-f200.google.com with SMTP id p1so3103372qkh.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 00:33:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Cl/p/uGMpqEVY6EZoINt0sCD0EwIoWAJNOS0ejEJyIY=;
 b=ZBCkB9U41/NtPqB8GtrW87Omyi8Y6OiOjb444h1GlSx4azoZ+qV18worxkV/lK4HbM
 o7pErlU5TBQeX8vo/1NRwGY050VVVUMR8oaGinXc0avX1VBPyQ01KKDoRlH5FYgyS3Yu
 nI01CWY98pQ2sjDkbrQT6GjNI5jGvSmZVIapVwZyptjEocCXRSineippOyKm5LQlERzn
 iVagqoCOCTsYuOKjslqbztVOTadPSR+w51xco2oQAPwwj2USp/OhaO571uQRmV7WMpoj
 m66Xnu6erN0K65DL0FDRrZWPOWyQpPw3BqkBQNzH+ENhuWBJoqdfZNHzrjKXxkbMBCKI
 8Xvg==
X-Gm-Message-State: APjAAAUTH7yu6iwP8Z16SpEVa3h0tOEDG/PD7du8Xwuvm0L957dUTczQ
 Az8Yg9/0DKH7F5ZzhWeUFDTgF4H3O+adkvDQso3JHCL0tNH1o53sOqrAHjX8R9dNOO6wN1adlWS
 Gg0M2UB+K48vBtC4=
X-Received: by 2002:ad4:5304:: with SMTP id y4mr1386272qvr.56.1580977998294;
 Thu, 06 Feb 2020 00:33:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqwsuI565R13NCerG+BLP1C2VcnfVgPCVQhImobzU6ZqmJrVGAMFc+Zb1uqRtMv1/OPbRGHLCQ==
X-Received: by 2002:ad4:5304:: with SMTP id y4mr1386256qvr.56.1580977997968;
 Thu, 06 Feb 2020 00:33:17 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id v10sm1236783qtq.58.2020.02.06.00.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 00:33:17 -0800 (PST)
Date: Thu, 6 Feb 2020 03:33:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: Re: [PATCH v2 0/3] vhost-user: Lift Max Ram Slots Limitation
Message-ID: <20200206033248-mutt-send-email-mst@kernel.org>
References: <1579143426-18305-1-git-send-email-raphael.norwitz@nutanix.com>
MIME-Version: 1.0
In-Reply-To: <1579143426-18305-1-git-send-email-raphael.norwitz@nutanix.com>
X-MC-Unique: YZWx5gcoPdykSg5qqBD1uA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: raphael.s.norwitz@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 15, 2020 at 09:57:03PM -0500, Raphael Norwitz wrote:
> In QEMU today, a VM with a vhost-user device can hot add memory a
> maximum of 8 times. See these threads, among others:
>=20
> [1] https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg01046.html
>     https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg01236.html
>=20
> [2] https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg04656.html
>=20
> This series introduces a new protocol feature
> VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS which, when enabled, lifts the
> restriction on the maximum number RAM slots imposed by vhost-user.
>=20
> The patch consists of 3 changes:
> 1. Fixed assert in vhost_user_set_mem_table_postcopy:
>    This is a bug fix in the postcopy migration path
> 2. Refactor vhost_user_set_mem_table functions:
>    This is a non-functional change refractoring the
>    vhost_user_set_mem_table and vhost_user_set_mem_table_postcopy
>    functions such that the feature can be more cleanly added.
> 3. Lift max memory slots limit imposed by vhost-user:
>    This change introduces the new protocol feature
>    VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS.
>=20
> The implementation details are explained in more detail in the commit
> messages, but at a high level the new protocol feature works as follows:
> - If the VHOST_USER_PROTCOL_F_CONFIGURE_SLOTS feature is enabled, QEMU wi=
ll
>   send multiple VHOST_USER_ADD_MEM_REG and VHOST_USER_REM_MEM_REG
>   messages to map and unmap individual memory regions instead of one larg=
e
>   VHOST_USER_SET_MEM_TABLE message containing all memory regions.
> - The vhost-user struct maintains a =E2=80=99shadow state=E2=80=99 of mem=
ory regions
>   already sent to the guest. Each time vhost_user_set_mem_table is called=
,
>   the shadow state is compared with the new device state. A
>   VHOST_USER_REM_MEM_REG will be sent for each region in the shadow state
>   not in the device state. Then, a VHOST_USER_ADD_MEM_REG will be sent
>   for each region in the device state but not the shadow state. After
>   these messages have been sent, the shadow state will be updated to
>   reflect the new device state.
>=20
> The VHOST_USER_SET_MEM_TABLE message was not reused because as the number=
 of
> regions grows, the message becomes very large. In practice, such large
> messages caused problems (truncated messages) and in the past it seems th=
e
> community has opted for smaller fixed size messages where possible. VRING=
s,
> for example, are sent to the backend individually instead of in one massi=
ve
> message.
>=20
> Current Limitations:
> - postcopy migration is not supported when the
>   VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS has been negotiated.=20
> - VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS cannot be negotiated when
>   VHOST_USER_PROTOCOL_F_REPLY_ACK has also been negotiated.
>=20
> Both of these limitations are due to resource contraints. They are not
> imposed for technical reasons.
>=20
> Changes since V1:
>     * Kept the assert in vhost_user_set_mem_table_postcopy, but moved it
>       to prevent corruption
>     * Made QEMU send a single VHOST_USER_GET_MAX_MEMSLOTS message at
>       startup and cache the returned value so that QEMU does not need to
>       query the backend every time vhost_backend_memslots_limit is called=
.

I'm a bit confused about what happens on reconnect.
Can you clarify pls?


> Best,
> Raphael
>=20
> Raphael Norwitz (3):
>   Fixed assert in vhost_user_set_mem_table_postcopy
>   Refactor vhost_user_set_mem_table functions
>   Lift max memory slots limit imposed by vhost-user
>=20
>  docs/interop/vhost-user.rst |  43 +++++
>  hw/virtio/vhost-user.c      | 385 +++++++++++++++++++++++++++++++++-----=
------
>  2 files changed, 336 insertions(+), 92 deletions(-)
>=20
> --=20
> 1.8.3.1


