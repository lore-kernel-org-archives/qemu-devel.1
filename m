Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBBCC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 14:23:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD2B92076C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 14:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QuHZ3MOq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD2B92076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRyjW-0002Fr-Nn
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 10:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kRyfc-000643-Jl
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 10:19:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28824)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kRyfa-00052E-LU
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 10:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602512361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E9ibbqtjEeLlaPJjoL0zxpjcDEpIzeQ7lA32FEIQVjU=;
 b=QuHZ3MOqh4DKQwVpiKU7Fb2w1aG4sVV/SWb5aZqI/1s9MSvBPfAk/8c4kixZcyMXCzGfyA
 81K9uQQljyUvf1uZ7hq5fCqCbUVYUXZLcpSKk8TbdT1QG5pnUNwBb8Mgy02U/Z4zSd/ic1
 ti0HpU/mShOfOe2zFZbniZYBYtVgxGI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-NEQo0_mtPFC8PCj1gVIaWg-1; Mon, 12 Oct 2020 10:19:16 -0400
X-MC-Unique: NEQo0_mtPFC8PCj1gVIaWg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0D3F1921FA2;
 Mon, 12 Oct 2020 14:19:15 +0000 (UTC)
Received: from [10.10.117.231] (ovpn-117-231.rdu2.redhat.com [10.10.117.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 52EB91051B;
 Mon, 12 Oct 2020 14:19:15 +0000 (UTC)
Subject: Re: [PATCH v6 00/36] qapi: static typing conversion, pt1
To: Markus Armbruster <armbru@redhat.com>
References: <20201009161558.107041-1-jsnow@redhat.com>
 <87blha8li3.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <513c75a6-3a69-1cb3-2a26-0782b9ce5de5@redhat.com>
Date: Mon, 12 Oct 2020 10:19:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87blha8li3.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 02:58:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 10/10/20 5:43 AM, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
>> Hi, this series adds static type hints to the QAPI module.
>> This is part one!
>>
>> Part 1: https://gitlab.com/jsnow/qemu/-/tree/python-qapi-cleanup-pt1
>> Everything: https://gitlab.com/jsnow/qemu/-/tree/python-qapi-cleanup-pt6
>>
>> - Requires Python 3.6+
>> - Requires mypy 0.770 or newer (for type analysis only)
>> - Requires pylint 2.6.0 or newer (for lint checking only)
>>
>> In general, this series tackles the cleanup of one individual QAPI
>> module at a time. Once it passes pylint or mypy checks, those checks are
>> enabled for that file.
>>
>> Type hints are added in patches that add *only* type hints and change no
>> other behavior. Any necessary changes to behavior to accommodate typing
>> are split out into their own tiny patches.
>>
>> Notes:
>>
>> - After patch 07, `isort -c` should pass 100% on this and every
>>    future commit.
>>
>> - After patch 08, `flake8 qapi/` should pass 100% on this and every
>>    future commit.
>>
>> - After patch 09, `pylint --rcfile=qapi/pylintrc qapi/` should pass 100%
>>    on this and every future commit.
>>
>> - After patch 18, `mypy --config-file=qapi/mypy.ini qapi/` should pass
>>    100% on this and every future commit.
> 
> Series
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 
> Queued, thanks!
> 

Thanks for putting up with me!

Only five left to go! Enjoy your PTO.

--js


