Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D93FC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 12:09:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E21420774
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 12:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="vsV8nY7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E21420774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMryD-0001bd-AB
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 08:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lekiravi@yandex-team.ru>)
 id 1kMrwu-00018T-DF
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:08:08 -0400
Received: from forwardcorp1o.mail.yandex.net ([2a02:6b8:0:1a2d::193]:36006)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lekiravi@yandex-team.ru>)
 id 1kMrwp-00028v-HT
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:08:07 -0400
Received: from sas1-5717c3cea310.qloud-c.yandex.net
 (sas1-5717c3cea310.qloud-c.yandex.net
 [IPv6:2a02:6b8:c14:3616:0:640:5717:c3ce])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 27AF12E14F5;
 Mon, 28 Sep 2020 15:07:58 +0300 (MSK)
Received: from localhost (localhost [::1])
 by sas1-5717c3cea310.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 qaNmDTLtwA-7vweCksx; Mon, 28 Sep 2020 15:07:58 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1601294878; bh=TFeXi1yU/KhtkMoxsA6GIFFOCOLN9YqLHbiZxNk4mmU=;
 h=References:Date:Message-Id:Cc:Subject:To:From;
 b=vsV8nY7IqPhMgN1pPys5gnzMEWvxQ4KbIoYrMXZphLLe3N6wHX0XZ49HAvV51Kzw3
 Nd2H7WPEVhw6SQEMUL7e7IXDshOHu4ZpdnKLaoe05+U2BbSv3lJujRLZvUCvoD9y/r
 azzBmenRks9mrhhfNB0dlUEONsEHdY/oK+yiPD28=
Authentication-Results: sas1-5717c3cea310.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000161690
Received: by sas1-841c59a7ad31.qloud-c.yandex.net with HTTP;
 Mon, 28 Sep 2020 15:07:57 +0300
From: Alexey Kirillov <lekiravi@yandex-team.ru>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20200921191912.105305-1-lekiravi@yandex-team.ru>
 <f5c36663-0845-c9fa-1e3b-636aef2ccd4a@yandex-team.ru>
Subject: Re: [PATCH v4 0/4] Introducing QMP query-netdev command
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Mon, 28 Sep 2020 15:07:57 +0300
Message-Id: <65531601293775@mail.yandex-team.ru>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Received-SPF: pass client-ip=2a02:6b8:0:1a2d::193;
 envelope-from=lekiravi@yandex-team.ru; helo=forwardcorp1o.mail.yandex.net
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
Cc: Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping

21.09.2020 22:19, Alexey Kirillov writes:
> This patch series introduces a new QMP command "query-netdev" to get
> information about currently attached backend network devices (netdevs).
> Also, since the "info_str" field of "NetClientState" is now deprecated,
> we no longer use it for netdevs, only for NIC/hubports.
> The HMP command "info network" now also uses the new QMP command inside.
>
> Usage example:
>
> -> { "execute": "query-netdev" }
> <- { "return": [
>          {
>              "listen": "127.0.0.1:90",
>              "type": "socket",
>              "peer-id": "hub0port1",
>              "id": "__org.qemu.net1"
>          },
>          {
>              "script": "/etc/qemu-ifup",
>              "downscript": "/etc/qemu-ifdown",
>              "ifname": "tap0",
>              "type": "tap",
>              "peer-id": "net5",
>              "vnet_hdr": true,
>              "id": "tap0"
>          },
>          {
>              "ipv6": true,
>              "ipv4": true,
>              "host": "10.0.2.2",
>              "ipv6-dns": "fec0::3",
>              "ipv6-prefix": "fec0::",
>              "net": "10.0.2.0/255.255.255.0",
>              "ipv6-host": "fec0::2",
>              "type": "user",
>              "peer-id": "net0",
>              "dns": "10.0.2.3",
>              "hostfwd": [
>                  {
>                      "str": "tcp::20004-:22"
>                  }
>              ],
>              "ipv6-prefixlen": 64,
>              "id": "netdev0",
>              "restrict": false
>          }
>      ]
>    }
>
> v3->v4:
> - Rename "query-netdevs" to "query-netdev".
> - Copy netdev drivers to new QAPI enum "NetBackend".
>
> v2->v3:
> - Remove NIC and hubports from query-netdevs.
> - Remove several fields from NetdevInfo since they are unnecessary.
> - Rename field @peer to @peer-id.
> - Add support of vhost-vdpa.
> - Keep "info_str" for NIC/hubports, but remove it for netdevs.
>
> v1->v2:
> - Rewrite HMP "info network" to get information from results of QMP command.
> - Remove obsolete field "info_str" from "NetClientState".
>
> Alexey Kirillov (4):
>  qapi: net: Add query-netdev command
>  tests: Add tests for query-netdev command
>  hmp: Use QMP query-netdev in hmp_info_network
>  net: Do not use legacy info_str for backends
>
>  include/net/net.h              |  4 +-
>  net/clients.h                  |  1 +
>  net/hub.c                      |  4 +-
>  net/hub.h                      |  2 +-
>  net/l2tpv3.c                    |  21 +++-
>  net/net.c                      | 213 +++++++++++++++++++++++++++++++-
>  net/netmap.c                    |  13 ++
>  net/slirp.c                    | 128 ++++++++++++++++++-
>  net/socket.c                    |  91 ++++++++++----
>  net/tap-win32.c                |  10 +-
>  net/tap.c                      | 107 ++++++++++++++--
>  net/vde.c                      |  39 +++++-
>  net/vhost-user.c                |  20 ++-
>  net/vhost-vdpa.c                |  15 ++-
>  qapi/net.json                  |  80 ++++++++++++
>  tests/qtest/meson.build        |  3 +
>  tests/qtest/test-query-netdev.c | 115 +++++++++++++++++
>  17 files changed, 807 insertions(+), 59 deletions(-)
>  create mode 100644 tests/qtest/test-query-netdev.c
>
> --
> 2.25.1

P.S. Sorry for double-ping (first message was with "Content-Type: text/html", my mistake).

-- 
Alexey Kirillov
Yandex.Cloud


