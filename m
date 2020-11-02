Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D82C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 20:16:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F70621534
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 20:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mLedTD8z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="iB8cSx50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F70621534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZgFq-0005Ht-Rr
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 15:16:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1kZg48-0004YK-DV
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 15:04:33 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:43571)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1kZg45-000353-WB
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 15:04:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1604347469; x=1635883469;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=0mnp43mgPhbKhzcPkj/kW4Ce1lJLDiymgzSAFodhEs0=;
 b=mLedTD8zsT9YAPW41tLKBGyb1zQVr1qcb0G2o7XvLOVUhwWWXytC7G5P
 Tku+RFJv3XZIyggUqXoqEKmbmPfQUSA3eC3x4ro8m/l15zimCM9p9W5ti
 xVP7uU2EOg0YipL35Zziv1agUgdkZG+SEqYL3COiGGD/zZGfQFmmX9cHk k=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 02 Nov 2020 12:04:27 -0800
X-QCInternal: smtphost
Received: from nasanexm03c.na.qualcomm.com ([10.85.0.106])
 by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 02 Nov 2020 12:04:27 -0800
Received: from nasanexm03c.na.qualcomm.com (10.85.0.106) by
 nasanexm03c.na.qualcomm.com (10.85.0.106) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 2 Nov 2020 12:04:27 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03c.na.qualcomm.com (10.85.0.106) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 2 Nov 2020 12:04:27 -0800
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com (10.167.173.24) by
 MW4PR02MB7265.namprd02.prod.outlook.com (20.182.11.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.19; Mon, 2 Nov 2020 20:04:26 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::dda2:8e04:fb37:ea4c]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::dda2:8e04:fb37:ea4c%7]) with mapi id 15.20.3477.035; Mon, 2 Nov 2020
 20:04:26 +0000
From: Stephen Long <steplong@quicinc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philippe.mathieu.daude@gmail.com>
Subject: Re: linux-user/elfload.c: Seeing a segfault in qemu with a binary
 with no data section
Thread-Topic: Re: linux-user/elfload.c: Seeing a segfault in qemu with a
 binary with no data section
