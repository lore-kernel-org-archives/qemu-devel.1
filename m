Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B844C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:44:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17EEF206F2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17EEF206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kECxH-000083-At
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 10:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kECwk-0007tH-3g
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 10:44:10 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51374
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kECwi-0005hs-9V
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 10:44:09 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-SSfRdzdqPE2RYHlnbBD6jg-1; Fri, 04 Sep 2020 10:44:05 -0400
X-MC-Unique: SSfRdzdqPE2RYHlnbBD6jg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67F021084D6A;
 Fri,  4 Sep 2020 14:44:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 35B0F5D9D2;
 Fri,  4 Sep 2020 14:44:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ABC661132B59; Fri,  4 Sep 2020 16:44:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v5 09/20] docs/sphinx: Add new qapi-doc Sphinx extension
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <20200810195019.25427-10-peter.maydell@linaro.org>
Date: Fri, 04 Sep 2020 16:44:02 +0200
In-Reply-To: <20200810195019.25427-10-peter.maydell@linaro.org> (Peter
 Maydell's message of "Mon, 10 Aug 2020 20:50:08 +0100")
Message-ID: <87eenh38lp.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:57:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

$ pycodestyle docs/sphinx/qapidoc.py 
docs/sphinx/qapidoc.py:42:1: E302 expected 2 blank lines, found 1
docs/sphinx/qapidoc.py:50:1: E302 expected 2 blank lines, found 1
docs/sphinx/qapidoc.py:74:80: E501 line too long (80 > 79 characters)
docs/sphinx/qapidoc.py:388:80: E501 line too long (80 > 79 characters)
docs/sphinx/qapidoc.py:391:80: E501 line too long (80 > 79 characters)
docs/sphinx/qapidoc.py:430:1: E302 expected 2 blank lines, found 1
docs/sphinx/qapidoc.py:489:80: E501 line too long (80 > 79 characters)
docs/sphinx/qapidoc.py:495:1: E302 expected 2 blank lines, found 1
$ PYTHONPATH=scripts pylint docs/sphinx/qapidoc.py 
************* Module qapidoc
docs/sphinx/qapidoc.py:36:4: E0611: No name 'AutodocReporter' in module 'sphinx.ext.autodoc' (no-name-in-module)
docs/sphinx/qapidoc.py:45:10: R1708: Do not raise StopIteration in generator, use return statement instead (stop-iteration-return)
docs/sphinx/qapidoc.py:104:4: R0201: Method could be a function (no-self-use)
docs/sphinx/qapidoc.py:253:4: R0201: Method could be a function (no-self-use)
docs/sphinx/qapidoc.py:34:4: C0412: Imports from package sphinx are not grouped (ungrouped-imports)

------------------------------------------------------------------
Your code has been rated at 9.64/10 (previous run: 8.85/10, +0.79)

Use your judgement.


