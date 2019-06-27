Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA67C48BD3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 02:13:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E90BC21726
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 02:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E90BC21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgJuZ-00077H-1p
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 22:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51621)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hgJqn-0002bG-4v
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 22:09:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hgJqm-0004OL-2u
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 22:09:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45446)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hgJql-0004O1-TN
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 22:09:24 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 429173082AF2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 02:09:23 +0000 (UTC)
Received: from [10.72.12.68] (ovpn-12-68.pek2.redhat.com [10.72.12.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ABE511001B04;
 Thu, 27 Jun 2019 02:09:21 +0000 (UTC)
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
References: <20190517134748.340381-1-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f64c5404-4bf5-1e2a-2161-9db3fa156bec@redhat.com>
Date: Thu, 27 Jun 2019 10:09:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190517134748.340381-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 27 Jun 2019 02:09:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Clean ups in net/net.c
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/5/17 =E4=B8=8B=E5=8D=889:47, Stefano Garzarella wrote:
> This series contains some clean ups in net/net.c
>
> The patch 1 solves an assertion failure when ipv6-prefixlen is not a nu=
mber,
>
> Following the Markus' advice, I modified the parsing of IPv6 prefix
> (patch 2) and IPv4 host:port (patch 3). Then I removed the get_str_sep(=
)
> function (patch 4) because it is no longer used.
>
> v3:
>   - Patch 2:
>     - fix indentation [Markus]
>     - move substrings at the function level, and call g_strfreev(substr=
ings)
>       at the end of the function [Markus]
>   - add Markus' R-b
>
> v2: https://www.mail-archive.com/qemu-devel@nongnu.org/msg615866.html
> v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg614561.html
>
> Stefano Garzarella (4):
>    net: fix assertion failure when ipv6-prefixlen is not a number
>    net: avoid using variable length array in net_client_init()
>    net: use g_strsplit() for parsing host address and port
>    net: remove unused get_str_sep() function
>
>   net/net.c | 99 +++++++++++++++++++++++++++---------------------------=
-
>   1 file changed, 49 insertions(+), 50 deletions(-)
>

Applied.

Thanks


