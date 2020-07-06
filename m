Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329F0C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 18:47:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02DDE20773
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 18:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXMi3rP3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02DDE20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsW97-00073Q-9g
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 14:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jsW8B-0005sE-7w
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 14:46:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47133
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jsW88-0008Bg-Dl
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 14:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594061175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fpqnGn82Pia6Q5GSbGRbSgNiA8bZkSWC3AHSZ5CsGhE=;
 b=WXMi3rP3Xn5qUa5XyzSisWYtxVA/MLhSGcl7nTJ7x+eDWMb2mloYshy2aGqeLvAlw3A6gT
 ON8s6u5XAQZe8cBwNO0eDnyc3znL+u1LRVa93wZ9d9wvrXUan8/TkiwyoMIcOgC5G8FvsT
 l4yt+oaHb5QQJ+YAcRKIGD/kqw6MB+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-0pK_os06Mz69ArgVCtFCvw-1; Mon, 06 Jul 2020 14:46:13 -0400
X-MC-Unique: 0pK_os06Mz69ArgVCtFCvw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E53AE19057A0;
 Mon,  6 Jul 2020 18:46:11 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-200.ams2.redhat.com
 [10.36.112.200])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 860F25D9CD;
 Mon,  6 Jul 2020 18:46:11 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A4ECB9D71; Mon,  6 Jul 2020 20:46:10 +0200 (CEST)
Date: Mon, 6 Jul 2020 20:46:10 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH 0/7] audio: Spring cleaning
Message-ID: <20200706184610.2vjhruoarwuzpmcr@sirius.home.kraxel.org>
References: <20200505132603.8575-1-f4bug@amsat.org>
 <f516d99c-1816-674d-3f83-ad8b6a55bfb8@amsat.org>
MIME-Version: 1.0
In-Reply-To: <f516d99c-1816-674d-3f83-ad8b6a55bfb8@amsat.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:22:37
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
Cc: Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>,
 qemu-devel@nongnu.org,
 =?utf-8?B?S8WRdsOhZ8OzIFpvbHTDoW4=?= <DirtY.iCE.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 06, 2020 at 08:09:47PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Gerd,
> 
> On 5/5/20 3:25 PM, Philippe Mathieu-Daudé wrote:
> > Cleaning old branches, salvaging what seems worthwhile...
> > This series is from the time I wanted cleaner buffer handling
> > to avoid abuses, started with chardev/ but got lost with reviews.
> > audio/ is smaller, so easier.
> > 
> > - Convert various prototypes to use const buffers
> > - Expose 'audio/audio.h' via public include directory.
> 
> You didn't commented on this series.
> 
> We might use a LPVOID in dsound_get_buffer_in() as suggested
> by Volker but I don't like it much. What do you think otherwise?

Well, your reply to Volker was "This is unfortunate, because a single
backend invalidates the whole series.", so I dropped it from my
TODO/review/merge list ...

Tagging the buffers as const, then cast the const away (even if only
in dsound) isn't a good idea IMHO.

take care,
  Gerd


