Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F40C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:19:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 703A521D43
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRQjba8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 703A521D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL6YP-0002lf-Fo
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 11:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kL6TJ-0006iI-2d
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:14:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20195
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kL6TH-00047g-9f
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600874050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lp//MlN1enUeUskjK++BMA85X1mQ0E3pd9laN4qKL/U=;
 b=DRQjba8/iNUvX8TkTQHlfCrNitxA2zPzdGjGmE4vX7+z9c6Fb7XkL1Hs1KcSJwpoBTdQ+K
 w3lO+UsbcvoaKCpvPYGXKV0T9SSUjNIbXQVzvTMNn+7CmXZxjEwy3GZquxm0EDnde3SwEO
 XIRfT3S9A6Gl8oVrIdERIgEBghDfITg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-qaKehN7GOSOzrpIaOV6pTA-1; Wed, 23 Sep 2020 11:14:08 -0400
X-MC-Unique: qaKehN7GOSOzrpIaOV6pTA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBC24800597;
 Wed, 23 Sep 2020 15:14:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A2F519C4F;
 Wed, 23 Sep 2020 15:14:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 21CEE1132E9A; Wed, 23 Sep 2020 17:14:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 1/1] MAINTAINERS: Add Python library stanza
References: <20200922230505.4089701-1-jsnow@redhat.com>
 <20200922230505.4089701-2-jsnow@redhat.com>
Date: Wed, 23 Sep 2020 17:14:06 +0200
In-Reply-To: <20200922230505.4089701-2-jsnow@redhat.com> (John Snow's message
 of "Tue, 22 Sep 2020 19:05:05 -0400")
Message-ID: <87wo0k34qp.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 05:11:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, crosa@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> I'm proposing that I split the actual Python library off from the other
> miscellaneous python scripts we have and declare it maintained. Add
> myself as a maintainer of this folder, along with Cleber.
>
> v2: change python/* to python/, thanks Alex.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Acked-by: Cleber Rosa <crosa@redhat.com>
> Acked-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  MAINTAINERS | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3d17cad19a..c0222ee645 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2355,11 +2355,18 @@ S: Maintained
>  F: include/sysemu/cryptodev*.h
>  F: backends/cryptodev*.c
> =20
> +Python library
> +M: John Snow <jsnow@redhat.com>
> +M: Cleber Rosa <crosa@redhat.com>
> +R: Eduardo Habkost <ehabkost@redhat.com>
> +S: Maintained
> +F: python/
> +T: git https://gitlab.com/jsnow/qemu.git python
> +
>  Python scripts
>  M: Eduardo Habkost <ehabkost@redhat.com>
>  M: Cleber Rosa <crosa@redhat.com>
>  S: Odd fixes
> -F: python/qemu/*py
>  F: scripts/*.py
>  F: tests/*.py

Separate sections just so you can have the appropriate S:, or is there a
deeper logic behind the split?


