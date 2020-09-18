Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E10C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 14:33:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4794D208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 14:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/ekACHZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4794D208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJHRi-0001W2-9X
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 10:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kJHPe-0000Vv-31
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 10:31:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22389
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kJHPW-0002Md-EE
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 10:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600439447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YioAiCntb6m5zXkpfoK9aquVxgvrd177Rf2zSWntga4=;
 b=d/ekACHZ3v9WJps1s5wAZeSdqy5uaKAEEt3tGuBZAMH8jobqTWEofDMqmcmc1FagVCigMA
 dACiCb2Ug9TQgSuplQdcZ51g3uPSyU9ecU71Hh1p9keTD4cBT+t9vwbUo6qTlWgW8cDJpq
 z5B22gKfZDX8kseZJKArLHbLTPglAdA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-IpFKK5grNS6Pk-uMI4Yj5g-1; Fri, 18 Sep 2020 10:30:41 -0400
X-MC-Unique: IpFKK5grNS6Pk-uMI4Yj5g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51784107B0F3;
 Fri, 18 Sep 2020 14:30:40 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6816D5D9D5;
 Fri, 18 Sep 2020 14:30:39 +0000 (UTC)
Subject: Re: [PATCH 00/37] qapi: static typing conversion, pt1
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20200915224027.2529813-1-jsnow@redhat.com>
 <17a3ca61-1c9a-8c0b-af89-2d9cad8c544b@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <3cac08c1-f112-8aa9-a792-24ec64e4728f@redhat.com>
Date: Fri, 18 Sep 2020 10:30:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <17a3ca61-1c9a-8c0b-af89-2d9cad8c544b@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 03:47:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.869, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Ben Widawsky <ben@bwidawsk.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/18/20 9:07 AM, Philippe Mathieu-Daudé wrote:
> Cc'ing Ben who offered to help with having the QEMU python
> scripts packaged (and this series is a step toward that).
> 

FWIW, I want to move ./python/qemu/ into ./python/qemu/core, and then 
move ./scripts/qapi to ./python/qemu/qapi.

I will leave the qapi-gen.py stub script behind for compatibility.

Once I've done that, I can add package setup scripts.

I have a long series adding mypy type hints and so forth to 
./python/qemu and adding packaging glue there too, but I shelved it as 
5.1 released and right now I am focusing on QAPI.

> On 9/16/20 12:39 AM, John Snow wrote:
>> Hi, this series starts adding static type hints to the QAPI module. As
>> you can see, the series started getting quite a bit long, so this is
>> only a partial conversion that focuses on a handful of the easier files.
>>
>> The tougher files -- schema.py, expr.py, parser.py -- will each receive
>> their own series as a follow-up to this one.
>>
>> Notes:
>>
>> - This requires Python 3.6+. Python 3.5 is EOL, so let's do that.
>>
>> - Any patch named "add notational type hints" changes ONLY signatures,
>>    which have no runtime impact whatsoever. These are big patches,
>>    but fairly straightforward.
>>
>> - Most other patches are as bite-sized as possible, generally fixing one
>>    single warning.
>>
>> - After patch 6, `flake8 qapi/` should pass 100% on this and every
>>    future commit.
>>
>> - After patch 7, `pylint --rcfile=qapi/pylintrc qapi/` should pass 100%
>>    on this and every future commit.
>>
>> - After patch 16, `mypy --config-file=qapi/mypy.ini qapi/` should pass
>>    100% on this and every future commit.
>>
>> Preliminary refactoring and prerequisites:
>>
>> 001/37: 'python: Require 3.6+'
>> 002/37: '[DO-NOT-MERGE] qapi: add debugging tools'
>> 003/37: 'qapi-gen: Separate arg-parsing from generation'
>> 004/37: 'qapi: move generator entrypoint into module'
>> 005/37: 'qapi: Remove wildcard includes'
>> 006/37: 'qapi: delint using flake8'
>> 007/37: 'qapi: add pylintrc'
>>
>> common.py (and params.py):
>>
>> 008/37: 'qapi/common.py: Remove python compatibility workaround'
>> 009/37: 'qapi/common.py: Add indent manager'
>> 010/37: 'qapi/common.py: delint with pylint'
>> 011/37: 'qapi/common.py: Replace one-letter 'c' variable'
>> 012/37: 'qapi/common.py: check with pylint'
>> 013/37: 'qapi/common.py: add notational type hints'
>> 014/37: 'qapi/common.py: Move comments into docstrings'
>> 015/37: 'qapi/common.py: split build_params into new file'
>> 016/37: 'qapi: establish mypy type-checking baseline'
>>
>> events.py:
>>
>> 017/37: 'qapi/events.py: add notational type hints'
>> 018/37: 'qapi/events.py: Move comments into docstrings'
>>
>> commands.py:
>>
>> 019/37: 'qapi/commands.py: Don't re-bind to variable of different type'
>> 020/37: 'qapi/commands.py: add notational type hints'
>> 021/37: 'qapi/commands.py: enable checking with mypy'
>>
>> source.py:
>>
>> 022/37: 'qapi/source.py: add notational type hints'
>> 023/37: 'qapi/source.py: delint with pylint'
>>
>> gen.py:
>>
>> 024/37: 'qapi/gen.py: Fix edge-case of _is_user_module'
>> 025/37: 'qapi/gen.py: add notational type hints'
>> 026/37: 'qapi/gen.py: Enable checking with mypy'
>> 027/37: 'qapi/gen.py: Remove unused parameter'
>> 028/37: 'qapi/gen.py: update write() to be more idiomatic'
>> 029/37: 'qapi/gen.py: delint with pylint'
>>
>> introspect.py:
>>
>> 030/37: 'qapi/introspect.py: Add a typed 'extra' structure'
>> 031/37: 'qapi/introspect.py: add _gen_features helper'
>> 032/37: 'qapi/introspect.py: create a typed 'Node' data structure'
>> 033/37: 'qapi/introspect.py: add notational type hints'
>>
>> types.py:
>>
>> 034/37: 'qapi/types.py: add notational type hints'
>> 035/37: 'qapi/types.py: remove one-letter variables'
>>
>> visit.py:
>>
>> 036/37: 'qapi/visit.py: remove unused parameters from gen_visit_object'
>> 037/37: 'qapi/visit.py: add notational type hints'
> 


