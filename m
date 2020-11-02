Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2D6C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:41:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D7372242C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tdlb2Obq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7372242C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZbxl-0005vD-Qz
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 10:41:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kZbwl-0004ul-EV
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 10:40:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30063)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kZbwi-000296-C5
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 10:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604331634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lz6eHzceJmgKkbkFYu3n5rr0/q0p9U8/1h5P40FG8pQ=;
 b=Tdlb2Obq1WeXSvmcuR311KZNi83+ZJvmkGovz3s/YnCbvlSELvpw3O0lwDHLPPl0XbqrzF
 JEUMtb/jg2hG9jX3nEiNC/fpTDXSjA6QThpbKTW36tluUsEyWXUvEh4xAaFxe9uKvzt+GD
 FD1O+a51L7LjnIXtqhJ6qsq8H+VVKLQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-xsc7ecfGMTWzNOIUuR00Kw-1; Mon, 02 Nov 2020 10:40:31 -0500
X-MC-Unique: xsc7ecfGMTWzNOIUuR00Kw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E559195CC46
 for <qemu-devel@nongnu.org>; Mon,  2 Nov 2020 15:40:30 +0000 (UTC)
Received: from [10.10.119.97] (ovpn-119-97.rdu2.redhat.com [10.10.119.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C53E16EF73;
 Mon,  2 Nov 2020 15:40:29 +0000 (UTC)
Subject: Re: [PATCH v2 00/11] qapi: static typing conversion, pt2
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20201026194251.11075-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <ec85be81-7f73-a5ea-7bfc-d8f4b575585f@redhat.com>
Date: Mon, 2 Nov 2020 10:40:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201026194251.11075-1-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/26/20 3:42 PM, John Snow wrote:
> Hi, this series adds static type hints to the QAPI module.
> This is part two, and covers introspect.py.
> 
> Part 2: https://gitlab.com/jsnow/qemu/-/tree/python-qapi-cleanup-pt2
> Everything: https://gitlab.com/jsnow/qemu/-/tree/python-qapi-cleanup-pt6
> 
> - Requires Python 3.6+
> - Requires mypy 0.770 or newer (for type analysis only)
> - Requires pylint 2.6.0 or newer (for lint checking only)
> 
> Type hints are added in patches that add *only* type hints and change no
> other behavior. Any necessary changes to behavior to accommodate typing
> are split out into their own tiny patches.
> 
> Every commit should pass with:
>   - flake8 qapi/
>   - pylint --rcfile=qapi/pylintrc qapi/
>   - mypy --config-file=qapi/mypy.ini qapi/
> 
> V2:
>   - Dropped all R-B from previous series; enough has changed.
>   - pt2 is now introspect.py, expr.py is pushed to pt3.
>   - Reworked again to have less confusing (?) type names
>   - Added an assertion to prevent future accidental breakage
> 

Ping!

Patches 1-3: Can be skipped; just enables sphinx to check the docstring 
syntax. Don't worry about these too much, they're just here for you to 
test with.

Patch 4 adds some small changes, to support:
Patch 5 adds the type hints.
Patches 6-11 try to improve the readability of the types and the code.

This was a challenging file to clean up, so I am sure there's lots of 
easy, low-hanging fruit in the review/feedback for me to improve.

> John Snow (11):
>    [DO-NOT-MERGE] docs: replace single backtick (`) with double-backtick
>      (``)
>    [DO-NOT-MERGE] docs/sphinx: change default role to "any"
>    [DO-NOT-MERGE] docs: enable sphinx-autodoc for scripts/qapi
>    qapi/introspect.py: add assertions and casts
>    qapi/introspect.py: add preliminary type hint annotations
>    qapi/introspect.py: add _gen_features helper
>    qapi/introspect.py: Unify return type of _make_tree()
>    qapi/introspect.py: replace 'extra' dict with 'comment' argument
>    qapi/introspect.py: create a typed 'Annotated' data strutcure
>    qapi/introspect.py: improve readability of _tree_to_qlit
>    qapi/introspect.py: Add docstring to _tree_to_qlit
> 
>   docs/conf.py                           |   6 +-
>   docs/devel/build-system.rst            | 120 +++++------
>   docs/devel/index.rst                   |   1 +
>   docs/devel/migration.rst               |  59 +++---
>   docs/devel/python/index.rst            |   7 +
>   docs/devel/python/qapi.commands.rst    |   7 +
>   docs/devel/python/qapi.common.rst      |   7 +
>   docs/devel/python/qapi.error.rst       |   7 +
>   docs/devel/python/qapi.events.rst      |   7 +
>   docs/devel/python/qapi.expr.rst        |   7 +
>   docs/devel/python/qapi.gen.rst         |   7 +
>   docs/devel/python/qapi.introspect.rst  |   7 +
>   docs/devel/python/qapi.main.rst        |   7 +
>   docs/devel/python/qapi.parser.rst      |   8 +
>   docs/devel/python/qapi.rst             |  26 +++
>   docs/devel/python/qapi.schema.rst      |   7 +
>   docs/devel/python/qapi.source.rst      |   7 +
>   docs/devel/python/qapi.types.rst       |   7 +
>   docs/devel/python/qapi.visit.rst       |   7 +
>   docs/devel/tcg-plugins.rst             |  14 +-
>   docs/devel/testing.rst                 |   2 +-
>   docs/interop/live-block-operations.rst |   4 +-
>   docs/system/arm/cpu-features.rst       | 110 +++++-----
>   docs/system/arm/nuvoton.rst            |   2 +-
>   docs/system/s390x/protvirt.rst         |  10 +-
>   qapi/block-core.json                   |   4 +-
>   scripts/qapi/introspect.py             | 277 +++++++++++++++++--------
>   scripts/qapi/mypy.ini                  |   5 -
>   scripts/qapi/schema.py                 |   2 +-
>   29 files changed, 487 insertions(+), 254 deletions(-)
>   create mode 100644 docs/devel/python/index.rst
>   create mode 100644 docs/devel/python/qapi.commands.rst
>   create mode 100644 docs/devel/python/qapi.common.rst
>   create mode 100644 docs/devel/python/qapi.error.rst
>   create mode 100644 docs/devel/python/qapi.events.rst
>   create mode 100644 docs/devel/python/qapi.expr.rst
>   create mode 100644 docs/devel/python/qapi.gen.rst
>   create mode 100644 docs/devel/python/qapi.introspect.rst
>   create mode 100644 docs/devel/python/qapi.main.rst
>   create mode 100644 docs/devel/python/qapi.parser.rst
>   create mode 100644 docs/devel/python/qapi.rst
>   create mode 100644 docs/devel/python/qapi.schema.rst
>   create mode 100644 docs/devel/python/qapi.source.rst
>   create mode 100644 docs/devel/python/qapi.types.rst
>   create mode 100644 docs/devel/python/qapi.visit.rst
> 


