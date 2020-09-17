Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97525C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:37:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FAB622208
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MmKx4LZ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FAB622208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIvyX-0001VI-LL
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 11:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kIvsC-0004jy-GA
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:31:00 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38545
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kIvsA-00073B-H0
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600356657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kQNwo0e9qpd+ZDuWvTBE2M0JEhQ1Ur7vXd2yxXfKIvw=;
 b=MmKx4LZ0+yaEYCbL0Uy0OFMb52NXs2lQBp0i+6K6y5kBVe/oul16MSHS4IzE8Vuu8VELp5
 GkbMFr//RXqTw2Zmn5a1makoAVdHZ5EY3R40UZOjh1FyQcF45LdlSrvsgYsOGJ3+U8TmJ+
 qMu041Zil89eFqzBuiE592mBZhWLsM4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338--6g1XOygMbOhaigER2rtAw-1; Thu, 17 Sep 2020 11:30:36 -0400
X-MC-Unique: -6g1XOygMbOhaigER2rtAw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2435E8BF159;
 Thu, 17 Sep 2020 15:30:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F2F61975E;
 Thu, 17 Sep 2020 15:30:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8C772113864A; Thu, 17 Sep 2020 17:30:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: Python 3.5 EOL; when can require 3.6?
References: <875z8eupyp.fsf@dusky.pond.sub.org>
 <CAFEAcA8q8J1n2UqsNbHgNwEedA8pZ6fNA7obCR1REN-33nvmkg@mail.gmail.com>
 <d07189e2-0683-2eb9-44e0-a275688fa8b4@redhat.com>
 <9d4363e8-7bb8-8255-9914-6d9bc36cec79@redhat.com>
Date: Thu, 17 Sep 2020 17:30:27 +0200
In-Reply-To: <9d4363e8-7bb8-8255-9914-6d9bc36cec79@redhat.com> (Thomas Huth's
 message of "Thu, 17 Sep 2020 16:10:55 +0200")
Message-ID: <871rj0o1yk.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 08:56:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thomas Huth <thuth@redhat.com> writes:

> On 16/09/2020 16.00, Thomas Huth wrote:
>> On 16/09/2020 14.30, Peter Maydell wrote:
>>> On Wed, 16 Sep 2020 at 08:43, Markus Armbruster <armbru@redhat.com> wrote:
>>>> We require Python 3.5.  It will reach its "end of life" at the end of
>>>> September 2020[*].  Any reason not to require 3.6 for 5.2?  qemu-iotests
>>>> already does for its Python parts.
>> [...]
>>> The default should be
>>> "leave the version dependency where it is", not "bump the version
>>> dependency as soon as we can".
>> 
>> OTOH, if none of our supported build systems uses python 3.5 by default
>> anymore, it also will not get tested anymore, so bugs might creep in,
>> which will of course end up in a bad experience for the users, too, that
>> still try to build with such an old version. So limiting the version to
>> the level that we also test is IMHO very reasonable.
>> 
>> Let's have a look at the (older) systems that we support and the python
>> versions according to repology.org:
>> 
>> - RHEL7 / CentOS 7 : 3.6.8
>> - Ubuntu 18.04 (Bionic) : >= 3.6.5
>> - openSUSE Leap 15.0 : >= 3.6.5
>> - OpenBSD Ports : >= 3.7.9
>> - FreeBSD Ports : >= 3.5.10 - but there is also 3.6 or newer
>> - Homebrew : >= 3.7.9
>> 
>> ... so I think it should be fine to retire 3.5 nowadays.
>
> Sorry, I forgot to check Debian. If I got that right, Debian 9 still
> uses Python 3.5 by default. So I guess that means we can not deprecate
> Python 3.5 yet?

Discussed before:

    Subject: Re: [PATCH] qapi: Fix code generation with Python 3.5
    Date: Sat, 18 Jan 2020 07:54:18 +0100
    Message-ID: <87lfq5s19h.fsf@dusky.pond.sub.org>
    https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg03855.html

Short version: Debian != Debian LTS.  We support Debian until EOL, not
LTS.  Debian 9 reached EOL in July.


