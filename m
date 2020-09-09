Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57083C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 04:58:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEDED21D40
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 04:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UCZ3eciZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEDED21D40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFsBT-0001N7-R5
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 00:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kFsA7-0008VO-0a
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 00:56:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44486
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kFsA5-0006GP-Ca
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 00:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599627408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LensnF3d07TEQ4BZFsCdYvKyPk3eauj5ipIuoYWkLLI=;
 b=UCZ3eciZOMX9afINsZdDofhqIieQ4ZEawYPCXzMymcwU4a7e3rrEMt5AqznyEdFXwDfndo
 1DOje7LGkNDWlCjdPBZKKjqmMNUxy5p70sT4ACfclGR9QUY44DMYOl2JhvXk53FtOHWN1H
 fA8fNMgRryUuoon60seH6Po0TotfymI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-orVhzYg8Opyv4PVwGEoWfQ-1; Wed, 09 Sep 2020 00:56:46 -0400
X-MC-Unique: orVhzYg8Opyv4PVwGEoWfQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0671410051C1;
 Wed,  9 Sep 2020 04:56:44 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A966F5C22E;
 Wed,  9 Sep 2020 04:56:43 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D14379D77; Wed,  9 Sep 2020 06:56:42 +0200 (CEST)
Date: Wed, 9 Sep 2020 06:56:42 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH 04/16] curses: Fixes curses compiling errors.
Message-ID: <20200909045642.vdevcr2osdqviir4@sirius.home.kraxel.org>
References: <20200908194820.702-1-luoyonggang@gmail.com>
 <20200908194820.702-5-luoyonggang@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200908194820.702-5-luoyonggang@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 00:56:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>,
 Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 09, 2020 at 03:48:08AM +0800, Yonggang Luo wrote:
> This is the compiling error:
> ../ui/curses.c: In function 'curses_refresh':
> ../ui/curses.c:256:5: error: 'next_maybe_keycode' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   256 |     curses2foo(_curses2keycode, _curseskey2keycode, chr, maybe_keycode)
>       |     ^~~~~~~~~~
> ../ui/curses.c:302:32: note: 'next_maybe_keycode' was declared here
>   302 |             enum maybe_keycode next_maybe_keycode;
>       |                                ^~~~~~~~~~~~~~~~~~
> ../ui/curses.c:256:5: error: 'maybe_keycode' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   256 |     curses2foo(_curses2keycode, _curseskey2keycode, chr, maybe_keycode)
>       |     ^~~~~~~~~~
> ../ui/curses.c:265:24: note: 'maybe_keycode' was declared here
>   265 |     enum maybe_keycode maybe_keycode;
>       |                        ^~~~~~~~~~~~~
> cc1.exe: all warnings being treated as errors
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>


