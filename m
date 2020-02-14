Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B589CC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 14:21:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EC89206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 14:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DLOHdbIg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC89206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2bqw-0006qC-Mg
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 09:21:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2bpj-0006GS-H6
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:20:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2bph-0002Vy-Vc
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:20:42 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59867
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2bph-0002V1-Rj
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:20:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581690040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4jrJPrLgKoaW3kX/K7OzUJOZPcPgPea0/KDWjN+8PlA=;
 b=DLOHdbIg3gklXM5YPQLxnDmJ/z9drP4RbroyF+Cz7oHMyqjs5JF3Zy0eHJSNBRVB+kKJMR
 DW6O174tq5qwQn9cflHzwP82+hU/wEbXoYjyhKrfKNGlrsZIaeml6F/ImlHMp2Qwn6hP6Y
 zW1I5Ryfc+sa6/JjvtLVdIoZ2ROt+NE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-MxPpURkbOJmKPSpNa3xm_g-1; Fri, 14 Feb 2020 09:20:38 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9812B8018A4;
 Fri, 14 Feb 2020 14:20:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B4B6A9008B;
 Fri, 14 Feb 2020 14:20:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3B70A11385C9; Fri, 14 Feb 2020 15:20:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 14/30] qapi/ui.json: Use explicit bulleted lists
References: <20200213175647.17628-1-peter.maydell@linaro.org>
 <20200213175647.17628-15-peter.maydell@linaro.org>
Date: Fri, 14 Feb 2020 15:20:33 +0100
In-Reply-To: <20200213175647.17628-15-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 13 Feb 2020 17:56:31 +0000")
Message-ID: <871rqxuu6m.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: MxPpURkbOJmKPSpNa3xm_g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
Cc: John Snow <jsnow@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> A JSON block comment like this:
>  Returns: nothing on success
>           If @node is not a valid block device, DeviceNotFound
>           If @name is not found, GenericError with an explanation
>
> renders like this:
>
>  Returns: nothing on success If node is not a valid block device,
>  DeviceNotFound If name is not found, GenericError with an explanation
>
> because whitespace is not significant.
>
> Use an actual bulleted list, so that the formatting is correct.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Markus Armbruster <armbru@redhat.com>


