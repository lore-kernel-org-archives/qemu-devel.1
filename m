Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C87C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:49:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EA0524653
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IePxPLdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA0524653
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itwib-0001Rs-94
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 11:49:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1itweY-0005Y0-HB
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:45:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1itweU-0005OK-S6
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:45:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55407
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1itweU-0005Nw-Ol
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:45:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579625118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UhoYieZ1CB710QG4EYP4qL/+hrUgwv/TvGef9XhMmo8=;
 b=IePxPLdX8sx2Gx6/eElpIBCQ9eR86JmxPIXouZLMU+v9hYuTf8aIbvq/t+WcoqqZcPwYJW
 Bjnev9SNAkBPy8aPNHrN9oRtZh4IeK1tqQGev+S9fzQlgpW5nLLqSIQpwyigeY1AZbBCuq
 d4kgvYojMmVIWUDFyhnMLInkIUnuU0Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-uGmz-fx1OUOjDm2QL80t4w-1; Tue, 21 Jan 2020 11:45:15 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56B8C107B27E;
 Tue, 21 Jan 2020 16:45:12 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 48FC460FC5;
 Tue, 21 Jan 2020 16:45:03 +0000 (UTC)
Date: Tue, 21 Jan 2020 17:45:01 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v2 05/10] target/s390x: Remove duplicated ifdef macro
Message-ID: <20200121174501.7b7a5401.cohuck@redhat.com>
In-Reply-To: <20200121110349.25842-6-philmd@redhat.com>
References: <20200121110349.25842-1-philmd@redhat.com>
 <20200121110349.25842-6-philmd@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: uGmz-fx1OUOjDm2QL80t4w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Like Xu <like.xu@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jan 2020 12:03:44 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Commit ae71ed8610 replaced the use of global max_cpus variable
> with a machine property, but introduced a unnecessary ifdef, as
> this block is already in the 'not CONFIG_USER_ONLY' branch part:
>=20
>    86 #if defined(CONFIG_USER_ONLY)
>    87
>   ...
>   106 #else /* !CONFIG_USER_ONLY */
>   107
>   ...
>   292 static void do_ext_interrupt(CPUS390XState *env)
>   293 {
>   ...
>   313 #ifndef CONFIG_USER_ONLY
>   314         MachineState *ms =3D MACHINE(qdev_get_machine());
>   315         unsigned int max_cpus =3D ms->smp.max_cpus;
>   316 #endif
>=20
> To ease code review, remove the duplicated preprocessor macro,
> and move the declarations at the beginning of the statement.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: New patch
> Cc: Like Xu <like.xu@linux.intel.com>
> ---
>  target/s390x/excp_helper.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

I case this goes via the misc tree:

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


