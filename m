Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9C2C4363A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 10:40:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CE612226B
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 10:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="WlcCUasK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE612226B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWGyP-000352-1d
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 06:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kWGxa-0002da-Fh
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 06:39:42 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:58055)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kWGxY-0007Ao-Db
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 06:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=hbN7uEJ8PB+OG4EQ/Sd4/l56YdDcfJcuDUfZ/mIbC9o=; b=WlcCUasKTNBxi0MLxSB18nxtzu
 aJC2pOhEilts+4X3UqlxdwOBmbatwS/hP/loDLPhO+NW/Qd4W2xcYHQN5fuQ7UyNH1SB/fWey3Mfg
 6RRHosZMkbumd6ogucR+Q8WY91t2nHz60x+gjZm1H6GjW4BhR5Lbdeqyx9g5gFQ2Av+tpFEBLZqhc
 shVL0hYBRLh5MSJWQXzKjKICDp0uIBnxVB6XTEcbjL43AXrZef8s3g3D9FG/0xbzJTuaxwWLTbyWO
 uUSOjoJL1qxG1S7MDJ3Y4RnW/dgg9TFiCUIeJkPOsmmrlk6T1U4ZfpdwpGn3L0z+w0Ai0JWrdmVhu
 a7I8E32A==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v4 01/12] libqos/qgraph: add qemu_name to QOSGraphNode
Date: Sat, 24 Oct 2020 12:39:35 +0200
Message-ID: <1877224.zvXS8ShSZb@silver>
In-Reply-To: <a3f22a0d-ad06-d227-e9ee-ce0e9c629f96@redhat.com>
References: <cover.1602182956.git.qemu_oss@crudebyte.com>
 <1689234.NbIpsrJQyj@silver> <a3f22a0d-ad06-d227-e9ee-ce0e9c629f96@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 06:39:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Samstag, 24. Oktober 2020 08:08:59 CEST Thomas Huth wrote:
> On 19/10/2020 12.35, Christian Schoenebeck wrote:
> > On Donnerstag, 8. Oktober 2020 20:34:56 CEST Christian Schoenebeck wrote:
> >> Add new member variable 'qemu_name' to struct QOSGraphNode.
> >> 
> >> This new member may be optionally set in case a different
> >> name for the node (which must always be a unique name) vs.
> >> its actually associated QEMU (QMP) device name is required.
> >> 
> >> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> >> ---
> >> 
> >>  tests/qtest/libqos/qgraph.c          | 1 +
> >>  tests/qtest/libqos/qgraph_internal.h | 1 +
> >>  2 files changed, 2 insertions(+)
> > 
> > So what shall happen with these libqos patches 1..7? Is that a nack, or
> > postpone for now?
> 
> I was hoping to see a review by Paolo or Laurent, who are much more familiar
> with qos than I am ... but after having a look at the patches, I think I
> can also give some feedback, too:
> 
> Patch 1 and 2 sound basically ok to me (should maybe be squashed together,
> though), but the qos_node_create_driver_named() function currently seems to
> be unused so far? So I'd postpone these two patches to the point in time
> when you really need the qos_node_create_driver_named() function.

I did use patches 1 & 2 in v1 of this series, as of v2 and higher I used a
workaround for the actual 9pfs test case patches not to depend on these 2
libqos patches. This happened after Paolo's feedback, who wrote that qos
patches 1 & 2 would be useful for other, future use cases, but argued it
would not be appropriate for my intended use case:

https://lore.kernel.org/qemu-devel/95ef57d0-b35e-f16a-f957-06bc3692cb7c@redhat.com/

I preserved patches 1 & 2 in this series though as he noted they might be
useful for future purposes and applied his requested changes. I personally
probably won't need thise 2 patches any time soon. So it's up to you what
shall happen with them. I don't mind if you postpone or nack them.

> The other patches are basically fine with me, too, but please avoid the
> hard-coded ESC codes that only work with certain terminals.
> 
>  Thomas

I'll respond to that on your patch 4 response.

Best regards,
Christian Schoenebeck



