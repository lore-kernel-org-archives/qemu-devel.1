Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBEFC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:45:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A505620720
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T835L+aQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A505620720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY5wK-0004ab-OZ
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 06:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jY5vb-0003ns-Gd
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:44:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46013
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jY5va-0008Gt-S2
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589193894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=35YmauD/BBm1tepF7T9THdx5MtF07eXSwwbbA8QgD58=;
 b=T835L+aQVbLskzXnXoCKAoMNpYhbn8AenPTfWbAiNTQemzpHBOATstfhlXSjeqZc9gd2ug
 Cb2sg6kybDQF/Od1u5iY+zdnO1NuwQT2ZxQkZwNLmCBLKfGqyPuWZPw//K/Xl/6wyHauxy
 J+XnKSf+d58vTGEZtEe3RFn2yguOEyA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-AamzL-fcM6yTA2yEQupXpw-1; Mon, 11 May 2020 06:44:50 -0400
X-MC-Unique: AamzL-fcM6yTA2yEQupXpw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEB1910082EA;
 Mon, 11 May 2020 10:44:46 +0000 (UTC)
Received: from gondolin (ovpn-112-254.ams2.redhat.com [10.36.112.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E7A1B5D9DA;
 Mon, 11 May 2020 10:44:37 +0000 (UTC)
Date: Mon, 11 May 2020 12:44:35 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Subject: Re: [PATCH 07/11] target/s390x/helper: Clean ifdef'ry
Message-ID: <20200511124435.7b9b2f23.cohuck@redhat.com>
In-Reply-To: <20200509130910.26335-8-f4bug@amsat.org>
References: <20200509130910.26335-1-f4bug@amsat.org>
 <20200509130910.26335-8-f4bug@amsat.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 00:05:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Stafford Horne <shorne@gmail.com>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 Laurent Vivier <laurent@vivier.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat,  9 May 2020 15:09:06 +0200
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> All this code is guarded checking CONFIG_USER_ONLY definition.
> Drop the duplicated checks.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Suspicious ifdef'ry in s390_handle_wait() from commit 83f7f32901c.
> ---
>  target/s390x/helper.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> index 09f60406aa..26e3b366e8 100644
> --- a/target/s390x/helper.c
> +++ b/target/s390x/helper.c
> @@ -33,6 +33,7 @@
>  #endif
> =20
>  #ifndef CONFIG_USER_ONLY
> +

I'd probably not have added the whitespace here...

>  void s390x_tod_timer(void *opaque)
>  {
>      cpu_inject_clock_comparator((S390CPU *) opaque);

(...)

> @@ -328,6 +324,7 @@ int s390_store_adtl_status(S390CPU *cpu, hwaddr addr,=
 hwaddr len)
>      cpu_physical_memory_unmap(sa, len, 1, len);
>      return 0;
>  }
> +

...and here, but I don't feel strongly about it.

>  #endif /* CONFIG_USER_ONLY */
> =20
>  void s390_cpu_dump_state(CPUState *cs, FILE *f, int flags)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


