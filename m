Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE40FC388F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 14:53:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30ECC24630
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 14:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xfc8H4zw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30ECC24630
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVbyK-0006vl-LW
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 10:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kVbwN-0004fW-8j
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 10:51:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55587)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kVbwG-0006uE-R4
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 10:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603378295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zLtAiCYFDHw50n3cD7Vg+88kzvzZQn9iSghMW8kTIAk=;
 b=Xfc8H4zwhNr6sDfHzaL8VpQ0Oebdzbfj2c/weyOK0O/nKUZNdUq3mHScmXSVgv/YwlGfkq
 1L4ZxS+TrX7kqCwm9mFg1ERvdit0AkfsVKKV9yHsACr1OTjEHwQw7qT7Fh0rF1EfnIZvs5
 HCq0b5mpnrLIPp9KbtEnurODWutdz8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-i-mE_adQN7WJ_h7TFNV_BA-1; Thu, 22 Oct 2020 10:51:31 -0400
X-MC-Unique: i-mE_adQN7WJ_h7TFNV_BA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AEB7801817;
 Thu, 22 Oct 2020 14:51:30 +0000 (UTC)
Received: from [10.10.119.13] (ovpn-119-13.rdu2.redhat.com [10.10.119.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E11FE19C4F;
 Thu, 22 Oct 2020 14:51:29 +0000 (UTC)
Subject: Re: [PATCH 00/25] qapi: static typing conversion, pt6
To: Markus Armbruster <armbru@redhat.com>
References: <20200922224501.4087749-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <c2fb9926-4fd5-5419-934f-90c355ca9203@redhat.com>
Date: Thu, 22 Oct 2020 10:51:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200922224501.4087749-1-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:33:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/22/20 6:44 PM, John Snow wrote:
> based-on: <20200922223525.4085762-1-jsnow@redhat.com>
>            [PATCH 00/26] qapi: static typing conversion, pt5
> 
> Hi, this series adds static type hints to the QAPI module.
> This is the final part, part six!
> 
> Part 6 (Everything):
>      https://gitlab.com/jsnow/qemu/-/tree/python-qapi-cleanup-pt6
> 

Note: I have rebased and updated the pt6 branch. I am currently working 
on respinning pt2, which now contains the introspect.py patches that 
were formerly in pt1.

Thanks,
--js

> - Requires Python 3.6+
> - Requires mypy 0.770 or newer (for type analysis only)
> - Requires pylint 2.6.0 or newer (for lint checking only)
> 
> This part of the series focuses on schema.py.
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
> John Snow (25):
>    qapi/schema: add Visitable mixin
>    qapi/schema.py: Move meta-type into class instances
>    qapi/schema.py: add assert in stub methods
>    qapi/schema.py: constrain QAPISchemaObjectType base type
>    qapi/schema.py: constrain QAPISchemaObjectTypeMember arg_type type
>    qapi/schema.py: constrain QAPISchemaEvent arg_type type
>    qapi/schema.py: constrain tag_member type
>    qapi/schema.py: Allow alternate_type to assert
>    qapi/schema.py: remove superfluous assert
>    qapi/schema.py: Add assertion to ifcond property
>    qapi/schema.py: Constrain type of QAPISchemaObjectType members field
>    qapi/schema.py: remove 'and' from non-bool rvalue expressions
>    qapi/schema.py: Test type of self.ret_type instead of local temp
>    qapi/schema.py: Assert variants of an object are also objects
>    qapi/schema.py: add type hint annotations
>    qapi/schema.py: enable checking
>    qapi: Disable similarity checks in pylint entirely
>    qapi/schema.py: Add pylint warning suppressions
>    qapi/schema.py: Convert several methods to classmethods
>    qapi/schema.py: Replace one-letter variable names
>    qapi/schema.py: disable pylint line limit
>    qapi/schema.py: Ignore unused argument for check()
>    qapi/schema.py: enable pylint checks
>    qapi/schema.py: Add module docstring
>    qapi/schema.py: Use python3 style super()
> 
>   scripts/qapi/mypy.ini  |   6 -
>   scripts/qapi/pylintrc  |   6 +-
>   scripts/qapi/schema.py | 848 +++++++++++++++++++++++++++--------------
>   3 files changed, 557 insertions(+), 303 deletions(-)
> 


