Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7098CC10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 08:46:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35F4C20767
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 08:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fmUsJMOU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F4C20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEUKv-0006Xi-Db
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 04:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52839)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jEUK3-0005pz-LJ
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 04:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jEUK1-0007jd-6s
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 04:45:06 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:43453)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jEUK0-0007Zr-WB
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 04:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584521103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=heUApGX4S2221MxWIL+wmJrJjPFrmN3msybUoGR6BP4=;
 b=fmUsJMOUIV06I2oCbznvTmAJ+6HNp24wNop6ImR8xvGqecNpg/kmr75DXea0f67SdyVxmU
 yXWUvKW40gv3qzK8wGJVq+Qq2whWtEMOv+Nmz6XL+n7KwOfE9VhjdpZBENTNCJgcsTsMp5
 QdqwmOfkPuVQx3X+WxcuEPEbirQYMMw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-Xlp4TP5DNxKYJezhWNphWQ-1; Wed, 18 Mar 2020 04:44:59 -0400
X-MC-Unique: Xlp4TP5DNxKYJezhWNphWQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA3EB800D53;
 Wed, 18 Mar 2020 08:44:58 +0000 (UTC)
Received: from [10.72.13.166] (ovpn-13-166.pek2.redhat.com [10.72.13.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E0C0873865;
 Wed, 18 Mar 2020 08:44:56 +0000 (UTC)
Subject: Re: [PATCH v2 0/2] net/colo-compare.c: Expose COLO-compare parameters
 to users
To: Zhang Chen <chen.zhang@intel.com>, qemu-dev <qemu-devel@nongnu.org>
References: <20200318082320.20768-1-chen.zhang@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e60c00f1-73e3-838a-ea28-09836611e53a@redhat.com>
Date: Wed, 18 Mar 2020 16:44:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200318082320.20768-1-chen.zhang@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Daniel Cho <danielcho@qnap.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/3/18 =E4=B8=8B=E5=8D=884:23, Zhang Chen wrote:
> From: Zhang Chen <chen.zhang@intel.com>
>
> Make a way to config COLO "compare_timeout" and "expired_scan_cycle" para=
meters
> according to user's scenarios and environments.
>
> V2:
>   - Rebased on upstream.
>   - Fixed typos.
>
> Zhang Chen (2):
>    net/colo-compare.c: Expose "compare_timeout" to users
>    net/colo-compare.c: Expose "expired_scan_cycle" to users
>
>   net/colo-compare.c | 95 +++++++++++++++++++++++++++++++++++++++++++---
>   qemu-options.hx    | 10 +++--
>   2 files changed, 97 insertions(+), 8 deletions(-)
>

Applied.

Thanks



