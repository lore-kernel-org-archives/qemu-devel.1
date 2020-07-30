Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEDBC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 12:52:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 982E42082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 12:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Zcgv6dRe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 982E42082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k183O-0003Sr-SN
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 08:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brogers@suse.com>) id 1k182R-0002yQ-TQ
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 08:51:59 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:32037)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <brogers@suse.com>) id 1k182P-0000vo-AN
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 08:51:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1596113515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fGpPqijvj0JbPmxTG56lUnFg4bbMb+vtEoGdwBHJ4kY=;
 b=Zcgv6dRewCR5mJhjf8pqEIHX+Ox+eQmkv4goGRojNqIK462J283I/2iQFk97ai/MZqG9Oz
 uNmpTTjfdq2C2S0zAklbJpctln19f1aXhEVwxYmM1vyMt+C2HcTJFFLlWIVewh+f6QN2sY
 FIivXRytsW9h308QLVBrqo1gzALyU0o=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2107.outbound.protection.outlook.com [104.47.18.107])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-25-HS9bYTunNgKZu3Fjt8QwxA-1; Thu, 30 Jul 2020 14:51:53 +0200
X-MC-Unique: HS9bYTunNgKZu3Fjt8QwxA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UROvBLGwO7nuPAqnfhM4U6UEXcPbUu1ip9KxF9XAUBvcy7d7Zn07GwqF7JRRh7xrcqEY6tp7kM2cjZaS3wvtXvHv7pf09U6MiXECUSb8vauMVo0gC3GMSLs3Lwk7Cfl27rN1heGcvJo6ty+S+4vahDMFKO+VQcRp7oB6CR8v8w2SG9/9iTMD8dUIpODW9LW6Qjn2rAFxOyWXPJ4g6E6MCKuiRh4jLgrnObyW+sZDZfQpzqBu/fhTK7F7yYM9YnKOhIDsCGtt+Bk2hJQc3R1k3D1GS8S05yvDHh71KEDx8AptUEw+oW0uDcdWkXEUqvLyK6OxdY1hk33Jq95C4+wVrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGpPqijvj0JbPmxTG56lUnFg4bbMb+vtEoGdwBHJ4kY=;
 b=lpqx5jbb04XWbcZVBaxdzSNAj3h2RnwJSWKvNjW7cZuHuooVILUBzIt0XzWt5UYXXmduKi9M34g9kaIqxapWlsBbwOeGUxiRCSA9DYlUgdyaD1sS3f+RODx4SD4FYn/Nlp2VkuTYg7J+CTqmeaJTfM2l4JMSkKdAH207tD77xtlNHpidA9yOSbOQEovzk1LXsBMu5M5pQJUbCkJt5miyD3IapUjm7RYrfd9j9PEQJRpJIAdfApDMVSdUYmuc+wzwwhgLCJDAsvFozll0Dw+jlYPW6921fOowSZZ63abP3gnTB+QnFdpQghWICrWvBjS6qq48SmRexcJshulVBxt9cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=suse.com;
