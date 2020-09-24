Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A79C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:51:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65C362074B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4GDJWmq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C362074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLSab-0005k3-3j
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 10:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kLSZ9-0004tr-8j
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 10:49:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56711)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kLSZ7-00072i-0n
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 10:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600958983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V9x6r+U0bJoMYJBuBmVd0ObQj4y5h1Wa0mBTEsaaoRk=;
 b=J4GDJWmqH3Ye78A94G+E/ZE4vrRijSNxU3obAXIfRu7z9xkIbboY1cd7HvDTaaRyFgoM0D
 nycM2/y1KPlDY27Oz6XHrCk3WOH+/u3vIqJD6W+VLbMSjI+Z8oiN2a9oEETh9NrwJ+VRO4
 GdL3muvlXtx4ydb+13IVsSjrHmHNnbc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-_7pT5y4NOemhbgMVGMgUtw-1; Thu, 24 Sep 2020 10:49:41 -0400
X-MC-Unique: _7pT5y4NOemhbgMVGMgUtw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 462D4AD508;
 Thu, 24 Sep 2020 14:49:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-70.ams2.redhat.com
 [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F01CF7368B;
 Thu, 24 Sep 2020 14:49:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7B20C113865F; Thu, 24 Sep 2020 16:49:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v5 00/20] Convert QAPI doc comments to generate rST
 instead of texinfo
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <CAFEAcA9cyKVwONYuzG3oPcQQ9sibpdtetCjcBe3133gd09Aa9w@mail.gmail.com>
 <87d0314nmp.fsf@dusky.pond.sub.org>
 <CAFEAcA9ABUwa_TnyczsO+TtSncX0hHwN7_zgyGGWP6nWtEkdDQ@mail.gmail.com>
 <87eenhzget.fsf@dusky.pond.sub.org>
 <CAFEAcA_zWkthoVGr+6NbjqsWvrinJ1R6gVaA2HAVauOy8ENGDA@mail.gmail.com>
 <CAFEAcA9enJKCjDeAaW6AOz8Udxh5fOVznOzC56rjg3G+5NNCCA@mail.gmail.com>
Date: Thu, 24 Sep 2020 16:49:38 +0200
In-Reply-To: <CAFEAcA9enJKCjDeAaW6AOz8Udxh5fOVznOzC56rjg3G+5NNCCA@mail.gmail.com>
 (Peter Maydell's message of "Thu, 24 Sep 2020 15:13:32 +0100")
Message-ID: <87mu1f8c1p.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 4 Sep 2020 at 17:05, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On Fri, 4 Sep 2020 at 16:54, Markus Armbruster <armbru@redhat.com> wrote:
>> > visit_module() lets you see the modules.
>> >
>> > visit_include() lets you see the includes.  The same module can be
>> > included multiple times.  Having to filter that out would be annoying.
>>
>> I don't think you'd need to filter it out for this use case -- I
>> assume Sphinx would just ignore the unnecessary extra dependency
>> information. But if visit_module() does what we want and you
>> recommend it I'll look at that.
>
> visit_module() seems to work. I notice it gets called with None
> before it's called with the filename of the top level qapi-schema.json,
> but it's easy enough to ignore the 'None' call...

None stands for the (nameless) module containing built-in stuff.


