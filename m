Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C873DC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 01:18:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43AC922404
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 01:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJs0/tCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43AC922404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka7Rn-0005Wf-1u
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 20:18:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6sP-0004XN-Nf
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:42:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41892)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6sF-0005QF-9T
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:42:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604450519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UhaAbk6va5Ou2HviN250rGgAYYYoJ2L2OYhq6nhum9c=;
 b=fJs0/tCzEB49Qbdflj6xdV2qUFO+vxj5n4ZPrNwulgqeEp2bbA9B/6xWthasX2S3P91BHU
 SN7R8ra/F2m2W1hvhqtgcTZ8md5gc5I6ZWRoXKasevTIe0vAQRNrHXkzTFp7e/4+rmUhET
 rmXoCKwGprB2Iw8FqrpM2Yd9Gq3G26g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-ihXf1oAxNgSU7ie6a9hNNw-1; Tue, 03 Nov 2020 19:41:57 -0500
X-MC-Unique: ihXf1oAxNgSU7ie6a9hNNw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48FCD1006CAC
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 00:41:56 +0000 (UTC)
Received: from [10.10.119.97] (ovpn-119-97.rdu2.redhat.com [10.10.119.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 98CBC6EF6A;
 Wed,  4 Nov 2020 00:41:55 +0000 (UTC)
Subject: Re: [PATCH v2 00/16] qapi: static typing conversion, pt3
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20201026213637.47087-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <1e06ab88-8d8d-d0b1-03f4-a868e2d95561@redhat.com>
Date: Tue, 3 Nov 2020 19:41:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201026213637.47087-1-jsnow@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
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

On 10/26/20 5:36 PM, John Snow wrote:
> based-on: <20201026194251.11075-1-jsnow@redhat.com>
>            [PATCH v2 00/11] qapi: static typing conversion, pt2

Ping,

This series can be reviewed independently of pt2, so I encourage you to 
try if you have the time.

> 
> Hi, this series adds static type hints to the QAPI module.
> This is part three, and it focuses on expr.py.
> 
> Part 3: https://gitlab.com/jsnow/qemu/-/tree/python-qapi-cleanup-pt3
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
>   - Rebased on the latest V2
> 002/16:[0001] [FC] 'qapi/expr.py: Check for dict instead of OrderedDict'
>   - Import order differences
> 007/16:[0006] [FC] 'qapi/expr.py: Add casts in a few select cases'
>   - Import order differences
> 008/16:[0006] [FC] 'qapi/expr.py: add type hint annotations'
>   - Import order differents
> 012/16:[0066] [FC] 'qapi/expr.py: Add docstrings'
>   - Various docstring changes for Sphinx
> 014/16:[0004] [FC] 'qapi/expr.py: Use tuples instead of lists for static data'
>   - Change to accommodate new 'coroutine' key
> 015/16:[0006] [FC] 'qapi/expr.py: move related checks inside check_xxx functions'
>   - Fix check order (ehabkost)
> 
> John Snow (16):
>    qapi/expr.py: Remove 'info' argument from nested check_if_str
>    qapi/expr.py: Check for dict instead of OrderedDict
>    qapi/expr.py: constrain incoming expression types
>    qapi/expr.py: Add assertion for union type 'check_dict'
>    qapi/expr.py: move string check upwards in check_type
>    qapi/expr.py: Check type of 'data' member
>    qapi/expr.py: Add casts in a few select cases
>    qapi/expr.py: add type hint annotations
>    qapi/expr.py: rewrite check_if
>    qapi/expr.py: Remove single-letter variable
>    qapi/expr.py: enable pylint checks
>    qapi/expr.py: Add docstrings
>    qapi/expr.py: Modify check_keys to accept any Iterable
>    qapi/expr.py: Use tuples instead of lists for static data
>    qapi/expr.py: move related checks inside check_xxx functions
>    qapi/expr.py: Use an expression checker dispatch table
> 
>   scripts/qapi/expr.py  | 447 +++++++++++++++++++++++++++++++-----------
>   scripts/qapi/mypy.ini |   5 -
>   scripts/qapi/pylintrc |   1 -
>   3 files changed, 334 insertions(+), 119 deletions(-)
> 


