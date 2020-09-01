Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C858AC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:05:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F981206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YWUn9PA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F981206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCzQT-000100-Qh
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 02:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kCzPl-0000Xg-2q
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 02:05:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53249
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kCzPi-0007WY-Hw
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 02:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598940301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y2DZpy3OdiaJMDRMli4v5dx33eDawQgjW0qruzRvIWc=;
 b=YWUn9PA3VQqgREfjr3Y8bkyAHZNoBzI/NCSycz2nmj5U2cBQdnSwxrABJ1wvywHsD2EVnn
 2t+neMx0h+CjugPlMd0MKvxcDtr0JLV2XvZhu052RM+vlTbGSckRYkjmHL1D2s8IpJSZUx
 URXaF+26zSeSUQIDrG4Uacb9uUhDLyY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-2tS-q4NOPW246NPhFR3qXg-1; Tue, 01 Sep 2020 02:04:57 -0400
X-MC-Unique: 2tS-q4NOPW246NPhFR3qXg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D8721074641;
 Tue,  1 Sep 2020 06:04:56 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-188.ams2.redhat.com [10.36.112.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 019FD1002393;
 Tue,  1 Sep 2020 06:04:45 +0000 (UTC)
Subject: Re: [PATCH] gitlab-ci.yml: Run check-qtest and check-unit at the end
 of the fuzzer job
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200831153228.229185-1-thuth@redhat.com>
 <CAAdtpL5vu9uO7tGiHLNTVCeZa3bw2zRE_PLn1tD=L-acMH_0Qw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7bea1d04-653f-f697-be6c-07e136fd6cd5@redhat.com>
Date: Tue, 1 Sep 2020 08:04:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAAdtpL5vu9uO7tGiHLNTVCeZa3bw2zRE_PLn1tD=L-acMH_0Qw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 23:17:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/08/2020 23.31, Philippe Mathieu-Daudé wrote:
> Hi Thomas,
> 
> Le lun. 31 août 2020 17:33, Thomas Huth <thuth@redhat.com
> <mailto:thuth@redhat.com>> a écrit :
> 
>     The fuzzer job finishes quite early, so we can run the unit tests and
>     qtests with -fsanitize=address here without extending the total test
>     time.
> 
>     Signed-off-by: Thomas Huth <thuth@redhat.com <mailto:thuth@redhat.com>>
>     ---
>      .gitlab-ci.yml | 5 +++--
>      1 file changed, 3 insertions(+), 2 deletions(-)
> 
>     diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>     index 17f1f8fad9..417fda6909 100644
>     --- a/.gitlab-ci.yml
>     +++ b/.gitlab-ci.yml
>     @@ -256,13 +256,14 @@ build-oss-fuzz:
>          - mkdir build-oss-fuzz
>          - CC="clang" CXX="clang++" CFLAGS="-fsanitize=address"
>            ./scripts/oss-fuzz/build.sh
>     +    - export ASAN_OPTIONS="fast_unwind_on_malloc=0"
>          - for fuzzer in $(find ./build-oss-fuzz/DEST_DIR/ -executable
>     -type f
>                            | grep -v slirp); do
>              grep "LLVMFuzzerTestOneInput" ${fuzzer} > /dev/null 2>&1 ||
>     continue ;
>              echo Testing ${fuzzer} ... ;
>     -        ASAN_OPTIONS="fast_unwind_on_malloc=0"
>     -         "${fuzzer}" -runs=1000 -seed=1 || exit 1 ;
>     +        "${fuzzer}" -runs=1000 -seed=1 || exit 1 ;
>            done
>     +    - cd build-oss-fuzz && make check-qtest-i386 check-unit
> 
> 
> As this does not use the fuzzer main entry point, what is the point of
> running that?

Read the friendly patch description ;-) - the idea here is that we run
the qtests and unit tests with -fsanitize=address in one of the
pipelines. We could also use a different task for this, but since the
fuzzer tests finish quite early and we already compiled the code with
-fsanitize=address here anyway, it's IMHO simply a good fit here.

 Thomas


