Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1EDC38BE0
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 18:33:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA7CE20838
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 18:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i5qAuM9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA7CE20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6IXN-0007i6-Uy
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 13:33:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j6IVw-0006aE-RB
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 13:31:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j6IVv-0000Ff-AT
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 13:31:32 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39662
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j6IVv-0000Eb-5C
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 13:31:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582569090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ejiAvgCjoes+5qK2CWU1LphuGFNSDDysxJjqN2SmL4c=;
 b=i5qAuM9ngk8PeuqdWHHh+hVGAKGVDVZ609K5QK0uC6Fgl3ErQZcuKDGwCtYa9s+CmDW+No
 7zO6ubzxjkIL2uJpvP41Z8IivbqC8afs7328hq6wDX0g+FCZuHW4AqEpIPJSjiRs7HglcB
 ddCFUIejlBtssghLovfVs9vgEEJ6bh0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-XulnkLYcPNauUPIpskxdxQ-1; Mon, 24 Feb 2020 13:31:26 -0500
X-MC-Unique: XulnkLYcPNauUPIpskxdxQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4C8BA0CC5;
 Mon, 24 Feb 2020 18:31:25 +0000 (UTC)
Received: from [10.3.116.90] (ovpn-116-90.phx2.redhat.com [10.3.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2076C5DA2C;
 Mon, 24 Feb 2020 18:31:22 +0000 (UTC)
Subject: Re: [PATCH v31 20/22] Add rx-softmmu
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200223065102.61652-1-ysato@users.sourceforge.jp>
 <20200223065102.61652-21-ysato@users.sourceforge.jp>
 <da7b0c50-4466-a491-8487-2c3a11984077@redhat.com>
 <598cc17a-9686-e9c5-72b5-5153d29d5a52@redhat.com>
 <fa92ac6a-fff9-e2be-ba7e-2463eec01c6c@redhat.com>
 <CAL1e-=hGQD2aJQhAXiYDnsTa71xm_yoDzVFjuAfB-=ydxkesDg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c044121d-d933-f4e7-184b-1b9f171a541d@redhat.com>
Date: Mon, 24 Feb 2020 12:31:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=hGQD2aJQhAXiYDnsTa71xm_yoDzVFjuAfB-=ydxkesDg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/24/20 11:53 AM, Aleksandar Markovic wrote:

>>>> Missing mention of the new enum member with a 'since 5.0' designation
>>>> in the documentation.
>>>

> Just want to bring to your attention a point that is not clear to me here.
> (forgive me for being an outsider in this area)

No problem - asking questions is how we learn.

> 
> Could you please take a look at commit:
> 
> bb5ccf225e81d2801c03e63d16c371f0617270e8
> <https://github.com/qemu/qemu/commit/bb5ccf225e81d2801c03e63d16c371f0617270e8#diff-d7db5c644ce52a6080e77ef1e7a3811b>
> 
> I am not familiar with QAPI doc generator, but shouldn't "Since: 3.0"
> cause the same problem as "ppcemb: dropped in 3.1"? If not, why?

That was the opposite direction - in that commit, we were removing stale 
comments about a member that was no longer present (if the member is not 
present, the doc engine doesn't know what to attach the tag to, and we 
now have the better qemu-deprecated.texi file for tracking removals). 
And even if the removal is not documented, users that depended on it 
(which should be few, or we would not have removed it), it becomes 
fairly obvious at the attempted point of use that it no longer works.

But when the member is present, but added later than the original 
struct, knowing what release the additional members were added is useful 
documentation when deciding whether support for the new member is 
present on all versions of qemu you care about, or whether your 
management code has to consider the case when the member was absent. 
Yes, you can get the same information from introspection 
programmatically (in fact, when libvirt has to deal with new additions, 
that's how it probes whether the addition is there), but having the 
consistent documentation reminds someone to think about whether checking 
the introspection is necessary.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


