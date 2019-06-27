Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DACC48BD3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 02:08:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42AC421726
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 02:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42AC421726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgJq9-0002Ac-7Q
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 22:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51340)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hgJpE-0001je-Q1
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 22:07:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hgJpD-0003iJ-Rf
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 22:07:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55518)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hgJpD-0003hy-Lt
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 22:07:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 918EE308429B
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 02:07:46 +0000 (UTC)
Received: from [10.72.12.68] (ovpn-12-68.pek2.redhat.com [10.72.12.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A2F755C1A1;
 Thu, 27 Jun 2019 02:07:40 +0000 (UTC)
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com, laine@redhat.com
References: <20190620184706.19988-1-dgilbert@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <352837b0-2327-2a80-b084-e85ffd65d372@redhat.com>
Date: Thu, 27 Jun 2019 10:07:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190620184706.19988-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 27 Jun 2019 02:07:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 0/5] network announce;
 interface selection & IDs
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/6/21 =E4=B8=8A=E5=8D=882:47, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Up until now, the 'announce' feature has mainly been used
> for migration where we announce on all interfaces.  Another
> use for 'announce' is in cases of network topology changes.
>
> Since network topology changes may only affect a subset
> of the interfaces, we add an 'interface list' to announce
> to restrict the announcment to the interfaces we're interested
> in.
>
> Multiple topology changes might happen in close succession,
> so we allow multiple timers, each with their own parameters
> (including the interface list).
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
> v5
>    Minor review fixes [Jason]
>
> Dr. David Alan Gilbert (5):
>    net/announce: Allow optional list of interfaces
>    net/announce: Add HMP optional interface list
>    net/announce: Add optional ID
>    net/announce: Add HMP optional ID
>    net/announce: Expand test for stopping self announce
>
>   hmp-commands.hx         |  7 +++-
>   hw/net/virtio-net.c     |  4 +-
>   include/net/announce.h  |  8 +++-
>   monitor/hmp-cmds.c      | 41 ++++++++++++++++++-
>   net/announce.c          | 89 +++++++++++++++++++++++++++++++++++-----=
-
>   net/trace-events        |  3 +-
>   qapi/net.json           | 16 ++++++--
>   tests/virtio-net-test.c | 57 ++++++++++++++++++++++++--
>   8 files changed, 198 insertions(+), 27 deletions(-)


Applied.

Thanks



