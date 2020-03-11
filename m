Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB57C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 15:13:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EB5D206C0
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 15:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jNDQQonv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB5D206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC33N-0005N4-OH
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 11:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jC32k-0004AO-Fo
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 11:13:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jC32j-0007uy-II
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 11:13:10 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23325
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jC32j-0007sC-FI
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 11:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583939588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=snbpvCqB6iChkpUOslMD6zLlilI2+inNiVMTlI38SOg=;
 b=jNDQQonvEOGEMkZYEPlwgNR+6mwmrh7fTvmz1IO1crCQ1JHPzAqUOrypu/fz3fVM4+6KNL
 +RS60pNNwsIcQacEbtf30WGxcC5aqICgP+drPLfOKTVvU90+2RFQwgids6V2cyP9o4h/y5
 C7c4jBcFMidrmcMcqfDrzL6leMZpkYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-Ep4MmACAPHeYZe8n_IoTxg-1; Wed, 11 Mar 2020 11:13:04 -0400
X-MC-Unique: Ep4MmACAPHeYZe8n_IoTxg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53DD6DBB5;
 Wed, 11 Mar 2020 15:13:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-34.ams2.redhat.com
 [10.36.116.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E4AF861069;
 Wed, 11 Mar 2020 15:12:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7223F11386A6; Wed, 11 Mar 2020 16:12:57 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v4 01/18] qapi/migration.json: Fix indentation
References: <20200309154405.13548-1-peter.maydell@linaro.org>
 <20200309154405.13548-2-peter.maydell@linaro.org>
Date: Wed, 11 Mar 2020 16:12:57 +0100
In-Reply-To: <20200309154405.13548-2-peter.maydell@linaro.org> (Peter
 Maydell's message of "Mon, 9 Mar 2020 15:43:48 +0000")
Message-ID: <87o8t3vsau.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

> Commits 6a9ad1542065ca0bd54c6 and 9004db48c080632aef23 added some
> new text to qapi/migration.json which doesn't fit the stricter
> indentation requirements imposed by the rST documentation generator.
> Reindent those lines to the new standard.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Markus Armbruster <armbru@redhat.com>


