Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274FDC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:33:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7D5A20578
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aDpJM8qU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7D5A20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDsBM-0004Tf-U6
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brogers@suse.com>) id 1kDrop-00013u-8B
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:10:36 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:25614)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <brogers@suse.com>) id 1kDrol-000816-Jb
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1599149428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/tjJjtORtCoA8Ohq8VNcGpGkXccyoEXuv0VXae/j/xg=;
 b=aDpJM8qUYjVei6kpXMIpUQhbn76TJpCT6MhQLoSA1w6E5xC2NklvNPsgLoRNVPTRLKgEbp
 l7qRHGyQqY9c2JBiEa/W+KbMzWh7RsGXIX2bltdVVsRRNkNvxDS+bRDxie36/feWvTJrqI
 pZbAq2BIBZO71WmUXWEPakuErBC5Bd8=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2173.outbound.protection.outlook.com [104.47.17.173])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-26-Pm5d72PmOQyRy7uf_wq_dw-1; Thu, 03 Sep 2020 18:10:27 +0200
X-MC-Unique: Pm5d72PmOQyRy7uf_wq_dw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8VRVItfAr7eAOTYVUFP8efblXD29IPvAw0DU7Orb1rEjpLnj9DL4VPDmnaf3TtfEMBQw3trcigKKqTjX7fqSTaYUC+mMN2kM5qB5sM1S8zvIgNQKtg7H9FilXIGPOthiiAw2ptlm36TAvKTnpQDg1UIrg+38FpfR0ppmJHo92yoHRhgH3lG5jaKPLKrF/Gjv3GiZC1MApNqxLAMd8JmSuEiGwM0ZwU8MkZMbaCkz3D5Ck+yPGEr/thR4d26sGBJr9y7HF6ep8mql8yMaE/Ggapyfc3z1RdLuVcCD8okslGNh1kkpLC0CotjxcLLuu4NfAdRaY0CJySQlcysn7m2sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ga0Db2XxpF9a1VFJG9JuOCJR7QoeVGV2nWGkHIA/UA=;
 b=JqXF4oXkoCnwfa1nCcasmG/0TDte4dK+99+4ptRInwPBiBYmqPAaKcxXcenFFIxb+s1dG62b3cHbwrGCvuclsRVO9oQh6uW0oVMYYbVQLTOG0/gbDhKeLcNc30FzAlmbRuL4hj3O/FffeAQM3rMte3tR39QoGw3mYT6GBxoBYRtz2mpP15mqXcXurGUlr0ZwqBxqVT3MN7PdhIS0/rePiigTxseE0JR4jFrpKqJnpJY5eWMj3uKMJX+jFe6GnAWzK5563lYCTG02W5PEAZz4NqeYw8EHZOrtOn2BBeBPxuZ6uBfcozEYQBjFAbLmwlakr91dvPrvLFsICex6SHLMHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=suse.com;
