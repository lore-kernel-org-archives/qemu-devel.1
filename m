Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B88BC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:05:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBC6B2084D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hfyNwIaM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC6B2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEASx-0002cg-2O
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 08:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brogers@suse.com>) id 1kEADs-0006jl-9d
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:49:40 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:60464)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <brogers@suse.com>) id 1kEADq-0006U2-9x
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1599220176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nYDh6gtcKN87xYJ19aNnPcbrOW8ngiM2ZH1YK1KbCxI=;
 b=hfyNwIaMC0ICsrdkN/ZCrtix7byd8N9rsbYYSxBCpeXNEEaPimm203Tw4o820QnbmO2AP4
 Ho36W0uZszMylxhA8h2vPANepm4gmb1rJOJlL59ocTsh/Tg3fojvPiMfKK/qFEhi8qIJfc
 JtX14mL25yMEYtGvxytgvwqcYhiP6ZQ=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2110.outbound.protection.outlook.com [104.47.18.110])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-12-UmfVwrRwNBeo_SG7Gt0mig-1; Fri, 04 Sep 2020 13:49:34 +0200
X-MC-Unique: UmfVwrRwNBeo_SG7Gt0mig-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjCNih88PcBYDlypx7uPR50c84VMcC/TzocJ07cwbuK9/Z8vGPuz9KsuCRXXoEUqHHus1IqmFicWu7XQrjh++93KQG5831JaxzhVQnJ6+ct8XxyIdv2VD4XC920xw0KONJbaYb/8iJ+k7V/EXZyeIO4zT3IiUH8Ww8TSkZBdtZsl89bakityUIBvvKcZWxu+Rn+2xbQ8t9dNSodPptTkwR4/dOWVlhKbmGzMei0t8xAgTBgRAXCHA6k774nsN/SGcwGrHLYUlvc0xXRcPU4tMEBH094/W7Kh+CSYaDaWvFVqZw/mC1Fef6kIyenmh6faniHZJI6UKXhFkYMTyImvkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYDh6gtcKN87xYJ19aNnPcbrOW8ngiM2ZH1YK1KbCxI=;
 b=fc07q3Gd9n5arf72ELfC+hLbfNtCHB/+v8L/ZiADFMSRyK6Dw2Tzuo7SY+ABW2mc9mlEGUh6Kw5yMk9p6t+6yGPYN4/XNT1oFQ0mVNkX2rZvTnHeYE9/RJmNL+shwzPRDPTfFLiFvjFZPYBpIxaMAnPACJ+/JvvvxNh2wtBslw4BhkILYH9PAN+n9c6bT2KKQk3bha4pG6If/f2RIZcu40dPieF5lDnMAKopghSU/yztIzLCxh0/ilM/weipSRqqpnzDgzOyn4V8HCcecrZHxBhYhi97XMtemtpXhY49cSKGI14mfLJtyj1A0aC4soaPoji9TkUJ7/Yi2gBJuuQGAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=suse.com;
