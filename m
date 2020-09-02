Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB231C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 10:39:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A5BE2071B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 10:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eLbm1H3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A5BE2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDQAv-0006so-QC
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 06:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDQAB-0006LD-Q1
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 06:38:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27831
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDQAA-0005in-4W
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 06:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599043125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LZoje0olfdNdCixpAqZ2V9m62xwQLJSBTx+PPTzrT5c=;
 b=eLbm1H3lzw5L76l/BND6dn/3AAFbE/rPKcuH0gv/d3IGkbCTrCC1hF/ONcPJrUiroua4iq
 VDT3FxbrLMe/nP1pDZ7WR1o7x2or0GJxKzADyhB7hsqTAV/W3ky82m2wo7XE5nwoQd9Jsr
 QHeGvjRgGBjIGY8C6/zXY6WafqwOv/w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-6yW6MfhFMJqnL8O_Dko32g-1; Wed, 02 Sep 2020 06:38:42 -0400
X-MC-Unique: 6yW6MfhFMJqnL8O_Dko32g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6075801ADE;
 Wed,  2 Sep 2020 10:38:40 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-129.ams2.redhat.com [10.36.112.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B4441002D5D;
 Wed,  2 Sep 2020 10:38:33 +0000 (UTC)
Subject: Re: Cirrus CI for msys2 are working now, but still buiding failed
To: luoyonggang@gmail.com, qemu-level <qemu-devel@nongnu.org>
References: <CAE2XoE_SkH-2dNULFAZNiRNRNP=OncwCy=xrDk0J3bzS1Th=tg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c61f6420-ffdb-b2b1-44ec-60b8a55f9c8a@redhat.com>
Date: Wed, 2 Sep 2020 12:38:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE_SkH-2dNULFAZNiRNRNP=OncwCy=xrDk0J3bzS1Th=tg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/09/2020 22.47, 罗勇刚(Yonggang Luo) wrote:
> https://cirrus-ci.com/task/6375504892657664
> 
> 
> failed with:
> ```
> 
> Compiling C object libqemu-s390x-softmmu.fa.p/meson-generated_.._trace_generated-helpers.c.obj
> Compiling C object libqemu-s390x-softmmu.fa.p/meson-generated_.._qapi_qapi-events.c.obj
> Compiling C object libqemu-s390x-softmmu.fa.p/meson-generated_.._qapi_qapi-emit-events.c.obj
> Linking static target libblock.fa
> Linking target qemu-system-aarch64.exe
> Linking target qemu-system-aarch64w.exe
> Linking target qemu-system-alpha.exe
> Linking target qemu-system-alphaw.exe
> Linking target qemu-system-arm.exe
> Linking target qemu-system-armw.exe
> Linking target qemu-system-avr.exe
> Linking target qemu-system-avrw.exe
> C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: cannot find -lfdt
> C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: cannot find -lfdt
> C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: cannot find -lfdt
> C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: cannot find -lfdt
> collect2.exe: error: ld returned 1 exit status
> collect2.exe: error: ld returned 1 exit status
> collect2.exe: error: ld returned 1 exit status
> collect2.exe: error: ld returned 1 exit status
> make: *** [Makefile.ninja:2258: qemu-system-avr.exe] Error 1
> make: *** Waiting for unfinished jobs....
> make: *** [Makefile.ninja:1970: qemu-system-alpha.exe] Error 1
> make: *** [Makefile.ninja:2260: qemu-system-avrw.exe] Error 1
> make: *** [Makefile.ninja:1972: qemu-system-alphaw.exe] Error 1
> C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: cannot find -lfdt
> C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: cannot find -lfdt
> C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: cannot find -lfdt
> C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: cannot find -lfdt
> collect2.exe: error: ld returned 1 exit status
> collect2.exe: error: ld returned 1 exit status
> make: *** [Makefile.ninja:2184: qemu-system-armw.exe] Error 1
> make: *** [Makefile.ninja:2182: qemu-system-arm.exe] Error 1
> collect2.exe: error: ld returned 1 exit status
> make: *** [Makefile.ninja:1875: qemu-system-aarch64.exe] Error 1
> collect2.exe: error: ld returned 1 exit status
> make: *** [Makefile.ninja:1877: qemu-system-aarch64w.exe] Error 1

Wow, that looks quite promising already! But I wonder why the build
system is trying to link libfdt to targets like qemu-system-avr that do
not need it?
And for the targets that need fdt, it should use the dtc submodule... I
can see in the log that the dtc submodule is checked out, but it does
not seem to be compiled ? As a test, could you please try to run
"configure" with "--disable-fdt" there?

 Thomas


