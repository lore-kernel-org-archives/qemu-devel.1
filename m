Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E672C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 955C32184D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gi3uOuql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955C32184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQQZ7-0004NR-Hy
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 03:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQQYA-0003xh-NX
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 03:41:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44260)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQQY6-00089o-K0
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 03:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602142873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ujcynzlgcjam+IP4IUFU07KsFxXv3w0AD6uUgZ2wIp8=;
 b=Gi3uOuqlUqN42CiN64ItQF2gD6f2GCoyZRaUOEaXk6qG3IvMmYGEXHyGr6IubsxZ36NIUq
 0GPUnklQ+9jeOuUfidU50otuodO9B8HIe4fwhYWyM4X6jzNFm9iCTtFZex+mxWxJD8t/yO
 z9ycA0Y0uAKGh35hX/buiMgXgmNfzUQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-xltvthuoM5W-p3jC3rf_Mw-1; Thu, 08 Oct 2020 03:41:10 -0400
X-MC-Unique: xltvthuoM5W-p3jC3rf_Mw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EF508070E4
 for <qemu-devel@nongnu.org>; Thu,  8 Oct 2020 07:41:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E5526715F;
 Thu,  8 Oct 2020 07:41:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D103511329C1; Thu,  8 Oct 2020 09:41:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v5 19/36] qapi/events.py: add type hint annotations
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-20-jsnow@redhat.com>
 <87zh4ye0fh.fsf@dusky.pond.sub.org>
 <bb656a3c-a92e-f934-5294-a4230842e322@redhat.com>
Date: Thu, 08 Oct 2020 09:41:07 +0200
In-Reply-To: <bb656a3c-a92e-f934-5294-a4230842e322@redhat.com> (John Snow's
 message of "Wed, 7 Oct 2020 11:39:28 -0400")
Message-ID: <87r1q92mi4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
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
Cc: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 10/7/20 7:32 AM, Markus Armbruster wrote:
>> Ignorant question: what's the difference between -> None (like here) and
>> nothing (like __init__() above?
>
> This came up in Cleber's review, too.
>
> Mypy supports a gradual typing paradigm; it is designed to facilitate
> what we are doing here: the gradual adding of types until we are able
> to enforce static typing everywhere.
>
> To that end, mypy uses a simple heuristic to determine if a function
> is "typed" or "untyped": did you use any type annotations for it?
>
> Meanwhile, __init__ never returns anything. You do not need to
> annotate its return type. mypy knows what the return type is and must
> be. In the case of __init__ with no parameters, it is both untyped and
> strictly typed!
>
> Annotating the return type for no-parameter init methods convinces
> mypy that this is a strictly typed method. It doesn't do this
> automatically, because doing so might enable more checks than you were
> ready for simply because mypy was able to accurately surmise the
> typing of just __init__.
>
> So it's just a little flip switch to enable strict typing, really.
>
> --js
>
> https://mypy.readthedocs.io/en/stable/class_basics.html#annotating-init-methods

I now understand we can omit -> None, except when it's the only type
hint, because omitting it then would make it untyped, which is not what
we want.

Is this just for __init__(), or is it for any function that doesn't
return anything?