Received: from AM4PR0401MB2354.eurprd04.prod.outlook.com
 (2603:10a6:200:54::21) by AM0PR0402MB3906.eurprd04.prod.outlook.com
 (2603:10a6:208:e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Thu, 3 Sep
 2020 16:10:26 +0000
Received: from AM4PR0401MB2354.eurprd04.prod.outlook.com
 ([fe80::9c57:5888:a06b:ec05]) by AM4PR0401MB2354.eurprd04.prod.outlook.com
 ([fe80::9c57:5888:a06b:ec05%10]) with mapi id 15.20.3326.025; Thu, 3 Sep 2020
 16:10:25 +0000
Message-ID: <965ae4eb1545abded177518f36b0f5dcf68a9169.camel@suse.com>
Subject: Re: [PATCH] meson: install ivshmem-client and ivshmem-server
From: Bruce Rogers <brogers@suse.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Date: Thu, 03 Sep 2020 10:10:17 -0600
In-Reply-To: <20200903154906.GA441291@redhat.com>
References: <20200903153524.98168-1-brogers@suse.com>
 <4eba2feb-a9b3-8bb7-6ed7-6b02c79519b1@redhat.com>
 <20200903154906.GA441291@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM4PR0302CA0023.eurprd03.prod.outlook.com
 (2603:10a6:205:2::36) To AM4PR0401MB2354.eurprd04.prod.outlook.com
 (2603:10a6:200:54::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.5] (63.248.145.198) by
 AM4PR0302CA0023.eurprd03.prod.outlook.com (2603:10a6:205:2::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Thu, 3 Sep 2020 16:10:24 +0000
X-Originating-IP: [63.248.145.198]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f70dfd57-8ee4-446b-31bc-08d85023de26
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3906:
X-Microsoft-Antispam-PRVS: <AM0PR0402MB390678C19F89EC77123256E1D92C0@AM0PR0402MB3906.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p7gVIwZrmKM8+2qmJOQ6pQHxKV7UdJvS43ee5BDqcE1Yzvi2vc4rIZ1xRftdhI7VOCOgTbhqdLfzjWuMYaGfFY/JUUPgrNclY87FHrIyvseWAtwEunkt8UhRfIZp/lXmROm+OveRpi4Ks3kIbfV9iCc878ezrjYIme/jErUwTuHbKQnhPMcAqibafoT5WghjlD7zLl2ljitwpkARIeMAJ3QGtoKHp+PNbqmleaDTQxRKl4FuS+/n2WCdFKKA7khJDBpqGhPpo25fH+/3qxHxXYQC/+LDaLpaLI87rFwF1mrvZBuBc85cHF25lrM35yDKgvII67AAMslwprVr2f0lTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR0401MB2354.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(346002)(136003)(376002)(366004)(39860400002)(6486002)(66946007)(66556008)(478600001)(86362001)(8936002)(186003)(6666004)(16526019)(2906002)(66476007)(316002)(16576012)(26005)(8676002)(5660300002)(2616005)(956004)(83380400001)(53546011)(36756003)(4326008)(110136005)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: QdxBYOe/T3P7fgJQ2oaoFDFF8H+OqKR6FhbiB0ziWApOf/pSsRe2/xBcD2Z1xhqDqTrJa0lahejQ4rrDce+uE50Tt4uVIu6wYZrZWVRXJwEDRHwqx/X8DeuImPe+jV9Vd3h9KJntTBErvHIi0ohqpy0RMUyJjfB32OrbKK8sbmvOgXijSM0R9/16ycramS+oDWw/L72P+cpkv7FU8Dc2xMY/vY2qjZzWC/GAQ0XEXh73vXEWJO9umMJk2vvG3mVI75nCrQ8Zr+M8f6825iz5d3P/HCywgQsw+SXrwIT9UJkSlNGs02NWMLlGvGXXTa2b9rgO/PPKUuuqXErtyz78BG8Ii3w6ZdfFA08kcfmPavO8izlvfVteKyluCFArjjxE6XLluVPBUZ9qL0ILFLmG5rJZU3aFVUbV0eOiv74lu5kvVaiQBd1RVd9mqcWs0xo3DlTmyqm+1HNcVdPhTm6TWhUVj2dtD2KTHNGqaFIU6MJ7HN0iW6SUTGTLtE7rclM945B1puQ6gOHObT/BvGOmdXXgyU52KJ0SVaUjzJxiRNnfXA8aClAnR4nfF8U02We2Y3YgoI/qdSHJmqmADDlBUAaBj25DhFHFo6IzI+xNu/RpFOpUXauHYKJKVb4NuK6Uu1GuBtBy792amZZz5F5mVQ==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70dfd57-8ee4-446b-31bc-08d85023de26
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2354.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 16:10:25.8050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X13D79ce/W6TGTvS30J+NOIzFZxC+NysUpDL6Kk+LyRlxUgUw+7/h0vWW6gvy+SkE/QYr9PVL/8NTWZmyF9F6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3906
Received-SPF: pass client-ip=62.140.7.102; envelope-from=brogers@suse.com;
 helo=de-smtp-delivery-102.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 12:10:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2020-09-03 at 16:49 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Sep 03, 2020 at 05:44:25PM +0200, Paolo Bonzini wrote:
> > On 03/09/20 17:35, Bruce Rogers wrote:
> > > Turn on the meson install flag for these executables
> > >=20
> > > Signed-off-by: Bruce Rogers <brogers@suse.com>
> > > ---
> > >  contrib/ivshmem-client/meson.build | 2 +-
> > >  contrib/ivshmem-server/meson.build | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/contrib/ivshmem-client/meson.build
> > > b/contrib/ivshmem-client/meson.build
> > > index 1b171efb4f..83a559117f 100644
> > > --- a/contrib/ivshmem-client/meson.build
> > > +++ b/contrib/ivshmem-client/meson.build
> > > @@ -1,4 +1,4 @@
> > >  executable('ivshmem-client', files('ivshmem-client.c',
> > > 'main.c'),
> > >             dependencies: glib,
> > >             build_by_default: targetos =3D=3D 'linux',
> > > -           install: false)
> > > +           install: true)
> > > diff --git a/contrib/ivshmem-server/meson.build
> > > b/contrib/ivshmem-server/meson.build
> > > index 3a53942201..a1c39aa3b3 100644
> > > --- a/contrib/ivshmem-server/meson.build
> > > +++ b/contrib/ivshmem-server/meson.build
> > > @@ -1,4 +1,4 @@
> > >  executable('ivshmem-server', files('ivshmem-server.c',
> > > 'main.c'),
> > >             dependencies: [qemuutil, rt],
> > >             build_by_default: targetos =3D=3D 'linux',
> > > -           install: false)
> > > +           install: true)
> > >=20
> >=20
> > They weren't installed before the conversion, were they?
>=20
> Unfortunately they were historically installed with --enable-tools.
>=20
Yeah, that's how I was getting them installed in what we are packaging
up.

- Bruce