Received: from AM4PR0401MB2354.eurprd04.prod.outlook.com
 (2603:10a6:200:54::21) by AM0PR04MB5636.eurprd04.prod.outlook.com
 (2603:10a6:208:130::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.19; Thu, 30 Jul
 2020 12:51:53 +0000
Received: from AM4PR0401MB2354.eurprd04.prod.outlook.com
 ([fe80::ac1e:4b9f:464c:d660]) by AM4PR0401MB2354.eurprd04.prod.outlook.com
 ([fe80::ac1e:4b9f:464c:d660%12]) with mapi id 15.20.3239.019; Thu, 30 Jul
 2020 12:51:53 +0000
Message-ID: <1b00c0e25ec65e113d4c7fa98b1466689f05a986.camel@suse.com>
Subject: Re: [PATCH] virtio-mem: Work around format specifier mismatch for
 RISC-V
From: Bruce Rogers <brogers@suse.com>
To: David Hildenbrand <david@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>
Date: Thu, 30 Jul 2020 06:51:46 -0600
In-Reply-To: <afd9a33f-8bfe-e4e5-64fe-c41da91d9d54@redhat.com>
References: <20200730005438.138369-1-brogers@suse.com>
 <20200730074926.dbxnhdxwvwugksnd@steredhat.lan>
 <8e1c42c8-9af9-5b86-d74f-eaa95392bd48@redhat.com>
 <20200730075856.uzptjg3o6nhhkrs3@steredhat.lan>
 <afd9a33f-8bfe-e4e5-64fe-c41da91d9d54@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0094.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::35) To AM4PR0401MB2354.eurprd04.prod.outlook.com
 (2603:10a6:200:54::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.4] (63.248.145.198) by
 AM0PR06CA0094.eurprd06.prod.outlook.com (2603:10a6:208:fa::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.18 via Frontend Transport; Thu, 30 Jul 2020 12:51:52 +0000
X-Originating-IP: [63.248.145.198]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef52e246-e77c-4ca5-2fb9-08d834875541
X-MS-TrafficTypeDiagnostic: AM0PR04MB5636:
X-Microsoft-Antispam-PRVS: <AM0PR04MB56365C26A29B58152FAF674FD9710@AM0PR04MB5636.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HWrMzFUM8357H5jL+o7Hjhu7CzPIYMugFUBL7O268eL9g4UudA+AyrfaUVAKYpyBkixT/70uANhnO8vFzwCg+srx0vfXgK8EQKf8iBYe1zBqqfbui3QZ2MvCQ8jX/hM1BRStSzWuu3v+7PkO/dIXHxYaPzkK7o14mSwsXNPXSus5z+BjVueEPys3fpyrGDhOBxC76yDIyUZH6YdoCa6//xRW48jRU9x9vp82KQeARyzXodcpTEhPIl0J1HfJ6zBzzxkOlZHpGQeXDEdZ80WpaAhDoXDFZh1crFpbUDmEP/awQ5hdwpGsTQJxPyjzouj5yrOWL/ZKjCqIbIJdfLTRXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR0401MB2354.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(376002)(366004)(396003)(39860400002)(136003)(956004)(4326008)(83380400001)(2616005)(478600001)(2906002)(66476007)(66946007)(66556008)(52116002)(86362001)(36756003)(53546011)(5660300002)(8936002)(110136005)(6666004)(186003)(16526019)(6486002)(8676002)(316002)(16576012)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: y12pzMQ+Cm99Jsl9o7yVl+I6z4cVT7pi+7MSfZhJIbKSpIA6w1+VaKgqGRPPK4FN/JxA2uWPfZHIMwDRY9E97X6Jf5ucxs93IbWOdZhlMJOP7Z42Y3jK233HZVqaNCZduo9Eufhs5uQxWM96lrwFjP/g9PD8cnIF+CFz7unwWtUsTVVn7gr2o+lYwnmYWezsbPg914SpqcQle9pNpu/IJ4OiD19KFLhwb1pKlmq6kpNEJkO2TDNwq1YqneZL1x/J/TpY68crOZ9ultc2m7AazGENwvtQ6pwZRcYrqVufbvzqw8NxPe80mjbG1T6RHa2hqwawDLkchge/HAUVE6zVCxMkpI8oGKX5LtOyB1pwxtmR0dlcZuxuWvX5kUNNE9BUOMbSgQF1VUniwP+SW6gn8M1dfAwrvLJcP1DkYiZ4KN8Wrpa8GDJwjAQmoL4cZrLnYi7pP4Dc7X88ilSfC4hAeiDv7ynYu4NKC+9UQ2QyL6Bu4xvEFS0tYjZziaflQZBXI1JuA3sfNyufT2p0UoTfYv6gyr665ws+lMBtI2tdU8lhvtDxU+kRaZ2cu0oy0VQl5jRElz7g4s3cP+WKJLAQDjduTuX1ACaesXzRF+sVRjIa+uDEdbTokjRs97B/6NllxUsMeB4wPYZ8T9SZXD1pDQ==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef52e246-e77c-4ca5-2fb9-08d834875541
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2354.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 12:51:53.1818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xGSV0XAQuQKwTW34TrhJxBxRdeLV8u1MLkXpehNiLOKCB5waI3Ffrq+3wM55T7xt0cdvvcQBtyEAI/2GA1EAEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5636
Received-SPF: pass client-ip=51.163.158.102; envelope-from=brogers@suse.com;
 helo=de-smtp-delivery-102.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 08:51:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2020-07-30 at 10:12 +0200, David Hildenbrand wrote:
> On 30.07.20 09:58, Stefano Garzarella wrote:
> > On Thu, Jul 30, 2020 at 09:51:19AM +0200, David Hildenbrand wrote:
> > > On 30.07.20 09:49, Stefano Garzarella wrote:
> > > > On Wed, Jul 29, 2020 at 06:54:38PM -0600, Bruce Rogers wrote:
> > > > > This likely affects other, less popular host architectures as
> > > > > well.
> > > > > Less common host architectures under linux get
> > > > > QEMU_VMALLOC_ALIGN (from
> > > > > which VIRTIO_MEM_MIN_BLOCK_SIZE is derived) define to a
> > > > > variable of
> > > > > type uintptr, which isn't compatible with the format
> > > > > specifier used to
> > > > > print a user message. Since this particular usage of the
> > > > > underlying data
> > > > > seems unique, the simple fix is to just cast it to the
> > > > > corresponding
> > > > > format specifier.
> > > > > 
> > > > > Signed-off-by: Bruce Rogers <brogers@suse.com>
> > > > > ---
> > > > >  hw/virtio/virtio-mem.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> > > > > index c12e9f79b0..fd01ffd83e 100644
> > > > > --- a/hw/virtio/virtio-mem.c
> > > > > +++ b/hw/virtio/virtio-mem.c
> > > > > @@ -754,7 +754,7 @@ static void
> > > > > virtio_mem_set_block_size(Object *obj, Visitor *v, const char
> > > > > *name,
> > > > >  
> > > > >      if (value < VIRTIO_MEM_MIN_BLOCK_SIZE) {
> > > > >          error_setg(errp, "'%s' property has to be at least
> > > > > 0x%" PRIx32, name,
> > > > > -                   VIRTIO_MEM_MIN_BLOCK_SIZE);
> > > > > +                   (unsigned int)VIRTIO_MEM_MIN_BLOCK_SIZE);
> > > > 
> > > > Since we use PRIx32, could be better to cast
> > > > VIRTIO_MEM_MIN_BLOCK_SIZE
> > > > to uint32_t?
> > > 
> > > Yeah, I guess something like
> > > 
> > > -#define VIRTIO_MEM_MIN_BLOCK_SIZE QEMU_VMALLOC_ALIGN
> > > +#define VIRTIO_MEM_MIN_BLOCK_SIZE ((uint32_t)QEMU_VMALLOC_ALIGN)
> > > 
> > > would be cleaner
> > 
> > Yeah, it is cleaner.
> 
> Bruce, can you respin if you agree? Thanks!
> 
Agreed.

- Bruce


