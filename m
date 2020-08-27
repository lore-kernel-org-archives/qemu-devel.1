Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B2BC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 08:01:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63BF222BF3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 08:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C5L2M7Ji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63BF222BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBCr3-0006eT-KW
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 04:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kBCqL-0005sp-Vy
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 04:01:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50343
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kBCqF-0001go-NO
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 04:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598515261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uGYlMkdObzIPtDER9gAmCZ3DZ4ZfBqIwIRqr0C2Xtv0=;
 b=C5L2M7JidjzRp5H8zawKPH+HijlcGLFXU0j1zv01HE2pI6yK9cCinxmFQ25j1pxWtYkYQl
 NFzFB1If1AIoeJrxopMvYLJnuIGHbjTOUUs7CoarRjw/iDTOf8EJKv5OI3KeLikQxEah6B
 xn13dRgtla7/40fs8RVu1eMLLJ8y8+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-Gd5bpH0bM1WbQipZTkRL4A-1; Thu, 27 Aug 2020 04:00:55 -0400
X-MC-Unique: Gd5bpH0bM1WbQipZTkRL4A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C5EA801AAE;
 Thu, 27 Aug 2020 08:00:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-54.ams2.redhat.com
 [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA6F07A40C;
 Thu, 27 Aug 2020 08:00:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 793F3991; Thu, 27 Aug 2020 10:00:52 +0200 (CEST)
Date: Thu, 27 Aug 2020 10:00:52 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Diego Viola <diego.viola@gmail.com>
Subject: Re: Help with usb-host hostdevice property
Message-ID: <20200827080052.aquvggd5beedfizt@sirius.home.kraxel.org>
References: <CA+ToGPGh2JwaHC_6mmJcsiEDn6Qp4=zMD+UTGfiKo-yeHjxKKQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+ToGPGh2JwaHC_6mmJcsiEDn6Qp4=zMD+UTGfiKo-yeHjxKKQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:42:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> usb 1-1: Invalid ep0 maxpacket: 64
> usb usb1-port1: unable to enumerate USB device

https://patchwork.ozlabs.org/project/qemu-devel/patch/20200826145239.6077-18-kraxel@redhat.com/

HTH,
  Gerd


