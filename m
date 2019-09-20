Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EB0C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 19:26:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E1D2080F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 19:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E1D2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBOY1-0005dk-TN
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 15:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60847)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tasleson@redhat.com>) id 1iBOX0-0004gs-DY
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 15:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tasleson@redhat.com>) id 1iBOWy-0006rq-FY
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 15:25:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59714)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tasleson@redhat.com>)
 id 1iBOWt-0006qV-UB; Fri, 20 Sep 2019 15:25:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 389FC10DCC8B;
 Fri, 20 Sep 2019 19:25:19 +0000 (UTC)
Received: from [10.3.112.12] (ovpn-112-12.phx2.redhat.com [10.3.112.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 977CA5D6B0;
 Fri, 20 Sep 2019 19:25:15 +0000 (UTC)
Subject: Re: [RFC 4/4] ahci media error reporting
To: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20190919194847.18518-1-tasleson@redhat.com>
 <20190919194847.18518-5-tasleson@redhat.com>
 <df07a621-8515-2414-2f59-a7eb7eebd75b@redhat.com>
 <20190920084327.GB5458@localhost.localdomain>
 <5ffcd3c0-eaa6-acdb-8c70-8ebb6b559c53@redhat.com>
From: Tony Asleson <tasleson@redhat.com>
Organization: Red Hat
Message-ID: <549bb50e-7300-48e7-4de6-47976770b9ca@redhat.com>
Date: Fri, 20 Sep 2019 14:25:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5ffcd3c0-eaa6-acdb-8c70-8ebb6b559c53@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Fri, 20 Sep 2019 19:25:19 +0000 (UTC)
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/20/19 11:18 AM, John Snow wrote:
> For sure -- I handle the normative cases, but I don't test what happens
> if you issue an unsupported NCQ command. (I don't know what real
> hardware does right now, either. I'm sure I could read the spec and find
> out, but don't have a testing setup that lets me analyze real hardware
> anymore.)

Regardless of what actual hardware does, it's always good to see what
the spec says as hardware folks get it wrong too sometimes :-)

-Tony

