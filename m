Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBACDC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 19:17:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2885205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 19:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2885205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBOPN-00088F-4U
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 15:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tasleson@redhat.com>) id 1iBONn-00078k-34
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 15:15:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tasleson@redhat.com>) id 1iBONl-0003bM-Uj
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 15:15:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35900)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tasleson@redhat.com>) id 1iBONl-0003b9-P5
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 15:15:53 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E070918C426E
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 19:15:52 +0000 (UTC)
Received: from [10.3.112.12] (ovpn-112-12.phx2.redhat.com [10.3.112.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 23F8F1001B22;
 Fri, 20 Sep 2019 19:15:51 +0000 (UTC)
Subject: Re: [RFC 0/4] POC: Generating realistic block errors
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20190919194847.18518-1-tasleson@redhat.com>
 <20190920083630.GA5458@localhost.localdomain>
 <566d0d07-35fc-2d66-a47c-00526546b31e@redhat.com>
 <c1c6ae56-ce0e-fddc-d72a-98a748b5c897@redhat.com>
From: Tony Asleson <tasleson@redhat.com>
Organization: Red Hat
Message-ID: <c109c513-362e-d042-d34b-700a64ff17a2@redhat.com>
Date: Fri, 20 Sep 2019 14:15:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c1c6ae56-ce0e-fddc-d72a-98a748b5c897@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Fri, 20 Sep 2019 19:15:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Reply-To: tasleson@redhat.com
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/20/19 12:08 PM, Eric Blake wrote:
> I am worried, however, that making data transactions have to go through
> QMP to get an answer on how to handle a specific guest request will slow
> things down; QMP is not built to be an efficient dataplane interface.

IMHO we only need to make the code path efficient up to the point we
know we have an IO operation that contains sector(s) that we want to do
something with.  Once that happens I don't think it will be an issue for
those to be slower.  A real spinning disk drive takes longer to handle a
request when it encounters an error too.

> If you truly want isolation (where another process receives all guest
> transactions, and makes decisions on how to handle them)

It would only handle specific sector(s) of interest, not all.

-Tony