Received: from AM4PR0401MB2354.eurprd04.prod.outlook.com
 (2603:10a6:200:54::21) by AM0PR04MB4387.eurprd04.prod.outlook.com
 (2603:10a6:208:73::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Fri, 4 Sep
 2020 11:49:33 +0000
Received: from AM4PR0401MB2354.eurprd04.prod.outlook.com
 ([fe80::9c57:5888:a06b:ec05]) by AM4PR0401MB2354.eurprd04.prod.outlook.com
 ([fe80::9c57:5888:a06b:ec05%10]) with mapi id 15.20.3326.025; Fri, 4 Sep 2020
 11:49:33 +0000
Message-ID: <5636584a23452c45d91f535e77374c37aaadcb48.camel@suse.com>
Subject: Re: [PATCH] meson: install ivshmem-client and ivshmem-server
From: Bruce Rogers <brogers@suse.com>
To: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 04 Sep 2020 05:49:28 -0600
In-Reply-To: <87lfhpaofy.fsf@dusky.pond.sub.org>
References: <20200903153524.98168-1-brogers@suse.com>
 <4eba2feb-a9b3-8bb7-6ed7-6b02c79519b1@redhat.com>
 <20200903154906.GA441291@redhat.com>
 <69f279ce-30e8-e83c-718b-021d3e6b264d@redhat.com>
 <87a6y6dmy4.fsf@dusky.pond.sub.org>
 <509826bc-9683-dd1d-fa6a-55fc3fddc57c@redhat.com>
 <87lfhpaofy.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0078.eurprd02.prod.outlook.com
 (2603:10a6:208:154::19) To AM4PR0401MB2354.eurprd04.prod.outlook.com
 (2603:10a6:200:54::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.5] (63.248.145.198) by
 AM0PR02CA0078.eurprd02.prod.outlook.com (2603:10a6:208:154::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Fri, 4 Sep 2020 11:49:31 +0000
X-Originating-IP: [63.248.145.198]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ba4e59d-1de3-4017-1292-08d850c896f9
X-MS-TrafficTypeDiagnostic: AM0PR04MB4387:
X-Microsoft-Antispam-PRVS: <AM0PR04MB4387B46ECD38DAE43BCA5113D92D0@AM0PR04MB4387.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fscZvrPRf5bab1B/CL1jGADJn4Gq1JUxe5rdzZab4dqPhbLFLxLSlU+/FOkx+fMFVPNn49bhI001u38Rs5OG30dvrBKMhnrIAfpJQGIBh3fJq1EeDAoa/W5cqW5KaI52eAHiYXJOtawhvTkqnHZQYRkdQaSdfurDLSfC+317c2uQ4zbR9dAHBWGUE0WtBd6Fcl3kyUQFzNRBWSq4iBXUolBqJ+xjjIg/usx+fAi2Vc7VoFwoF4T0RpFBfahXxiperIfV6K8roYsSJe4G5yD+ZVEXbVX8D0zoMjiGrrzi+WQvj5Zf6wW0JbyvjQN6BN6Cj09u2uHEx0gGB60zQyjEpqYzz++srn6zt1pkgddqkn97QkknVj9sjaA/hogEh4Erq/cjRqkD8UArSrf7inwwYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR0401MB2354.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(346002)(396003)(136003)(366004)(376002)(6486002)(8936002)(5660300002)(26005)(86362001)(186003)(2616005)(66946007)(4326008)(956004)(66556008)(53546011)(2906002)(16526019)(66476007)(52116002)(16576012)(316002)(478600001)(110136005)(8676002)(4744005)(6666004)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: JlzmrAqpz30DtCybrs+JSFRpod5i+BHn2OFkPZuv3QdKKGPb3fDPof0AauQWmfWBhjCjIeYhgLQoLaD1vKwo8bLfEzYXxoQC78ecHT8PI7+ohABg1rt6AF9HjECxNdMr37w5f+AQlFC5vJTxYWugO7lmsGkrKE8ONzI3ckTlw1o2T+NkkzUu6gJmyiOIMPLBFJPEXiNWErvAI4t+VI5GXc0mFeQyPC+kA+9Npp1HziirPAvunDtCxxFpINIlvg/FbiMLka+/qmB98rLDfH8ahZez1lc+lwdRdXKCuUZpe4k0asXzBTGmdF7IIK+GSD2/VeyreKNRYoT8MFFyy/aXBIHcKeNw4NyzwOTepo8k52zKkD/wa0HB94fBWQgMWFotTEqBZZ5FEI8vWXUKQJi78G3+da74Qc4DXYRAeB8ZR1puEWRqw9wsifpdv1iZyTBhi5sq5sCgQhJca8PS09VeCSOB4Jz2zHkqW+2/ijfAjP0tCZ6iVPR5dZ718JGkivXz24MLpit5Fpa3xWvCTC3cT2Cg6K5LqtrmJXSC4FBT931czAvQQ3sQnOj+2x2OZ8/raHut8oTkOJU79eaarj/FNrg9zUruFvMCV3qPZof5VZxjTznfRN0NQyzq0V5yNQWhs1m9lVWtBy0vK9M4OkYYbw==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba4e59d-1de3-4017-1292-08d850c896f9
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2354.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 11:49:33.1576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46bW9NvJKBqPJHBczppm1EGx1e4cxzsOuWvfrZjeLWiJZebDcR0eAHnMlRoIf4rfloeE7SLcDB+iigDvyLjFMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4387
Received-SPF: pass client-ip=62.140.7.102; envelope-from=brogers@suse.com;
 helo=de-smtp-delivery-102.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 07:49:36
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
Cc: marcandre.lureau@redhat.com,
 Daniel =?ISO-8859-1?Q?P=2EBerrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2020-09-04 at 11:20 +0200, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
> > On 04/09/20 09:24, Markus Armbruster wrote:
> > > > Ah, via the tools variable in configure.  Nice maze.  I've
> > > > queued the patch.
> > > Please don't.
> > > 
> > > These programs are examples to help people understand how the
> > > ivhsmem
> > > device works.  They might even be useful for debugging.  They are
> > > *not*
> > > to be used in production.
> > 
> > Oooookay. :)  It needs to be documented in the changelog.
> 
> I'll take care of updating <https://wiki.qemu.org/ChangeLog/5.2>;.
> 

Thanks all for the clarification on this one. It was packaged up simply
because it got installed, and I never got to looking at the use case
for these binaries.

I'll remove them from what we package in SUSE's SLE and openSUSE.

- Bruce


