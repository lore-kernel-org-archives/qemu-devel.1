Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3EBC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 21:45:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 839F4206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 21:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bptgHZUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839F4206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k89Pr-00084i-QK
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 17:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k89Ok-0007CR-QH
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 17:44:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37927
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k89Oi-0006FU-7M
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 17:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597787038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NIcUBY8rv8ol3h9XS1cXSqqY9ofHs1ExTA2icmkSVOg=;
 b=bptgHZUMN/lTC/r6yzrf9yLSsU2fLOCuE5ZWghlpjSPP8WF1xP2afgBJ0mQLLo15G+Ee70
 VgJTRE0YyRuRHWD+Jtv6FVLP9EjaSUY2esJirGBwNmnjVtmWzAMiT+p832/IXd7oOHQxBK
 2+kEMOo4V9gG8uzIoyV/Xp3DPAKEolw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-bFsF8iH9PsCR16tM1hjTdA-1; Tue, 18 Aug 2020 17:43:56 -0400
X-MC-Unique: bFsF8iH9PsCR16tM1hjTdA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7788D1DE0E;
 Tue, 18 Aug 2020 21:43:55 +0000 (UTC)
Received: from localhost (ovpn-117-244.rdu2.redhat.com [10.10.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1EFEE7E302;
 Tue, 18 Aug 2020 21:43:55 +0000 (UTC)
Date: Tue, 18 Aug 2020 17:43:54 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: Re: [PATCH 06/41] allwinner-h3: Rename memmap enum constants
Message-ID: <20200818214354.GC500103@habkost.net>
References: <20200813222625.243136-1-ehabkost@redhat.com>
 <20200813222625.243136-7-ehabkost@redhat.com>
 <6ff80e86-2499-f1af-787b-e22043756d7e@amsat.org>
 <CAPan3Wq94G7Nd6segi-JnrL6Zbkb-ygeykkL4zbvRv7rCQ8a2g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAPan3Wq94G7Nd6segi-JnrL6Zbkb-ygeykkL4zbvRv7rCQ8a2g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 16:56:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 17, 2020 at 09:07:58PM +0200, Niek Linnenbank wrote:
> Hi,
> 
> Interesting suggestion Philippe. I modelled the initial code of the H3 SoC
> mostly in-line with the aspeed SoC,
> to let it use commonly applied code structures where possible. And it looks
> like in this series, aspeed_soc.h is also
> getting the same change. I'll see if I can find some time to make a small
> patch to move the enum to the local allwinner-h3.c file like you
> suggested.
> 
> For Eduardo's work, I'm OK with a rename for now to AW_H3_DEV_*. I see it
> is also done like that in aspeed_soc.h and similar files.
> I do have one follow-up question: which value(s) from the enum are actually
> in conflict? Could you add that in the commit message perhaps, for clarity?

For allwinner-h3, the conflicting macros are: AW_H3_CCU,
AW_H3_SYSCTRL.

v2 of the series will have the conflicting macros mentioned in
the commit message in all the "rename enum constants" patches.

> 
> With that answered:
>   Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>

Thanks!

-- 
Eduardo


