Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4170C433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 06:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B358F2245C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 06:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LpbH7777"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B358F2245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3CvU-0000lk-W5
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 02:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3Cub-0000Jz-BI
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 02:28:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60926)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3CuY-0000pD-Ol
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 02:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596608904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=kXn5DVovnSKu13AF2ZMqtcu/1DGNI0xmrWhBhfYS+U4=;
 b=LpbH7777HJDAUV/sADc0eN7f+0DEsjp/zsfodLvGbX90Sv05wP5z1w6BvTpdhrdZC1uLj9
 lu2dMF9LuIflhhIC/gT5VHD9Yqt5g4N68rBLA0LV3LGMGaYsoT4NB+CjhhYpjOG+yPdtsY
 Mv+UPAN7g6eCnjHQmI6ZspXl55y/WLU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-qElSeSC_MSa3xSHeq_XdAg-1; Wed, 05 Aug 2020 02:28:20 -0400
X-MC-Unique: qElSeSC_MSa3xSHeq_XdAg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 423916D04D;
 Wed,  5 Aug 2020 06:28:19 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-142.ams2.redhat.com [10.36.112.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BE0C2B6F0;
 Wed,  5 Aug 2020 06:28:13 +0000 (UTC)
Subject: Re: [PATCH 11/11] dockerfiles/debian-win64-cross: Download WHPX MinGW
 headers
To: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200804170055.2851-1-thuth@redhat.com>
 <20200804170055.2851-12-thuth@redhat.com>
 <4cdba8c7-c6a1-e561-9e84-1dae8cf4cd04@weilnetz.de>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ce473498-1be8-2ec1-ff54-6b52d07f7038@redhat.com>
Date: Wed, 5 Aug 2020 08:28:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <4cdba8c7-c6a1-e561-9e84-1dae8cf4cd04@weilnetz.de>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 02:28:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/08/2020 20.32, Stefan Weil wrote:
> Am 04.08.20 um 19:00 schrieb Thomas Huth:
> 
>> To compile-test the WHPX accelerator, we need to download these system
>> headers first (they are unfortunately not part of any released and
>> packaged MinGW toolchain yet).
>>
>> Idea taken from another patch by Stefan Weil.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  tests/docker/dockerfiles/debian-win64-cross.docker | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
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
>>  
>>  # Specify the cross prefix for this image (see tests/docker/common.rc)
>>  ENV QEMU_CONFIGURE_OPTS --cross-prefix=x86_64-w64-mingw32.shared-
> 
> 
> I expect a build failure: Mingw-w64 decided to use lower case filenames,
> and those header files include each other.

The first two headers include the third header, that's why I've used
lowercase for the third header (which is apparently not included by QEMU
directly).
But yes, all that CamelCase vs. lower-case stuff is very annoying. I
think once there is a new MinGW release available in the major Linux
distros that ships with these headers, we should change the QEMU source
code to always use the lowercase headers, too.

 Thomas


