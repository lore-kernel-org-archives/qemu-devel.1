Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7B1C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 14:24:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4498F206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 14:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ELMnGnIO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4498F206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2btB-0000I5-Fu
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 09:24:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2bsb-0008I3-UP
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:23:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2bsb-00089x-0r
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:23:41 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27608
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2bsa-0007zk-JM
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:23:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581690219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JEX7eN2lABDfLf7hoiU3hV1OiewFZPyPs5PzbR/vOl0=;
 b=ELMnGnIOV/Qd+RkJAMcAF3qpW5uvhFvNQU2vuzAcZK9ucSemATh0svFhkgaNsr//b6zDkh
 PxgUorrDsV5deIJ12qoPKfmyPUtiH08hGb0sEYFEcEbtn7Fpf7RquIPiRxoAktflCVWs31
 Un+0yFT3BMVQq3c/ngm9I0bw98dFgh4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-67Kv3J2mOVSwd1idwRnxLA-1; Fri, 14 Feb 2020 09:23:35 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D746800D5E;
 Fri, 14 Feb 2020 14:23:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ACB5560BE1;
 Fri, 14 Feb 2020 14:23:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5172411385C9; Fri, 14 Feb 2020 15:23:30 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 15/30] qapi/{block, misc, tmp,
 net}.json: Use explicit bulleted lists
References: <20200213175647.17628-1-peter.maydell@linaro.org>
 <20200213175647.17628-16-peter.maydell@linaro.org>
Date: Fri, 14 Feb 2020 15:23:30 +0100
In-Reply-To: <20200213175647.17628-16-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 13 Feb 2020 17:56:32 +0000")
Message-ID: <87wo8ptfh9.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 67Kv3J2mOVSwd1idwRnxLA-1
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

> A JSON block comment like this:
>      Returns: nothing on success
>               If @node is not a valid block device, DeviceNotFound
>               If @name is not found, GenericError with an explanation
>
> renders like this:
>
>      Returns: nothing on success If node is not a valid block device,
>      DeviceNotFound If name is not found, GenericError with an explanatio=
n
>
> because whitespace is not significant.
>
> Use an actual bulleted list, so that the formatting is correct.
>
> This commit gathers up the remaining json files which had
> places needing this fix.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Markus Armbruster <armbru@redhat.com>

What's the rationale for the split between

    [PATCH v2 13/30] qapi/block-core.json: Use explicit bulleted lists
    [PATCH v2 14/30] qapi/ui.json: Use explicit bulleted lists
    [PATCH v2 15/30] qapi/{block, misc, tmp, net}.json: Use explicit bullet=
ed lists

?


