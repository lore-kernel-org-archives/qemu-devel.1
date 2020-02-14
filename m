Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C810C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 14:34:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 078B8206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 14:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EqUN3FN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078B8206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2c39-0006md-57
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 09:34:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2c2T-0006Kp-4G
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:33:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2c2R-0002Jy-VN
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:33:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30694
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2c2R-0002J2-Rf
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:33:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581690831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z9wdn20XU4/gBSitwtC0Wk0wu9/HfCtMImd824bvTJk=;
 b=EqUN3FN4sYNxRhlhwcv6sN5rAEGbcWrxAZbabWV6tw1oL0siqrIYAjbIWnxCTDoEHAMf1p
 7GBee61l5mW0y2Nyx/ur3fJIxT922EnZUjZytlJtouGsfHnUjigOd5VEf3COOAmORV2brW
 eqt1jW/a4P6Ti+lpmgjMvTx1PP9xZA4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-0-UfA-6DMLSVEOSTkJYrJg-1; Fri, 14 Feb 2020 09:33:47 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72ADC800D4E;
 Fri, 14 Feb 2020 14:33:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA94F60BE1;
 Fri, 14 Feb 2020 14:33:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5067F11385C9; Fri, 14 Feb 2020 15:33:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 06/30] qga/qapi-schema.json: minor format fixups for rST
References: <20200213175647.17628-1-peter.maydell@linaro.org>
 <20200213175647.17628-7-peter.maydell@linaro.org>
 <87tv3twd39.fsf@dusky.pond.sub.org>
Date: Fri, 14 Feb 2020 15:33:42 +0100
In-Reply-To: <87tv3twd39.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Fri, 14 Feb 2020 13:46:50 +0100")
Message-ID: <87a75ltf09.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 0-UfA-6DMLSVEOSTkJYrJg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
Cc: John Snow <jsnow@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> rST format requires a blank line before the start of a bulleted
>> or enumerated list. Two places in qapi-schema.json were missing
>> this blank line.
>
> Relies on the previous commit message's "we would like to add a rST
> backend" to establish context.  Suggest:
>
>   We would like to switch the doc comments to rST format, and rST
>   requires...

A few more commit message could use the same treatment.  Since I have
reason to hope to find only minor things I can address in my tree, I
won't point it out every time, but just do it, then give you an
opportunity to check my tweaks.

[...]


