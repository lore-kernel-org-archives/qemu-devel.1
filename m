Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EE1C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 07:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83226204FD
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 07:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RdngKrdk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83226204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5OPJ-0004Gc-NX
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 03:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k5OOl-0003pu-Ci
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 03:08:39 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60559
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k5OOi-0000gt-Bh
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 03:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597129715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3rK5k/nMHNfI02o0ouYNTapYr3ibZKViZZTMAEA021w=;
 b=RdngKrdkCjc+VamF+rzTXswiDSapEREFezzpsOZsTSaahByeW9McC1RNVuB+sK2dRXTQzU
 BILKx3ED7PcD37aPr7EcHQJZyqE9Lfs3Hq2YUzTQZmf7X8y2HJ0+veK4ay3RdGyvZxM90l
 Ay1RO+eK1Ygrvh5Ls3iuns7CbY7x45s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-5t7IPn-JOg6LSc7TD_Esjw-1; Tue, 11 Aug 2020 03:08:33 -0400
X-MC-Unique: 5t7IPn-JOg6LSc7TD_Esjw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5306100CCC1;
 Tue, 11 Aug 2020 07:08:31 +0000 (UTC)
Received: from gondolin (ovpn-113-33.ams2.redhat.com [10.36.113.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0DF166F123;
 Tue, 11 Aug 2020 07:08:30 +0000 (UTC)
Date: Tue, 11 Aug 2020 09:08:28 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2] CODING_STYLE.rst: flesh out our naming conventions.
Message-ID: <20200811090828.12307821.cohuck@redhat.com>
In-Reply-To: <20200810105147.10670-1-alex.bennee@linaro.org>
References: <20200810105147.10670-1-alex.bennee@linaro.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 03:08:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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

On Mon, 10 Aug 2020 11:51:47 +0100
Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:

> Mention a few of the more common naming conventions we follow in the
> code base including common variable names and function prefix and
> suffix examples.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20
> ---
> v2
>   - punctuation fixes suggested by Cornelia
>   - re-worded section on qemu_ prefix
>   - expanded on _locked suffix
> ---
>  CODING_STYLE.rst | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
>=20
> diff --git a/CODING_STYLE.rst b/CODING_STYLE.rst
> index 427699e0e42..e7ae44aed7f 100644
> --- a/CODING_STYLE.rst
> +++ b/CODING_STYLE.rst
> @@ -109,8 +109,34 @@ names are lower_case_with_underscores_ending_with_a_=
t, like the POSIX
>  uint64_t and family.  Note that this last convention contradicts POSIX
>  and is therefore likely to be changed.
> =20
> -When wrapping standard library functions, use the prefix ``qemu_`` to al=
ert
> -readers that they are seeing a wrapped version; otherwise avoid this pre=
fix.
> +Variable Naming Conventions
> +---------------------------
> +
> +A number of short naming conventions exist for variables that use
> +common QEMU types. For example, the architecture independent CPUState
> +this is often held as a ``cs`` pointer variable, whereas the concrete

s/this//

> +CPUArchState us usually held in a pointer called ``env``.

s/us/is/

> +
> +Likewise, in device emulation code the common DeviceState is usually
> +called ``dev`` with the actual status structure often uses the terse

s/with/while/

> +``s`` or maybe ``foodev``.
> +
> +Function Naming Conventions
> +---------------------------
> +
> +The ``qemu_`` prefix is used for utility functions that are widely
> +called from across the code-base. This includes wrapped versions of
> +standard library functions (e.g. qemu_strtol) where the prefix is
> +added to the function name to alert readers that they are seeing a
> +wrapped version; otherwise avoid this prefix.

Hm... not so sure about "otherwise avoid this prefix". It sounds a bit
like you should avoid it for anything but wrappers, but I think what we
want to say is that qemu_ should be used for anything that is
potentially useful in many places, but probably not if there is a
better prefix?

> +
> +If there are two versions of a function to be called with or without a
> +lock held, the function that expects the lock to be already held
> +usually uses the suffix ``_locked``.
> +
> +Public functions (i.e. declared in public headers) tend to be prefixed
> +with the subsystem or file they came from. For example, ``tlb_`` for
> +functions from ``cputlb.c`` or ``cpu_`` for functions from cpus.c.
> =20
>  Block structure
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


