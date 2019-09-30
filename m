Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9C9C388F3
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 07:55:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E791021855
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 07:55:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E791021855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEqWx-0003rJ-2E
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 03:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iEqW7-0003KV-ON
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 03:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iEqW6-0006fH-RU
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 03:54:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52796)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iEqW6-0006f3-M0
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 03:54:46 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C8E8E85538
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 07:54:45 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id t11so4140653wrq.19
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 00:54:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:user-agent:from:to:cc:subject:date:message-id
 :mime-version;
 bh=GwBewE7NUtEdrhA2330PbdenQD0mDRvOZP38FRTgXFM=;
 b=iyURfFyjvC7U64/O6NeQeQXq4urZP7tSRA+l2hLNJd4UMZUo2rKZXWRmj9hphtvkM8
 IucMgXFByBxevYqWG8/aE0vxFr/5oNpNipu5Z1p4p8Q4L4vWJ61HUO/409tEKJljaVqd
 7asp9IYn1JdsZZ5bcWYmMbAu7XGHbpH/hO7Yp6lSMQWuSJDaIoNlM4OGWQsUR0ICodPC
 vCmreEUy8d2Y7LIFWdkRv2UUsnsAqmIaQz9hCNBulGZyiF7pBjHimDwobd40K55uCQJK
 2cg9NFdQ6KhHvJvWbx/EaJp3UZQARMyr3SijDKykmmTr8K1DuYKIeINw/XuYIA9gxonm
 8DOg==
X-Gm-Message-State: APjAAAWv0RJcpDkgZSW3RoYQtHDIo6Imm/KeMcCMTlp1DVf4+s9RuAET
 A/gR9QTX/mxg1RVMt1qmGUmj22glSKhYsNDlM85czpS7ZD2ATqHKAAq0oZUsl4tPv5fqraPxGHV
 qXU9gitWpz/6An3I=
X-Received: by 2002:adf:f008:: with SMTP id j8mr11960642wro.75.1569830084619; 
 Mon, 30 Sep 2019 00:54:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw5lK0JEwUGiu5E4lIZlY/tOcOvNsLqrcVXlIg2jQJiSSNpEDLkTEYwtNxI1CTaKHSyu18PQw==
X-Received: by 2002:adf:f008:: with SMTP id j8mr11960622wro.75.1569830084452; 
 Mon, 30 Sep 2019 00:54:44 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id y186sm39017515wmb.41.2019.09.30.00.54.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2019 00:54:43 -0700 (PDT)
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: mihajlov@linux.vnet.ibm.com
Subject: Arch info lost in "info cpus"
Date: Mon, 30 Sep 2019 09:54:41 +0200
Message-ID: <87blv2i5ha.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: imammedo@redhat.com, tao3.xu@intel.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain

Hi,

Commit 137b5cb6ab565cb3781d5337591e155932b4230e (hmp: change
hmp_info_cpus to use query-cpus-fast) updated the "info cpus" commit to
make it more lightweight, but also removed the ability to get the
architecture specific status of each vCPU.

This information was really useful to diagnose certain Guest issues,
without the need of using GDB, which is more intrusive and requires
enabling it in advance.

Is there an alternative way of getting something equivalent to what
"info cpus" provided previously (in 2.10)?

Thanks,
Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2RtMEACgkQ9GknjS8M
AjXJcBAAl5vlAi9N4f8zSiHtRst4vyaBbIf3BL1waeBKmec3bP5brTvGEyvo4Zo9
xZ285lw/unr/imsjUtsFJ7OvnzzCjWKgq+jQs0MUFhMIF4JeHDxlDQZ+swUUAM/o
sMKwzeMy7JQyKGk1eBEF6SpYHVYVEpyVZuk42ikzC7NhPy1l6hHvu78QAQomw6xK
G6FM+u9OTEgCTdPNKbLyyVD+2VBtAkfdKYQVqu6553jCWe2z6WQAq36+rfwPC+PI
q2ttcAoNwwTHrCrPHGy/WP/Mldzs5cQeDEARyi2t+cNGlO5T/0EOe47t7CChOawj
AAUEwWE25nTk9E2un33GTJrofgC7DQFu9ZXZdzaIwSA5NpJStK80qWk/YkE44evu
BiGBfhz20qkbyaeu4dOJCFCzlGHevOZpSuNi2XC4zN0zTWekEipaFLhY662HS5Ft
ipaX8pjc0RDZLgq251dhCjHdLQMyNiq+v5h9A+wYWJOqjDx3eveNpsMDlQ8oSSBB
LLAVh/ISwNg9OACUTmCVhfXRmTxf9kCqulCy3NqVlrgCtZtSmCgZxHh8NcXH3Lat
22M3DVFqQMcEJlfWQ8B7OkiCxsti8y5NsbwyGSmiG+4tZ2GEOZ02/5UqptjhXPYi
R8rFJCkLrsA3qDtLxKJubdGI5wUBpQVtyW0WP02r10r+YN8QbIc=
=ladd
-----END PGP SIGNATURE-----
--=-=-=--

