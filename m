Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D64C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 19:24:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A52E020661
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 19:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ApxzKvEd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A52E020661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1EfC-0004Pd-MH
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 14:24:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60271)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1j1Edw-0003us-UQ
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 14:22:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1j1Edu-0000Gv-I1
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 14:22:51 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25105
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1j1Edu-0000FO-3M
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 14:22:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581362569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e3XDYnIwBr/zakQdTtvGafFGH6YB8ako/0eq9cf+U2I=;
 b=ApxzKvEd/21MJxyQmjvJcgjGiwszXKJIN9t5RuzhnM0N+ZG6wBACRGdMCFbn0nhgBx46aE
 cYrbSqpQ07NHV2tCcsY26M2rShlrAQv7wY2opMrT1BlnE2Sp7lfa+z5PmwNqF/4gXqpk9E
 WnJplgFwJ3C/Pru0cDxCQ0YjFU1hWhY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-0j4peY-uOXW1TFXbe3h8Fw-1; Mon, 10 Feb 2020 14:22:43 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1067B1413;
 Mon, 10 Feb 2020 19:22:42 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-102.gru2.redhat.com
 [10.97.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 67D7489F27;
 Mon, 10 Feb 2020 19:22:37 +0000 (UTC)
Subject: Re: [PATCH] MAINTAINERS: Add Philippe, Alex and Wainer to the
 Gitlab-CI section
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200210155115.9371-1-thuth@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <cd92e444-994c-924f-18b1-9736733d76ac@redhat.com>
Date: Mon, 10 Feb 2020 17:22:35 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200210155115.9371-1-thuth@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 0j4peY-uOXW1TFXbe3h8Fw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2/10/20 1:51 PM, Thomas Huth wrote:
> Initially, I was the only one who was using Gitlab while most developers
> had their git trees still on other systems, but that has changed nowadays=
.
> There is now much more interest in the Gitlab-CI today, so it would be
> good to have more than only one maintainer / reviewer for the gitlab-ci.y=
ml
> file. Alex, Wainer and Philippe kindly offered their help here, so let's
> add them to the corresponding section in the MAINTAINERS file now.
>
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Cc: Wainer Moschetta <wainersm@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 3 +++
>   1 file changed, 3 insertions(+)


Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>


>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e72b5e5f69..64ef7a1906 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2743,6 +2743,9 @@ W: https://cirrus-ci.com/github/qemu/qemu
>  =20
>   GitLab Continuous Integration
>   M: Thomas Huth <thuth@redhat.com>
> +M: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> +M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> +R: Wainer dos Santos Moschetta <wainersm@redhat.com>
>   S: Maintained
>   F: .gitlab-ci.yml
>  =20


