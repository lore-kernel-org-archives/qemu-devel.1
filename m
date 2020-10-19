Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9960EC43457
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 14:37:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 138B2222E9
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 14:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KNIW7Jam"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 138B2222E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUWHS-0005Bq-M0
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 10:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kUWFA-0003WW-Ve
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 10:34:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32581)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kUWF8-0005r3-Qf
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 10:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603118072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uspDEkghDJ2IE6SLJs8AHDOUfIMnpEgsc89EmFr4N5Y=;
 b=KNIW7JamyyGIkHQ1bQu0BSVVr4dbtVUtNBrRiMD4umoaNk13WN6FHlub3MgtOmn8Iyvrxo
 Xfx5bQGDh4ev/HG1p/E2Y4HdaYK+IlJNpBNjsyz4pcc3kkAZN4r2eU0ybTrO81QWNf1kY3
 Na/Q0N8m2Dha+7FmABatCT9yygsvHCA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-c8PqZRFpMTK6P7sqQrd5Yw-1; Mon, 19 Oct 2020 10:34:28 -0400
X-MC-Unique: c8PqZRFpMTK6P7sqQrd5Yw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD85F195CC42;
 Mon, 19 Oct 2020 14:34:26 +0000 (UTC)
Received: from [10.10.114.194] (ovpn-114-194.rdu2.redhat.com [10.10.114.194])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 27A646EF42;
 Mon, 19 Oct 2020 14:34:26 +0000 (UTC)
Subject: Re: [PULL 00/34] QAPI patches patches for 2020-10-10
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20201010095504.796182-1-armbru@redhat.com>
 <7f68ee42-dce8-b304-365a-402c5b37147b@amsat.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <e1c433cd-811c-67be-8a6e-57dc1b9d2ea6@redhat.com>
Date: Mon, 19 Oct 2020 10:34:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <7f68ee42-dce8-b304-365a-402c5b37147b@amsat.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 01:44:30
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/18/20 3:29 AM, Philippe Mathieu-Daudé wrote:
> On 10/10/20 11:54 AM, Markus Armbruster wrote:
>> The following changes since commit 
>> 4a7c0bd9dcb08798c6f82e55b5a3423f7ee669f1:
>>
>>    Merge remote-tracking branch 
>> 'remotes/dgibson/tags/ppc-for-5.2-20201009' into staging (2020-10-09 
>> 15:48:04 +0100)
>>
>> are available in the Git repository at:
>>
>>    git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2020-10-10
>>
>> for you to fetch changes up to b4c0aa59aff520e2a55edd5fef393058ca6520de:
>>
>>    qapi/visit.py: add type hint annotations (2020-10-10 11:37:49 +0200)
>>
>> ----------------------------------------------------------------
>> QAPI patches patches for 2020-10-10
> 
> The "GCC check-tcg (user)" is 6 min slower since this pull request,
> making Travis-CI fails:
> 
> https://travis-ci.org/github/qemu/qemu/builds/734773760
> https://travis-ci.org/github/qemu/qemu/builds/734983001
> 
> Any remote idea what could be the reason?
> 

Not even in the slightest. Is it consistently slower and you are 
positive it is related to explicitly this?

Here's a run (after this PR) that's at 42.5 minutes:
https://travis-ci.org/github/qemu/qemu/builds/736183657

--js

>> ----------------------------------------------------------------
>> John Snow (34):
>>        docs: repair broken references
>>        qapi: modify docstrings to be sphinx-compatible
>>        qapi-gen: Separate arg-parsing from generation
>>        qapi: move generator entrypoint into package
>>        qapi: Prefer explicit relative imports
>>        qapi: Remove wildcard includes
>>        qapi: enforce import order/styling with isort
>>        qapi: delint using flake8
>>        qapi: add pylintrc
>>        qapi/common.py: Remove python compatibility workaround
>>        qapi/common.py: Add indent manager
>>        qapi/common.py: delint with pylint
>>        qapi/common.py: Replace one-letter 'c' variable
>>        qapi/common.py: check with pylint
>>        qapi/common.py: add type hint annotations
>>        qapi/common.py: Convert comments into docstrings, and elaborate
>>        qapi/common.py: move build_params into gen.py
>>        qapi: establish mypy type-checking baseline
>>        qapi/events.py: add type hint annotations
>>        qapi/events.py: Move comments into docstrings
>>        qapi/commands.py: Don't re-bind to variable of different type
>>        qapi/commands.py: add type hint annotations
>>        qapi/source.py: add type hint annotations
>>        qapi/source.py: delint with pylint
>>        qapi/gen: Make _is_user_module() return bool
>>        qapi/gen.py: add type hint annotations
>>        qapi/gen.py: Remove unused parameter
>>        qapi/gen.py: update write() to be more idiomatic
>>        qapi/gen.py: delint with pylint
>>        qapi/types.py: add type hint annotations
>>        qapi/types.py: remove one-letter variables
>>        qapi/visit.py: assert tag_member contains a QAPISchemaEnumType
>>        qapi/visit.py: remove unused parameters from gen_visit_object
>>        qapi/visit.py: add type hint annotations
>>
>>   docs/devel/multi-thread-tcg.rst |   2 +-
>>   docs/devel/testing.rst          |   2 +-
>>   scripts/qapi-gen.py             |  57 +++----------
>>   scripts/qapi/.flake8            |   2 +
>>   scripts/qapi/.isort.cfg         |   7 ++
>>   scripts/qapi/commands.py        |  90 ++++++++++++++------
>>   scripts/qapi/common.py          | 174 
>> +++++++++++++++++++++-----------------
>>   scripts/qapi/events.py          |  58 +++++++++----
>>   scripts/qapi/expr.py            |   7 +-
>>   scripts/qapi/gen.py             | 180 
>> +++++++++++++++++++++++++---------------
>>   scripts/qapi/introspect.py      |  16 +++-
>>   scripts/qapi/main.py            |  95 +++++++++++++++++++++
>>   scripts/qapi/mypy.ini           |  30 +++++++
>>   scripts/qapi/parser.py          |   6 +-
>>   scripts/qapi/pylintrc           |  70 ++++++++++++++++
>>   scripts/qapi/schema.py          |  33 ++++----
>>   scripts/qapi/source.py          |  35 +++++---
>>   scripts/qapi/types.py           | 125 +++++++++++++++++++---------
>>   scripts/qapi/visit.py           | 116 +++++++++++++++++++-------
>>   19 files changed, 764 insertions(+), 341 deletions(-)
>>   create mode 100644 scripts/qapi/.flake8
>>   create mode 100644 scripts/qapi/.isort.cfg
>>   create mode 100644 scripts/qapi/main.py
>>   create mode 100644 scripts/qapi/mypy.ini
>>   create mode 100644 scripts/qapi/pylintrc
>>
> 


