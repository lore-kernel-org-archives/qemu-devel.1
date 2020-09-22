Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729C9C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 23:10:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0718F221EF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 23:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZORFppPD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0718F221EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKrQG-0004bH-2v
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 19:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKrBD-0007QK-Jx
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:54:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43359)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKrBB-0001VN-Da
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600815272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7t0NgnFan1ngd2tpnSwgQqs6d5UMb8Vmj5Jc59NHEqE=;
 b=ZORFppPDI1PcbMJKMI8UhlcZc2xYGqiwgtlzlmZFNmJySHAGZrchkoHpM6ONDop1gHh93h
 7niHzOwvtianliayfBJaypo/ydb+bbIZqDgM9oRoq8TzYqTQnzJRWiFjoJOz4LirJpY2KP
 tQyJvcAUqERMY4YBr2AbCyaDovCIL9I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-gCy81_3IP2Og_9sSVxdSLQ-1; Tue, 22 Sep 2020 18:54:30 -0400
X-MC-Unique: gCy81_3IP2Og_9sSVxdSLQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 718F21005E64;
 Tue, 22 Sep 2020 22:54:29 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA33A614F5;
 Tue, 22 Sep 2020 22:54:28 +0000 (UTC)
Subject: Re: [PATCH 00/26] qapi: static typing conversion, pt5
To: Markus Armbruster <armbru@redhat.com>
References: <20200922223525.4085762-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <8091613c-2277-f08a-386c-6bbf3d241382@redhat.com>
Date: Tue, 22 Sep 2020 18:54:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200922223525.4085762-1-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 15:47:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/22/20 6:34 PM, John Snow wrote:
> based-on: <20200922210101.4081073-1-jsnow@redhat.com>

^ Copy-paste malfunction

based-on: <20200922212115.4084301-1-jsnow@redhat.com>

>            [PATCH 0/6] qapi: static typing conversion, pt4
> 
> Hi, this series adds static type hints to the QAPI module.
> This is part five!
> 
> Part 5: https://gitlab.com/jsnow/qemu/-/tree/python-qapi-cleanup-pt5
> Everything: https://gitlab.com/jsnow/qemu/-/tree/python-qapi-cleanup-pt6
> 
> - Requires Python 3.6+
> - Requires mypy 0.770 or newer (for type analysis only)
> - Requires pylint 2.6.0 or newer (for lint checking only)
> 
> This part of the series focuses on just parser.py.
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
> John Snow (26):
>    qapi/parser.py: refactor parsing routine into method
>    qapi/parser.py: group variable declarations in __init__
>    qapi/parser.py: use 'with' statement for opening files
>    qapi/source.py: Add default arguments to QAPISourceInfo
>    qapi/parser.py: start source info at line 0
>    qapi/parser.py: raise QAPIParseError during file opening
>    qapi/parser.py: fully remove 'null' constant
>    qapi/parser.py: Assert lexer value is a string
>    qapi/parser.py: assert get_expr returns object in outer loop
>    qapi/parser.py: assert object keys are strings
>    qapi/parser.py: Convert several methods to @classmethod
>    qapi/parser.py: add casts to pragma checks
>    qapi/parser.py: add type hint annotations
>    qapi/parser.py: add docstrings
>    qapi/parser.py: add ParsedExpression type
>    qapi/pragma.py: Move QAPISchemaPragma into its own module
>    qapi/pragma.py: Move pragma parsing out of parser.py
>    qapi/parser.py: Modify _include() to use parser state
>    qapi/parser.py: add parent argument
>    qapi/parser.py: remove unused check_args_section arguments
>    qapi/parser.py: QAPIDoc: convert @staticmethod to @classmethod
>    qapi/parser.py: add type hint annotations (QAPIDoc)
>    qapi/parser.py: enable mypy checks
>    qapi/parser.py: remove one and two-letter variables
>    qapi/parser.py: Silence too-few-public-methods warning
>    qapi/parser.py: enable pylint checks
> 
>   scripts/qapi/error.py                     |   8 +-
>   scripts/qapi/expr.py                      |  56 ++--
>   scripts/qapi/mypy.ini                     |   5 -
>   scripts/qapi/parser.py                    | 322 +++++++++++++---------
>   scripts/qapi/pragma.py                    |  68 +++++
>   scripts/qapi/pylintrc                     |   3 +-
>   scripts/qapi/schema.py                    |   6 +-
>   scripts/qapi/source.py                    |  22 +-
>   tests/qapi-schema/leading-comma-list.err  |   2 +-
>   tests/qapi-schema/trailing-comma-list.err |   2 +-
>   10 files changed, 301 insertions(+), 193 deletions(-)
>   create mode 100644 scripts/qapi/pragma.py
> 


