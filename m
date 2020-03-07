Return-Path: <SRS0=oVW3=4Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36470C10F00
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 17:05:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06A53206D5
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 17:05:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A53206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ehu.eus
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAct9-000327-48
	for qemu-devel@archiver.kernel.org; Sat, 07 Mar 2020 12:05:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49111)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <unai.martinezcorral@ehu.eus>) id 1jAcsM-0002cr-Ik
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:04:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <unai.martinezcorral@ehu.eus>) id 1jAcsK-0005MO-CV
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:04:33 -0500
Received: from smtp.lg.ehu.es ([158.227.0.66]:44316 helo=smtp.ehu.eus)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
 id 1jAcsK-0005Ah-0d
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:04:32 -0500
Received: from imsva1.lgp.ehu.es (imsva1.lgp.ehu.es [10.0.3.245])
 by postfix.smtp1.imsva1 (Postfix) with ESMTPS id 92DEE3852D;
 Sat,  7 Mar 2020 18:04:23 +0100 (CET)
Received: from imsva1.lgp.ehu.es (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4ED5C11004A;
 Sat,  7 Mar 2020 18:04:23 +0100 (CET)
Received: from imsva1.lgp.ehu.es (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 42AB2110045;
 Sat,  7 Mar 2020 18:04:23 +0100 (CET)
Received: from smtp.ehu.eus (unknown [10.0.100.73])
 by imsva1.lgp.ehu.es (Postfix) with ESMTPS;
 Sat,  7 Mar 2020 18:04:23 +0100 (CET)
Received: from dd5f6ec33fb0 (unknown [81.0.0.187])
 by smtp1 (Postfix) with ESMTPSA id 66D523852D;
 Sat,  7 Mar 2020 18:04:22 +0100 (CET)
Date: Sat, 7 Mar 2020 17:04:16 +0000
From: unai.martinezcorral@ehu.eus
To: qemu-devel@nongnu.org
Subject: [PATCH v8 0/9] qemu-binfmt-conf.sh
Message-ID: <20200307170251.GA7@dd5f6ec33fb0>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Greylist: ACL 184 matched, not delayed by milter-greylist-4.6.2 (smtp1
 [10.0.100.73]); Sat, 07 Mar 2020 18:04:23 +0100 (CET)
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSVA-9.1.0.1631-8.5.0.1020-25276.001
X-TM-AS-Result: No--2.367-7.0-31-10
X-imss-scan-details: No--2.367-7.0-31-10
X-TMASE-Version: IMSVA-9.1.0.1631-8.5.1020-25276.001
X-TMASE-Result: 10--2.366500-10.000000
X-TMASE-MatchedRID: LUUEnUEr1lY8mRT0SYY6fjjNGpWCIvfTRf40pT7Zmv6+fWK8N2kAh+zn
 6eE2grwnFid7Q1ZuuwxX+dnljX3KA2QlvAMDRacisFkCLeeufNsxXH/dlhvLv3qm3WhT4L+k6qe
 +9Ra150UQSK75DSbBzpTYBuznfGcbAnkQm1CuhGITF1LtYW9lay9+D0Xu5w5qzP9LEqj2YnisZR
 v6MhtinLF6Z4Nuyc7poXlOqzs+6jnRY+PC8HKY5X4neC0h7SADqb3/o5s+OcORoQLwUmtov18vP
 NhBIHcIIxdpW/bdWaCaW4TcTEshkjH/KDxsnDuI4WAObM1VUqhDfgjVpfaTrZcFdomgH0ln/sTo
 Y2qzpx5eu6llOoM7BnnDQRq5CiZH9xS3mVzWUuAojN1lLei7RS9skqPEzmNgnk+QpcqVtX1fO4s
 KXHM0MOgswaW/Yfy2M6XGoXaKOlVenbXtcFSoaqcYvnjPk7TCKU8InMIdhn+yGwxWYAvbPQnoQr
 0aJHnc0egPf++T1T/YdbOkPFfd3QbC42epSz89
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
X-Greylist: Sender IP whitelisted, Sender succeeded SMTP AUTH, not delayed by
 milter-greylist-4.6.2 (postfix.smtp1.imsva1 [10.0.100.73]);
 Sat, 07 Mar 2020 18:04:23 +0100 (CET)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 158.227.0.66
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
Cc: riku.voipio@iki.fi, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series reworks qemu-binfmt-conf.sh:

* Argument <CPU> from option '--systemd' is generalized to <TARGETS>, and it is
  accepted for any mode (default, debian or systemd). It can be a single target
  arch or a list of them.
* Option '-r|--clear' is added, which allows to remove an already registered
  target interpreter or a list of them. The implementation is functional but
  partial. Please, see the corresponding commit.
* Option '-t|--test' is added, which allows to execute the CHECK according
  to the provided arguments, but no interpreter is configured.
* Support to set options through environment variables: QEMU_TARGETS, QEMU_PATH,
  QEMU_SUFFIX, QEMU_PERSISTENT, QEMU_CREDENTIAL, QEMU_CLEAR and QEMU_TEST.

The following changes are not backward compatible:

* Option '--persistent' no longer requires/accepts an argument.
* Option '--credential' no longer requires/accepts an argument.
* Option '--systemd' no longer requires/accepts an argument.
* Option '--qemu-path' is renamed to '--path'.
* Option '--qemu-suffix' is renamed to '--suffix'.

The functionality of all of them is untouched. Changes are related to syntax only.

v8:

* Fix typos and address review comments

v7:

* Check that a interpreter exists before trying to remove it.

v6:

* Don't need to use "find".
* Put the ";;" at the same position.
* Set BINFMT_CLEAR to ':', to allow --test to work with --clear.
* Do not show DEBIANDIR and SYSTEMDDIR in the Env-variable column.

 Based on:

* [PATCH v5 0/10] qemu-binfmt-conf.sh
   * should have been [PATCH v5 0/9] qemu-binfmt-conf.sh
* [PATCH v4 0/10] qemu-binfmt-conf.sh
* [PATCH v3 0/10] qemu-binfmt-conf.sh
* [PATCH v2] qemu-binfmt-conf.sh: add CPUS, add --reset, make -p and -c boolean (no arg)
* [PATCH] qemu-binfmt-conf.sh: add CPUS, add --reset, make -p and -c boolean (no arg)
* scripts/qemu-binfmt-conf.sh: allow clearing of entries

Regards

Unai Martinez-Corral (9):
      qemu-binfmt-conf.sh: enforce safe style consistency
      qemu-binfmt-conf.sh: make opts -p and -c boolean
      qemu-binfmt-conf.sh: add QEMU_CREDENTIAL and QEMU_PERSISTENT
      qemu-binfmt-conf.sh: use the same presentation format as for qemu-*
      qemu-binfmt-conf.sh: remove 'qemu' prefix from cli options
      qemu-binfmt-conf.sh: honour QEMU_PATH and/or QEMU_SUFFIX
      qemu-binfmt-conf.sh: generalize <CPU> to positional TARGETS
      qemu-binfmt-conf.sh: add option --clear
      qemu-binfmt-conf.sh: add --test

scripts/qemu-binfmt-conf.sh | 211
1 file changed, 133 insertions(+), 78 deletions(-)


