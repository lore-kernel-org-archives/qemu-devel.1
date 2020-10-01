Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358B6C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 08:55:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E89207F7
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 08:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xlvcy2VI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E89207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNuNE-0000MS-Dl
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 04:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNuLy-0007if-1M
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 04:54:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41000)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNuLw-0005Zy-5o
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 04:54:17 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601542455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GWaxj/TTCRfGD8bPi1H+q607va6GR/kvojv1ba9j87M=;
 b=Xlvcy2VIzaujX6C4U59ivu0nS1QI7tanJ1tBjPsU4fBpsKTaiyIZm29yArmBZ4teuZ4Ux5
 r6cQ2QMNYDA6y7sSkyu3BCMm275LlhTUnKVbb8W4vXmPd1BvQZ/CXqJdGEUod3q/qllWNP
 iwnx4GA3W/qiZZmEG2fCzHc5AVnT/Dk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350--chwiWrzNFSAGpHJ1bVpRg-1; Thu, 01 Oct 2020 04:54:13 -0400
X-MC-Unique: -chwiWrzNFSAGpHJ1bVpRg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A828D1015CB5;
 Thu,  1 Oct 2020 08:54:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7241E60DA0;
 Thu,  1 Oct 2020 08:54:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DDBA3113864A; Thu,  1 Oct 2020 10:54:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v4 04/46] qapi: modify docstrings to be sphinx-compatible
References: <20200930043150.1454766-1-jsnow@redhat.com>
 <20200930043150.1454766-5-jsnow@redhat.com>
 <87wo0bejmy.fsf@dusky.pond.sub.org>
 <4bb15cb7-ddcc-ae41-dcb8-81aaa7117ffa@redhat.com>
Date: Thu, 01 Oct 2020 10:54:10 +0200
In-Reply-To: <4bb15cb7-ddcc-ae41-dcb8-81aaa7117ffa@redhat.com> (John Snow's
 message of "Wed, 30 Sep 2020 13:38:23 -0400")
Message-ID: <87a6x6498t.fsf@dusky.pond.sub.org>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 9/30/20 4:47 AM, Markus Armbruster wrote:
>> Sadly, the fact that start_if() and end_if() are functions isn't
>> immediately obvious anymore.
>> I've seen :func:`start_if` elsewhere.  Is this something we should
>> or
>> want to use?
>
> Looks like `start_if()` works just fine too. If you are hard-set in
> wanting to see those parentheses I can use this style, but admit I am 
> not likely to use them myself in newer docstrings, and there's no way
> to enforce their presence OR absence that I am aware of.

Well, there's no way to enforce presence or absence of ` either, right?

Aside: checking the enclosed text resolves as a cross-reference could
provide good-enough enforcement of absence, but enclosing stuff in `
when you shouldn't is probably the lesser issue.

> I'll bake that change in for now until I see another reply.

Since this is a side show right now, consider the arguments raised so
far, use your judgement, and move on to the main show.


