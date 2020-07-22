Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA32AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:39:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B289220729
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ne5ZrzxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B289220729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyD5u-0005Zp-SW
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 07:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyD52-00059k-Lc
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:38:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55548
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyD50-00028W-Sj
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595417913;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xz2nSyj7CaaC4a6NWR6vgdyfoAYWmkyE9zD9ooQBOsk=;
 b=Ne5ZrzxWeuBwi2DFYKX0M6bnjD18MbBky2YX6I6zA5CU/NC6ydFU9POgzqGkEACgs9+oX1
 FjbQbH4MXfpXUmShbMnHmu8JYlc87fo72fum0QthrrmHiubcKbLRQIIcFMgPcfX+opOiUs
 Xm48YqTu8MZl7WRSEJUK6RgUEPIwh04=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-v6AyXOUVMKqL52YRXLyB7A-1; Wed, 22 Jul 2020 07:38:29 -0400
X-MC-Unique: v6AyXOUVMKqL52YRXLyB7A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DFEB192376A;
 Wed, 22 Jul 2020 11:38:27 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D8C161A836;
 Wed, 22 Jul 2020 11:38:24 +0000 (UTC)
Date: Wed, 22 Jul 2020 12:38:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 05/12] util/oslib-win32: add qemu_get_host_physmem
 implementation
Message-ID: <20200722113821.GD2324845@redhat.com>
References: <20200722062902.24509-1-alex.bennee@linaro.org>
 <20200722062902.24509-6-alex.bennee@linaro.org>
 <6d316f94-fd8a-9b59-5f47-f37c833eb79b@weilnetz.de>
 <87wo2vu6lg.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87wo2vu6lg.fsf@linaro.org>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 21:28:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: fam@euphon.net, Stefan Weil <sw@weilnetz.de>, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, f4bug@amsat.org, cota@braap.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 22, 2020 at 12:33:47PM +0100, Alex Bennée wrote:
> 
> Stefan Weil <sw@weilnetz.de> writes:
> 
> > Am 22.07.20 um 08:28 schrieb Alex Bennée:
> >
> >> It seems GetPhysicallyInstalledSystemMemory isn't available in the
> >> MinGW headers so we have to declare it ourselves. Compile tested only.
> >
> >
> > It is available, at least for Mingw-w64 which I also use for cross
> > builds on Debian, but is only included with _WIN32_WINNT >= 0x0601.
> >
> > Currently we set _WIN32_WINNT to 0x0600.
> 
> That would explain why some people see things working if they build with
> visual studio (which I presume has a higher setting). We could just wrap
> the body of the function in:

No, that's not how it works. We define _WIN32_WINNT in qemu/osdep.h,
and this causes the Windows headers to hide any functions that post-date
that version.

This is similar to how you might set _POSIX_C_SOURCE / _XOPEN_SOURCE
to control UNIX header visibility.

IOW, the use of visual studio shouldn't affect it.

>   #if (_WIN32_WINNT >= 0x0601)
> 
> much like in commands-win32.c?
> 
> Of course it wouldn't even be compile tested (I used the fedora docker
> image). We should probably clean up the test-mingw code to work with
> both the fedora and debian-w[32|64] images.

I'd just go for GlobalMemoryStatusEx  like Stefan suggests. We use this
in libvirt and GNULIB already and it does the job.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


