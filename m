Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CCDC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:38:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9622B22224
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="cW1enXkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9622B22224
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kITtQ-00035R-IU
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 05:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lekiravi@yandex-team.ru>)
 id 1kITsj-0002We-1i
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:37:41 -0400
Received: from forwardcorp1p.mail.yandex.net
 ([2a02:6b8:0:1472:2741:0:8b6:217]:52162)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lekiravi@yandex-team.ru>)
 id 1kITse-0006xX-5o
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:37:39 -0400
Received: from iva8-d077482f1536.qloud-c.yandex.net
 (iva8-d077482f1536.qloud-c.yandex.net
 [IPv6:2a02:6b8:c0c:2f26:0:640:d077:482f])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 006DC2E1479;
 Wed, 16 Sep 2020 12:37:29 +0300 (MSK)
Received: from localhost (localhost [::1])
 by iva8-d077482f1536.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 4cw7lI0dfQ-bRvqGa8M; Wed, 16 Sep 2020 12:37:28 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1600249048; bh=r5Re/4/+svCR7Rj7iXiKRnEI5cVuFJB3/vUFrP976+o=;
 h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
 b=cW1enXkLzAw6gJu3DxHriVeXouK6YmhhW+iVxRtFVhDccf2gh45Z/BM11+qDJcIg7
 TMnwIkWUwGIUIyQ0E39JEP6tR/eStt3SlUtRfYqCO3xCOPtEe6DG6EwzsC5uA+8mUq
 Z7/nuxeO/CZouEkx/LIUe3Gx34NUhIKasJBT8gXk=
Authentication-Results: iva8-d077482f1536.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000161690
Received: by iva4-6d0ca09d92db.qloud-c.yandex.net with HTTP;
 Wed, 16 Sep 2020 12:37:27 +0300
From: Alexey Kirillov <lekiravi@yandex-team.ru>
To: Markus Armbruster <armbru@redhat.com>,
	Eric Blake <eblake@redhat.com>
In-Reply-To: <87tuw8731m.fsf@dusky.pond.sub.org>
References: <20200901182326.59633-1-lekiravi@yandex-team.ru>
 <20200901182326.59633-2-lekiravi@yandex-team.ru>
 <87lfhsjubv.fsf@dusky.pond.sub.org>
 <37711599469320@mail.yandex-team.ru>
 <871rjdrca0.fsf@dusky.pond.sub.org>
 <b632d444-bdf9-648b-9d55-a9e72efb8fbc@redhat.com>
 <87tuw8731m.fsf@dusky.pond.sub.org>
Subject: Re: [PATCH v3 1/4] qapi: net: Add query-netdevs command
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Wed, 16 Sep 2020 12:37:27 +0300
Message-Id: <32031600248373@mail.yandex-team.ru>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Received-SPF: pass client-ip=2a02:6b8:0:1472:2741:0:8b6:217;
 envelope-from=lekiravi@yandex-team.ru; helo=forwardcorp1p.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 05:37:29
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

08.09.2020, 17:32, "Markus Armbruster" <armbru@redhat.com>:
> Eric Blake <eblake@redhat.com> writes:
>
>>  On 9/7/20 7:39 AM, Markus Armbruster wrote:
>>
>>>>>  This is union Netdev plus a common member @peer-id, less the variant
>>>>>  members for NetClientDriver values 'nic' and 'hubport'.
>>>>>
>>>>>  Can 'type: 'nic' and 'type': 'hubport' occur?
>>>>
>>>>  No, it can't. We don't support NIC/hubport in query-netdevs, so we neither create this
>>>>  structure for them, nor store config.
>>>  Same for 'none', I guess.
>>>  As defined, NetdevInfo allows types 'none', 'nic', and 'hubport', it
>>>  just has no variant members for them. The fact that they can't occur is
>>>  not coded into the type, and therefore not visible in introspection.
>>>  To make introspection more precise, we'd have to define a new enum
>>>  type.
>>>  How much that would complicate the C code is unclear.
>>>  Do we need it to be more precise? Eric, got an opinion?
>>
>>  Is the problem that a new enum would be duplicating things?
>
> Enumerating network drivers twice is mildly annoying. I worry more
> about having to convert between the two enumerations in C.
>
> My actual question: do we need query-qmp-schema report the precise set
> of 'type' values? As is, it reports a few that can't actually occur.
>
>>                                                               Is it
>>  worth allowing one enum to have a 'base':'OtherEnum' in the schema to
>>  reduce some of the duplication?
>
> We could then generate functions (or macros) to convert from base enum
> to extended enum, and back, where the latter can fail.
>
> Worthwhile only if we have sufficient use for it.

I'm sorry, did I understand correctly that at the moment I don't need any
additional changes in the patch yet?
If that is, I will continue using NetClientDriver as a discriminator.

-- 
Alexey Kirillov
Yandex.Cloud

