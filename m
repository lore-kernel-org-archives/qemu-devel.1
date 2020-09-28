Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD3DC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 12:16:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06E322083B
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 12:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NoLhjP9E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E322083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMs4j-0006Mu-T0
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 08:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kMs2T-0004lA-I0
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:13:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21286)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kMs2Q-0002n2-Mn
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:13:53 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601295229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FaBnfHVh0dtkTtElVSXw6nOI7+nNcP/huSbTdwxUHtw=;
 b=NoLhjP9EprKPSgQKDXyij3GVEhAV5Sl86msoiKqnWUx27jm2p5oAG/y1kEb7nvrAneole1
 ChJgl/OFlZfzh7T/OTFQEI+YXd7w5RbuuyuEYBtv9YJsAVuehZtwe5MDSfDTXYKSkxqVJG
 VY92kRAnd+1hNVMGsOdSMN588Ku/4M0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-xDGO77m1PBuyRQ6nfwVX6g-1; Mon, 28 Sep 2020 08:13:48 -0400
X-MC-Unique: xDGO77m1PBuyRQ6nfwVX6g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32EBE10BBEC3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 12:13:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-70.ams2.redhat.com
 [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0282749F7;
 Mon, 28 Sep 2020 12:13:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8B572113865F; Mon, 28 Sep 2020 14:13:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 12/47] qapi: enforce import order/styling with isort
References: <20200925002900.465855-1-jsnow@redhat.com>
 <20200925002900.465855-13-jsnow@redhat.com>
 <87imc2w6uf.fsf@dusky.pond.sub.org>
 <8baab976-1dfd-a7b4-1a1e-47480cf0c4b6@redhat.com>
Date: Mon, 28 Sep 2020 14:13:44 +0200
In-Reply-To: <8baab976-1dfd-a7b4-1a1e-47480cf0c4b6@redhat.com> (John Snow's
 message of "Fri, 25 Sep 2020 11:26:50 -0400")
Message-ID: <87tuvigkuf.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 9/25/20 5:20 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>> 
>>> While we're mucking around with imports, we might as well formalize the
>>> style we use. Let's use isort to do it for us.
>>>
>>> force_sort_within_sections: Intermingles "from x" and "import x" style
>>> statements, such that sorting is always performed strictly on the module
>>> name itself.
>>>
>>> force_grid_wrap=4: Four or more imports from a single module will force
>>> the one-per-line style that's more git-friendly. This will generally
>>> happen for 'typing' imports.
>>>
>>> multi_line_output=3: Uses the one-per-line indented style for long
>>> imports.
>>>
>>> include_trailing_comma: Adds a comma to the last import in a group,
>>> which makes git conflicts nicer to deal with, generally.
>>>
>>> Suggested-by: Cleber Rosa <crosa@redhat.com>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>   scripts/qapi/.isort.cfg    | 5 +++++
>>>   scripts/qapi/commands.py   | 6 +-----
>>>   scripts/qapi/doc.py        | 2 +-
>>>   scripts/qapi/expr.py       | 4 ++--
>>>   scripts/qapi/introspect.py | 3 +--
>>>   scripts/qapi/main.py       | 1 -
>>>   scripts/qapi/parser.py     | 2 +-
>>>   scripts/qapi/schema.py     | 2 +-
>>>   scripts/qapi/types.py      | 1 -
>>>   9 files changed, 12 insertions(+), 14 deletions(-)
>>>   create mode 100644 scripts/qapi/.isort.cfg
>>>
>>> diff --git a/scripts/qapi/.isort.cfg b/scripts/qapi/.isort.cfg
>>> new file mode 100644
>>> index 0000000000..b0aeffec26
>>> --- /dev/null
>>> +++ b/scripts/qapi/.isort.cfg
>>> @@ -0,0 +1,5 @@
>>> +[settings]
>>> +force_sort_within_sections=True
>>> +force_grid_wrap=4
>>> +multi_line_output=3
>>> +include_trailing_comma=True
>>> diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
>>> index e1df0e341f..64ed5278f9 100644
>>> --- a/scripts/qapi/commands.py
>>> +++ b/scripts/qapi/commands.py
>>> @@ -13,11 +13,7 @@
>>>   See the COPYING file in the top-level directory.
>>>   """
>>>   -from .common import (
>>> -    build_params,
>>> -    c_name,
>>> -    mcgen,
>>> -)
>>> +from .common import build_params, c_name, mcgen
>>>   from .gen import QAPIGenCCode, QAPISchemaModularCVisitor, ifcontext
>> Squash this hunk into the previous commit, please.
>> 
>
> Yes, OK.
>
>>>     
>>> diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
>>> index b764a8ccc0..1acb773e0a 100644
>>> --- a/scripts/qapi/doc.py
>>> +++ b/scripts/qapi/doc.py
>>> @@ -5,9 +5,9 @@
>>>   """This script produces the documentation of a qapi schema in texinfo format"""
>>>     import re
>>> +
>>>   from .gen import QAPIGenDoc, QAPISchemaVisitor
>>>   -
>> Do you delete the blank line to keep isort happy?
>> 
>
> isort offers to actually edit your files for you, it isn't just a
> checker, it actually rewrites.
>
> By default, it leaves one space below imports. You can configure it to
> add two. I didn't really have a strong preference, so I left it at the 
> default.
>
> I'm going to leave it at the default for now, but I can change it if
> you have a preference.

PEP 8: "Surround top-level function and class definitions with two blank
lines."

[...]


