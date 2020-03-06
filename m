Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFCBC3F2D6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 14:18:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08A082084E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 14:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h3PY+6DG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A082084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jADo6-0002Jy-89
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 09:18:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jADnP-0001oY-8V
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:17:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jADnO-0002kU-97
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:17:47 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53139
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jADnO-0002ei-5v
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:17:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583504265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JfOznyBN4MfKm2/OufrkyJzsCUKzSbUGkLnA6DzqiRE=;
 b=h3PY+6DGNwO+ZobIzwxqB6MvQ4BR/Wu/7gmLk236VtVuacxK4HSku25WS3NPWzDJGt6BMW
 Qu9RKimfMIQpxna3X45j+9POGTHNEWsNsUQDcz1DcuUuVz8HOMSA1bFPEoDM2UZPw5IEzm
 XQbW1eeSNP2Tt8voi43JyzhHfFSfL6M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150--PVpGOWeNYGSQJx-5Q2Gfw-1; Fri, 06 Mar 2020 09:17:43 -0500
X-MC-Unique: -PVpGOWeNYGSQJx-5Q2Gfw-1
Received: by mail-wr1-f72.google.com with SMTP id f10so1055047wrv.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 06:17:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gg9yffsfnC4G2SYky+DWyoVzp4tT/cFHcbi486h6GqM=;
 b=HUadyM0eS+naB2ufeB2oH/82dded157GNYK9CTuQE9fzHehuNk9q3ADNkmU3eKcZp3
 tIa8mknVyuRL5v24oE0Rth16u1J2fzImbVzHAJbZ3kog5dhWyV8vT0DZOqh4oIQF+ui+
 0BwOUDDECA5yt5pn5BPIK477OVnDO7lftpmTPECVybcG67JMNIgNw7iB8irW2rvs+Gp5
 366ecIMPtHIV8Fn0R9qZRC655NwRRKsGpmkfiaHWbfeLknFiRtbV4s7jRuPKoKU3Lkkx
 ZQLBea8uxcRiYmGfr4fExogL/P7oTEUjz92IorK0fYrGfVUZdysBApmiKDTtUK6MjnT2
 p0UA==
X-Gm-Message-State: ANhLgQ3WScfx7WpO5jV2SiTZWK3untaZU+k7w/NsBe1xBu62GQqLMiek
 aeU5URGu4GxKBrSwiaa6x5ScBlY6Ln3RP6lmm3eBql5YxaK2ErefHUohJabh+V6ObBN67rmQ7rB
 nxrwqHx9EJRsHmyA=
X-Received: by 2002:adf:ef8f:: with SMTP id d15mr4195859wro.17.1583504262376; 
 Fri, 06 Mar 2020 06:17:42 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsHMbwZRM7f17aobBddOJcQUWrc5ablqqM9S9B72l5wk3qLAAxHsmDaJoV2tznlLGvVX9EvCA==
X-Received: by 2002:adf:ef8f:: with SMTP id d15mr4195829wro.17.1583504262074; 
 Fri, 06 Mar 2020 06:17:42 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8cd7:8509:4683:f03a?
 ([2001:b07:6468:f312:8cd7:8509:4683:f03a])
 by smtp.gmail.com with ESMTPSA id f15sm32309848wru.83.2020.03.06.06.17.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2020 06:17:41 -0800 (PST)
Subject: Re: [PATCH 7/7] aio-posix: remove idle poll handlers to improve
 scalability
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20200305170806.1313245-1-stefanha@redhat.com>
 <20200305170806.1313245-8-stefanha@redhat.com>
 <58ce9251-77ba-9db2-b1c1-fd97cd175e9a@redhat.com>
 <20200306135036.GP1335569@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <56306d86-cd1b-07b6-f538-7cfbcb6b5ab1@redhat.com>
Date: Fri, 6 Mar 2020 15:17:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200306135036.GP1335569@stefanha-x1.localdomain>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/03/20 14:50, Stefan Hajnoczi wrote:
>> Not sure I understand the "almost" part.  If it's accessed only from
>> aio_poll() it is protected via either AIO_WAIT_WHILE or the BQL, not by
>> ctx->list_lock; if it's protected by ctx->list_lock (using
>> qemu_lockcnt_inc in readers), it is an RCU list.
> aio_remove_fd_handler() removes nodes from the list during
> aio_set_fd_handler(), but only while holding ctx->list_lock and the
> count is zero (no readers).
>=20
> All other access is done from with ctx->list_lock incremented.  This
> code needs to be reentrant in case of nested aio_poll() but nothing else
> will access the list at the same time.

Oh, I see, adds are only done under ctx->list_lock and those are the
part that need the write barriers in the RCU iterators.

Paolo

> Therefore RCU is not needed.  ctx->list_lock acts more like a rwlock.


