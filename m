Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D126C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 22:24:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24853206D4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 22:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=data61.csiro.au header.i=@data61.csiro.au header.b="i08BznKI";
	dkim=pass (1024-bit key) header.d=CSIROAU.onmicrosoft.com header.i=@CSIROAU.onmicrosoft.com header.b="iHQgt+gg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24853206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=data61.csiro.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iukth-0008BE-9s
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 17:24:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41265)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=284a180dc=Peter.Chubb@data61.csiro.au>)
 id 1iuksx-0007QL-Hw
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 17:23:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=284a180dc=Peter.Chubb@data61.csiro.au>)
 id 1iuksw-0000Xm-7l
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 17:23:35 -0500
Received: from act-mtaout2.csiro.au ([2405:b000:e00:257::7:38]:31526)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <prvs=284a180dc=Peter.Chubb@data61.csiro.au>)
 id 1iuksu-0000Ry-Qp; Thu, 23 Jan 2020 17:23:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=data61.csiro.au; i=@data61.csiro.au; q=dns/txt;
 s=dkim; t=1579818212; x=1611354212;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=tYdoDcdCsoZBk/rNmNfPsl03Ec2TC8cS5tFBud7PxeI=;
 b=i08BznKIzShtba/dcY2aYMmCV5EndwzLcDwDa9mbXML00Z/redYMePcr
 toHS6vj09NUnMHmaBTWRCLx9yST0SANesoRhWWoe3sLzwDTSxou66cKZs
 6sOUbCII7ip1wz3UQVJYnadoncmGoCBz0UhvbA3o/y1phH9KqvwBrgG/3 A=;
IronPort-SDR: hbzQaXWjRsDhjlB9sEhNez+vJrujh9XhPRIUTNVQM9QlND6Kpm5zuN3n1FpZU5NZPzzjR6iyRg
 sNIhN2XC1EUg==
X-SBRS: 4.0
IronPort-PHdr: =?us-ascii?q?9a23=3AhX6DkRVfw21GiVKpAzEdi7eBsfjV8LGuZFwc94?=
 =?us-ascii?q?YnhrRSc6+q45XlOgnF6O5wiEPSAt2J8OpK3uzRta2oGXcN55qMqjgjSNRNTF?=
 =?us-ascii?q?dE7KdehAk8GIiAAEz/IuTtankCEdhPThlO/2yxO2BZEdr3OQSUqWaz9zlUEw?=
 =?us-ascii?q?isfQc=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A+EEAQCTHCpejACwBSSwhIATAJKcgDR?=
 =?us-ascii?q?lHAEBAQEBBwEBEQEEBAEBgWoEAQELAYFTUF4TeAQ1CodOA4sPnUADVAkBAQE?=
 =?us-ascii?q?NAR8OAgEBAoECgzwCgh8kNwYOAgMBAQsBAQUBAQEBAQUEAgIQAQEBJoVnDIN?=
 =?us-ascii?q?OcAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFAoEHBT4?=
 =?us-ascii?q?CAQMSFRMGAQE3AQ8CAQgOKBAQIiUCBA4FIoMEAYJKAy0BAQICojYCgTmIYAE?=
 =?us-ascii?q?BgXMzgn8BAQV3hBcYggwJCQGBLgGMFoIaEoE1gl0+hEmFbq9YBwECgjmHQI5?=
 =?us-ascii?q?0G4I3mECXQI4OhBgCBAIEBQIOAQEFgWgigVodT4NACUcYDYgBGoITgUaKU3Q?=
 =?us-ascii?q?CgSeLCwGBDwEB?=
X-IPAS-Result: =?us-ascii?q?A+EEAQCTHCpejACwBSSwhIATAJKcgDRlHAEBAQEBBwEBE?=
 =?us-ascii?q?QEEBAEBgWoEAQELAYFTUF4TeAQ1CodOA4sPnUADVAkBAQENAR8OAgEBAoECg?=
 =?us-ascii?q?zwCgh8kNwYOAgMBAQsBAQUBAQEBAQUEAgIQAQEBJoVnDINOcAEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFAoEHBT4CAQMSFRMGAQE3A?=
 =?us-ascii?q?Q8CAQgOKBAQIiUCBA4FIoMEAYJKAy0BAQICojYCgTmIYAEBgXMzgn8BAQV3h?=
 =?us-ascii?q?BcYggwJCQGBLgGMFoIaEoE1gl0+hEmFbq9YBwECgjmHQI50G4I3mECXQI4Oh?=
 =?us-ascii?q?BgCBAIEBQIOAQEFgWgigVodT4NACUcYDYgBGoITgUaKU3QCgSeLCwGBDwEB?=
