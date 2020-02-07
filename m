Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBC9C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 08:27:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 025E120726
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 08:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WOPm/+0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025E120726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izyzA-00035c-6t
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 03:27:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1izyyU-0002Y8-0L
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 03:26:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1izyyT-00015V-0Z
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 03:26:53 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47658
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1izyyS-00013i-Sa
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 03:26:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581064012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uwyqtmyEhZCV+SovDAOUhUZzsaUHNv+ozZ7l+V/puMY=;
 b=WOPm/+0QZRaSeg0aDeE+OGRZHw7e7Jx7ERzDnk2tRCxwOz0s8YWuczRWFDuFxx7MHd/b/1
 ZMLC6k7qKX49hY7UucAQDeVCVBKis6N+VHFWE1Vw+Va4fv1doovf2qofnGk5dOw5r1Ktpe
 1IWLBJ12VQnLstjz837iM1SxHNWp++M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-Vc0G0U-BMIGHRjxXbtnJ0Q-1; Fri, 07 Feb 2020 03:26:50 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4109DB22;
 Fri,  7 Feb 2020 08:26:49 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8AE757FB60;
 Fri,  7 Feb 2020 08:26:45 +0000 (UTC)
Date: Fri, 7 Feb 2020 09:26:43 +0100
From: Andrew Jones <drjones@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2] docs/arm-cpu-features: Make kvm-no-adjvtime comment
 clearer
Message-ID: <20200207082643.m7pkyjbx5h2o4zh7@kamzik.brq.redhat.com>
References: <20200206225148.23923-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200206225148.23923-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Vc0G0U-BMIGHRjxXbtnJ0Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 06, 2020 at 11:51:48PM +0100, Philippe Mathieu-Daud=E9 wrote:
> The bold text sounds like 'knock knock'. Only bolding the

Who's there?

> second 'not' makes it easier to read.
>=20
> Fixes: dea101a1ae
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
> v2: Removed unrelated hunk
> ---
>  docs/arm-cpu-features.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/docs/arm-cpu-features.rst b/docs/arm-cpu-features.rst
> index dbf3b7cf42..fc1623aeca 100644
> --- a/docs/arm-cpu-features.rst
> +++ b/docs/arm-cpu-features.rst
> @@ -185,7 +185,7 @@ the list of KVM VCPU features and their descriptions.
> =20
>    kvm-no-adjvtime          By default kvm-no-adjvtime is disabled.  This
>                             means that by default the virtual time
> -                           adjustment is enabled (vtime is *not not*
> +                           adjustment is enabled (vtime is not *not*
>                             adjusted).
> =20
>                             When virtual time adjustment is enabled each
> --=20
> 2.21.1
>=20
>

Not-Not-Reviewed-by: Andrew Jones <drjones@redhat.com>


