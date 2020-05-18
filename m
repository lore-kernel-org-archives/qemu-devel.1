Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1511AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 09:39:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D95CC2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 09:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95CC2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jacF6-0005k1-34
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 05:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jacED-0005KU-7b
 for qemu-devel@nongnu.org; Mon, 18 May 2020 05:38:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:12456)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jacEB-0006XJ-GI
 for qemu-devel@nongnu.org; Mon, 18 May 2020 05:38:32 -0400
IronPort-SDR: kPcFHienzOgQxCmzMI8nh/ankJfixTCZZhYDgJ+YaQS0RitgzMnj8knXMnq7kqfAqTav5qvvDh
 nRV2KTvi7lUw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2020 02:38:27 -0700
IronPort-SDR: FQjieA5GZsIuuke1cCUqd7XeVgfke3S4NVirWf6OJOL43fLLrsixRPTl1FU+dvx7f6miD3s+Xw
 hstrKOuQkUvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,406,1583222400"; d="scan'208";a="263895956"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by orsmga003.jf.intel.com with ESMTP; 18 May 2020 02:38:27 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 18 May 2020 02:38:27 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX605.ccr.corp.intel.com (10.109.6.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 18 May 2020 17:38:25 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Mon, 18 May 2020 17:38:25 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
Subject: RE: [PATCH 0/5] colo: Introduce resource agent and test suite/CI
Thread-Topic: [PATCH 0/5] colo: Introduce resource agent and test suite/CI
Thread-Index: AQHWJ4+JC/byrpQAOkeK5CfNvLkl+6io5uXw
Date: Mon, 18 May 2020 09:38:24 +0000
Message-ID: <a1d3390036cd4007b53786cf6cb7b5a9@intel.com>
References: <cover.1589199922.git.lukasstraub2@web.de>
In-Reply-To: <cover.1589199922.git.lukasstraub2@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=192.55.52.115; envelope-from=chen.zhang@intel.com;
 helo=mga14.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 05:38:28
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Jason Wang <jasowang@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Lukas Straub <lukasstraub2@web.de>
> Sent: Monday, May 11, 2020 8:27 PM
> To: qemu-devel <qemu-devel@nongnu.org>
> Cc: Alberto Garcia <berto@igalia.com>; Dr. David Alan Gilbert
> <dgilbert@redhat.com>; Zhang, Chen <chen.zhang@intel.com>
> Subject: [PATCH 0/5] colo: Introduce resource agent and test suite/CI
>=20
> Hello Everyone,
> These patches introduce a resource agent for fully automatic management o=
f
> colo and a test suite building upon the resource agent to extensively tes=
t colo.
>=20
> Test suite features:
> -Tests failover with peer crashing and hanging and failover during checkp=
oint
> -Tests network using ssh and iperf3 -Quick test requires no special
> configuration -Network test for testing colo-compare -Stress test: failov=
er all
> the time with network load
>=20
> Resource agent features:
> -Fully automatic management of colo
> -Handles many failures: hanging/crashing qemu, replication error, disk
> error, ...
> -Recovers from hanging qemu by using the "yank" oob command -Tracks
> which node has up-to-date data -Works well in clusters with more than 2
> nodes
>=20
> Run times on my laptop:
> Quick test: 200s
> Network test: 800s (tagged as slow)
> Stress test: 1300s (tagged as slow)
>=20
> The test suite needs access to a network bridge to properly test the netw=
ork,
> so some parameters need to be given to the test run. See
> tests/acceptance/colo.py for more information.
>=20
> I wonder how this integrates in existing CI infrastructure. Is there a co=
mmon
> CI for qemu where this can run or does every subsystem have to run their
> own CI?

Wow~ Very happy to see this series.
I have checked the "how to" in tests/acceptance/colo.py,
But it looks not enough for users, can you write an independent document fo=
r this series?
Include test Infrastructure ASC II diagram,  test cases design , detailed h=
ow to and more information for=20
pacemaker cluster and resource agent..etc ?

Thanks
Zhang Chen


>=20
> Regards,
> Lukas Straub
>=20
>=20
> Lukas Straub (5):
>   block/quorum.c: stable children names
>   colo: Introduce resource agent
>   colo: Introduce high-level test suite
>   configure,Makefile: Install colo resource-agent
>   MAINTAINERS: Add myself as maintainer for COLO resource agent
>=20
>  MAINTAINERS                              |    6 +
>  Makefile                                 |    5 +
>  block/quorum.c                           |   20 +-
>  configure                                |   10 +
>  scripts/colo-resource-agent/colo         | 1429 ++++++++++++++++++++++
>  scripts/colo-resource-agent/crm_master   |   44 +
>  scripts/colo-resource-agent/crm_resource |   12 +
>  tests/acceptance/colo.py                 |  689 +++++++++++
>  8 files changed, 2209 insertions(+), 6 deletions(-)  create mode 100755
> scripts/colo-resource-agent/colo  create mode 100755 scripts/colo-resourc=
e-
> agent/crm_master
>  create mode 100755 scripts/colo-resource-agent/crm_resource
>  create mode 100644 tests/acceptance/colo.py
>=20
> --
> 2.20.1

