Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7BCC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:45:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49B9F20888
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XuMqPH8W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B9F20888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeKj4-00059o-By
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 11:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeKcD-0004oU-II
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:38:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44480
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeKcC-00044f-HO
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590680319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RQu9URXHm3TK36XSaXCSttgLb+YQkStVK7BwXFtJ4rc=;
 b=XuMqPH8WId7B6hvUuIsWfK3aBzm4G8+0BLmgDttzt4Q56a2GAY9V5GUUUBr3KZYFRGMCJj
 hb5nhiwPj4aLINfIbmoQpO8smDszJrze6CW2WWTIiGrFP0VWnSxkIKY3+26Y0dpAW40zCl
 1X9wAVxTwGPdmjJDT+ZUftJhD/KqxEU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-MvlcRy1wMiCzEHjQPxum0g-1; Thu, 28 May 2020 11:38:37 -0400
X-MC-Unique: MvlcRy1wMiCzEHjQPxum0g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F10941B18BEE;
 Thu, 28 May 2020 15:38:36 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E9D45C221;
 Thu, 28 May 2020 15:38:36 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5A74616E2C; Thu, 28 May 2020 17:38:35 +0200 (CEST)
Date: Thu, 28 May 2020 17:38:35 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PULL 00/12] testing and plugin fixes
Message-ID: <20200528153835.d7rn2uswoivqjpqz@sirius.home.kraxel.org>
References: <20200527145455.2550-1-alex.bennee@linaro.org>
 <CAFEAcA_LrZjBY_y3UR=fdOtDvnY=zGG-10Yeq0ZjbBc=EsvRfw@mail.gmail.com>
 <87blm83y5v.fsf@linaro.org>
 <CAFEAcA_QTkWA7eBwORWMmpcH1E5bF4A3mFtkzdstkucd-2+p3A@mail.gmail.com>
 <591d2690-c2e7-98aa-8569-5f99737c5f71@redhat.com>
MIME-Version: 1.0
In-Reply-To: <591d2690-c2e7-98aa-8569-5f99737c5f71@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 01:51:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 28, 2020 at 05:18:42PM +0200, Philippe Mathieu-Daudé wrote:
> +Gerd
> 
> On 5/28/20 5:09 PM, Peter Maydell wrote:
> > On Thu, 28 May 2020 at 15:57, Alex Bennée <alex.bennee@linaro.org> wrote:
> >> I get these on commit ddc760832fa8cf5e93b9d9e6e854a5114ac63510:
> >>
> >>     LINK    arm-softmmu/qemu-system-arm
> >>   ld: /usr/lib/libc.so and /usr/lib/crt0.o: warning: multiple common of `environ'
> >>   ld: warning: libintl.so.1, needed by /usr/pkg/lib/libgio-2.0.so, may conflict with libintl.so.8
> >>   ld: warning: libintl.so.1, needed by /usr/pkg/lib/libgio-2.0.so, may conflict with libintl.so.8
> >>   ld: warning: libintl.so.1, needed by /usr/pkg/lib/libgio-2.0.so, may conflict with libintl.so.8
> >>   ld: warning: libintl.so.1, needed by /usr/pkg/lib/libgio-2.0.so, may conflict with libintl.so.8
> >>   ld: warning: libintl.so.1, needed by /usr/pkg/lib/libgio-2.0.so, may conflict with libintl.so.8

Hmm, on a quick glance this looks like a netbsd packaging bug ...

> Maybe building back NetBSD 8.1?
> 
> $ git checkout 2cc3e591b3321a~ tests/vm/netbsd
> $ make vm-build-netbsd
> $ git checkout HEAD tests/vm/netbsd

The *nsd installs fetch and install a bunch of addon packages, so when
these are updated a netbsd image rebuild will use the newer versions.

IIRC both tests/vm/netbsd and tests/vm/basevm.py changes will trigger
and netbsd image rebuild.  If you want avoid that you have to touch the
disk image after git checkout so make thinks it is up-to-date and
doesn't try to rebuild it.

take care,
  Gerd


