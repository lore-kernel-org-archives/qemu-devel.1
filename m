Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB09C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:58:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34C742075F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="bptGfYgf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34C742075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAaOk-00031d-Gn
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 10:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron@os.amperecomputing.com>)
 id 1kAaNz-00028f-0y
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:57:19 -0400
Received: from mail-eopbgr750103.outbound.protection.outlook.com
 ([40.107.75.103]:21762 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron@os.amperecomputing.com>)
 id 1kAaNu-0001Zv-37
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:57:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHZa8JyDf5QpVD7+rInQG94BUlL+/mXvmObxHa357TD4b/eHaRGSoHYcxH3cMznocUKjIkvRzdBifapEdC5oZODUVjr911X5eQPi74j9gXbJ2efS+DSwOWPDqNYUcT3Wlk8g57YgojPJQ0aVsd200nNYS9ZXBYKIL+BehK5sCPryIGS+DnS0iL7M4zwR8e4NpV6HtChg+lRCauCFLYBmG8tXuv7IjfwhH7ui9NYqkUR4d18QNDN1CnXbo72ixxquDrFa8ihUYY6+aqVmEi5Vcf9/tPrEsyWeuovMgwoEMYV7X46grfiG4BHuI4ech6OIFHn8MkYa3ccaZoNySOaM+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYxU3ckPGD5Q9UxF9NkyYzNMdOXSqfWdPIalCIsD6mI=;
 b=PvnZl8scixXV2fVNHVlSzeuemr50Oijx48aSvKFRuSSoz2uxn7A0bd+SzZSwgorZxgF4Fxa8kWg8NHIRM4El2vd3VSx8IamheTl1OXD4OfAhjc/IYyyrSwwmhnFz5Rt+9BHlxOEUM0/MziOf+imcVfhEPihGPW0I2/rgDu4vGZVUficjqX3QM9c/V+TJEW6KcDEjTOe0coAC2aq2Uf0+Fnigp5rHrDN3xBHys0kqxtsvC0KL/wTeyhWTZk01eUwaPrfdtlIL5teWcsgPkceLBdBejIQCJYc9cw8ftmmIDe/CBUO6lrKdNjEn+RO46PulqHhhFWxCJFvOcLY74Xa77A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYxU3ckPGD5Q9UxF9NkyYzNMdOXSqfWdPIalCIsD6mI=;
 b=bptGfYgfWBATq7U+0Z+JwdrEsXD8QVTS35ZJNe3crNhddoqKYeGT86J2xvGOkpP7vqpFOyLkGdkP0QbLxQgWxyPAjDe2GRqpFgFc7XHRFwCUWC9E6bGTTEx5NfzS0zDzOswp4osZ/1y9D28u801mIss5BXVPzzJu7wjl7GJtHWU=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from SN6PR01MB4304.prod.exchangelabs.com (2603:10b6:805:a6::23) by
 SN6PR01MB3790.prod.exchangelabs.com (2603:10b6:805:26::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.26; Tue, 25 Aug 2020 14:42:08 +0000
Received: from SN6PR01MB4304.prod.exchangelabs.com
 ([fe80::447c:afdb:2702:e275]) by SN6PR01MB4304.prod.exchangelabs.com
 ([fe80::447c:afdb:2702:e275%5]) with mapi id 15.20.3305.032; Tue, 25 Aug 2020
 14:42:08 +0000
Date: Tue, 25 Aug 2020 10:41:06 -0400
From: Aaron Lindsay <aaron@os.amperecomputing.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: [PULL 39/49] target/arm: Filter cycle counter based on
 PMCCFILTR_EL0
Message-ID: <20200825144106.GI2714117@strawberry.localdomain>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
 <20190118145805.6852-40-peter.maydell@linaro.org>
 <CAFEAcA9jUpJF4FQirb3avWJAMjh+AdkimW3DgMyMjbDjBCQSvQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9jUpJF4FQirb3avWJAMjh+AdkimW3DgMyMjbDjBCQSvQ@mail.gmail.com>
X-ClientProxiedBy: MN2PR08CA0021.namprd08.prod.outlook.com
 (2603:10b6:208:239::26) To SN6PR01MB4304.prod.exchangelabs.com
 (2603:10b6:805:a6::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 MN2PR08CA0021.namprd08.prod.outlook.com (2603:10b6:208:239::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend
 Transport; Tue, 25 Aug 2020 14:42:08 +0000
X-Originating-IP: [68.73.113.219]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd5f3865-9658-43c6-b27c-08d849050b35
X-MS-TrafficTypeDiagnostic: SN6PR01MB3790:
X-Microsoft-Antispam-PRVS: <SN6PR01MB379033474F4F8CAE5CF88FF58A570@SN6PR01MB3790.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vmCFDiV6GOMggZ8tsYsaCOws3qL2sNHQAGSkc6ZV+wsfWyoVbXdELjxXjI1vTvEpFhy+UkcvKvPmWKe1SgKPhaER53t5HPPR6pYWSbkjqgd0QSlw8d+pKSwdqEZHaKSqxYpPbl++1KE4TW+tz2yx49evG7fl30aVOJWWqDge71Y4U1luJsn4v8aKn9c9XoTGbUIYZP2n3BOXHTIwu2kzLbf+JvUw0AHttJWUEdx08bgyaIG/DXvYjantTGJwrjl3lABD18/3pNpHJ5SCRKpe3kSPNDvMjbN/Ei8RuSdtWEJoAFglrGEX+yEMqyFkJRjiBQQwiYD6jIq4wIGMDYtB9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR01MB4304.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(39840400004)(366004)(396003)(186003)(6916009)(66556008)(66476007)(86362001)(6486002)(4326008)(83380400001)(26005)(33656002)(52116002)(66946007)(956004)(16576012)(19627235002)(8936002)(9686003)(1076003)(2906002)(478600001)(316002)(5660300002)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: PhyT5YM3RUCuO9SYMt0X+JKERojAcWMevHt77Wkfd/x0uAYCDDQ/ytXDAOqsabi69UuYcT9UxPZfS8OpTpRwavT4ohEkQGaIgy728yywHp+qv1nBP5RitMpXQB/MFO7wjjxZp///WSLcop174C1y9WR4YvfywSp9r0kArHilYNuG1zFEdWQH4I480wUWf0v0/NVoKfQkaxWmzC4gSvXl41wTdIAb9kRmwcOoHRa3omPxJMGDA2u9IsJhZ8Qi5zqSuAX7ciB5v9nb9di80YlO4XgeTQZk5HQ9VMXxeYJyEfUk9FjyNvUzL3rZ8DsVZI0nL8aSmlVUB/HZiMEwSD0X6eiMT7FM+udXz3tPyJ/BL6jTb9HSLKZIn0WulykL8Jqq6shD7PDoDywCv67O9nZbPhxB+nbcnBoQbOaRXk/TE9m3nLQZgX3N3dmK53tdrW2dg3OXCR4pkoko4I6NCtpNTIR2y9MndmvL81ShkXT9X/biCLR1Mf272ueYiBlujRj4ddxqT4NFxV6YgqCurSdtRQ/53PFWPx6h/h9YObC1VrwtZdHedxRCn2b0z17x5gli5aX4LcLQf7JZ/ArfDheZkxXwj41Xas6yENEgyXv+iOlUzlJqfU/Q+P1sWAg0ju3Up4SCh8Bddni2QFZl0SEnKg==
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5f3865-9658-43c6-b27c-08d849050b35
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4304.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 14:42:08.6476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LPSqxOI7wxITrrrbJ6n/hrN64OVdIcgWJUCh7Y1SRo1PVapL6IBgETBOy83UcfyNlpayjqTkpyp50JhtqaODAgA4kW4/+FGSG/hSjxFOZds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB3790
Received-SPF: pass client-ip=40.107.75.103;
 envelope-from=aaron@os.amperecomputing.com;
 helo=NAM02-BL2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 10:57:12
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_ILLEGAL_IP=1.3, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Aug 24 17:33, Peter Maydell wrote:
> On Fri, 18 Jan 2019 at 14:58, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > From: Aaron Lindsay <aaron@os.amperecomputing.com>
> >
> > Rename arm_ccnt_enabled to pmu_counter_enabled, and add logic to only
> > return 'true' if the specified counter is enabled and neither prohibited
> > or filtered.
> >
> > Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> > Signed-off-by: Aaron Lindsay <aclindsa@gmail.com>
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Message-id: 20181211151945.29137-5-aaron@os.amperecomputing.com
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> 
> Hi Aaron; I've just had somebody report what seems like a bug
> in this code from last year:
> 
> > +/* Returns true if the counter (pass 31 for PMCCNTR) should count events using
> > + * the current EL, security state, and register configuration.
> > + */
> > +static bool pmu_counter_enabled(CPUARMState *env, uint8_t counter)
> >  {
> > -    /* This does not support checking PMCCFILTR_EL0 register */
> > +    uint64_t filter;
> > +    bool e, p, u, nsk, nsu, nsh, m;
> > +    bool enabled, prohibited, filtered;
> > +    bool secure = arm_is_secure(env);
> > +    int el = arm_current_el(env);
> > +    uint8_t hpmn = env->cp15.mdcr_el2 & MDCR_HPMN;
> >
> > -    if (!(env->cp15.c9_pmcr & PMCRE) || !(env->cp15.c9_pmcnten & (1 << 31))) {
> > -        return false;
> > +    if (!arm_feature(env, ARM_FEATURE_EL2) ||
> > +            (counter < hpmn || counter == 31)) {
> > +        e = env->cp15.c9_pmcr & PMCRE;
> > +    } else {
> > +        e = env->cp15.mdcr_el2 & MDCR_HPME;
> > +    }
> > +    enabled = e && (env->cp15.c9_pmcnten & (1 << counter));
> > +
> > +    if (!secure) {
> > +        if (el == 2 && (counter < hpmn || counter == 31)) {
> > +            prohibited = env->cp15.mdcr_el2 & MDCR_HPMD;
> > +        } else {
> > +            prohibited = false;
> > +        }
> > +    } else {
> > +        prohibited = arm_feature(env, ARM_FEATURE_EL3) &&
> > +           (env->cp15.mdcr_el3 & MDCR_SPME);
> 
> The Arm ARM says that MDCR.SPME is 0 to prohibit secure-state
> event counting, and 1 to enable it.  So shouldn't this test
> be "!(env->cp15.mdcr_el3 & MDCR_SPME)" ?
> 
> (compare also the AArch32.CountEvents pseudocode, which has
> a test "HaveEL3(EL3) && ISSecure() && spme == '0' &&...")

I agree my original patch was incorrect. My guess is that I overlooked
the trailing D changing to an E and got caught assuming MDCR_HPMD and
MDCR_SPME both prohibited counting when set. Sending a fix separately.

-Aaron

