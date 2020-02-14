Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88791C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:24:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A19F2168B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xa/msTC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A19F2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2cpa-0004tD-J9
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 10:24:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48059)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2cob-0003IZ-0h
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:23:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2coZ-0004A6-5n
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:23:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54136
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2coY-00042x-Lv
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:23:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581693813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zq3tTHKMHThelryW+GrW/XWmdIXJAoXdeTB4wou6J1o=;
 b=Xa/msTC3jxvIFdLGdNwmLcI8Exhh2RafXq+7LkKjJs0pBE32fYS5m/2tUbq1KZpPF1J7RU
 XNf7+PyK+uzcazTjyVFViDqPfYVneXAbbHk+PJSiYfht2jqxCbgHyibJsP5mYjG8EXzp4b
 BktRlFf2P2O3q8DuhRGW5sirbavh5dI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-62MQKd_vOl-DdRyONT-cFA-1; Fri, 14 Feb 2020 10:23:31 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 142BB800D50
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 15:23:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D69D7867EC;
 Fri, 14 Feb 2020 15:23:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5B7F311385C9; Fri, 14 Feb 2020 16:23:29 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Andrea Bolognani <abologna@redhat.com>
Subject: Re: [PATCH] qapi: Expand documentation for LostTickPolicy
References: <20200211183744.210298-1-abologna@redhat.com>
Date: Fri, 14 Feb 2020 16:23:29 +0100
In-Reply-To: <20200211183744.210298-1-abologna@redhat.com> (Andrea Bolognani's
 message of "Tue, 11 Feb 2020 19:37:44 +0100")
Message-ID: <875zg9ry4u.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 62MQKd_vOl-DdRyONT-cFA-1
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
Cc: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Andrea Bolognani <abologna@redhat.com> writes:

> The current documentation is fairly terse and not easy to decode
> for someone who's not intimately familiar with the inner workings
> of timer devices. Expand on it by providing a somewhat verbose
> description of what behavior each policy will result in, as seen
> from both the guest OS and host point of view.
>
> Signed-off-by: Andrea Bolognani <abologna@redhat.com>

Queued, thanks!


