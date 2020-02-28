Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB14C3F2C6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 01:17:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2B8E2469D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 01:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B8E2469D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fsf.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7UHL-0007Rw-P7
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 20:17:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <iank@fsf.org>)
 id 1j7UGR-00070K-Ec; Thu, 27 Feb 2020 20:16:28 -0500
Received: from mail.fsf.org ([209.51.188.13]:45338)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <iank@fsf.org>)
 id 1j7UGR-00074Y-9u; Thu, 27 Feb 2020 20:16:27 -0500
Received: from mail.iankelling.org ([72.14.176.105]:32870)
 by mail.fsf.org with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.69) (envelope-from <iank@fsf.org>)
 id 1j7UGQ-0002wk-WB; Thu, 27 Feb 2020 20:16:27 -0500
Received: from iank by mail.iankelling.org with local (Exim 4.90_1)
 (envelope-from <iank@fsf.org>)
 id 1j7UGP-00029I-Ml; Thu, 27 Feb 2020 20:16:25 -0500
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Ian Kelling <iank@fsf.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: FYI: The daily digest email for qemu-devel/qemu-arm didn't go out
 today
Date: Thu, 27 Feb 2020 20:16:25 -0500
Message-ID: <87r1yfo6ja.fsf@fsf.org>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by mail.fsf.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I hope to fix it tomorrow, but I can't be sure. Maybe it will fix itself
and I'll just abandon the digest for today. Very few people use the
digest feature, normally it goes out at noonish eastern time.

All I've had time to do done is grab a stack trace, seems like there's
some characters in an email that mailman doesn't like. If anyone wants
to lend a hand, this is from a lightly modified senddigests from mailman
to get a stack trace:

Traceback (most recent call last):
  File "/usr/lib/mailman/cron/sd", line 106, in <module>
    main()
  File "/usr/lib/mailman/cron/sd", line 89, in main
    mlist.send_digest_now()
  File "/var/lib/mailman/Mailman/Digester.py", line 60, in send_digest_now
    ToDigest.send_digests(self, mboxfp)
  File "/var/lib/mailman/Mailman/Handlers/ToDigest.py", line 147, in send_digests
    send_i18n_digests(mlist, mboxfp)
  File "/var/lib/mailman/Mailman/Handlers/ToDigest.py", line 347, in send_i18n_digests
    payload = unicode(payload, mcset, 'replace'
  File "/usr/lib/python2.7/encodings/base64_codec.py", line 41, in base64_decode
    assert errors == 'strict'
AssertionError

-- 
Ian Kelling | Senior Systems Administrator, Free Software Foundation
GPG Key: B125 F60B 7B28 7FF6 A2B7  DF8F 170A F0E2 9542 95DF
https://fsf.org | https://gnu.org

