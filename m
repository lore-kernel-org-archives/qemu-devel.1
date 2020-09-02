Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB56C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:34:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 747D020773
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TPGvy/ja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 747D020773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDYWT-0005Vr-N5
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 15:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDYVR-0004YW-RM
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:33:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20072)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDYVP-0002by-Hy
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599075194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FjmKzt3jKpt0WlmVW5sAaFbZ+p20xb8nRLvHsIcEIok=;
 b=TPGvy/jatJN4i4Vpy3GYXzLViOgGO+Z9x2WzyipiGWb+HQoHMtfY+ZeCF/BlY+BmTjB3Vz
 +dDT4zvABrTrrVevdF46KD9Ty5/WOkagMC9MVuhNYsa7gJMLq0xE0hWW1ZiwiVFa4m2Sxx
 +vXrbJieH3xYLFUpd2y5MXaIhQKpwgE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-BDBVcu2XMp2UxurCNrPJPw-1; Wed, 02 Sep 2020 15:33:11 -0400
X-MC-Unique: BDBVcu2XMp2UxurCNrPJPw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 630C080EF8B;
 Wed,  2 Sep 2020 19:33:10 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-76.ams2.redhat.com [10.36.112.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD0725D6C4;
 Wed,  2 Sep 2020 19:33:09 +0000 (UTC)
Subject: Re: new msys2 testing failure, does this fixe? undefined reference to
 `qemu_lock_fd_test'
To: luoyonggang@gmail.com, qemu-level <qemu-devel@nongnu.org>
References: <CAE2XoE8VqiSFAuRL--VZtj-wOsGcGPn0FO3SOLeVfXwrP12_ig@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <20727adf-8d8c-ada2-c95b-a4f8d7653c91@redhat.com>
Date: Wed, 2 Sep 2020 21:33:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE8VqiSFAuRL--VZtj-wOsGcGPn0FO3SOLeVfXwrP12_ig@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:42:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.324, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 02/09/2020 21.13, 罗勇刚(Yonggang Luo) wrote:
> 
> C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:
> tests/test-image-locking.o: in function `check_locked_bytes':
> 5564D:/a/qemu/qemu/tests/test-image-locking.c:69: undefined reference to
> `qemu_lock_fd_test'
> 5565C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:
> D:/a/qemu/qemu/tests/test-image-locking.c:71: undefined reference to
> `qemu_lock_fd_test'
> 5566C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:
> D:/a/qemu/qemu/tests/test-image-locking.c:62: undefined reference to
> `qemu_lock_fd_test'
> 5567C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:
> tests/test-image-locking.o: in function `main':
> 5568D:/a/qemu/qemu/tests/test-image-locking.c:152: undefined reference
> to `qemu_has_ofd_lock'
> 5569collect2.exe: error: ld returned 1 exit status
> 5570make: *** [D:/a/qemu/qemu/rules.mak:88:
> tests/test-image-locking.exe] Error 1
> 5571make: *** Waiting for unfinished jobs....

You need this patch here:

https://lore.kernel.org/qemu-devel/20200823111757.72002-4-thuth@redhat.com/

and also:

https://lore.kernel.org/qemu-devel/20200823111757.72002-5-thuth@redhat.com/

... or wait for Paolo's next meson pull request which will convert
tests/Makefile to meson.

 Thomas


