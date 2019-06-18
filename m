Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB17C31E5C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 03:12:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8CF520665
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 03:12:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8CF520665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53366 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd4Xe-0008NJ-WB
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 23:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58823)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hd4XB-0007xt-87
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 23:11:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hd4XA-0001Wy-At
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 23:11:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44064)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hd4XA-0001TT-4N
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 23:11:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4DB12308219F
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 03:11:41 +0000 (UTC)
Received: from [10.72.12.155] (ovpn-12-155.pek2.redhat.com [10.72.12.155])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E13051017E31;
 Tue, 18 Jun 2019 03:11:32 +0000 (UTC)
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com, laine@redhat.com
References: <20190613095924.21908-1-dgilbert@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7768e0c1-0e85-5cb7-7fe1-e27429762c16@redhat.com>
Date: Tue, 18 Jun 2019 11:11:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613095924.21908-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 18 Jun 2019 03:11:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 0/5] network announce;
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


On 2019/6/13 =E4=B8=8B=E5=8D=885:59, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Laine asked for some extra features on the network announce support;


It's better to explain why this feature is needed.=C2=A0 Is this because=20
libvirt can change the host network topology on the fly?

Thanks


>
> The first allows the announce timer to announce on a subset of the
> interfaces.
>
> The second allows there to be multiple timers, each with their own
> parameters (including the interface list).
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
> v4
>    Minor typo fixes
>    Expanded the test to check we can stop a running announce
>
> Dr. David Alan Gilbert (5):
>    net/announce: Allow optional list of interfaces
>    net/announce: Add HMP optional interface list
>    net/announce: Add optional ID
>    net/announce: Add HMP optional ID
>    net/announce: Expand test for stopping self announce
>
>   hmp-commands.hx         |  7 +++-
>   hmp.c                   | 41 +++++++++++++++++++-
>   hw/net/virtio-net.c     |  4 +-
>   include/net/announce.h  |  8 +++-
>   net/announce.c          | 83 ++++++++++++++++++++++++++++++++++------=
-
>   net/trace-events        |  3 +-
>   qapi/net.json           | 16 ++++++--
>   tests/virtio-net-test.c | 57 ++++++++++++++++++++++++++--
>   8 files changed, 192 insertions(+), 27 deletions(-)
>

