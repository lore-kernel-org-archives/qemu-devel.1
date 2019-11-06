Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00928C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:47:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF4EE2084D
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DjW3Nsm+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF4EE2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSNWd-0007LO-7m
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 10:47:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48823)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iSNUR-0005oA-Fj
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:45:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iSNUQ-0008I4-Dq
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:44:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53345
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iSNUQ-0008Hm-Ay
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:44:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573055097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yggV/leei0n7EP+uWawudsk97Br7qWLyJj9HZS7egXs=;
 b=DjW3Nsm+KhLaaUBsWPv1y8rO0mfRynkOHkroIlimGwJlMpuZWDgpBas2DCxmM5qcOq08R5
 WUa5F2XXIqmJi3lM2RSTkmmRGG9zkRpoxwqf6g6WWNYSPZAHi6V8YlnegzoXwBz35TBz6I
 JDPdgW6sPtFbVePNfrCfCJh+0leYIv4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-swN5EDQ9NXGLe208RZUgig-1; Wed, 06 Nov 2019 10:44:54 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0EC5477;
 Wed,  6 Nov 2019 15:44:53 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B980C5D9E1;
 Wed,  6 Nov 2019 15:44:52 +0000 (UTC)
Message-ID: <f3822494defad291fa70000487c339f3f73317ca.camel@redhat.com>
Subject: Re: [PATCH v2 03/21] iotests: Add _filter_json_filename
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Wed, 06 Nov 2019 17:44:51 +0200
In-Reply-To: <20191015142729.18123-4-mreitz@redhat.com>
References: <20191015142729.18123-1-mreitz@redhat.com>
 <20191015142729.18123-4-mreitz@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: swN5EDQ9NXGLe208RZUgig-1
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

On Tue, 2019-10-15 at 16:27 +0200, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/common.filter | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common=
.filter
> index 9f418b4881..63bc6f6f26 100644
> --- a/tests/qemu-iotests/common.filter
> +++ b/tests/qemu-iotests/common.filter
> @@ -227,5 +227,29 @@ _filter_qmp_empty_return()
>      grep -v '{"return": {}}'
>  }
> =20
> +_filter_json_filename()
> +{
> +    $PYTHON -c 'import sys
> +result, *fnames =3D sys.stdin.read().split("json:{")

Very minor nitpick, maybe I would give 'fnames' a more generic name,
since its is just result of a split, thus not really a list of filenames.
Feel free to ignore that though.

> +depth =3D 0
> +for fname in fnames:
> +    depth +=3D 1 # For the opening brace in the split separator
> +    for chr_i, chr in enumerate(fname):
> +        if chr =3D=3D "{":
> +            depth +=3D 1
> +        elif chr =3D=3D "}":
> +            depth -=3D 1
> +            if depth =3D=3D 0:
> +                break
> +
> +    # json:{} filenames may be nested; filter out everything from
> +    # inside the outermost one
> +    if depth =3D=3D 0:
> +        chr_i +=3D 1 # First character past the filename
> +        result +=3D "json:{ /* filtered */ }" + fname[chr_i:]
> +
> +sys.stdout.write(result)'
> +}
> +
>  # make sure this script returns success
>  true

I must admit that I haven't run tested it, but it looks like it should work=
.
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
=09Maxim Levitsky



