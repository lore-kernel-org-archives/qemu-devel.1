Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F50EC352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 09:36:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ECDF2082E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 09:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UiEJkoC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ECDF2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52859 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j003s-00047D-9v
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 04:36:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j000E-0006on-CC
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 04:32:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j000C-0004ku-PG
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 04:32:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44359
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j000C-0004kb-EM
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 04:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581067964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QQBMskfW61vA0Iv9ymxa7wvjOWaYwYVziGyCRImgkGk=;
 b=UiEJkoC/mEAj3GceZw+t1wIUt+vyEhgYtDJxFz11+XEe5x8rv66GHvLlzMcpfkvZTqyXQd
 v8kS58EZLen2n4nXu1iyeQjU4euuMCEyw8YahyO7tcXV0OfeMGgxdqSBuNMwlLlGRgh5ty
 1hu0beuKvTGHLv/vHyL72Kvn20La7UU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-z3MhkYCEM2ehM8LTKMc6HA-1; Fri, 07 Feb 2020 04:32:39 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DCAF8010D6;
 Fri,  7 Feb 2020 09:32:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 731681001B30;
 Fri,  7 Feb 2020 09:32:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 46F5111386A7; Fri,  7 Feb 2020 10:32:32 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 10/29] qapi: Remove hardcoded tabs
References: <20200206173040.17337-1-peter.maydell@linaro.org>
 <20200206173040.17337-11-peter.maydell@linaro.org>
Date: Fri, 07 Feb 2020 10:32:32 +0100
In-Reply-To: <20200206173040.17337-11-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 6 Feb 2020 17:30:21 +0000")
Message-ID: <87h802u4i7.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: z3MhkYCEM2ehM8LTKMc6HA-1
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

> There are some stray hardcoded tabs in some of our json files;
> remove them.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Most of the hardcoded tabs got removed in passing in
> fixing the indent in lines that they were in, but
> these are not part of doc comments.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


