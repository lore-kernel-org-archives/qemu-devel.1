Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3FACA9EBB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:39:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15862205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W739Kg4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15862205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNYeE-0002XM-Mg
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 04:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37680)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iNYPV-0007bl-4G
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:23:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iNYPU-0001xb-08
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:23:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38488
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iNYPT-0001wL-S4
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571905435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h0IWtDF0ADfFiEaFyX2zpoTuXxmHqzoVzuCAkngFNh0=;
 b=W739Kg4HKS69jS7xVLf3WNbJxJHCdkGJVOY64SoEQAp+8QOcehpnJG7BwujiFP/toovmP8
 x1e4Uq6yG4UmrIK0yzixzQ5tQU4qkSVvGcQJ8MXjqMkxgr3VJrMNhdS1O4iqXWskcg6dT3
 AoHsaiPtYAylggiIisOCL27+PXeP35U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-z-8UBYFEMii8hQvvTnRaXw-1; Thu, 24 Oct 2019 04:23:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67870800D5A;
 Thu, 24 Oct 2019 08:23:52 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com
 [10.36.116.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 080395D9CA;
 Thu, 24 Oct 2019 08:23:52 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5A5759DB6; Thu, 24 Oct 2019 10:23:51 +0200 (CEST)
Date: Thu, 24 Oct 2019 10:23:51 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Thomas Huth <huth@tuxfamily.org>
Subject: Re: [PATCH] qemu-options: Rework the help text of the '-display'
 option
Message-ID: <20191024082351.n2j3ffimqlpbgqf3@sirius.home.kraxel.org>
References: <20191023120129.13721-1-huth@tuxfamily.org>
MIME-Version: 1.0
In-Reply-To: <20191023120129.13721-1-huth@tuxfamily.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: z-8UBYFEMii8hQvvTnRaXw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 23, 2019 at 02:01:28PM +0200, Thomas Huth wrote:
> Improve the help text of the "-display" option:
>=20
> - Only print the options that we have enabled in the binary
>   (similar to what we do for other options like -netdev already)
>=20
> - The "frame=3Don|off" from "-display sdl" has been removed in commit
>   09bd7ba9f5f7 ("Remove deprecated -no-frame option"), so we should
>   not show this in the help text anymore
>=20
> - The "-display egl-headless" line was missing a "\n" at the end
>=20
> - Indent the default display text in a nicer way
>=20
> Signed-off-by: Thomas Huth <huth@tuxfamily.org>

Queue up for UI.

thanks,
  Gerd