Received: from exch4-cdc.nexus.csiro.au ([IPv6:2405:b000:601:13::247:34])
 by act-ironport-int.csiro.au with ESMTP/TLS/ECDHE-RSA-AES256-SHA384;
 24 Jan 2020 09:23:22 +1100
Received: from exch1-cdc.nexus.csiro.au (2405:b000:601:13::247:31) by
 exch4-cdc.nexus.csiro.au (2405:b000:601:13::247:34) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Fri, 24 Jan 2020 09:23:21 +1100
Received: from ExEdge1.csiro.au (150.229.7.34) by exch1-cdc.nexus.csiro.au
 (152.83.247.31) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend
 Transport; Fri, 24 Jan 2020 09:23:21 +1100
Received: from AUS01-ME1-obe.outbound.protection.outlook.com (104.47.116.58)
 by ExEdge1.csiro.au (150.229.7.34) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 24 Jan 2020 09:23:16 +1100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkcYpVBg1NKCwTgBhtApiJBFNsdqTjEvWakatQO2+bbCbIS2z9pIi3crmEGZ3Wto54LrL3qeYBJSTHa65jcgMK6e6UjwiyPqCqmfVMMGWapyjcDOs/OunPyxA+zz0Ou8hofVfSYM9cN6lsiR/GNr5gzXPV3ua+Gm4S2RYGBxmGRyIuyBDrGF5b6Z63COV2ova7ggPm1KbZig8GIARLrbYZkUSFm5g84W1gVmzwaMMCVhlvrO9Lu7FWibYjn/op3LbGp0oJt27foUBK1doDxy0U/2ytIGYGWaVMoNHYUBWCGkiWo8eY4M5VwFOrI/Ypq4lUmgW0R+/Hs7BMsB5eOAaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/1aDiNnyfyNKKdk+tBGP31D24zHTVGXC7CsKcHQRtI=;
 b=ITwEjpLcpv8Y30LcHFEth+YGVwUDGArX+Rq8y7PnCWXFy2QdWjAFJzmJDrwTUv61AYZulowgNQVQnWjlsCh77oAqKFIds3/dm61f7RbZlgmlSQhkpEKfKq91+gueh6xSVLIU+SO5VdAxspuH3j8e38PmEzcg4XOZMAWc81JBO3Jv8lEWFkf6YVdemx8MYcwaGi1mGONVj5ca+sb9KdzURQ6P15jxrrOuyMDG9J+FgoX3VX3dPwSQel9juPEkRywWblDIZ8lbQ1PbtPSqaLVUj3haq/7lCo6AeKcnCKMPpvbJt5/E8r0ek2ycsVzjx7JYv5MtouJbV4/ECApISlMp3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=data61.csiro.au; dmarc=pass action=none
 header.from=data61.csiro.au; dkim=pass header.d=data61.csiro.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CSIROAU.onmicrosoft.com; s=selector1-CSIROAU-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/1aDiNnyfyNKKdk+tBGP31D24zHTVGXC7CsKcHQRtI=;
 b=iHQgt+ggxOADbSdA2taQO1sqIi4cY+bDFQpHxVJP0A6cMK5DhBxDrcU/2Xnh3TVm5HjM55twEL3flB+KyBtNFurzs00El3X5LN0O2wjC1q1lwSAiiPXWMv8XteDv6urVA8rxZKrE/4edhmbGrxxD7DrbQL5YtvCKh5KIyYlZALI=
