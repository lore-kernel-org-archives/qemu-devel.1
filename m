Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D493C10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 21:00:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD49C2464B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 21:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD49C2464B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ehui.eus
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBPVI-00035I-Pm
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 17:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48413)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <unai.martinezcorral@ehui.eus>) id 1jBNr2-0003Vz-N8
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:14:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <unai.martinezcorral@ehui.eus>) id 1jBNr1-0003xb-I9
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:14:20 -0400
Received: from smtp.lg.ehu.es ([158.227.0.66]:24394 helo=smtp.ehu.eus)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <unai.martinezcorral@ehui.eus>)
 id 1jBNr1-0003w4-7k
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:14:19 -0400
Received: from imsva2.lgp.ehu.es (imsva2.lgp.ehu.es [10.0.3.246])
 by postfix.smtp2.imsva2 (Postfix) with ESMTPS id A6BB32D29;
 Mon,  9 Mar 2020 20:01:28 +0100 (CET)
Received: from imsva2.lgp.ehu.es (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 98CBB5A04F;
 Mon,  9 Mar 2020 20:01:28 +0100 (CET)
Received: from imsva2.lgp.ehu.es (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D74D5A045;
 Mon,  9 Mar 2020 20:01:28 +0100 (CET)
Received: from smtp.ehu.eus (unknown [10.0.100.76])
 by imsva2.lgp.ehu.es (Postfix) with ESMTPS;
 Mon,  9 Mar 2020 20:01:28 +0100 (CET)
Received: from 669c1c222ef4 (static.187.0.0.81.ibercom.com [81.0.0.187])
 by smtp2 (Postfix) with ESMTPSA id 3CCC62D29;
 Mon,  9 Mar 2020 20:01:28 +0100 (CET)
Date: Mon, 9 Mar 2020 19:01:19 +0000
From: Unai Martinez-Corral <unai.martinezcorral@ehui.eus>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 0/10] qemu-binfmt-conf.sh
Message-ID: <20200309190110.GA31@669c1c222ef4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Greylist: ACL 191 matched, not delayed by milter-greylist-4.6.2 (smtp2
 [10.0.100.76]); Mon, 09 Mar 2020 20:01:28 +0100 (CET)
X-TM-AS-GCONF: 00
X-Greylist: Sender IP whitelisted, Sender succeeded SMTP AUTH, not delayed by
 milter-greylist-4.6.2 (postfix.smtp2.imsva2 [10.0.100.76]);
 Mon, 09 Mar 2020 20:01:28 +0100 (CET)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 158.227.0.66
X-Mailman-Approved-At: Mon, 09 Mar 2020 16:57:38 -0400
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

v10

* Split style related commit

v9

* Make style coherent with the dominant pattern

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

Unai Martinez-Corral (10):
      qemu-binfmt-conf.sh: enforce style consistency
      qemu-binfmt-conf.sh: enforce safe tests
      qemu-binfmt-conf.sh: make opts -p and -c boolean
      qemu-binfmt-conf.sh: add QEMU_CREDENTIAL and QEMU_PERSISTENT
      qemu-binfmt-conf.sh: use the same presentation format as for qemu-*
      qemu-binfmt-conf.sh: remove 'qemu' prefix from cli options
      qemu-binfmt-conf.sh: honour QEMU_PATH and/or QEMU_SUFFIX
      qemu-binfmt-conf.sh: generalize <CPU> to positional TARGETS
      qemu-binfmt-conf.sh: add option --clear
      qemu-binfmt-conf.sh: add --test

scripts/qemu-binfmt-conf.sh | 221
1 file changed, 138 insertions(+), 83 deletions(-i)

