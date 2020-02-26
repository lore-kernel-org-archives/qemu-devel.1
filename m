Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FD9C4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:49:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B1D320838
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iqfZ8DVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B1D320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6vBa-0000An-Ft
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 06:49:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j6v8Y-0005fB-Cs
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:45:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j6v8X-0000nV-Cg
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:45:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28793
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j6v8X-0000lD-85
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:45:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582717556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+k1dK9gZ4+/WnOqUKKCaapt39SXPuxF9WCiS7emUTpg=;
 b=iqfZ8DVwvDDYjRu4/TZm2rechQbOoPlCmTjWf3HQKW6b8cWS0N8Yj2+uJC5mhuQG1TiL1i
 jrOsAJya2Eup3mmSWaGEDafjVIWymPH7nRcAyK0wNMJMhxFtjkw+QWRdxMlQHrpPgXo70a
 YXhTgRDKvqMNpnXR6qs5guKBjfmEJQM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-blbUS37SN9OQIznuEIa6jw-1; Wed, 26 Feb 2020 06:45:52 -0500
X-MC-Unique: blbUS37SN9OQIznuEIa6jw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDD6A13E2;
 Wed, 26 Feb 2020 11:45:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CD635DA60;
 Wed, 26 Feb 2020 11:45:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A48B411386A6; Wed, 26 Feb 2020 12:45:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 00/12] Convert QAPI doc comments to generate rST
 instead of texinfo
References: <20200225140437.20609-1-peter.maydell@linaro.org>
Date: Wed, 26 Feb 2020 12:45:47 +0100
In-Reply-To: <20200225140437.20609-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Tue, 25 Feb 2020 14:04:25 +0000")
Message-ID: <87imjt607o.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

> This series switches all our QAPI doc comments over from
> texinfo format to rST.
>
> I've pushed out a v3 because a lot of v2 is now in master and
> it seems like it might be easier (and less intimidating :-))
> to review a patchset that's only got the remaining work and
> which is based on current master.

Appreciated!

> Changes v2->v3:
>  * all the "preliminary tidy up of existing doc comment" patches
>    are now in master -- thanks!
>  * rebased on current master (there were some minor conflicts with
>    the just-committed creation of the tools manual)
>
> We have 3 weeks left til softfreeze, so I'm still hopeful we
> can land this in this release cycle, though I suppose it would
> not be a disaster if it landed in the next. (I'm guessing we
> will not complete conversion of the other bits of Texinfo to
> rST this cycle, anyway.)

I'll try to review in time.  Plenty of competition, so no promises.

[...]


