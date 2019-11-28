Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55215C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 01:45:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28DA2215A5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 01:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28DA2215A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia8sO-00049f-9R
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 20:45:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52504)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1ia8qH-00024y-0Z
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 20:43:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1ia8aG-0003vl-Os
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 20:27:05 -0500
Received: from mga14.intel.com ([192.55.52.115]:63169)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1ia8aG-0003ko-FJ
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 20:27:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Nov 2019 17:26:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,251,1571727600"; d="scan'208";a="211859490"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga003.jf.intel.com with ESMTP; 27 Nov 2019 17:26:57 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 27 Nov 2019 17:26:53 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 27 Nov 2019 17:26:52 -0800
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 27 Nov 2019 17:26:52 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.108]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.60]) with mapi id 14.03.0439.000;
 Thu, 28 Nov 2019 09:26:50 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Daniel Cho
 <danielcho@qnap.com>, "lukasstraub2@web.de" <lukasstraub2@web.de>
Subject: RE: Network connection with COLO VM
Thread-Topic: Network connection with COLO VM
Thread-Index: AQHVpNpTPcqw102+1EeSLCuWtdaGTKeeUWSAgACH4yA=
Date: Thu, 28 Nov 2019 01:26:50 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D780631A02A@shsmsx102.ccr.corp.intel.com>
References: <CA+XQNE4eP8tfHB5eV8813bqaE+L5yooBDFCdbMWJPysvev4UKg@mail.gmail.com>
 <20191127105121.GA3017@work-vm>
In-Reply-To: <20191127105121.GA3017@work-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzI3MmY1NzQtNmJjNy00OGI4LWJhMTUtNTJiY2M1NmZjOWM1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieWhqVFlMcHMzNWVQVTVFUThXNWZINHhXaWhJZVZGb2xPTyszUlAzRUd4MEh4ZFF3T2srYVdwSG4yeEtZcFwvSWcifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Sent: Wednesday, November 27, 2019 6:51 PM
> To: Daniel Cho <danielcho@qnap.com>; Zhang, Chen
> <chen.zhang@intel.com>; lukasstraub2@web.de
> Cc: qemu-devel@nongnu.org
> Subject: Re: Network connection with COLO VM
>=20
> * Daniel Cho (danielcho@qnap.com) wrote:
> > Hello everyone,
> >
> > Could we ssh to colo VM (means PVM & SVM are starting)?
> >
>=20
> Lets cc in Zhang Chen and Lukas Straub.

Thanks Dave.

>=20
> > SSH will connect to colo VM for a while, but it will disconnect with
> > error
> > *client_loop: send disconnect: Broken pipe*
> >
> > It seems to colo VM could not keep network session.
> >
> > Does it be a known issue?
>=20
> That sounds like the COLO proxy is getting upset; it's supposed to compar=
e
> packets sent by the primary and secondary and only send one to the outsid=
e
> - you shouldn't be talking directly to the guest, but always via the prox=
y.  See
> docs/colo-proxy.txt
>=20

Hi Daniel,

I have try ssh to COLO guest with 8 hours, not occurred this issue.
Please check your network/qemu configuration.
But I found another problem maybe related this issue, if no network communi=
cation for a period of time(maybe 10min), the first message send to guest h=
ave a chance with delay(maybe 1-5 sec), I will try to fix it when I have ti=
me.

Thanks
Zhang Chen

> Dave
>=20
> > Best Regard,
> > Daniel Cho
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


