Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B5FC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 03:16:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F43E215E5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 03:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F43E215E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaAHm-0008Vl-84
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 22:16:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1iaAGv-0007zE-PG
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 22:15:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1iaAGs-00085b-Rb
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 22:15:12 -0500
Received: from mga12.intel.com ([192.55.52.136]:37632)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1iaAGs-0007wP-G8
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 22:15:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Nov 2019 19:15:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,251,1571727600"; d="scan'208";a="234307724"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga004.fm.intel.com with ESMTP; 27 Nov 2019 19:15:06 -0800
Received: from fmsmsx102.amr.corp.intel.com (10.18.124.200) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 27 Nov 2019 19:15:06 -0800
Received: from shsmsx105.ccr.corp.intel.com (10.239.4.158) by
 FMSMSX102.amr.corp.intel.com (10.18.124.200) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 27 Nov 2019 19:15:06 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.108]) by
 SHSMSX105.ccr.corp.intel.com ([169.254.11.225]) with mapi id 14.03.0439.000;
 Thu, 28 Nov 2019 11:15:04 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: RE: [PATCH V2 0/4] Introduce Advanced Watch Dog module
Thread-Topic: [PATCH V2 0/4] Introduce Advanced Watch Dog module
Thread-Index: AQHVpTost7EjEw2DykO80qUemhR1uqefzLTQ
Date: Thu, 28 Nov 2019 03:15:03 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D780631A4A4@shsmsx102.ccr.corp.intel.com>
References: <20191101024850.20808-1-chen.zhang@intel.com>
 <9CFF81C0F6B98A43A459C9EDAD400D78062F1384@shsmsx102.ccr.corp.intel.com>
 <87eext8gmb.fsf@dusky.pond.sub.org>
In-Reply-To: <87eext8gmb.fsf@dusky.pond.sub.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjc5ODNkYWItMGIwMi00ZmU2LWFiNzEtYjlmYjU0NWNhYWM5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRzJhcFFOanFublBlU3BqUmcrMXAwNjFnUFZ4WXAzeHJuMFdqN1R3YjhCSVZLVXpLVXk1Nk9od21QZWpCZW1JeSJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.136
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-dev <qemu-devel@nongnu.org>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Markus Armbruster <armbru@redhat.com>
> Sent: Wednesday, November 27, 2019 11:49 PM
> To: Zhang, Chen <chen.zhang@intel.com>
> Cc: Jason Wang <jasowang@redhat.com>; Paolo Bonzini
> <pbonzini@redhat.com>; Philippe Mathieu-Daud=E9 <philmd@redhat.com>;
> qemu-dev <qemu-devel@nongnu.org>; Zhang Chen <zhangckid@gmail.com>
> Subject: Re: [PATCH V2 0/4] Introduce Advanced Watch Dog module
>=20
> "Zhang, Chen" <chen.zhang@intel.com> writes:
>=20
> > Hi~ All~
> >
> > Ping.... Anyone have time to review this series? I need more comments~
>=20
> Any takers?

Hi Markus,

Thank you for your attention.
This is a very simple module to complete the tasks related to error detecti=
on and automatic processing.
I have write the detail reason why we need it in real environment on the co=
mmit log.
Here is the latest patch:
https://lists.nongnu.org/archive/html/qemu-devel/2019-11/msg02872.html

Thanks
Zhang Chen


