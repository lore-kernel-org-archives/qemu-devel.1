Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14B7C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 10:38:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5361120768
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 10:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="VNHjOMzB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5361120768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFEXk-0007Nr-BQ
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 06:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lekiravi@yandex-team.ru>)
 id 1kFEWy-00063E-Jw
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 06:37:48 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:50098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lekiravi@yandex-team.ru>)
 id 1kFEWu-0004EA-Cg
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 06:37:46 -0400
Received: from sas1-ec30c78b6c5b.qloud-c.yandex.net
 (sas1-ec30c78b6c5b.qloud-c.yandex.net
 [IPv6:2a02:6b8:c14:2704:0:640:ec30:c78b])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 5A5FC2E1516;
 Mon,  7 Sep 2020 13:37:38 +0300 (MSK)
Received: from localhost (localhost [::1])
 by sas1-ec30c78b6c5b.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 GfDwWv2BTn-bbwaIiKV; Mon, 07 Sep 2020 13:37:38 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1599475058; bh=cwcsiQlrmauxS/kvXdy+OJF6Jf56aoZ0/BafKIkkCoE=;
 h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
 b=VNHjOMzBjmsnFBEPs4/Pbac3EWe89QQlO4tZnwYjlTZu/yPQqqsbIWmslEUrsLefB
 v6S2WM/u/7OCFTUDam6si7JjmMapJ9fQpVPP5Ywfo6zxpMli3v0mOdyJ34W44mspe+
 eLuRM140MJ6iXd+w29dwfj65JDIqY/celOH7xydk=
Authentication-Results: sas1-ec30c78b6c5b.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000161690
Received: by sas1-1199a7868807.qloud-c.yandex.net with HTTP;
 Mon, 07 Sep 2020 13:37:37 +0300
From: Alexey Kirillov <lekiravi@yandex-team.ru>
To: Markus Armbruster <armbru@redhat.com>
In-Reply-To: <87lfhsjubv.fsf@dusky.pond.sub.org>
References: <20200901182326.59633-1-lekiravi@yandex-team.ru>
 <20200901182326.59633-2-lekiravi@yandex-team.ru>
 <87lfhsjubv.fsf@dusky.pond.sub.org>
Subject: Re: [PATCH v3 1/4] qapi: net: Add query-netdevs command
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Mon, 07 Sep 2020 13:37:37 +0300
Message-Id: <37711599469320@mail.yandex-team.ru>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Received-SPF: pass client-ip=5.45.199.163;
 envelope-from=lekiravi@yandex-team.ru; helo=forwardcorp1j.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 06:37:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
 Vincenzo Maffione <v.maffione@gmail.com>, Luigi Rizzo <rizzo@iet.unipi.it>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi!

02.09.2020, 14:23, "Markus Armbruster" <armbru@redhat.com>:
> Alexey Kirillov <lekiravi@yandex-team.ru> writes:
>
>>  Add a qmp command that provides information about currently attached
>>  backend network devices and their configuration.
>>
>>  Signed-off-by: Alexey Kirillov <lekiravi@yandex-team.ru>
>
> [...]
>>  diff --git a/qapi/net.json b/qapi/net.json
>>  index ddb113e5e5..c09322bb42 100644
>>  --- a/qapi/net.json
>>  +++ b/qapi/net.json
>>  @@ -714,3 +714,71 @@
>>   ##
>>   { 'event': 'FAILOVER_NEGOTIATED',
>>     'data': {'device-id': 'str'} }
>>  +
>>  +##
>>  +# @NetdevInfo:
>>  +#
>>  +# Configuration of a network backend device (netdev).
>>  +#
>>  +# @id: Device identifier.
>>  +#
>>  +# @type: Specify the driver used for interpreting remaining arguments.
>>  +#
>>  +# @peer-id: Connected frontend network device identifier.
>>  +#
>>  +# Since: 5.2
>>  +##
>>  +{ 'union': 'NetdevInfo',
>>  + 'base': { 'id': 'str',
>>  + 'type': 'NetClientDriver',
>>  + '*peer-id': 'str' },
>>  + 'discriminator': 'type',
>>  + 'data': {
>>  + 'user': 'NetdevUserOptions',
>>  + 'tap': 'NetdevTapOptions',
>>  + 'l2tpv3': 'NetdevL2TPv3Options',
>>  + 'socket': 'NetdevSocketOptions',
>>  + 'vde': 'NetdevVdeOptions',
>>  + 'bridge': 'NetdevBridgeOptions',
>>  + 'netmap': 'NetdevNetmapOptions',
>>  + 'vhost-user': 'NetdevVhostUserOptions',
>>  + 'vhost-vdpa': 'NetdevVhostVDPAOptions' } }
>
> This is union Netdev plus a common member @peer-id, less the variant
> members for NetClientDriver values 'nic' and 'hubport'.
>
> Can 'type: 'nic' and 'type': 'hubport' occur?

No, it can't. We don't support NIC/hubport in query-netdevs, so we neither create this
structure for them, nor store config.

> What's the use case for @peer-id?

Main reason is to provide information "is this backend connected to frontend device".
User also may want to know which backend used for frontend device.

> Assuming we want @peer-id: its documentation is too vague. Cases:
>
> * Not connected to a frontend: I guess @peer-id is absent then.

Absolutely correct.

> * Connected to a frontend
>
>   - that has a qdev ID (the thing you set with -device id=...): I guess
>     it's the qdev ID then.

Correct.

>   - that doesn't have a qdev ID: anyone's guess.

We use field "name" of structure NetClientState, so if there is no direct ID setting,
there must be generated name (in format "model.id").

>>  +
>>  +##
>>  +# @query-netdevs:
>>  +#
>>  +# Get a list of @NetdevInfo for all virtual network backend devices (netdevs).
>>  +#
>>  +# Returns: a list of @NetdevInfo describing each netdev.
>>  +#
>>  +# Since: 5.2
>>  +#
>>  +# Example:
>>  +#
>>  +# -> { "execute": "query-netdevs" }
>>  +# <- { "return": [
>>  +# {
>>  +# "ipv6": true,
>>  +# "ipv4": true,
>>  +# "host": "10.0.2.2",
>>  +# "ipv6-dns": "fec0::3",
>>  +# "ipv6-prefix": "fec0::",
>>  +# "net": "10.0.2.0/255.255.255.0",
>>  +# "ipv6-host": "fec0::2",
>>  +# "type": "user",
>>  +# "peer-id": "net0",
>>  +# "dns": "10.0.2.3",
>>  +# "hostfwd": [
>>  +# {
>>  +# "str": "tcp::20004-:22"
>>  +# }
>>  +# ],
>>  +# "ipv6-prefixlen": 64,
>>  +# "id": "netdev0",
>>  +# "restrict": false
>>  +# }
>>  +# ]
>>  +# }
>>  +#
>>  +##
>>  +{ 'command': 'query-netdevs', 'returns': ['NetdevInfo'] }


-- 
Alexey Kirillov
Yandex.Cloud

