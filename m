Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC9EC10F14
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 18:36:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 630CE2082A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 18:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 630CE2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35768 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEI5f-0008Dl-Ii
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 14:36:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe.barajas@intel.com>) id 1hEHOI-0006pE-TU
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 13:52:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe.barajas@intel.com>) id 1hEHOH-0001hs-TD
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 13:52:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:39974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <felipe.barajas@intel.com>)
	id 1hEHOH-0001f6-EF
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 13:52:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	10 Apr 2019 10:51:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,334,1549958400"; 
	d="scan'208,217";a="133144922"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
	by orsmga008.jf.intel.com with ESMTP; 10 Apr 2019 10:51:56 -0700
Received: from fmsmsx118.amr.corp.intel.com (10.18.116.18) by
	fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Wed, 10 Apr 2019 10:51:56 -0700
Received: from fmsmsx124.amr.corp.intel.com ([169.254.8.175]) by
	fmsmsx118.amr.corp.intel.com ([169.254.1.37]) with mapi id
	14.03.0415.000; Wed, 10 Apr 2019 10:51:56 -0700
From: "Barajas, Felipe" <felipe.barajas@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: QEMU Logo question
Thread-Index: AdTvxaGzGRKzD9anTdKnP8O68SDvqw==
Date: Wed, 10 Apr 2019 17:51:56 +0000
Message-ID:
 <9733F0BD86F8654AA2F9754B852827E6072FB6EF@fmsmsx124.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTQwYWJlYWUtMjZjYi00ZWMwLWE5NzktM2Y1YTliZjlmMTI3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZ1cxYUdYd3JUMFhOTndCdndWVXg2bjBsa1pEQVg2Y1BjbVBlVmFzekFZcHlIR1hKUWxLWW9cL2hvMlQ1bytObksifQ==
x-originating-ip: [10.1.200.108]
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.151
X-Mailman-Approved-At: Wed, 10 Apr 2019 14:35:02 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: [Qemu-devel] QEMU Logo question
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410175156.Y9rjEKZu9JdWXGlN3GMoKXD0iqwZ_0xM-i79pWqGLEc@z>

Hi,

I am trying to understand who in the QEMU community can give me permission =
to use the QEMU logo in a whitepaper.
I am an application engineer at Intel and I have prepared some benchmarks u=
sing QEMU as a solution accelerated by Intel hardware (CPUs, SSDs, etc)
I would like to use the QEMU logo in this white paper.

Do you know who in the community would have authority to give me such permi=
ssion ?

Thank you

Felipe Barajas


