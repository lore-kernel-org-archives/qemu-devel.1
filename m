Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23A0C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 13:03:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE1D3222C2
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 13:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMS5Y8NQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1D3222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2adI-0001kP-TC
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 08:03:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45037)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2acQ-0000wU-2O
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 08:02:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2acO-0008SJ-42
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 08:02:53 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22194
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2acN-0008Pi-VV
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 08:02:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581685371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3CUrqUmS1sGU8+TCNDtOaB2rMoHnl66A9tIiJixMhgQ=;
 b=JMS5Y8NQG+oeEcCwiKT6492tFp5E5uQutqzKk0WIqP25ahMp387ssFeFSWz/bUwkRN8x8H
 A4xYdlMw/rK8T3GlqtKa6vwa7DHadYtpGS3nIk0+JxxHrLYMAkg/6InqJud+4olfyx+wNt
 ICEnRv+xWtnVJwckaO+4sof41XSB8Io=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-qQvJmSzZMSmco4ThNXv6PA-1; Fri, 14 Feb 2020 08:02:47 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DA07101FC6B;
 Fri, 14 Feb 2020 13:02:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E74831001B2C;
 Fri, 14 Feb 2020 13:02:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 66CB811385C9; Fri, 14 Feb 2020 14:02:12 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 08/30] qapi: Use ':' after @argument in doc comments
References: <20200213175647.17628-1-peter.maydell@linaro.org>
 <20200213175647.17628-9-peter.maydell@linaro.org>
Date: Fri, 14 Feb 2020 14:02:12 +0100
In-Reply-To: <20200213175647.17628-9-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 13 Feb 2020 17:56:25 +0000")
Message-ID: <87h7ztwcdn.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: qQvJmSzZMSmco4ThNXv6PA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: John Snow <jsnow@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> Some qapi doc comments have forgotten the ':' after the
> @argument, like this:
>
> # @filename         Filename for the new image file
> # @size             Size of the virtual disk in bytes
>
> The result is that these are parsed as part of the body
> text and appear as a run-on line:
>   filename Filename for the new image file size Size of the virtual disk =
in bytes"
> followed by
>   filename: string
>     Not documented
>   size: int
>     Not documented
>
> in the 'Members' section.
>
> Correct the formatting.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

The title sounds like it's just a tweak, but it actually fixes bugs in
the generated documentation.  Suggest to change the title to

    qapi: Fix incorrect "Not documented" claims in QMP documentation

R-by stands regardless.


