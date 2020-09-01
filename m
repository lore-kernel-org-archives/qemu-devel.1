Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37101C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:32:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F10DF2065F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQZVmLTE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F10DF2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD9D8-0005gU-TV
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 12:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kD9CP-0005CK-Cz
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 12:31:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25291
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kD9CN-0000D8-Ki
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 12:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598977914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g1IZQ6AltFmBFyQLFbCB/PODNH94UDUbA4nr0TWySVg=;
 b=LQZVmLTEg5L9K+d0Nbvoi7yLcv/9J+d0OHq+fGj1NjFxM8/q/0LVR4brHv27etfbVKTpss
 qr6R2NmoAbj25tdA9dUvTNXE2nSF5rBRyIiA3086c3nC42HMhiA3iwN3DMTKqYdF8E0gI7
 PMRfExp32oGRr8Pe7zPUvL8kNoBs7zU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-SMWhHuy8PX2KKAHzbD5KOA-1; Tue, 01 Sep 2020 12:31:52 -0400
X-MC-Unique: SMWhHuy8PX2KKAHzbD5KOA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E992B10ABDA1;
 Tue,  1 Sep 2020 16:31:50 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-188.ams2.redhat.com [10.36.112.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8918319C66;
 Tue,  1 Sep 2020 16:31:45 +0000 (UTC)
Subject: Re: [PATCH v2 5/7] dockerfiles/debian-win64-cross: Download WHPX
 MinGW headers
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200823111757.72002-1-thuth@redhat.com>
 <20200823111757.72002-6-thuth@redhat.com>
 <20200901162508.GV345480@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <37748f4a-c362-017e-c2f3-98e282c45eb5@redhat.com>
Date: Tue, 1 Sep 2020 18:31:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200901162508.GV345480@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 00:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, luoyonggang@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/09/2020 18.25, Daniel P. Berrangé wrote:
> On Sun, Aug 23, 2020 at 01:17:55PM +0200, Thomas Huth wrote:
>> To compile-test the WHPX accelerator, we need to download these system
>> headers first (they are unfortunately not part of any released and
>> packaged MinGW toolchain yet).
>>
>> Idea taken from another patch by Stefan Weil.
>>
>> Message-Id: <20200804170055.2851-12-thuth@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  tests/docker/dockerfiles/debian-win64-cross.docker | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> 
>>
>> diff --git a/tests/docker/dockerfiles/debian-win64-cross.docker b/tests/docker/dockerfiles/debian-win64-cross.docker
>> index 2fc9cfcbc6..4cc4a3f365 100644
>> --- a/tests/docker/dockerfiles/debian-win64-cross.docker
>> +++ b/tests/docker/dockerfiles/debian-win64-cross.docker
>> @@ -32,7 +32,14 @@ RUN apt-get update && \
>>          mxe-$TARGET-w64-mingw32.shared-sdl2 \
>>          mxe-$TARGET-w64-mingw32.shared-sdl2-mixer \
>>          mxe-$TARGET-w64-mingw32.shared-sdl2-gfx \
>> -        mxe-$TARGET-w64-mingw32.shared-zlib
>> +        mxe-$TARGET-w64-mingw32.shared-zlib \
>> +        curl && \
>> +    curl -s -S -o /usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/WinHvEmulation.h \
>> +        "https://sourceforge.net/p/mingw-w64/mingw-w64/ci/master/tree/mingw-w64-headers/include/winhvemulation.h?format=raw" && \
>> +    curl -s -S -o /usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/WinHvPlatform.h \
>> +        "https://sourceforge.net/p/mingw-w64/mingw-w64/ci/master/tree/mingw-w64-headers/include/winhvplatform.h?format=raw" && \
>> +    curl -s -S -o /usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/winhvplatformdefs.h \
>> +        "https://sourceforge.net/p/mingw-w64/mingw-w64/ci/master/tree/mingw-w64-headers/include/winhvplatformdefs.h?format=raw"
> 
> My only concern here is whether sourceforge.net  URLs are reliable enough
> for CI, or whether we should instead be mirroring the w64 repo on
> git.qemu.org ?
> 
> I guess this will be a short term issue until a new mingw release is made
> and arrives i nthe distros, so we can try with the curl approach for
> now and change if it causes problems

That's my assumption, too. And since the containers are only rebuild
when something changed (as far as I understood), the download should
only occur quite rarely, so there is hopefully really not a big
dependency here.

> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

Thanks!

 Thomas


