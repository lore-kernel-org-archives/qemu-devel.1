Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D07C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 17:48:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F4B72072D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 17:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R934t1FL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F4B72072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEzHN-00012Z-GX
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 13:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ppandit@redhat.com>) id 1jEzGi-0000bU-BF
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1jEzGh-0003T2-HO
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:47:44 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:41215)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1jEzGh-0003Sv-E5
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584640063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aa98oriqgYvIhWGLmeTOS2k0XcmQpLGQ/Ygw5GjPXCQ=;
 b=R934t1FLLKdv3SNd0epSxYjuZLSZ3j4pnBur5f0nDcf4NJpoLcAEdcmRLsKrhzBAx42/TO
 P32JK6v1cQAChjx8hQkfGYcjeTygplQDkdSMAeORPzAgQJAh9UeN7YAldC5PH0nLLktJBP
 QRVsYpQI0ebaRWjpQzPDOvHl/bm273w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-4fhCnWyjMMCo8Oayxc5gIw-1; Thu, 19 Mar 2020 13:47:41 -0400
X-MC-Unique: 4fhCnWyjMMCo8Oayxc5gIw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50C511857BE1;
 Thu, 19 Mar 2020 17:47:40 +0000 (UTC)
Received: from kaapi (unknown [10.40.192.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 203605D9CA;
 Thu, 19 Mar 2020 17:47:29 +0000 (UTC)
Date: Thu, 19 Mar 2020 23:17:23 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v4 2/3] net: tulip: add .can_recieve routine
In-Reply-To: <ceb92631-f9f9-52bf-a5b3-87c01370d6c3@redhat.com>
Message-ID: <nycvar.YSQ.7.76.2003192315020.5086@xnncv>
References: <20200319095211.741445-1-ppandit@redhat.com>
 <20200319095211.741445-3-ppandit@redhat.com>
 <ceb92631-f9f9-52bf-a5b3-87c01370d6c3@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed;
 boundary="-1463810047-1523341832-1584640059=:5086"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Li Qiang <pangpei.lq@antfin.com>,
 Sven Schnelle <svens@stackframe.org>, Ziming Zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

---1463810047-1523341832-1584640059=:5086
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

+-- On Thu, 19 Mar 2020, Philippe Mathieu-Daud=C3=A9 wrote --+
| Typo "can_recieve" -> "can_receive" in subject.

Oops! Fixed it, sent revised patch v5.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
---1463810047-1523341832-1584640059=:5086--


