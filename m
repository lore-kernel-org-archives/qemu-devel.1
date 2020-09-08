Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C3DC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 15:57:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2268020738
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 15:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="vdhy36Hd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2268020738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFg0A-0007Rq-5w
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 11:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lekiravi@yandex-team.ru>)
 id 1kFfvQ-0000H3-Ux
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 11:52:52 -0400
Received: from forwardcorp1j.mail.yandex.net ([2a02:6b8:0:1619::183]:48374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lekiravi@yandex-team.ru>)
 id 1kFfvK-0003L6-Pg
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 11:52:51 -0400
Received: from myt5-23f0be3aa648.qloud-c.yandex.net
 (myt5-23f0be3aa648.qloud-c.yandex.net
 [IPv6:2a02:6b8:c12:3e29:0:640:23f0:be3a])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id A9CDA2E1768;
 Tue,  8 Sep 2020 18:52:40 +0300 (MSK)
Received: from localhost (localhost [::1])
 by myt5-23f0be3aa648.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 c5XFXTgpvd-qdwC4IKd; Tue, 08 Sep 2020 18:52:40 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1599580360; bh=tBY3Ug4cbO6QjLjoroU33lOpmN4LKcxgFP0TjDfNwIM=;
 h=References:Date:Message-Id:Cc:Subject:To:From;
 b=vdhy36Hd4MRpU0Fa0WUbd4jXq4xO/voB6QuQDOdMhcQgag2b5WTbcKN6OjkYPvlpg
 ldAAsvQWyLSbtGJFfwL26v3dyBoM/yARRdBS9P9DsI1CL9ScApzK2ffTX38IEmNmYZ
 kNxY6oJd+GWh4FwcMPuphfgCMOwXla6d2g0RD5R0=
Authentication-Results: myt5-23f0be3aa648.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000161690
Received: by myt4-457577cc370d.qloud-c.yandex.net with HTTP;
 Tue, 08 Sep 2020 18:52:39 +0300
From: Alexey Kirillov <lekiravi@yandex-team.ru>
To: Markus Armbruster <armbru@redhat.com>
References: <20200901182326.59633-1-lekiravi@yandex-team.ru>
 <20200901182326.59633-2-lekiravi@yandex-team.ru>
 <87lfhsjubv.fsf@dusky.pond.sub.org>
 <37711599469320@mail.yandex-team.ru> <871rjdrca0.fsf@dusky.pond.sub.org>
Subject: Re: [PATCH v3 1/4] qapi: net: Add query-netdevs command
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Tue, 08 Sep 2020 18:52:39 +0300
Message-Id: <18211599579782@mail.yandex-team.ru>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Received-SPF: pass client-ip=2a02:6b8:0:1619::183;
 envelope-from=lekiravi@yandex-team.ru; helo=forwardcorp1j.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

