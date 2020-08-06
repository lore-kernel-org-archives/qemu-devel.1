Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0707C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:31:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5CAF2312D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iYm4b4eY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5CAF2312D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3fz2-0002QO-RO
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 09:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k3fuw-0003V4-Dm
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 09:26:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43118)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k3fuu-0001fX-6y
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 09:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596720402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gATjTAJfUOKSkw0bPmIty9msJzfneBhk9VT91K4fysg=;
 b=iYm4b4eYQOMYXbBgwrnFNuQNTqBRcTDRX/w2NY3foaGsGZcGjgGm32kJ7Y6g9vQdaPEf1K
 cFTvws0W/9IHqSJlYbbcMTSme6h3B4/hl/ybYIqYAYoOCC8SbvtIEGyRM5mG68sOeYSWrB
 GpzW7Q3yB//BdNo68s5lCrQSbwoIwe8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-y-zFSA3QPxmf80CLKwYccw-1; Thu, 06 Aug 2020 09:26:38 -0400
X-MC-Unique: y-zFSA3QPxmf80CLKwYccw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E1B18064AB;
 Thu,  6 Aug 2020 13:26:37 +0000 (UTC)
Received: from gondolin (ovpn-113-2.ams2.redhat.com [10.36.113.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D78BC5F1EF;
 Thu,  6 Aug 2020 13:26:36 +0000 (UTC)
Date: Thu, 6 Aug 2020 15:26:34 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH] CODING_STYLE.rst: flesh out our naming conventions.
Message-ID: <20200806152634.54a0a0c2.cohuck@redhat.com>
In-Reply-To: <20200806114036.10646-1-alex.bennee@linaro.org>
References: <20200806114036.10646-1-alex.bennee@linaro.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 04:59:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  6 Aug 2020 12:40:36 +0100
Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:

> Mention a few of the more common naming conventions we follow in the
> code base including common variable names and function prefix and
> suffix examples.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  CODING_STYLE.rst | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/CODING_STYLE.rst b/CODING_STYLE.rst
> index 427699e0e42..17cb42ba761 100644
> --- a/CODING_STYLE.rst
> +++ b/CODING_STYLE.rst
> @@ -109,9 +109,32 @@ names are lower_case_with_underscores_ending_with_a_=
t, like the POSIX
>  uint64_t and family.  Note that this last convention contradicts POSIX
>  and is therefore likely to be changed.
> =20
> +Variable Naming Conventions
> +---------------------------
> +
> +A number of common short naming conventions exist for variables that use
> +common QEMU types. For example when dealing with the architecture

s/example/example,/

> +independent CPUState this is often in a ``cs`` pointer variable

"the architecture independent CPUState is often held in a ``cs``
pointer variable," ?

> +whereas the concrete CPUArchState us usually held in a pointer called
> +``env``.
> +
> +Likewise in device emulation code the common DeviceState is usually

s/Likewise/Likewise,/

> +called ``dev`` with the actual state structure often the very terse

"while the actual statue structure often uses..." ?

> +``s`` or maybe ``foodev``.
> +
> +Function Naming Conventions
> +---------------------------
> +
>  When wrapping standard library functions, use the prefix ``qemu_`` to al=
ert
>  readers that they are seeing a wrapped version; otherwise avoid this pre=
fix.
> =20
> +Functions that are expected to be called with some sort of lock held
> +usually have the suffix ``_locked``.

Hm, I think this is mostly for those cases where you have two versions?
What about:

"If there are two versions of a function to be called with or without a
lock held, the function that expects the lock to be already usually
uses the suffix ``_locked``."

> +
> +Public functions (i.e. declared in public headers) tend to be prefixes

s/prefixes/prefixed/

> +with the subsystem or file they came from. For example ``tlb_`` for

s/example/example,/

> +functions from ``cputlb.c`` or ``cpu_`` for functions from cpus.c.
> +
>  Block structure
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20


