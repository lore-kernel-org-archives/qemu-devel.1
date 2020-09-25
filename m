Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A27C4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 22:55:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B87942065E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 22:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFhWV3Gj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B87942065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLwd9-0004l8-Ln
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 18:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLwbu-0004Kf-Hw
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 18:54:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLwbr-0004DR-Bw
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 18:54:38 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601074474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XjusmB28Xj5463lZynbj6X9pnVuRcdCHyQzOPcBe70Q=;
 b=YFhWV3GjwH+BrR0qOHBqsargE8AYZ18L6Ii/8dXEXS10x2gALTq1xeaj/OMjgdsCelwRj3
 oAPemsUcXkc2oc4ztTCKSefEE4bH9IRGOlHb/RQgwfWFxom2Iz6WCdXGVawtP8J2kZ3a2+
 vaUcKJ3h0y+QUuCGy6Wp5WCRZVQwlSY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-52rUkcDoNmi3eCoB4-gzBw-1; Fri, 25 Sep 2020 18:54:32 -0400
X-MC-Unique: 52rUkcDoNmi3eCoB4-gzBw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B15F1007B01;
 Fri, 25 Sep 2020 22:54:31 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6589B60C84;
 Fri, 25 Sep 2020 22:54:30 +0000 (UTC)
Subject: Re: [PATCH 00/16] qapi: static typing conversion, pt2
To: Markus Armbruster <armbru@redhat.com>
References: <20200922211313.4082880-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <af9ccbcb-20f3-3bd1-fe3b-912652c560bf@redhat.com>
Date: Fri, 25 Sep 2020 18:54:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200922211313.4082880-1-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 9/22/20 5:12 PM, John Snow wrote:
> based-on: <20200922210101.4081073-1-jsnow@redhat.com>
>            [PATCH v2 00/38] qapi: static typing conversion, pt1
> 
> Hi, this series adds static type hints to the QAPI module.
> This is part two!
> 
> Part 2: https://gitlab.com/jsnow/qemu/-/tree/python-qapi-cleanup-pt2
> Everything: https://gitlab.com/jsnow/qemu/-/tree/python-qapi-cleanup-pt6
> 

Thanks for reviews. I will not be re-spinning pt2 until pt1 is fully 
merged, but I have re-based on pt1-v3 and made some minor adjustments to 
accommodate new development in pt1.

You can find that staged here:
https://gitlab.com/jsnow/qemu/-/tree/python-qapi-cleanup-pt2


Here's the review status of pt2:

[01] qapi-expr-py-remove-info       # [SOB] JS [RB] CR,EH
[02] qapi-expr-py-check-for-dict    # [SOB] JS [RB] CR,EH
[03] qapi-expr-py-constrain         # [SOB] JS [RB] CR,EH
[04] qapi-expr-py-add-assertion-for # [SOB] JS [RB] CR,EH
[05] qapi-expr-py-move-string-check # [SOB] JS [RB] CR,EH
[06] qapi-expr-py-check-type-of     # [SOB] JS [RB] EH
[07] qapi-expr-py-add-casts-in-a    # [SOB] JS [RB] CR,EH
[08] qapi-expr-py-add-notational    # [SOB] JS [RB] CR,EH
[09] qapi-expr-py-rewrite-check_if  # [SOB] JS [RB] CR,EH [TB] CR
[10] qapi-expr-py-remove-single     # [SOB] JS [RB] CR,EH
[11] pylint-enable                  # [SOB] JS [TB] CR,EH [RB] CR,EH
[12] qapi-expr-py-add-docstrings    # [SOB] JS [RB] CR
[13] qapi-expr-modify-check_keys-to # [SOB] JS [RB] CR,EH
[14] qapi-expr-use-tuples-instead   # [SOB] JS [RB] CR,EH
[15] qapi-expr-move-related-checks  # [SOB] JS [RB] CR
[16] qapi-expr-use-an-expression    # [SOB] JS [RB] CR,EH

As for the difflog so far:

Patches 2, 3, 7, 8 change import orderings (isort)
Patch 12 sees some docstrings rewritten to pass sphinx.
Patch 15 addresses Eduardo's review comments.

--js


