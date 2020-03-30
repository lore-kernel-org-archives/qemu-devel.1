Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F945C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 14:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEB992072E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 14:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z2gRJGs0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB992072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIvgJ-0006r8-4L
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 10:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60235)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jIvfd-0006S6-Fv
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 10:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jIvfc-0000DT-AD
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 10:45:45 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:58165)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jIvfc-0000CX-56
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 10:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585579543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IbeZ0iHfQTg4kLIlCP7xnBVPfhKnlfPxAaWFj4ncNrw=;
 b=Z2gRJGs0PgaaKDkYrBk7PK87aIjiVpCA3NtafYau/RW922DIHOyrnQIDuwMI1dKptdLE5H
 pW87h8rAd2JWsbvJkD5yDu6/jFxUOVTpm1wNaDru4zh4Os9ZW+l06m6yRUWiEbdtUhh5Wl
 q5sk/7ERCrUFc+lbz8p9Ncrl7SCe52Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-MXYjG4DBM8iHp4vG8IHx4w-1; Mon, 30 Mar 2020 10:45:29 -0400
X-MC-Unique: MXYjG4DBM8iHp4vG8IHx4w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3E68801E7B;
 Mon, 30 Mar 2020 14:45:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A321419925;
 Mon, 30 Mar 2020 14:45:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1B68611385E2; Mon, 30 Mar 2020 16:45:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v9 05/14] iotests: add pylintrc file
References: <20200324232103.4195-1-jsnow@redhat.com>
 <20200324232103.4195-6-jsnow@redhat.com>
Date: Mon, 30 Mar 2020 16:45:27 +0200
In-Reply-To: <20200324232103.4195-6-jsnow@redhat.com> (John Snow's message of
 "Tue, 24 Mar 2020 19:20:54 -0400")
Message-ID: <874ku5vr3s.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> This allows others to get repeatable results with pylint. If you run
> `pylint iotests.py`, you should see a 100% pass.

Nice.

>
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/pylintrc | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 tests/qemu-iotests/pylintrc
>
> diff --git a/tests/qemu-iotests/pylintrc b/tests/qemu-iotests/pylintrc
> new file mode 100644
> index 0000000000..8720b6a0de
> --- /dev/null
> +++ b/tests/qemu-iotests/pylintrc
> @@ -0,0 +1,22 @@
> +[MESSAGES CONTROL]
> +
> +# Disable the message, report, category or checker with the given id(s).=
 You
> +# can either give multiple identifiers separated by comma (,) or put thi=
s
> +# option multiple times (only on the command line, not in the configurat=
ion
> +# file where it should appear only once). You can also use "--disable=3D=
all" to
> +# disable everything first and then reenable specific checks. For exampl=
e, if
> +# you want to run only the similarities checker, you can use "--disable=
=3Dall
> +# --enable=3Dsimilarities". If you want to run only the classes checker,=
 but have
> +# no Warning level messages displayed, use "--disable=3Dall --enable=3Dc=
lasses
> +# --disable=3DW".
> +disable=3Dinvalid-name,
> +        no-else-return,
> +        too-many-lines,
> +        too-few-public-methods,
> +        too-many-arguments,
> +        too-many-locals,
> +        too-many-branches,
> +        too-many-public-methods,

Keep sorted?

> +        # These are temporary, and should be removed:
> +        missing-docstring,
> +        line-too-long,

For what it's worth, I also disable these for checking QAPI code, except
for no-else-return.  My true reason for keeping no-else-return is of
course that I agree with pylint these elses are ugly.  But I pretend to
simply go with the flow ;)


