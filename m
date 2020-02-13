Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DEAC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 16:52:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6580206ED
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 16:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b3Jv8j6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6580206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2HjR-0001Ml-1l
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 11:52:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1j2Hif-0000xW-QH
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 11:52:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1j2Hid-0005Zy-Tf
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 11:52:05 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27403
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1j2Hid-0005Yn-Pg
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 11:52:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581612722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vWegnVtFFiE2vYMqXA24P9p7vLiR6FEenRzK02gGWlc=;
 b=b3Jv8j6VBLXbdjd8Uym9L4xHVqfb3dn9e47pTs+9uswFJp7L7N9FEUYUZvqfTNu1tlNWNh
 pVZWnPbFD0ddty1MkmPrU3Ow6faAHY2dZICzsU+lodPuryhR0xqM1pItPsLd9TK2WxQybY
 UmPAt2H1oS7UJCf80zTDpr9iEXAJ03w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-qpkKJHShNgeBJoyviQ57QQ-1; Thu, 13 Feb 2020 11:51:55 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D0B3477
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 16:51:54 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A1705DA7B;
 Thu, 13 Feb 2020 16:51:53 +0000 (UTC)
Date: Thu, 13 Feb 2020 17:51:50 +0100
From: Andrew Jones <drjones@redhat.com>
To: Andrea Bolognani <abologna@redhat.com>
Subject: Re: [PATCH] qapi: Expand documentation for LostTickPolicy
Message-ID: <20200213165150.dxefqbb6ep7t5tk7@kamzik.brq.redhat.com>
References: <20200211183744.210298-1-abologna@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200211183744.210298-1-abologna@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: qpkKJHShNgeBJoyviQ57QQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 11, 2020 at 07:37:44PM +0100, Andrea Bolognani wrote:
> The current documentation is fairly terse and not easy to decode
> for someone who's not intimately familiar with the inner workings
> of timer devices. Expand on it by providing a somewhat verbose
> description of what behavior each policy will result in, as seen
> from both the guest OS and host point of view.
>=20
> Signed-off-by: Andrea Bolognani <abologna@redhat.com>
> ---
> This information is reported pretty much word by word in
>=20
>   https://libvirt.org/formatdomain.html#elementsTime
>=20
> so I'm hoping I can get the QEMU documentation updated and then just
> merge back the changes.
>=20
>  qapi/misc.json | 34 +++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)
>=20
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 33b94e3589..cd7445d29f 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -163,17 +163,29 @@
>  ##
>  # @LostTickPolicy:
>  #
> -# Policy for handling lost ticks in timer devices.
> -#
> -# @discard: throw away the missed tick(s) and continue with future injec=
tion
> -#           normally.  Guest time may be delayed, unless the OS has expl=
icit
> -#           handling of lost ticks
> -#
> -# @delay: continue to deliver ticks at the normal rate.  Guest time will=
 be
> -#         delayed due to the late tick
> -#
> -# @slew: deliver ticks at a higher rate to catch up with the missed tick=
. The
> -#        guest time should not be delayed once catchup is complete.
> +# Policy for handling lost ticks in timer devices.  Ticks end up getting
> +# lost when, for example, the guest is paused.
> +#
> +# @discard: throw away the missed ticks and continue with future injecti=
on
> +#           normally.  The guest OS will see the timer jump ahead by a
> +#           potentially quite significant amount all at once, as if the
> +#           intervening chunk of time had simply not existed; needless t=
o
> +#           say, such a sudden jump can easily confuse a guest OS which =
is
> +#           not specifically prepared to deal with it.  Assuming the gue=
st
> +#           OS can deal correctly with the time jump, the time in the gu=
est
> +#           and in the host should now match.
> +#
> +# @delay: continue to deliver ticks at the normal rate.  The guest OS wi=
ll
> +#         not notice anything is amiss, as from its point of view time w=
ill
> +#         have continued to flow normally.  The time in the guest should=
 now
> +#         be behind the time in the host by exactly the amount of time d=
uring
> +#         which ticks have been missed.
> +#
> +# @slew: deliver ticks at a higher rate to catch up with the missed tick=
s.
> +#        The guest OS will not notice anything is amiss, as from its poi=
nt
> +#        of view time will have continued to flow normally.  Once the ti=
mer
> +#        has managed to catch up with all the missing ticks, the time in
> +#        the guest and in the host should match.
>  #
>  # Since: 2.0
>  ##
> --=20
> 2.24.1
>=20
>

Reviewed-by: Andrew Jones <drjones@redhat.com>


