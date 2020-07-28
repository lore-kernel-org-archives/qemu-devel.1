Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F0FC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 01:07:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C198720829
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 01:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fujitsu.onmicrosoft.com header.i=@fujitsu.onmicrosoft.com header.b="msblpOIW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C198720829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0E5X-0002mi-33
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 21:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1k0E4p-0002MO-TU
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 21:06:43 -0400
Received: from esa8.fujitsucc.c3s2.iphmx.com ([68.232.159.88]:61698)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1k0E4m-0001XW-Jg
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 21:06:43 -0400
IronPort-SDR: HPPtf7IzFTto7joHIMCWvTrLg1j7UX56ElCjembggH9jz96SAqSpJLCTYpow/OlfAMr3W5vq/8
 SpZV4hE5jdDJ1AqZ1lxLRj1CNPMS86gGZXV4Qs55XYh49iGvzGLCOlpk2S/lklPgenUZ2fyLe4
 fRL8mHzLexEJb5yes5+E5xVUO/MHqXYTvQkgAIEf/Og02OUei3g+NSf6+QoLgFx/PHVFFqKqA0
 Hd+gAR2Q57nDyEDD3T4tAIK/TUsCouYxU77fl/BqbWcoezgUXsOj6zVjd/wFtIIQbg7GvA8lHO
 jX4=
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="16082438"
X-IronPort-AV: E=Sophos;i="5.75,404,1589209200"; d="scan'208";a="16082438"
Received: from mail-os2jpn01lp2052.outbound.protection.outlook.com (HELO
 JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.52])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2020 10:06:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjyHlJtAWnDYyGLgmIUlKZXEKwIXx95lRVOrlFHQA+YGgw32o/S2svNkCR5Ut5OO84eEyyVawjIoA75o6AaxeiQr+7I8AS+JOWXQ6tv9FqfVrIRpJ76sb6FRtIwZHsDu6K6JF+IB+u1hIfkKiPkt9M+KJm7hCJkEyERs7ToE8hrp78fOSEbUMdAUKv/AxYTvOY1S2bdVqnc0L11+d2cvW7l2Mv92U7vlQsbZls89GVYw5ddrAxtzz6n3xXv84K1Z0uGTa6k0eg7lL5hsw/T4wVCCFrVfMTANrKM2MDK74oiR/++35ql1qLLWQ1doF5IEHO6fEtKFhtZd+kp9wNWBcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJLwpsTVnamdBcvWM3pinX7B3nkos738/piCt9lRNMc=;
 b=AKz2iQ7IbeDpFxUTX7ToXOZx7oIn7Ngn6cUa+Ltquxxy77OOSPZ7jy9o6NBBr3ra3ApP2qWbpo31xo1kwGcfqBcrmxaKMUOS92s4pvwQ3gE1X5RB5YnQE/S+UvIwfuz02Sm2AJ5I3OPSzA586zgYOrYmhUrkaNZmNcJHtwXwU66Ea2DLNIVJic/FWNSWjpqY9baHL5iza47CFI1AtzCe9r4mRns8oyzrN5S+XU+T8oRgj9Pgdz5s3VRpiOFbfr9T6scaAR9ahHxBtZA0VOA/YSotXAd/K7dXyUT7X4bTHtotmSWxZ2ATsNRs5qpyqFhzHP7WTIPq3tJeaKAHf4QtTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJLwpsTVnamdBcvWM3pinX7B3nkos738/piCt9lRNMc=;
 b=msblpOIW9d4SS3JGe+spzmO/ebCMAuFn7GsyYwfM1LpjdHgRP6QrIc68CJ4l8BS6K3Mlnu6vdnCFrHAZwLMEjMLtFgguCv+OSqb9av+whTA56VbB+TTyDYQ4jo4dl9acq+tr9ywZNMxnkHxFbvqRU3FTHHQcXYyY8ibBVPYr6AE=