Thread-Index: AdaxUyv7uCuOMu4XSoKbndddapgs5w==
Date: Mon, 2 Nov 2020 20:04:25 +0000
Message-ID: <MWHPR0201MB354799A3C98A1B3AE7741DB2C7100@MWHPR0201MB3547.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [2606:6000:cfc0:2f:41ec:6160:7613:734c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 696cddf2-28f5-4a32-9ae2-08d87f6a7fde
x-ms-traffictypediagnostic: MW4PR02MB7265:
x-microsoft-antispam-prvs: <MW4PR02MB7265B8D0CB3EA6619D8466B0C7100@MW4PR02MB7265.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O0qYDA5I3CFWQXLl8oD5VUbsdcggN0c2yAvmeG71iUgfRE3aZdwhN3gsI1WwK/e61+F1nheRFpJE6dZO8ysHbooOn4QQvlVeSMofYEVlhIJ4h7ivcX2ZEmnVcrK459ixbZoJTlc9IYIZqhx+xy41b7/I6f3Gi4ZIn/h/vKeOOwFdxP8cIhGQnl2hYVe6HfsAGMX48siFMF3S7THTRsB6eKIddXsBFlc3Aal1rP34l87m9OgTSW7UDL/+Vk5rqhV9L0Aieqn+UfFp1BpYIuUiSECxCKfKGIieOdNFkPJZfty6q75azLYE/F9kBT3412xdjnDLJvR9p9kJViUcVioS0A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(346002)(366004)(39860400002)(396003)(136003)(52536014)(66446008)(2906002)(110136005)(7696005)(5660300002)(6506007)(9686003)(66946007)(64756008)(66476007)(66556008)(76116006)(54906003)(8676002)(316002)(478600001)(558084003)(55016002)(186003)(71200400001)(86362001)(4326008)(33656002)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: FC0uo7HflSQo8Nce/hrFGVi0YWNL3oXHGnxk8Rdjn+Hy0b8gS2TZ7gTMZUOBF2IR31TRR/7HMdk3g4lawb7ez1IQ10tA4FUHN7Sj9xOTjhLlkyEnKgZ5aIJDvoH6DqcGIaGjy52GdlkBLDJk6B7vAIO+Tza1Q6nLA2FvxropI3YBOPNp58aJ180T0DAtVqdtCJmvt0KcOibgqf/BqF5/1Y/pM7lYV4Hx9OGwqiMKt9LWexOOxkGp55T69LJtJT2TNf7EjPy72sRSHNwm7sHPWNh8zdFfIdawehhQKt2uvYUEIFdKfghDMBXFp+5IoxRAgBwuxenRkARUhlvKHDTwqmuzcjOWHJFU1JMDmbUg3MrFY5f76i66SGzPRY0OnL+wUA/419wD78kQBXrBmJKuCxxrUbfoVMtJy6AZ67fb70pHiZ5xiDc9/X0TWgpzZ9Y3fxuKxvLotekZHOjMJX4EBvjV41ICommQymrz1dyVZeJ/CxegMptZyuJV3bppdZes53ee2QqWsJrczj1NjutqvZV1A2UQZEfTfcUEwjI/Zx3cUmr9QseZpQUsvqVsd5ubaAgoqb1nYmWDowyqKyYNq9YVCPgCst6cIWFcCwaBu6U/sHJ/ocvgIdL25NbYALGwxAPF7IisdBoPz79O0Qd7T7GnHzfvEwPG8Yx8kd+oZWSD96+BXfFlFXCRev8bMg0QVrx/i0WZMMqe/EBot4LF/A==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awrsYA++QJEiW9NULfkU10/RVSx9zDZIRiFob4YZAvRFi6ZYijTRCBTHPXcDUBFqexEayhQDhoP4ivrP+VuLedSNnbOXQ2l6k6CleGNwyb1Tdo2DGwIVrw/iSsV4XhyIXLbOPxs9nWKS2oAaAQWi6iF7wJhrXslXQymJ9V798HA4lhrAKU3ZAsKyvqxwZEDEoRkZP/k0AXUCvJMrj56X0PWlAxkkVdzYCYwiKdbQbpa62zOp7GE/5SK1V67aWvPSpqnhjkrg71BtafGNAa5ggcxNE/anBC9tBWtxS67Rmj5VpUlzGQmZ7lnGQqoXdcerVIcPzc4GPfjxSvOFI5HRGw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USKCG5ut7NkUhbjcF8SglNyEyEIY5r6YCIbOdPZE+Z0=;
 b=VIPwh1qb5zbLywFa/62O+55ba+77iy3uzirJZlfJNy9YuodiFFDrRc/8SAkjrVGScHotFt8pbFfbYdQ+qDB9iswfUM2QScDI4uHQOYXwB0tXbGCer3RveG434yrVC2hWV382Ev7uGHllEJbw6FfzdKxORkVHJ7FQwEpKcfJepxU8xwibO0nGhbw/k1UkPTyVx0ISjPw8MaJOu4RuarkXVMS1VEzlZNTtzpWj3L+/TuHcwSNr+xE+cArKZyUGRykEJ54x/gPwkO9V8MWSY04ebzIHRkhWqk0buzr0s8C4kXRAx61SspZnHbKvgjbY2L7V1sSSYe/nhZDEQwc9HDyFoA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USKCG5ut7NkUhbjcF8SglNyEyEIY5r6YCIbOdPZE+Z0=;
 b=iB8cSx50E8AZK3VbSgHxj3FcrhHLRe8fWbr3q8uIrncnRAqBidDhtk8vREmcN4G5V/SXWD9gGxZDjWNPsLzLr7S2nuYzS6VkDGQgthHQn/oTgMKHfwph7x8pxbndMe4iYppHW14MUtyLTY6Vvpxhrqpk1KRWK1vJO6LJQxGxUvM=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: MWHPR0201MB3547.namprd02.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 696cddf2-28f5-4a32-9ae2-08d87f6a7fde
x-ms-exchange-crosstenant-originalarrivaltime: 02 Nov 2020 20:04:26.1081 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: wrpYZ3ENWen1EwU54ynYChjlaQyJ4spfMn7GLPnRBmVw2VRK8AUJ9NNqmrUQjFwKkAqBAASRg0BSne71QhVI+g==
x-ms-exchange-transport-crosstenantheadersstamped: MW4PR02MB7265
x-originatororg: quicinc.com
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.38; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 13:30:16
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 "laurent@vivier.eu" <laurent@vivier.eu>, Ben Hutchings <ben@decadent.org.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ahh whoops, I see the actual intended change was to replace "eppnt->p_files=
z !=3D 0" with "vaddr_len !=3D 0", which isn't on master.

Thanks,
Stephen

