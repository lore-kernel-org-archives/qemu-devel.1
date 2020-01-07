Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6B5C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 09:37:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54FF32073D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 09:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Isji0h6a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FF32073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iolId-0002DP-Gr
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 04:37:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iol6Q-0001UB-F3
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 04:24:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iol6P-0000Xu-BX
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 04:24:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31082
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iol6P-0000Wj-7H
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 04:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578389078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DWqckSk/tioOWaCoBRp04rIF/f7CclB54RR60DKZDl4=;
 b=Isji0h6a7CleFgf3edoeMukOda7qZqYnIHbzXtd0itYT5Y6Y0ZqWWDmig8TDYHV5+e797I
 BS93yqHqbKYlc0Enfu2d29lEqGvHCQ6E1VYrTyxG0wUPAvIZyJTYy0dibljvcXgnJnKR/i
 ce4YG+ojU9VDfDk2rvmbYSx1svVsmLY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-mEM7jDcPOAKAY6Kin-IuLw-1; Tue, 07 Jan 2020 04:24:34 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D64B107BAAE;
 Tue,  7 Jan 2020 09:24:33 +0000 (UTC)
Received: from gondolin (ovpn-117-222.ams2.redhat.com [10.36.117.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D67BD7DB55;
 Tue,  7 Jan 2020 09:24:28 +0000 (UTC)
Date: Tue, 7 Jan 2020 10:24:26 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v1] hw: fix using 4.2 compat in 5.0 machine types for
 i440fx/q35
Message-ID: <20200107102426.3f31d4d6.cohuck@redhat.com>
In-Reply-To: <20191223072856.5369-1-dplotnikov@virtuozzo.com>
References: <20191223072856.5369-1-dplotnikov@virtuozzo.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: mEM7jDcPOAKAY6Kin-IuLw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 23 Dec 2019 10:28:56 +0300
Denis Plotnikov <dplotnikov@virtuozzo.com> wrote:

> 5.0 machine type uses 4.2 compats. This seems to be incorrect, since
> the latests machine type by now is 5.0 and it should use its own
> compat or shouldn't use any relying on the defaults.
> Seems, like this appeared because of some problems on merge/rebase.

Yes, I seem to have fat-fingered that while rebasing.

> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  hw/i386/pc_piix.c | 1 -
>  hw/i386/pc_q35.c  | 1 -
>  2 files changed, 2 deletions(-)

I double checked that the other compat machines seem fine.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


