Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D4CC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 11:03:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8C6921852
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 11:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZOfeM1U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C6921852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX1Hv-0004ju-Vq
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 06:03:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44604)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iX1Gv-0004Dc-HL
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 06:02:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iX1Gu-00035b-F0
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 06:02:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28496
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iX1Gu-000351-B6
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 06:02:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574161331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TPSGMgbnnwg23VD+FaSY7EyRjDfn+nXipDIrfy7WFCI=;
 b=XZOfeM1UnQ5b5zGcRAnqVpwri/K3HY6f6SdcqO6gZ415sC34wPIaBtPa8hPootJeTwvFp8
 gfKMlcJdUwzH/+UnN6OqulWeeReF7YFbJLtlVSRQt8fG9XvtuoCUQoLBfAXGtweTu2fTo4
 pCRD4lXovKwkSVtHpiIcYK59K6eezI4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-w6FMpf-2P7i8aXTlQfxteg-1; Tue, 19 Nov 2019 06:02:10 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE29D8018A2
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 11:02:09 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-181.ams2.redhat.com
 [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A80969198;
 Tue, 19 Nov 2019 11:02:08 +0000 (UTC)
Subject: Re: [PATCH 13/16] xen: convert "-machine igd-passthru" to an
 accelerator property
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
 <1573655945-14912-14-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2c34a923-377e-7491-210a-ab712e5d442c@redhat.com>
Date: Tue, 19 Nov 2019 12:02:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <1573655945-14912-14-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: w6FMpf-2P7i8aXTlQfxteg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/11/2019 15.39, Paolo Bonzini wrote:
> The first machine property to fall is Xen's Intel integrated graphics
> passthrough.  The "-machine igd-passthru" option does not set anymore
> a property on the machine object, but desugars to a GlobalProperty on
> accelerator objects.
>=20
> The setter is very simple, since the value ends up in a
> global variable, so this patch also provides an example before the more
> complicated cases that follow it.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/core/machine.c   | 20 --------------------
>  hw/xen/xen-common.c | 16 ++++++++++++++++
>  include/hw/boards.h |  1 -
>  qemu-options.hx     |  9 +++++----
>  vl.c                | 14 ++++----------
>  5 files changed, 25 insertions(+), 35 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