07.09.2020, 15:40, "Markus Armbruster" <armbru@redhat.com>:
> Alexey Kirillov <lekiravi@yandex-team.ru> writes:
>
>>  Hi!
>>
>>  02.09.2020, 14:23, "Markus Armbruster" <armbru@redhat.com>:
>>>  Alexey Kirillov <lekiravi@yandex-team.ru> writes:
>>>
>>>>   Add a qmp command that provides information about currently attached
>>>>   backend network devices and their configuration.
>>>>
>>>>   Signed-off-by: Alexey Kirillov <lekiravi@yandex-team.ru>
>>>
>>>  [...]
>>>>   diff --git a/qapi/net.json b/qapi/net.json
>>>>   index ddb113e5e5..c09322bb42 100644
>>>>   --- a/qapi/net.json
>>>>   +++ b/qapi/net.json
>>>>   @@ -714,3 +714,71 @@
>>>>    ##
>>>>    { 'event': 'FAILOVER_NEGOTIATED',
>>>>      'data': {'device-id': 'str'} }
>>>>   +
>>>>   +##
>>>>   +# @NetdevInfo:
>>>>   +#
>>>>   +# Configuration of a network backend device (netdev).
>>>>   +#
>>>>   +# @id: Device identifier.
>>>>   +#
>>>>   +# @type: Specify the driver used for interpreting remaining arguments.
>>>>   +#
>>>>   +# @peer-id: Connected frontend network device identifier.
>>>>   +#
>>>>   +# Since: 5.2
>>>>   +##
>>>>   +{ 'union': 'NetdevInfo',
>>>>   + 'base': { 'id': 'str',
>>>>   + 'type': 'NetClientDriver',
>>>>   + '*peer-id': 'str' },
>>>>   + 'discriminator': 'type',
>>>>   + 'data': {
>>>>   + 'user': 'NetdevUserOptions',
>>>>   + 'tap': 'NetdevTapOptions',
>>>>   + 'l2tpv3': 'NetdevL2TPv3Options',
>>>>   + 'socket': 'NetdevSocketOptions',
>>>>   + 'vde': 'NetdevVdeOptions',
>>>>   + 'bridge': 'NetdevBridgeOptions',
>>>>   + 'netmap': 'NetdevNetmapOptions',
>>>>   + 'vhost-user': 'NetdevVhostUserOptions',
>>>>   + 'vhost-vdpa': 'NetdevVhostVDPAOptions' } }
>>>
>>>  This is union Netdev plus a common member @peer-id, less the variant
>>>  members for NetClientDriver values 'nic' and 'hubport'.
>>>
>>>  Can 'type: 'nic' and 'type': 'hubport' occur?
>>
>>  No, it can't. We don't support NIC/hubport in query-netdevs, so we neither create this
>>  structure for them, nor store config.
>
> Same for 'none', I guess.
>
> As defined, NetdevInfo allows types 'none', 'nic', and 'hubport', it
> just has no variant members for them. The fact that they can't occur is
> not coded into the type, and therefore not visible in introspection.
>
> To make introspection more precise, we'd have to define a new enum type.
> How much that would complicate the C code is unclear.
>
> Do we need it to be more precise? Eric, got an opinion?
>
> Existing type Netdev has the same issue for 'none' and 'nic'. I guess
> this is so we can reuse the type for -net. Not sure that's a good idea,
> but not this patch's problem.
>
>>>  What's the use case for @peer-id?
>>
>>  Main reason is to provide information "is this backend connected to frontend device".
>>  User also may want to know which backend used for frontend device.
>>
>>>  Assuming we want @peer-id: its documentation is too vague. Cases:
>>>
>>>  * Not connected to a frontend: I guess @peer-id is absent then.
>>
>>  Absolutely correct.
>>
>>>  * Connected to a frontend
>>>
>>>    - that has a qdev ID (the thing you set with -device id=...): I guess
>>>      it's the qdev ID then.
>>
>>  Correct.
>>
>>>    - that doesn't have a qdev ID: anyone's guess.
>>
>>  We use field "name" of structure NetClientState, so if there is no direct ID setting,
>>  there must be generated name (in format "model.id").
>
> Perhaps:
>
>       # @peer-id: the connected network backend's name (absent if no
>       # backend is connected)

Maybe you mean:

# @peer-id: The connected frontend network device name (absent if no frontend
# is connected).

In any case, thanks for pointing. I'll add this in the next patch version.

>>>>   +
>>>>   +##
>>>>   +# @query-netdevs:
>>>>   +#
>>>>   +# Get a list of @NetdevInfo for all virtual network backend devices (netdevs).
>>>>   +#
>>>>   +# Returns: a list of @NetdevInfo describing each netdev.
>>>>   +#
>>>>   +# Since: 5.2
>>>>   +#
>>>>   +# Example:
>>>>   +#
>>>>   +# -> { "execute": "query-netdevs" }
>>>>   +# <- { "return": [
>>>>   +# {
>>>>   +# "ipv6": true,
>>>>   +# "ipv4": true,
>>>>   +# "host": "10.0.2.2",
>>>>   +# "ipv6-dns": "fec0::3",
>>>>   +# "ipv6-prefix": "fec0::",
>>>>   +# "net": "10.0.2.0/255.255.255.0",
>>>>   +# "ipv6-host": "fec0::2",
>>>>   +# "type": "user",
>>>>   +# "peer-id": "net0",
>>>>   +# "dns": "10.0.2.3",
>>>>   +# "hostfwd": [
>>>>   +# {
>>>>   +# "str": "tcp::20004-:22"
>>>>   +# }
>>>>   +# ],
>>>>   +# "ipv6-prefixlen": 64,
>>>>   +# "id": "netdev0",
>>>>   +# "restrict": false
>>>>   +# }
>>>>   +# ]
>>>>   +# }
>>>>   +#
>>>>   +##
>>>>   +{ 'command': 'query-netdevs', 'returns': ['NetdevInfo'] }


-- 
Alexey Kirillov
Yandex.Cloud

