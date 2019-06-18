Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54203C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 05:33:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A202133F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 05:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A202133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53780 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd6kU-000160-Da
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 01:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55406)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hd6jU-0000gh-Dt
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 01:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hd6jS-000804-Od
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 01:32:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56564)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hd6jS-0007uX-Is
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 01:32:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4AED25F793
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 05:32:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-177.ams2.redhat.com
 [10.36.117.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D0FB5F729;
 Tue, 18 Jun 2019 05:32:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 82C7311386A6; Tue, 18 Jun 2019 07:32:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jason Wang <jasowang@redhat.com>
References: <20190604115221.28364-1-armbru@redhat.com>
 <20190604115221.28364-3-armbru@redhat.com>
 <10f1a64b-cbc7-600f-7a52-cdd57ec5f71f@redhat.com>
Date: Tue, 18 Jun 2019 07:32:27 +0200
In-Reply-To: <10f1a64b-cbc7-600f-7a52-cdd57ec5f71f@redhat.com> (Jason Wang's
 message of "Tue, 18 Jun 2019 11:31:00 +0800")
Message-ID: <87imt3zces.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Tue, 18 Jun 2019 05:32:29 +0000 (UTC)
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

Jason Wang <jasowang@redhat.com> writes:

> On 2019/6/4 =E4=B8=8B=E5=8D=887:52, Markus Armbruster wrote:
>> -netdev tap,helper=3D... is a useless duplicate of -netdev bridge.
>> Deprecate and de-document.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
>
> This requires more thought as TAP could be used independently. Force
> using a "bridge" backend may lead some confusion.

Can you explain your qualms in a bit more detail?

The thoughts that led to this patch:
https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg03164.html

Consensus back then:

1. Add qemu-bridge-helper.c to Jason's "Network device backends"

2. Deprecate -netdev tap parameter "helper"

3. Improve documentation of -netdev bridge

4. Create a manual page for qemu-bridge-helper that also covers
   /etc/qemu/bridge.conf.

5. Fix the nutty error handling in parse_acl_file()

This series covers the first two [PATCH 1+2], and records the remaining
three more permanently [PATCH 3].

