Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CC1C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 09:50:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23B5C2073F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 09:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5utvPVA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B5C2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZXTz-0006FQ-8b
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 04:50:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54074)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iZXOc-0000rt-AN
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 04:44:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iZXA0-0000Gb-GC
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 04:29:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60135
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iZX9v-0000CV-0n
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 04:29:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574760558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/s3We4K5d3Gq0dka0iuIN+MTQ2Ng5dV5egThTYtW80E=;
 b=B5utvPVA/hi0gFcQlw7pNKj68EX6TrhUNvsS5agYnDTLd1qTud7zW2Y3qXwxb0B11z/qg6
 a207VKcdy7wed3rXJl3iEToWcaBGsrR7afqdHoH4pkouredDjt13Vf5xPd3djkzHYqZl+W
 Z0BHYA7HJMmvIbiWSzrI2LcD8ORgUaY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-Qyx4QZhON8yMi4GrgsvlLQ-1; Tue, 26 Nov 2019 04:29:16 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9443D1801B94;
 Tue, 26 Nov 2019 09:29:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6385760BEC;
 Tue, 26 Nov 2019 09:29:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E08F51138606; Tue, 26 Nov 2019 10:29:13 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Subject: Re: [QUESTION] What is the best license option for new files
 introduced in QEMU?
References: <CAL1e-=gmaimCBh5NBBYFp6Z1ci4ZheQtXpyjU9Uexqi4zSHh2A@mail.gmail.com>
Date: Tue, 26 Nov 2019 10:29:13 +0100
In-Reply-To: <CAL1e-=gmaimCBh5NBBYFp6Z1ci4ZheQtXpyjU9Uexqi4zSHh2A@mail.gmail.com>
 (Aleksandar Markovic's message of "Mon, 25 Nov 2019 18:49:51 +0100")
Message-ID: <87lfs39eae.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Qyx4QZhON8yMi4GrgsvlLQ-1
X-Mimecast-Spam-Score: 0
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Aleksandar Markovic <aleksandar.m.mail@gmail.com> writes:

> I read LICENSE file, but I read also recent contributions, and it is
> not clear to me what version of GPL is best/recommended for new file
> just being introduced to QEMU:

The situation is confusing.  It's a mess of our own making.

> * GPL 2.0
> * GPL 2.0 (or later at your option)
> * GPL 2.1
> * GPL 2.1 (or later at your option)
>
> or something else. (The rest od wording of license preamble is clear
> to me.) Please somebody explsin snd clarify.

Let's not add to the mess: GPLv2+ unless you have a compelling reason to
deviate, spelled out in your commit message.

In my opinion, accepting GPLv2-only contributions was a mistake.


