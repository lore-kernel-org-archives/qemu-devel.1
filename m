Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F09C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:15:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB3C92068F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cITrqLvx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB3C92068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnMHs-00075K-W8
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 09:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jnMH6-0006ei-Kg
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 09:14:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46560
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jnMH5-0000fs-3H
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 09:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592831650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eUvnWnkkh5qWFXUTLkYDClYUS+zbeXp8tbMtOstAA3w=;
 b=cITrqLvxSJBgDi+bdwArckxuybqBluIYVaqqjb3JRGtPYD5tJb5u7DP/P83ykyKW58eblu
 s5EaXx2PpwqYX1lk5rh2LEY+CVp9cmXkdhBtDAHl5gM9d6lGqGG64rZiE7swuW44FFBlH3
 /KeU9WrvznwBHcNE40awaapO+ZVmjyY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-LYxFAWK0PFGeE1qR-RclpQ-1; Mon, 22 Jun 2020 09:14:03 -0400
X-MC-Unique: LYxFAWK0PFGeE1qR-RclpQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 734AA19200C0;
 Mon, 22 Jun 2020 13:14:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E26C5C220;
 Mon, 22 Jun 2020 13:14:01 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id AB46117477; Mon, 22 Jun 2020 15:13:58 +0200 (CEST)
Date: Mon, 22 Jun 2020 15:13:58 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: Is roms/vgabios/config.mak still needed?
Message-ID: <20200622131358.3azvpxfbtiq3sv6v@sirius.home.kraxel.org>
References: <alpine.BSF.2.22.395.2006172005060.14527@zero.eik.bme.hu>
 <7f64c36d-08f5-95a5-54f7-733578734c87@redhat.com>
 <alpine.BSF.2.22.395.2006211319550.23351@zero.eik.bme.hu>
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2006211319550.23351@zero.eik.bme.hu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 01:27:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jun 21, 2020 at 01:20:58PM +0200, BALATON Zoltan wrote:
> On Wed, 17 Jun 2020, Philippe Mathieu-Daudé wrote:
> > On 6/17/20 8:08 PM, BALATON Zoltan wrote:
> > > Hello,
> > > 
> > > I've noticed that configure creates roms/vgabios/config.mak but commit
> > > 91b8eba9ec3f5af7dd48927811eb7ff69fc4617f seems to have removed vgabios
> > > so should this be dropped from configure now as well? If it's still
> > > needed it should be added to .gitignore.
> > 
> > You are right, it is a left-over from 91b8eba9ec3f and should be dropped
> > from configure.
> 
> Will you or Gerd do something about it? I'd rather not touch configure
> without completely understading it.

Don't be shy, it's not that hard ;)
Patch sent.

take care,
  Gerd


