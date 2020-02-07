Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C7CC352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:14:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0004120720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PGHJkI57"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0004120720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j01aV-0002sr-5x
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 06:14:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j01ZH-0000xw-0f
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:13:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j01ZE-0007NE-LT
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:13:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29048
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j01ZD-0007HO-OR
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:13:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581073978;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f6SFr5pduWQxlu0WksYSi6nycfYulm0IDscl4fl7hW4=;
 b=PGHJkI57HmnxfUr9+EBhfWAaIzARS34e/kQZTgKzrWIXqO5HQs9sP/1KbynPdKmAGKZPtc
 3V7iOjpqN1tFqOgXJRdD8Zzwz8dMEiG0px9+AdSIaZv/eAmPrqRxJ0TvH8ysFaglorgLHd
 7sGWYdbEfFl3WamMVuJuwFAK5rvKXJo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-xFaRKRn0O3-9FQyuBkHsRg-1; Fri, 07 Feb 2020 06:12:56 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A14B2DB25
 for <qemu-devel@nongnu.org>; Fri,  7 Feb 2020 11:12:55 +0000 (UTC)
Received: from redhat.com (ovpn-116-157.ams2.redhat.com [10.36.116.157])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 24AEF19756;
 Fri,  7 Feb 2020 11:12:38 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 1/2] tests/vhost-user-bridge: move to contrib/
In-Reply-To: <20200207095412.794912-1-lvivier@redhat.com> (Laurent Vivier's
 message of "Fri, 7 Feb 2020 10:54:11 +0100")
References: <20200207095412.794912-1-lvivier@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Fri, 07 Feb 2020 12:12:36 +0100
Message-ID: <87lfpe8xcr.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: xFaRKRn0O3-9FQyuBkHsRg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Reply-To: quintela@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Laurent Vivier <lvivier@redhat.com> wrote:
> vhost-user-bridge is not a test. Move it to contrib/ and
> add it to the tools list.
>
> It will be built only if tools (--enable-tools) and
> vhost-user (--enable-vhost-user) are enabled (both are set
> by default).
>
> Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


