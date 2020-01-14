Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2ABAC33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:36:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B3952467D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZzPKvYoA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3952467D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irNJA-00040n-8x
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 09:36:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1irNHA-0001DE-7s
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:34:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1irNH7-0001KF-H1
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:34:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49796
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1irNH7-0001Jo-AI
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:34:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579012472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8/KBtYEfdNPiYGTguXe6ia3e1ZNToOxRwJYq0LA4fbk=;
 b=ZzPKvYoAl5T6cfch3ou06Lp53dU0XRWteDfAU0iv/RyVJIqBRz+cknm2davgVdwDUE96qG
 Gk8Ulupwnhzce3fX00MJ5hY5pnTEYDNIlOsXGXzmpvmxZTaR4VSB9DoCsu3ibWXxK/zDtO
 rYPi6GaJNSYjyyOiOp0/xu/EqzGF0TY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-1787JuzvPAGuxp6-L-2xnw-1; Tue, 14 Jan 2020 09:34:28 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23AAA18B5F6A;
 Tue, 14 Jan 2020 14:34:27 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-253.ams2.redhat.com [10.36.116.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BF581081325;
 Tue, 14 Jan 2020 14:34:26 +0000 (UTC)
Date: Tue, 14 Jan 2020 15:34:24 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3] iotests: Add more "skip_if_unsupported" statements to
 the python tests
Message-ID: <20200114143424.GC8159@linux.fritz.box>
References: <20200114140203.24326-1-thuth@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200114140203.24326-1-thuth@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 1787JuzvPAGuxp6-L-2xnw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 14.01.2020 um 15:02 hat Thomas Huth geschrieben:
> The python code already contains a possibility to skip tests if the
> corresponding driver is not available in the qemu binary - use it
> in more spots to avoid that the tests are failing if the driver has
> been disabled.
>=20
> While we're at it, we can now also remove some of the old checks that
> were using iotests.supports_quorum() - and which were apparently not
> working as expected since the tests aborted instead of being skipped
> when "quorum" was missing in the QEMU binary.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v3:
>  - Remove the old iotests.supports_quorum()-based tests
>  - Check for "throttle" in 245, too

Thanks, applied to the block branch.

Kevin


