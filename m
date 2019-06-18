Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23017C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 05:49:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD6042147A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 05:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD6042147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53896 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd70A-00047g-W7
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 01:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59828)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hd6zG-0003fq-NP
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 01:48:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hd6zF-0002xk-K0
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 01:48:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51522)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hd6zF-0002wS-E6
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 01:48:53 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D1082356CA
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 05:48:43 +0000 (UTC)
Received: from [10.72.12.155] (ovpn-12-155.pek2.redhat.com [10.72.12.155])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EFEE51001DCB;
 Tue, 18 Jun 2019 05:48:42 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>
References: <20190604115221.28364-1-armbru@redhat.com>
 <20190604115221.28364-3-armbru@redhat.com>
 <10f1a64b-cbc7-600f-7a52-cdd57ec5f71f@redhat.com>
 <87imt3zces.fsf@dusky.pond.sub.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <42a29307-00cc-5b30-ea8d-1a960a90f599@redhat.com>
Date: Tue, 18 Jun 2019 13:48:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87imt3zces.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 18 Jun 2019 05:48:52 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/3] net: Deprecate tap backend's parameter
 "helper"
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/6/18 =E4=B8=8B=E5=8D=881:32, Markus Armbruster wrote:
> Jason Wang <jasowang@redhat.com> writes:
>
>> On 2019/6/4 =E4=B8=8B=E5=8D=887:52, Markus Armbruster wrote:
>>> -netdev tap,helper=3D... is a useless duplicate of -netdev bridge.
>>> Deprecate and de-document.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>
>> This requires more thought as TAP could be used independently. Force
>> using a "bridge" backend may lead some confusion.
> Can you explain your qualms in a bit more detail?
>
> The thoughts that led to this patch:
> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg03164.html
>
> Consensus back then:
>
> 1. Add qemu-bridge-helper.c to Jason's "Network device backends"
>
> 2. Deprecate -netdev tap parameter "helper"


The problem comes from this point. The main reason is TAP could be used=20
without bridge e.g:

- you can simply assign an IP and and properly configure route table on=20
host to make it work

- or setup tc actions or using XDP to transfer packets between TAP and=20
another interfaces

- using AF_PACKET or other socket to capture the traffic and do the=20
forwarding in userspace

So it looks to me switching to use -netdev bridge is inappropriate.

Thanks



>
> 3. Improve documentation of -netdev bridge
>
> 4. Create a manual page for qemu-bridge-helper that also covers
>     /etc/qemu/bridge.conf.
>
> 5. Fix the nutty error handling in parse_acl_file()
>
> This series covers the first two [PATCH 1+2], and records the remaining
> three more permanently [PATCH 3].
>

