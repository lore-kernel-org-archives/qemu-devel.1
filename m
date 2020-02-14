Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9910FC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:48:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6654F2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ox33x7Wl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6654F2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2dCU-0006EU-Ii
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 10:48:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2dAo-0004A5-QX
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:46:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2dAn-0005wl-6R
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:46:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25025
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2dAn-0005td-13
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:46:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581695191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JcToj2X1V84uSNMRggFk/PHi5rcNmwxh1m1M+sOr2SE=;
 b=Ox33x7WlW2E21xkXYARMwwTI7Jsw3wvmT9wruJgZF2pZLBRiWjMB5XkngonByHgvk4YO8M
 qcMF8t4bM/0dmonkVRodBPWadsh5wBkHzmm6r2bdJqkba/HY1nP4ByRRdphCrwslwPiE14
 48GaQRA21Ts6sUtw4vEWg7Y/Rbj//0Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-QjeVIYWdO4uqpfFcM9G0Pg-1; Fri, 14 Feb 2020 10:46:30 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F0DDDB6D;
 Fri, 14 Feb 2020 15:46:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A2EE84780;
 Fri, 14 Feb 2020 15:46:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BCB9811385C9; Fri, 14 Feb 2020 16:46:24 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 15/30] qapi/{block, misc, tmp,
 net}.json: Use explicit bulleted lists
References: <20200213175647.17628-1-peter.maydell@linaro.org>
 <20200213175647.17628-16-peter.maydell@linaro.org>
 <87wo8ptfh9.fsf@dusky.pond.sub.org>
 <CAFEAcA8fGvMk1mdOwrpYiYCiz-1vRUi6KOJkvHyLwoCpPNfLhQ@mail.gmail.com>
Date: Fri, 14 Feb 2020 16:46:24 +0100
In-Reply-To: <CAFEAcA8fGvMk1mdOwrpYiYCiz-1vRUi6KOJkvHyLwoCpPNfLhQ@mail.gmail.com>
 (Peter Maydell's message of "Fri, 14 Feb 2020 14:28:37 +0000")
Message-ID: <871rqxrx2n.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: QjeVIYWdO4uqpfFcM9G0Pg-1
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
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 14 Feb 2020 at 14:23, Markus Armbruster <armbru@redhat.com> wrote=
:
>> What's the rationale for the split between
>>
>>     [PATCH v2 13/30] qapi/block-core.json: Use explicit bulleted lists
>>     [PATCH v2 14/30] qapi/ui.json: Use explicit bulleted lists
>>     [PATCH v2 15/30] qapi/{block, misc, tmp, net}.json: Use explicit bul=
leted lists
>>
>> ?
>
> Just keeping down the size of individual patches for ease of
> review. ui.json and block-core.json both had enough uses that
> needed fixing to feel like reasonably patch-sized amounts. This
> patch is all the straggler files, none of which had numerous
> enough changes to seem worth splitting further.

I see.

Separating block.json and block-core.json is a bit odd.

Mind if I squash all three?


