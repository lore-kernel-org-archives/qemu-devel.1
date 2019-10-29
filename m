Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A89CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 11:20:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75E5920663
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 11:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ew8we3sk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75E5920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPPXj-0005Lg-KX
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 07:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iPPWW-0004De-30
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 07:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iPPWV-0003lg-7Q
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 07:18:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24077
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iPPWV-0003kq-3x
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 07:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572347929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cj/IzrBqgytoWSNyvGZubH7cLoTCioWwgLlYqZx4q5o=;
 b=ew8we3skjWsQIF6sp5HOri10Xc1kEiR3HDdyunW9onFj/FT8Wz8dms4Yx7BUKCHZUkXEjh
 IdMpBvwaZlnVkkDs+T/e1plwn0GUr0odRDGUJByyC4vZyZHuv8oLieBt48Tl6iZrILD/4f
 XagA7Xy8saQLqRk2M42u+Lxz+M4oyqw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-Rvo2taJtMeyN6Mk1wqzj1A-1; Tue, 29 Oct 2019 07:18:46 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C41F9800C80
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 11:18:45 +0000 (UTC)
Received: from localhost (ovpn-116-231.ams2.redhat.com [10.36.116.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F0E419C77;
 Tue, 29 Oct 2019 11:18:41 +0000 (UTC)
Date: Tue, 29 Oct 2019 12:18:38 +0100
From: Jens Freimann <jfreimann@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v6 0/11] add failover feature for assigned network devices
Message-ID: <20191029111810.vserlqeb6cwwzgxn@jenstp.localdomain>
References: <20191025121930.6855-1-jfreimann@redhat.com>
 <20191028102723.jwfzxp6mav6ce62g@jenstp.localdomain>
 <20191028115750-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191028115750-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Rvo2taJtMeyN6Mk1wqzj1A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: aadam@redhat.com, ailan@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 28, 2019 at 11:58:53AM -0400, Michael S. Tsirkin wrote:
>I see at least comments from Markus.
>You answered but don't you need to also tweak the patch?

That comment was addressed already IMO, but I'll change the patch
description as well and while I'm at it will also fix David's comment.

regards,
Jens


