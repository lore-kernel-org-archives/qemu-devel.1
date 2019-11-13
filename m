Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B418C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 21:33:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66C3E206E3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 21:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="An8x9xWc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C3E206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV0GG-0006Et-EY
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 16:33:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iV0ES-0005Cj-Sy
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 16:31:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iV0EQ-0001JK-Jv
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 16:31:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54041
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iV0EQ-0001J2-AI
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 16:31:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573680677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7KBW1nGJyHu0aagMv80J6SqG8NLHQwHSxHCtzbR6g14=;
 b=An8x9xWceUJUopKaszLtbTM5vSaV1OymtMimRAvMvtzeP4TKgDifsUsRIW+jDUQ+RvQ5JC
 S4lbbPRogOki0tLq+nu5Og7eYJwDJszV1x3SpTtP1Vk/8448+paI/oFRcvvRznaGUmU8/C
 zr3mmgA06ICdLILM0hHKf6Z71T7tgxQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-CSQ9T3D2OtOym6HzL2AZFg-1; Wed, 13 Nov 2019 16:31:14 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B09B5A260C;
 Wed, 13 Nov 2019 21:31:12 +0000 (UTC)
Received: from [10.3.116.242] (ovpn-116-242.phx2.redhat.com [10.3.116.242])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 821665ED25;
 Wed, 13 Nov 2019 21:31:08 +0000 (UTC)
Subject: Re: [PATCH 1/2] qapi: net: Add query-netdevs command
To: Alexey Kirillov <lekiravi@yandex-team.ru>,
 Jason Wang <jasowang@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20191113212516.13606-1-lekiravi@yandex-team.ru>
 <20191113212516.13606-2-lekiravi@yandex-team.ru>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <92284c15-1019-01b8-80ed-a443a5f15972@redhat.com>
Date: Wed, 13 Nov 2019 15:31:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191113212516.13606-2-lekiravi@yandex-team.ru>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: CSQ9T3D2OtOym6HzL2AZFg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 qemu-devel@nongnu.org, Vincenzo Maffione <v.maffione@gmail.com>,
 yc-core@yandex-team.ru, Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Luigi Rizzo <rizzo@iet.unipi.it>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/13/19 3:25 PM, Alexey Kirillov wrote:
> Add a qmp command that provides information about currently attached
> network devices and their configuration.
>=20
> Signed-off-by: Alexey Kirillov <lekiravi@yandex-team.ru>
> ---

> +++ b/qapi/net.json
> @@ -754,3 +754,88 @@
>   ##
>   { 'event': 'FAILOVER_NEGOTIATED',
>     'data': {'device-id': 'str'} }
> +
> +##
> +# @NetdevInfo:
> +#
> +# Configuration of a network device.
> +#
> +# @id: Device identifier.
> +#
> +# @type: Specify the driver used for interpreting remaining arguments.
> +#
> +# @peer: Connected network device.
> +#
> +# @queues_count: Number of queues.

Unless there is a strong reason otherwise, this should be 'queues-count'.

> +#
> +# @hub: hubid of hub, if connected to.
> +#
> +# Since: 4.2
> +##
> +{ 'union': 'NetdevInfo',
> +  'base': { 'id': 'str',
> +            'type': 'NetClientDriver',
> +            '*peer': 'str',
> +            'queues_count': 'int',
> +            '*hub': 'int' },
> +  'discriminator': 'type',
> +  'data': {
> +      'nic':        'NetLegacyNicOptions',
> +      'user':       'NetdevUserOptions',
> +      'tap':        'NetdevTapOptions',
> +      'l2tpv3':     'NetdevL2TPv3Options',
> +      'socket':     'NetdevSocketOptions',
> +      'vde':        'NetdevVdeOptions',
> +      'bridge':     'NetdevBridgeOptions',
> +      'hubport':    'NetdevHubPortOptions',
> +      'netmap':     'NetdevNetmapOptions',
> +      'vhost-user': 'NetdevVhostUserOptions' } }
> +
> +##
> +# @x-query-netdevs:

What are the reasons for the x- prefix?  Are we planning on changing=20
this interface down the road?  If so, what changes might we make?

> +#
> +# Get a list of @NetdevInfo for all virtual network devices.
> +#
> +# Returns: a list of @NetdevInfo describing each virtual network device.
> +#
> +# Since: 4.2

This is a new feature; as such, it's too late to make it into 4.2;=20
you'll want to change this to 5.0.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


