Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565D8C433E6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 07:50:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17E6D20826
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 07:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aCuPHdb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E6D20826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDNWz-0001FV-AA
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 03:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kDNWP-0000nb-TE
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 03:49:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30967
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kDNWN-0007gv-Tr
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 03:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599032970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JBzOGaXG2V3pklivZXeBHbFIdiqjShAfxsr0ww/Uhtk=;
 b=aCuPHdb8qg4Yc+cybjkT7PXnMf4ijAapay2C6b+cZhpFAtd2iBclDZcfYbiu6BZdyVLrFU
 16DGJMujkR7Iq5llt1IiMN8W/Az5tDzYR1JfFCz/q6iApNmF6ALhFFtVYyc+sr1rgoM9/E
 v7TVYO/lEEtLccznCWj/1crAGFGKikU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-cmRQLuBtPbu6wzckRsoJOw-1; Wed, 02 Sep 2020 03:49:28 -0400
X-MC-Unique: cmRQLuBtPbu6wzckRsoJOw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B71BA807333;
 Wed,  2 Sep 2020 07:49:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com
 [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8CBCB78374;
 Wed,  2 Sep 2020 07:49:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 74C739D5A; Wed,  2 Sep 2020 09:49:22 +0200 (CEST)
Date: Wed, 2 Sep 2020 09:49:22 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Sai Pavan Boddu <saipava@xilinx.com>
Subject: Re: [PATCH v4 7/7] Versal: Connect DWC3 controller with virt-versal
Message-ID: <20200902074922.byls6qvyojoueji3@sirius.home.kraxel.org>
References: <1598642380-27817-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1598642380-27817-8-git-send-email-sai.pavan.boddu@xilinx.com>
 <20200831071258.pkjkqss76tiuc7i2@sirius.home.kraxel.org>
 <BY5PR02MB6772DB240C020D41B2492274CA2E0@BY5PR02MB6772.namprd02.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <BY5PR02MB6772DB240C020D41B2492274CA2E0@BY5PR02MB6772.namprd02.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:33:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Francisco Eduardo Iglesias <figlesia@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Vikram Garhwal <fnuv@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Edgar Iglesias <edgari@xilinx.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?utf-8?Q?'Marc-Andr=C3=A9?= Lureau' <marcandre.lureau@redhat.com>,
 Ying Fang <fangying1@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 'Philippe =?utf-8?Q?Mathieu-Daud=C3=A9'?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> > Also a single IRQ only.
> > 
> > I'm wondering which is correct?  Probably one IRQ?  Do we need support for
> > multiple IRQs in xhci-sysbus in the first place?
> [Sai Pavan Boddu] It should be only one, as others seems to be define for device and OTG modes.

Documenting the registers/irqs used for device & otg in comments would be nice.

thanks,
  Gerd


