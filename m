Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05827C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 09:40:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1443214AF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 09:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YLYnxSNZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1443214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39317 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuvRv-0004w5-VX
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 04:40:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iuvRA-0003gm-Bz
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:39:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iuvR9-0006GS-6r
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:39:36 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37119
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iuvR9-0006G3-2e
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:39:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579858774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=1vY8OaegJzn5LL8P6e2mC+9dCQ/2UJodKmSZqQ08NEE=;
 b=YLYnxSNZY8wlW/4PZXyeJMpJIWvSdSM8p9CxhLybm4bS2jt0poVDqCCCClVJyv+ZOE4eMR
 Xm/IejJwVVyJBTst5dJ66bVzlIY6riMAeXnwHOPXuGfIWOgD8TuzyBuPQMmdesIZ5MO3kt
 7HoEu0L4Hyt/MmV487grt0B4exQjxOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-NSA5XfRQM4-QKvwhR5zeWQ-1; Fri, 24 Jan 2020 04:39:31 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22A798010CA;
 Fri, 24 Jan 2020 09:39:30 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-156.ams2.redhat.com [10.36.116.156])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 423DE388;
 Fri, 24 Jan 2020 09:39:29 +0000 (UTC)
Subject: Re: [PATCH 4/5] target/s390x: Move DisasFields into DisasContext
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200123232248.1800-1-richard.henderson@linaro.org>
 <20200123232248.1800-5-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <49e5c963-ae6a-f0da-5943-14f193ae62fc@redhat.com>
Date: Fri, 24 Jan 2020 10:39:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200123232248.1800-5-richard.henderson@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: NSA5XfRQM4-QKvwhR5zeWQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: cohuck@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/01/2020 00.22, Richard Henderson wrote:
> I believe that the separate allocation of DisasFields from DisasContext
> was meant to limit the places from which we could access fields.  But
> that plan did not go unchanged, and since DisasContext contains a pointer
> to fields, the substructure is accessible everywhere.
> 
> By allocating the substructure with DisasContext, we improve the locality
> of the accesses by avoiding one level of pointer chasing.  In addition,
> we avoid a dangling pointer to stack allocated memory, diagnosed by static
> checkers.
> 
> Launchpad: https://bugs.launchpad.net/bugs/1661815
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/s390x/translate.c        | 22 +++++++++---------
>  target/s390x/translate_vx.inc.c | 40 ++++++++++++++++-----------------
>  2 files changed, 30 insertions(+), 32 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


