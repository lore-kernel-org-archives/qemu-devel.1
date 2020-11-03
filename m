Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5FDC00A89
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:18:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7227E22243
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WjJMgUyk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7227E22243
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZlu7-0000yC-3w
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 21:18:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZlnT-0004rQ-Ei
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:11:44 -0500
Received: from mail-eopbgr680059.outbound.protection.outlook.com
 ([40.107.68.59]:28077 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZlnQ-00045K-U2
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:11:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYeAYBDXzI2oXnBFcHuT4OZWhY2Kd+SO3gDRaUSyEwrj1kXoHpc9cPO7xl2cH76mabVc+qigiUJtsp052FxwIQNxq8k1blwtrUWWdM3O+YLUZg4kBrVm11SaIvArMHQH1PWFPJGWQ68YcpSWTUe3m55oB5QTyLB63b7Ri5lKd8J7c6ki+CiY3dMYe9xImBiUIUTsHq5UJl5AlvjojS43tNyoau/E5dxpdVHEWipG14I0erpl5G3HOriLbBKX6dV4WsV1zUJrPYuqyYSJL9LQy2U+jQrEdix+xwaCqYp/ppvuaJw3fbp5LUwXoHCz6P+kdgAHfYC9XpOB+UwY42THvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAGscG1fxHpMulpQfdS4xhNdYwc0+uo5Z21iWQWlwF4=;
 b=DLUUrRUdEnWXNGNjkfZjGukEeSldX17U5sf5WKlpxVprlP5CiO6L7cIQqaQRJI7wN6dBn0b9pmMfvE2aGbr1OlP9eya0qMW0teIQSHqPkue4Msbi7fpvtBtBGpvS7HfmT/0A70BV65W1T1yii7QzCpbJ+9d918QhSgPje010xlIte3GTzJLLCbaPQnsObugJA+25j3PsEYW0YS/iFcSSN+FUdXG2by8w+azfSoI6Nka65qfDON4MGYzubbEbRvp0jH8jGp4+wNuwwAmqlUw95LZLySGX/FGy6YhYSlIP79NzQIbfSeohdaWh5M1nENdAOUL6J+cPT4I4daD3YQ9FKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAGscG1fxHpMulpQfdS4xhNdYwc0+uo5Z21iWQWlwF4=;
 b=WjJMgUykcGx+AZqg2E4V49k/mut5IzyV4Who4DVzY5unVxjfF19QGxs60/ZFWIbiBReiokBe+WVyE1u45fV8ldf/yePZZnxEISAbzRQwf7VQxJL1Pz6dMcio3UsnvZ5fIFEF/tdoZX1sJInIlqJgdobpsfklrimpPYhwwc1bUs8=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB3670.namprd12.prod.outlook.com (2603:10b6:610:21::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Tue, 3 Nov
 2020 02:11:34 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 02:11:34 +0000
Date: Mon, 2 Nov 2020 20:11:22 -0600
From: Michael Roth <michael.roth@amd.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PULL 09/12] qga: add ssh-{add,remove}-authorized-keys
Message-ID: <20201103021122.thtfyhrnvpic22sr@vm0>
References: <20201027055317.351868-1-michael.roth@amd.com>
 <20201027055317.351868-10-michael.roth@amd.com>
 <878sbju5bs.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878sbju5bs.fsf@dusky.pond.sub.org>
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: DM6PR02CA0077.namprd02.prod.outlook.com
 (2603:10b6:5:1f4::18) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by
 DM6PR02CA0077.namprd02.prod.outlook.com (2603:10b6:5:1f4::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 3 Nov 2020 02:11:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9a3eb751-f400-437f-1ef3-08d87f9dc97c
X-MS-TrafficTypeDiagnostic: CH2PR12MB3670:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3670E8B8904EAD572334FE7195110@CH2PR12MB3670.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vP/kx2z95MZWjYODQGQgBwX3XHCcEKz642BZUkJw0AwpzNZl0HHpA9lOgR7rd6zhithEooAlFypeaBLY2kOubDmy1JMNIv6u0FcWkS2zdPgs+lngIdR4RrboUTReVFlzs424q+t0smEXMvoQSYh7xWhhwK7HY1nfctBiiCwVgfxQnHCbD6WghLL7lhA07VEUID46Pu6rskgcONa5b4TNLalw6Dg7Go6VaI+u/pAtN6RKahA0vEJgr6+sEH9gVqtYSJLrelxmHOBIrpcwpg/z5EYmNea4z5hS2kafe+yTtavmJ0yzQobvBU/c92wdiPWcuo/uxaMsecXtGi88twN35C6JGBZek7eDlugXdn+TqrHy6Wym//wwHWIAUqrOrFVbZ5asMUvBMMyRR1pm7YA+4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(7916004)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(52116002)(8676002)(45080400002)(83380400001)(44832011)(8936002)(4326008)(54906003)(26005)(33716001)(86362001)(186003)(956004)(6486002)(478600001)(966005)(2906002)(6496006)(16526019)(6916009)(66556008)(6666004)(5660300002)(316002)(9686003)(1076003)(66946007)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: vBzdeyDdNEQP7rpAJl4grmEjFPKoJSowuwkJA1cncC82Z9qbBi6DxpLQ7dzelYZ0T+z2cM/xQOydPjHgEZIIUtQxbL9Z4kYGJQV4iM7oPv6JSjwCWLyk8LHGD5xeqPbT0SdmW01mzV19aTiJgcqmsQsDBvbgCxS688Z0Ab5+RW9q7LNWtJ8hrmDi2qqbPit89ugk36Pox9emLfX4Tp6iyEQnmdcpa5/a6I2+mjar2WvELGpQuSMCARQZvKledxzV6FM40aK1NvEABJhxKZ3ki6tk+WQDMv9y7++6gA7SrTLp0N1I6H4EHFgSQHtBDVpy/FpXRQp82+iBA3sDaCZxebCed3Io3YwmMk7kL+zDCHkNDKTP1ekfBPykxlwgOubIYudqqx+ewyc7kbon4GdcBXEjP8E+7ZXRarcGUMXnD7l1MHG6sSVQpWd48HB3ba5iTiFJ7KeDKionkSAO1ZlA+fhEqEM2BKOsYFJb6pLGxKwicAxAQfWe4AYvZlraxdJYHOdO+lERLOINmd1TXzU/Kfh21oQ2fKbrz9ECSYIdS8kHxt4Zx4fGcY708FwpbRAV2c7/SuXZZlVdySs876z6KoOjrXLVbGuiU1SxCKBK6e80G4hYLl8/49OpqjhUI1zaZC1OPhGH5FXCjpu64qmjuA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3eb751-f400-437f-1ef3-08d87f9dc97c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 02:11:34.3686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4qQH7gLZIGOCqHCgNMnXrA+K76ijP0SUxNZgqsB8eI3qU44udcALiQmA+s2KrGUJjnkL/Z1hH017I4QrUAOdEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3670
Received-SPF: none client-ip=40.107.68.59; envelope-from=Michael.Roth@amd.com;
 helo=NAM04-BN3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 21:11:37
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Cc: Michal Privoznik <mprivozn@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 02, 2020 at 04:49:27PM +0100, Markus Armbruster wrote:
> Michael Roth <michael.roth@amd.com> writes:
> 
> > From: Marc-André Lureau <marcandre.lureau@redhat.com>
> >
> > Add new commands to add and remove SSH public keys from
> > ~/.ssh/authorized_keys.
> >
> > I took a different approach for testing, including the unit tests right
> > with the code. I wanted to overwrite the function to get the user
> > details, I couldn't easily do that over QMP. Furthermore, I prefer
> > having unit tests very close to the code, and unit files that are domain
> > specific (commands-posix is too crowded already). FWIW, that
> > coding/testing style is Rust-style (where tests can or should even be
> > part of the documentation!).
> >
> > Fixes:
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.redhat.com%2Fshow_bug.cgi%3Fid%3D1885332&amp;data=04%7C01%7Cmichael.roth%40amd.com%7C7302cfdd51b547a8c3de08d87f46e6cf%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637399289788005891%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=IcYz5b1yBg3Q%2BPg82Z5VMdpf60vYHsLL518ENd0T1A4%3D&amp;reserved=0
> >
> > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > *squashed in fix-ups for setting file ownership and use of QAPI
> >  conditionals for CONFIG_POSIX instead of stub definitions
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > ---
> >  qga/commands-posix-ssh.c | 407 +++++++++++++++++++++++++++++++++++++++
> >  qga/meson.build          |  20 +-
> >  qga/qapi-schema.json     |  35 ++++
> >  3 files changed, 461 insertions(+), 1 deletion(-)
> >  create mode 100644 qga/commands-posix-ssh.c
> >
> > diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
> > new file mode 100644
> > index 0000000000..a7bc9a1c24
> > --- /dev/null
> > +++ b/qga/commands-posix-ssh.c
> > @@ -0,0 +1,407 @@
> > + /*
> > +  * This work is licensed under the terms of the GNU GPL, version 2 or later.
> > +  * See the COPYING file in the top-level directory.
> > +  */
> > +#include "qemu/osdep.h"
> > +
> > +#include <glib-unix.h>
> > +#include <glib/gstdio.h>
> > +#include <locale.h>
> > +#include <pwd.h>
> > +
> > +#include "qapi/error.h"
> > +#include "qga-qapi-commands.h"
> > +
> > +#ifdef QGA_BUILD_UNIT_TEST
> > +static struct passwd *
> > +test_get_passwd_entry(const gchar *user_name, GError **error)
> > +{
> > +    struct passwd *p;
> > +    int ret;
> > +
> > +    if (!user_name || g_strcmp0(user_name, g_get_user_name())) {
> > +        g_set_error(error, G_UNIX_ERROR, 0, "Invalid user name");
> > +        return NULL;
> > +    }
> > +
> > +    p = g_new0(struct passwd, 1);
> > +    p->pw_dir = (char *)g_get_home_dir();
> > +    p->pw_uid = geteuid();
> > +    p->pw_gid = getegid();
> > +
> > +    ret = g_mkdir_with_parents(p->pw_dir, 0700);
> > +    g_assert_cmpint(ret, ==, 0);
> 
> checkpatch ERROR: Use g_assert or g_assert_not_reached
> 
> See commit 6e9389563e "checkpatch: Disallow glib asserts in main code"
> for rationale.

Thanks for the pointer, I couldn't figure out what the issue was and
assumed it was just noise. Wish I noticed this message before I sent out
v2... v3 incoming.

> 
> More below, and in PATCH 10+12.


> 
> [...]
> 

