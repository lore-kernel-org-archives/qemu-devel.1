Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCBCC43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 07:34:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E69F62089E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 07:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69F62089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40906 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJvN7-0007eE-4Z
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 03:34:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hJvLz-0006q6-NO
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 03:33:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hJvE7-0003gV-Ka
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 03:24:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hJvE6-0003d4-Ow
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 03:24:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3A9B1308B79B
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 07:24:52 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-45.ams2.redhat.com
	[10.36.116.45])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 79E5A66062;
	Fri, 26 Apr 2019 07:24:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id B497011AAF; Fri, 26 Apr 2019 09:24:46 +0200 (CEST)
Date: Fri, 26 Apr 2019 09:24:46 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20190426072446.r7b7wsm4qghd7pzr@sirius.home.kraxel.org>
References: <20190423132004.13725-1-marcandre.lureau@redhat.com>
	<20190423132004.13725-6-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190423132004.13725-6-marcandre.lureau@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Fri, 26 Apr 2019 07:24:52 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 05/11] vhost-user: add
 vhost_user_gpu_set_socket()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426072446.H2PcELZAMEjwW9Av1SuifUQL-BRiOdy2WZGt7Qh1jtY@z>

On Tue, Apr 23, 2019 at 03:19:58PM +0200, Marc-Andr=E9 Lureau wrote:
> Add a new vhost-user message to give a unix socket to a vhost-user
> backend for GPU display updates.

Can you split input/gpu into two patch series?

> +Wire format
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Unless specified differently, numbers are in the machine native byte
> +order.
> +
> +A vhost-user-gpu request consists of 2 header fields and a payload.
> +
> ++---------+------+---------+
> +| request | size | payload |
> ++---------+------+---------+
> +
> +Header
> +------
> +
> +:request: ``u32``, type of the request
> +
> +:size: ``u32``, size of the payload
> +
> +A reply consists only of a payload, whose content depends on the reque=
st.

I'd suggest to use the same format for replies, only with "request"
meaning "status" in replies.  Allows for OK/ERROR status in replies,
and having a size field in replies too should make things more robust.
Also allows for an empty reply (status=3Dok,size=3D0).

cheers,
  Gerd


