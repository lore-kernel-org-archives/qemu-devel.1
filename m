Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C37BC4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 16:17:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2B9521721
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 16:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B9521721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60590 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hajSF-0003yY-Ek
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 12:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35211)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <hang.yuan@intel.com>) id 1haiwX-0000v1-Ll
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:44:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hang.yuan@intel.com>) id 1haiwW-0005Ky-5k
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:44:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:61049)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <hang.yuan@intel.com>) id 1haiwT-0005CI-EK
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:44:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Jun 2019 08:43:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,362,1557212400"; d="scan'208";a="183838166"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
 by fmsmga002.fm.intel.com with ESMTP; 11 Jun 2019 08:43:57 -0700
Received: from fmsmsx111.amr.corp.intel.com (10.18.116.5) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 11 Jun 2019 08:43:56 -0700
Received: from shsmsx108.ccr.corp.intel.com (10.239.4.97) by
 fmsmsx111.amr.corp.intel.com (10.18.116.5) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 11 Jun 2019 08:43:56 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.137]) by
 SHSMSX108.ccr.corp.intel.com ([169.254.8.188]) with mapi id 14.03.0415.000;
 Tue, 11 Jun 2019 23:43:54 +0800
From: "Yuan, Hang" <hang.yuan@intel.com>
To: Stefan Hajnoczi <stefanha@gmail.com>, "Xu, Colin" <colin.xu@intel.com>
Thread-Topic: [Qemu-devel] New HAXM maintainer
Thread-Index: AQHVFG9hXb6g1URZF02Y0Qf1WsVgjKaWIggAgACNImA=
Date: Tue, 11 Jun 2019 15:43:53 +0000
Message-ID: <C294FBAE55175941838A8D362DCD8AA225EFEEFE@SHSMSX104.ccr.corp.intel.com>
References: <a84315e7-6e37-cb4b-1ec8-f1e5831594e8@linux.intel.com>
 <20190611151530.GA1620@stefanha-x1.localdomain>
In-Reply-To: <20190611151530.GA1620@stefanha-x1.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMmE4NTc4NzItMDljNi00ZWNhLThkYzYtY2VmZmJhYTkwYzAwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQUdUQWsyWkpyUXFLbnZtSUNWQlVaYWJscVN5SXorZmJJbjBUb2FLQjQ2STlFa0RncVNmSGJEK01sdTRTOGo1OSJ9
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.20
X-Mailman-Approved-At: Tue, 11 Jun 2019 12:02:01 -0400
Subject: Re: [Qemu-devel] New HAXM maintainer
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
Cc: haxm-team <haxm-team@intel.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thank you for the good suggestion! We will prepare the patch.

Regards,
Henry

> -----Original Message-----
> From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
> Sent: Tuesday, June 11, 2019 11:16 PM
> To: Xu, Colin <colin.xu@intel.com>; Yuan, Hang <hang.yuan@intel.com>
> Cc: qemu-devel <qemu-devel@nongnu.org>; haxm-team <haxm-
> team@intel.com>
> Subject: Re: [Qemu-devel] New HAXM maintainer
>=20
> On Mon, May 27, 2019 at 05:34:24PM +0800, Yu Ning wrote:
> > I am leaving Intel, and will soon lose access to my Intel email account=
s.
> > Effective today, I am no longer maintainer of the HAXM open source
> > project (https://github.com/intel/haxm). Colin Xu (colin DOT xu AT
> > intel DOT com) will take my place, and he will be helped by Henry Yuan
> > (hang DOT yuan AT intel DOT com) as well as the rest of the HAXM team a=
t
> Intel (team email:
> > haxm DASH team AT intel DOT com).
> >
> > I am grateful for all the support this community has given to HAXM and
> > myself over the past few years. I would appreciate your continued
> > support for the project and the Intel HAXM team.
>=20
> Colin and Henry, do you want to send a patch to the ./MAINTAINERS file?
>=20
> By listing yourselves as maintainers in that file scripts/get_maintainer.=
pl will
> identify you.  This script is often used by people to decide who should b=
e
> CCed on patch emails.
>=20
> Stefan

