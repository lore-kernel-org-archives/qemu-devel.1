Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2201C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 13:14:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C4692067D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 13:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C4692067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hucp2-0006rr-RO
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 09:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53693)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mprivozn@redhat.com>) id 1hucoh-0006S6-B7
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 09:14:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mprivozn@redhat.com>) id 1hucog-00070a-6m
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 09:14:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53954)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1hucog-000709-1i
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 09:14:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3CF6CA707;
 Mon,  5 Aug 2019 13:14:21 +0000 (UTC)
Received: from [10.40.204.137] (ovpn-204-137.brq.redhat.com [10.40.204.137])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C26B5D6C8;
 Mon,  5 Aug 2019 13:14:14 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>
References: <350c3150b25e0c44e24e0a3bd15dacc7284684c9.1565009145.git.mprivozn@redhat.com>
 <CAFEAcA8BfOw5Q3L8zqsw16C7askG7bdNVPoJT-aAE2Tr6-a=3Q@mail.gmail.com>
From: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
Message-ID: <fb8fea4d-461e-6cbe-91fd-83d0e762a5dd@redhat.com>
Date: Mon, 5 Aug 2019 15:14:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8BfOw5Q3L8zqsw16C7askG7bdNVPoJT-aAE2Tr6-a=3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: sk-SK
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Mon, 05 Aug 2019 13:14:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] Makefile: Drop $(DESTDIR) from generated
 FW paths
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
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/5/19 3:00 PM, Peter Maydell wrote:
> <snip/>
> Hi -- this looks like a duplicate of
> https://patchew.org/QEMU/20190530192812.17637-1-olaf@aepfle.de/
> 
> (which Philippe has put in a pullreq which I guess is
> destined for 4.1, though I'm still waiting for confirmation
> of that, ie that it really is a for-4.1-worthy bug).
> 

Ah, did not realize that. Sorry. I've replied there.

Michal