Received: from OSBPR01MB4582.jpnprd01.prod.outlook.com (2603:1096:604:74::21)
 by OSAPR01MB2356.jpnprd01.prod.outlook.com (2603:1096:604:4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 01:06:30 +0000
Received: from OSBPR01MB4582.jpnprd01.prod.outlook.com
 ([fe80::d8f2:88cb:21f7:f426]) by OSBPR01MB4582.jpnprd01.prod.outlook.com
 ([fe80::d8f2:88cb:21f7:f426%3]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 01:06:30 +0000
From: "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
To: 'Stefan Hajnoczi' <stefanha@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH v2 3/3] virtiofsd: probe unshare(CLONE_FS) and print an
 error
Thread-Topic: [PATCH v2 3/3] virtiofsd: probe unshare(CLONE_FS) and print an
 error
Thread-Index: AQHWZEivmvW03GFCrkeQVmLj4OJ+oKkcK5UA
Date: Tue, 28 Jul 2020 01:05:10 +0000
Deferred-Delivery: Tue, 28 Jul 2020 01:06:10 +0000
Message-ID: <OSBPR01MB45826073E5A54CF869E56721E5730@OSBPR01MB4582.jpnprd01.prod.outlook.com>
References: <20200727190223.422280-1-stefanha@redhat.com>
 <20200727190223.422280-4-stefanha@redhat.com>
In-Reply-To: <20200727190223.422280-4-stefanha@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckermailid: 54bd764f6b734f24b691a183ef9bbd28
x-securitypolicycheck: OK by SHieldMailChecker v2.6.3
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [118.155.224.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4bf4e8c7-3b4e-4566-6589-08d83292760e
x-ms-traffictypediagnostic: OSAPR01MB2356:
x-microsoft-antispam-prvs: <OSAPR01MB2356CA84ED9D499E9D4297A4E5730@OSAPR01MB2356.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: THC30Mt2S7RcDoXmRRURNWK/XMlFgWFJjym8PM/7kNTUKKZ+M5cJDWXiUMOwReb7bzI8KhW0hGmxmj4Gr9uUYAPv9Xw05Qm7yQ4r/H9gSXY6tqGMPoZ/40v7tT8QG+F7Ysp8hhtSxOfgqSFtwPbMHxDoYoSxI3iv0X/00k0GrlnbaIg1Vt+5Be3fUi4FL6zKN3A/PZWIVik+nW6B39CsQrirO/zaWpKXctHZfkGy0w6UU9wpUmFRV+WTuEF9xgUIfx8sgd5EAHnpbq+zJcPcEcbqJk6qlxDunkeUfpJY6xD/Av+LJNrytPkMjMa+TymatXxId1BgMuC5ci3yih2ZM0Gqi7Fv468QpDYOKUyzwoulJv6dahfaEh9K3YeSO6Ic9h7Gb50TOfzHb1Pqwm4PdG2STG/fOKr1FEShSR65TWskxQNLPdszqrO5UNphJSOi
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSBPR01MB4582.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(86362001)(8936002)(7696005)(83380400001)(110136005)(85182001)(54906003)(55016002)(8676002)(33656002)(6666004)(26005)(83080400001)(66446008)(64756008)(66946007)(66476007)(76116006)(4326008)(2906002)(478600001)(186003)(966005)(52536014)(316002)(6506007)(5660300002)(71200400001)(66556008)(9686003)(777600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 8yaYL8sJd8+KabkaFYLaXYXTB64NYh5SLLezwFQAhpVsNmmhr+o9WEUZJMZ3jes7zPKsrLHD6OQevYfDTCs7jLJtRD8yQFesH2+EhvO9Yc6qXC7RHFopFE0wK0iCmxSGmH9SsFsy7t7/SKLYwGiXdl/K1Ia9MfpEBmy30amF3PVPth+UvPUOHh7H+Ju4NYA5rPr2Pnf+a9V7txDP3MZ5GdtszxdtihXALr8Qi+ABUzQMyFlhRNEbKrFZw99ZvpeNwG19aosGt8Q1QLvaxlVfnZkJcotpYA/RAmVOYfSOPZ4nxTxMK7CsR8VlY3fG1M4xelmXAifj6A9XcAefbo05AULlgXjhh+A++pCHD/WXtIQ5nVTG6ob2xK7+65ryNm7Sf1ZqVjpofNsy/G+dJGoJip/EONwTwdl0V0WuyMreCAO7aHAgq1aArzm2z1/B9M0lSYbbESDA0O1ZuX1oUPuIM9toxnoF1hzMVWw4MstNxR6kZHC9KMPBkurncAxDXNoQ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4582.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf4e8c7-3b4e-4566-6589-08d83292760e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 01:06:29.9474 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mAhti4sCSApZDPciksL/mcip9a+ZkzgjAfdY4INycFBhQOdOYPazD/iPFgxFOzzzCuW3PlgTuKDtmEZblLPzxtfmUuYomJjmI7bBIoFfeag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2356
Received-SPF: pass client-ip=68.232.159.88;
 envelope-from=misono.tomohiro@fujitsu.com; helo=esa8.fujitsucc.c3s2.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 21:06:35
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
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
Cc: "vromanso@redhat.com" <vromanso@redhat.com>,
 Daniel Walsh <dwalsh@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "rmohr@redhat.com" <rmohr@redhat.com>,
 "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
 "mpatel@redhat.com" <mpatel@redhat.com>,
 "vgoyal@redhat.com" <vgoyal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> Subject: [PATCH v2 3/3] virtiofsd: probe unshare(CLONE_FS) and print an e=
rror
>=20
> An assertion failure is raised during request processing if
> unshare(CLONE_FS) fails. Implement a probe at startup so the problem can
> be detected right away.
>=20
> Unfortunately Docker/Moby does not include unshare in the seccomp.json
> list unless CAP_SYS_ADMIN is given. Other seccomp.json lists always
> include unshare (e.g. podman is unaffected):
> https://raw.githubusercontent.com/seccomp/containers-golang/master/seccom=
p.json
>=20
> Use "docker run --security-opt seccomp=3Dpath/to/seccomp.json ..." if the
> default seccomp.json is missing unshare.

Hi, sorry for a bit late.

unshare() was added to fix xattr problem:=20
  https://github.com/qemu/qemu/commit/bdfd66788349acc43cd3f1298718ad491663c=
fcc#
In theory we don't need to call unshare if xattr is disabled, but it is har=
d to get to know
if xattr is enabled or disabled in fv_queue_worker(), right?

So, it looks good to me.
Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>

Regards,
Misono

>=20
> Cc: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tools/virtiofsd/fuse_virtio.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.=
c
> index 3b6d16a041..9e5537506c 100644
> --- a/tools/virtiofsd/fuse_virtio.c
> +++ b/tools/virtiofsd/fuse_virtio.c
> @@ -949,6 +949,22 @@ int virtio_session_mount(struct fuse_session *se)
>  {
>      int ret;
>=20
> +    /*
> +     * Test that unshare(CLONE_FS) works. fv_queue_worker() will need it=
. It's
> +     * an unprivileged system call but some Docker/Moby versions are kno=
wn to
> +     * reject it via seccomp when CAP_SYS_ADMIN is not given.
> +     *
> +     * Note that the program is single-threaded here so this syscall has=
 no
> +     * visible effect and is safe to make.
> +     */
> +    ret =3D unshare(CLONE_FS);
> +    if (ret =3D=3D -1 && errno =3D=3D EPERM) {
> +        fuse_log(FUSE_LOG_ERR, "unshare(CLONE_FS) failed with EPERM. If =
"
> +                "running in a container please check that the container =
"
> +                "runtime seccomp policy allows unshare.\n");
> +        return -1;
> +    }
> +
>      ret =3D fv_create_listen_socket(se);
>      if (ret < 0) {
>          return ret;
> --
> 2.26.2


