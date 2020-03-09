Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3172BC10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:13:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 037E8222D9
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 037E8222D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ehu.eus
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBNpw-0002WM-6R
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 15:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <unai.martinezcorral@ehu.eus>) id 1jBNoy-0001iK-MS
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <unai.martinezcorral@ehu.eus>) id 1jBNov-0002UT-E7
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:12:10 -0400
Received: from smtp.lg.ehu.es ([158.227.0.66]:34952 helo=smtp.ehu.eus)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
 id 1jBNov-0002SW-2u
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:12:09 -0400
Received: from imsva2.lgp.ehu.es (imsva2.lgp.ehu.es [10.0.3.246])
 by postfix.smtp2.imsva2 (Postfix) with ESMTPS id 3A4476761;
 Mon,  9 Mar 2020 20:12:06 +0100 (CET)
Received: from imsva2.lgp.ehu.es (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC1025A0A5;
 Mon,  9 Mar 2020 20:12:05 +0100 (CET)
Received: from imsva2.lgp.ehu.es (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E0B505A0A4;
 Mon,  9 Mar 2020 20:12:05 +0100 (CET)
Received: from smtp.ehu.eus (unknown [10.0.100.76])
 by imsva2.lgp.ehu.es (Postfix) with ESMTPS;
 Mon,  9 Mar 2020 20:12:05 +0100 (CET)
Received: from 669c1c222ef4 (static.187.0.0.81.ibercom.com [81.0.0.187])
 by smtp2 (Postfix) with ESMTPSA id 936B36CAE;
 Mon,  9 Mar 2020 20:12:05 +0100 (CET)
Date: Mon, 9 Mar 2020 19:12:00 +0000
From: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 0/10] qemu-binfmt-conf.sh
Message-ID: <20200309191200.GA60@669c1c222ef4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Greylist: ACL 191 matched, not delayed by milter-greylist-4.6.2 (smtp2
 [10.0.100.76]); Mon, 09 Mar 2020 20:12:05 +0100 (CET)
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSVA-9.1.0.1631-8.5.0.1020-25280.002
X-TM-AS-Result: No--2.406-7.0-31-10
X-imss-scan-details: No--2.406-7.0-31-10
X-TMASE-Version: IMSVA-9.1.0.1631-8.5.1020-25280.002
X-TMASE-Result: 10--2.405600-10.000000
X-TMASE-MatchedRID: VEAyyTkk0UXr0qGBvdXjxLmQWToO0X1/V0QSZ/pNFUFV1lQ/Hn0TOiiq
 snPUKvF6alU0i33F6RBSCsh9ot3/DqVIsznpoCaYEhGH3CRdKUWpZoxavGZhjoASWMYnDi+T8xf
 51HO7e/Wd4idtc2EO8iGbZZp+472ZbI6WQV23HWr4GlcsEXGVMHEONw67gSVcdzLikT92GFEfKF
 3OCkQ3ow10tp2psQ1EEvsg7x5dWvFis7UoQ0MxblD5LQ3Tl9H7ZB/U2HvdblH5+tteD5RzhYmUy
 BBpbWbNmfJeSkrv0+ptu21XpQLmylUOzfoovIJKdfk9ZxDdshYXaMhZSeVFDDs61woVLQQEofEK
 OpOUPKni8zVgXoAltjrm2CwlZwVRJ0RPnyOnrZJojjqxwnvCbp8yDDBH+rskutb3s21IB6Qm1lL
 Fq6i0douL4jNVcVaRzEzjGbc6fBAllxM1N+Ws+lkWFfShbAzAb2RJ9GzmHbIbicrrJB4OAMzNhQ
 Tu4uISUWFuYX84RFtAi5mQw7zH3ap25+1U9AW2
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
X-Greylist: Sender IP whitelisted, Sender succeeded SMTP AUTH, not delayed by
 milter-greylist-4.6.2 (postfix.smtp2.imsva2 [10.0.100.76]);
 Mon, 09 Mar 2020 20:12:06 +0100 (CET)
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

