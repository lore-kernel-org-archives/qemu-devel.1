Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671E8C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:50:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A27520659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvOOa8V0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A27520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFry-0004yC-PS
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:50:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47935)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1idEx3-0005QI-I4
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:51:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1idEx2-0001qn-Ay
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:51:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53676
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1idEx2-0001py-75
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:51:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575643883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MEwE8pL9dFFmbHzly4cgPXrxw1npkuiParZRs2foA1k=;
 b=fvOOa8V0r49tPOa7nfvxqHfv5SlCQ9VeAcrFuRCKAADqJwCg59uendPcUPTMEC/j6DTlQl
 JvspQU3ndgxcJBLYlbLGXdn/oohudZ5147Qur+qVSvmKgfNyKRAs7B904r5vo7RfQFBzPm
 Zpya7GS6r8KxFleMlnADkJLu7LaJZo8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430--KjZt7VqNOuUylpXa9WIlw-1; Fri, 06 Dec 2019 09:51:20 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 785A918AAFAB;
 Fri,  6 Dec 2019 14:51:18 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B412B19C7F;
 Fri,  6 Dec 2019 14:51:15 +0000 (UTC)
Subject: Re: [PATCH] qapi: better document NVMe blockdev @device parameter
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20191206143811.3777524-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <fa41baea-5b86-192d-97ed-6f13caf2fdfa@redhat.com>
Date: Fri, 6 Dec 2019 08:51:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191206143811.3777524-1-berrange@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: -KjZt7VqNOuUylpXa9WIlw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/6/19 8:38 AM, Daniel P. Berrang=C3=A9 wrote:
> Mention that this is a PCI device address & give the format it is
> expected it. Also mention that it must be first unbound from any

maybe s/expected it/expecting/

> host kernel driver.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>   qapi/block-core.json | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 0cf68fea14..fcb52ec24f 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2963,9 +2963,13 @@
>   #
>   # Driver specific block device options for the NVMe backend.
>   #
> -# @device:    controller address of the NVMe device.
> +# @device:    PCI controller address of the NVMe device in
> +#             format hhhh:bb:ss.f (host:bus:slot.function)
>   # @namespace: namespace number of the device, starting from 1.
>   #
> +# Note that the PCI @device must have been unbound from any host
> +# kernel driver before instructing QEMU to add the blockdev.
> +#

Reviewed-by: Eric Blake <eblake@redhat.com>

Doesn't affect code, but similarly no reason to hurry this into 4.2.=20
5.0 and qemu-stable (cc'd) is good enough.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


