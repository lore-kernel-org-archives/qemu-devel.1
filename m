Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CD4C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:43:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1016A21924
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RoSZYInx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1016A21924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT6Pa-0007FB-Pp
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 10:42:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53012)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iT6Mh-0004Im-CZ
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:40:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iT6Mf-00080M-Sb
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:39:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59214
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iT6Mf-000805-Pi
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:39:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573227596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kLlpMqWVrIqZ4jO/uoj4lEr4tH6hdS3E/A1bSwnJT4o=;
 b=RoSZYInxPfN6XcpTTWvYv+WwmvkTkcYYlCtt3Fuwm3i+s/U4YmDWAp4JR7PVTeQcRQCkww
 0M3VrMutxbnJ+sg3Ju1qc9fxInvIcL9hCNGGpzd2Gx+KMhi/awt8T8WCdpgDDdypQceb5J
 0K+AurlMUhrKzhkPQBqgkSTJnAHOH9Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-q_nrS10TNKOGf3l684LODA-1; Fri, 08 Nov 2019 10:39:52 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B16961005500;
 Fri,  8 Nov 2019 15:39:51 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 81FE33CC6;
 Fri,  8 Nov 2019 15:39:50 +0000 (UTC)
Message-ID: <e25b1fb30d4ac01f37677e40c53b03f7e9f0579e.camel@redhat.com>
Subject: Re: [PATCH v3 01/22] iotests: s/qocw2/qcow2/
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Fri, 08 Nov 2019 17:39:49 +0200
In-Reply-To: <20191107163708.833192-2-mreitz@redhat.com>
References: <20191107163708.833192-1-mreitz@redhat.com>
 <20191107163708.833192-2-mreitz@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: q_nrS10TNKOGf3l684LODA-1
X-Mimecast-Spam-Score: 0
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2019-11-07 at 17:36 +0100, Max Reitz wrote:
> Probably due to blind copy-pasting, we have several instances of "qocw2"
> in our iotests.  Fix them.
>=20
> Reported-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/060 | 2 +-
>  tests/qemu-iotests/061 | 2 +-
>  tests/qemu-iotests/062 | 2 +-
>  tests/qemu-iotests/066 | 2 +-
>  tests/qemu-iotests/068 | 2 +-
>  tests/qemu-iotests/108 | 2 +-
>  tests/qemu-iotests/138 | 2 +-
>  tests/qemu-iotests/261 | 2 +-
>  8 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
> index b91d8321bb..725e58a5a5 100755
> --- a/tests/qemu-iotests/060
> +++ b/tests/qemu-iotests/060
> @@ -44,7 +44,7 @@ _filter_io_error()
>  . ./common.rc
>  . ./common.filter
> =20
> -# This tests qocw2-specific low-level functionality
> +# This tests qcow2-specific low-level functionality
>  _supported_fmt qcow2
>  _supported_proto file
>  _supported_os Linux
> diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
> index 4eac5b83bd..e1b8044630 100755
> --- a/tests/qemu-iotests/061
> +++ b/tests/qemu-iotests/061
> @@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  . ./common.rc
>  . ./common.filter
> =20
> -# This tests qocw2-specific low-level functionality
> +# This tests qcow2-specific low-level functionality
>  _supported_fmt qcow2
>  _supported_proto file
>  _supported_os Linux
> diff --git a/tests/qemu-iotests/062 b/tests/qemu-iotests/062
> index d5f818fcce..79738b1c26 100755
> --- a/tests/qemu-iotests/062
> +++ b/tests/qemu-iotests/062
> @@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  . ./common.rc
>  . ./common.filter
> =20
> -# This tests qocw2-specific low-level functionality
> +# This tests qcow2-specific low-level functionality
>  _supported_fmt qcow2
>  _supported_proto generic
> =20
> diff --git a/tests/qemu-iotests/066 b/tests/qemu-iotests/066
> index 28f8c98412..cacbdb6ae0 100755
> --- a/tests/qemu-iotests/066
> +++ b/tests/qemu-iotests/066
> @@ -36,7 +36,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  . ./common.rc
>  . ./common.filter
> =20
> -# This tests qocw2-specific low-level functionality
> +# This tests qcow2-specific low-level functionality
>  _supported_fmt qcow2
>  _supported_proto generic
> =20
> diff --git a/tests/qemu-iotests/068 b/tests/qemu-iotests/068
> index 22f5ca3ba6..c164ccc64a 100755
> --- a/tests/qemu-iotests/068
> +++ b/tests/qemu-iotests/068
> @@ -36,7 +36,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  . ./common.rc
>  . ./common.filter
> =20
> -# This tests qocw2-specific low-level functionality
> +# This tests qcow2-specific low-level functionality
>  _supported_fmt qcow2
>  _supported_proto generic
> =20
> diff --git a/tests/qemu-iotests/108 b/tests/qemu-iotests/108
> index 9c08172237..872a9afec9 100755
> --- a/tests/qemu-iotests/108
> +++ b/tests/qemu-iotests/108
> @@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  . ./common.rc
>  . ./common.filter
> =20
> -# This tests qocw2-specific low-level functionality
> +# This tests qcow2-specific low-level functionality
>  _supported_fmt qcow2
>  _supported_proto file
>  _supported_os Linux
> diff --git a/tests/qemu-iotests/138 b/tests/qemu-iotests/138
> index 6a731370db..8b2f587af0 100755
> --- a/tests/qemu-iotests/138
> +++ b/tests/qemu-iotests/138
> @@ -36,7 +36,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  . ./common.rc
>  . ./common.filter
> =20
> -# This tests qocw2-specific low-level functionality
> +# This tests qcow2-specific low-level functionality
>  _supported_fmt qcow2
>  _supported_proto file
>  _supported_os Linux
> diff --git a/tests/qemu-iotests/261 b/tests/qemu-iotests/261
> index fb96bcfbe2..9f2817251f 100755
> --- a/tests/qemu-iotests/261
> +++ b/tests/qemu-iotests/261
> @@ -40,7 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  . ./common.rc
>  . ./common.filter
> =20
> -# This tests qocw2-specific low-level functionality
> +# This tests qcow2-specific low-level functionality
>  _supported_fmt qcow2
>  _supported_proto file
>  _supported_os Linux


Thank you!
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
=09Maxim Levitsky



