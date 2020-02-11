Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B98EC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 08:36:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17B6220658
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 08:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i0ozBfo8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B6220658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1R1b-0002ZE-8k
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 03:36:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j1R0f-0001pq-So
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 03:35:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j1R0e-0006al-Bv
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 03:35:09 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49090
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j1R0e-0006QQ-0z
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 03:35:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581410106;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IbOPxbuyM/BU2Xlzv4ld1EGX3vbsBk63yJcj9VgI2hw=;
 b=i0ozBfo8FXhgTuhvLCShejWxOQYOdh04sg8YMS0K4AjNGft7cx9E/JHcpwFnkH4++8mK8n
 nN7+Hd4FIHAk5v1Ij8Pzv+H76WNBdBfoCc5+AIT1Ra/BIg7FJPXjC0TW2Tylk8RzMH9tMf
 HkWI5ipy4iS/GYw2tgdZUboW7Ocg+Qw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-ocNEm_GTP1mo1-P02XIbig-1; Tue, 11 Feb 2020 03:35:02 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB47618A550F
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 08:35:01 +0000 (UTC)
Received: from redhat.com (ovpn-117-191.ams2.redhat.com [10.36.117.191])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 72BAD5DA7B;
 Tue, 11 Feb 2020 08:34:53 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>
Subject: Re: [PATCH] tests/migration: Add some slack to auto converge
In-Reply-To: <20200210195731.177595-1-dgilbert@redhat.com> (David Alan
 Gilbert's message of "Mon, 10 Feb 2020 19:57:31 +0000")
References: <20200210195731.177595-1-dgilbert@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Tue, 11 Feb 2020 09:34:51 +0100
Message-ID: <87r1z15xp0.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: ocNEm_GTP1mo1-P02XIbig-1
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
Reply-To: quintela@redhat.com
Cc: lvivier@redhat.com, thuth@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> There's an assert in autoconverge that checks that we quit the
> iteration when we go below the expected threshold.  Philippe
> saw a case where this assert fired with the measured value
> slightly over the threshold. (about 3k out of a few million).
>
> I can think of two reasons:
>   a) Rounding errors
>   b) That after we make the decision to quit iteration we do one
>     more sync and that sees a few more dirty pages.
>
> So add 1% slack to the assertion, that should cover a and
> most cases of b, probably all we'll see for the test.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

It shouldn't matter really.  And if we are seeing that problem.