Received: from SYCPR01MB5101.ausprd01.prod.outlook.com (20.178.184.208) by
 SYCPR01MB3950.ausprd01.prod.outlook.com (20.177.143.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.24; Thu, 23 Jan 2020 22:23:20 +0000
Received: from SYCPR01MB5101.ausprd01.prod.outlook.com
 ([fe80::413c:1062:c76:11e9]) by SYCPR01MB5101.ausprd01.prod.outlook.com
 ([fe80::413c:1062:c76:11e9%6]) with mapi id 15.20.2644.028; Thu, 23 Jan 2020
 22:23:20 +0000
From: "Chubb, Peter (Data61, Kensington NSW)" <Peter.Chubb@data61.csiro.au>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH REPOST v3 16/80] arm/kzm: drop RAM size fixup
Thread-Topic: [PATCH REPOST v3 16/80] arm/kzm: drop RAM size fixup
Thread-Index: AQHV0eIaZNsiC0tAMkmTgShAgbpGh6f406gA
Date: Thu, 23 Jan 2020 22:23:20 +0000
Message-ID: <84zhedx161.wl-Peter.Chubb@data61.csiro.au>
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
 <1579779525-20065-17-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579779525-20065-17-git-send-email-imammedo@redhat.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Peter.Chubb@data61.csiro.au; 
x-originating-ip: [221.199.209.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d6a37fe-a005-4859-9e61-08d7a052da17
x-ms-traffictypediagnostic: SYCPR01MB3950:
x-microsoft-antispam-prvs: <SYCPR01MB3950E10EE50ECDFE2A4C4F08BB0F0@SYCPR01MB3950.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:425;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39850400004)(396003)(136003)(346002)(376002)(199004)(189003)(316002)(54906003)(6486002)(86362001)(5660300002)(4744005)(478600001)(6512007)(2906002)(966005)(26005)(2616005)(6506007)(8936002)(4326008)(8676002)(81166006)(66556008)(66476007)(6916009)(64756008)(186003)(71200400001)(76116006)(66446008)(66946007)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SYCPR01MB3950;
 H:SYCPR01MB5101.ausprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6urm8GCUDaFfQlpWnrsW2wglGrDbbb926iXXfSd3/317DuPeS4yoQmJOgJujlQ8DtZ+1u3hQPvkkmeSB52XtVTTFoMzNTI6MkzYB0jbNYX0vgConpj2kUG3rqo/4pWMB/CMsNQHQXSoS6eWKDGV9BFmFWHRhuHB7eUY9cYivHLB0DfLYrMgFF0gFq1BQ13LzHLjXxU2Qe7Cjdnf70TW+F8jIlJGPWk+q/IjS2CIWbgzEhaVPX+s8oKpzv/Od2B4ICK9ev5c6Lz8RpuMY4o32L0uKcy79xLaPGEh8yvKnA+sIDeH9H5aqMUQYkRxd/JDfzVlA6JnJASsJzhd9aWr/hMIj4yhW2wG3HFbglph54QJKWx55uxcwfgSP9JPCU5Ig8hDyITi/pB6JOywmIoGJ5tqT3VzYYG0Hx2D/Y4UI4bGAwKYkFxTe+ITAAccX3FbrikMFA2XtaftUorR4s2vxtqnRVnx2S3zyl1eTDwwRyAM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E7643C225687384598AF762A2CA3CF8A@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d6a37fe-a005-4859-9e61-08d7a052da17
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 22:23:20.1318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0fe05593-19ac-4f98-adbf-0375fce7f160
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ov6o4+Sih3JDo4eX2ThZpM24WgGOft1VgYEfV5h3lax4kv300w3HEtMXpYe0fZ2o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYCPR01MB3950
X-OriginatorOrg: data61.csiro.au
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2405:b000:e00:257::7:38
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "peter.chubb@nicta.com.au" <peter.chubb@nicta.com.au>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Igor> If the user provided too large a RAM size, the code used to
Igor> complain and trim it to the max size.  Now tht RAM is allocated by
Igor> generic code, that's no longer possible, so generate an error and
Igor> exit instead.

You can add my 'reviewed-by' to this. There's one really minor typo in
the comment (tht->that) that you may wish to fix before the final
commit.


Reviewed-by: Peter Chubb <peter.chubb@data61.csiro.au>

--=20
Dr Peter Chubb         Tel: +61 2 9490 5852      http://ts.data61.csiro.au/
Trustworthy Systems Group                                    CSIRO's Data61=

