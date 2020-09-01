Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE8FC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:13:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0606A208DB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0606A208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCzXf-0004Am-3y
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 02:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCzX7-0003lM-Tv
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 02:12:41 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36644)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCzX6-0008Ph-Ax
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 02:12:41 -0400
Received: by mail-ed1-f66.google.com with SMTP id w1so281082edr.3
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 23:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=beWS+bjZnhjKamk948UU1Bx/Jd4mYpBieQFET6SOAZk=;
 b=fNYvP55DD0R0fFs6cOOvDt5hm2y+8fPAMU2dcRVb23vi1dslKmc9K5Mp6bOYUvXUBq
 gEmMNkYJsHjgQsR4OBmS+PUXKkixMT8WyXNKXn/z2byvj0doaAtDS639Q+HLbcOBek5v
 0EJE8qxwVL7TI0+YpmhH10MmW0L/Hc3t/HuwQcGuaMhIs+gghW0208Om9bZ2yJW7y0l9
 Y7VeVJKliYVlDZN6F2nb9a/T5iefW+uunWYE3i+Fb4yvDS3Q90wjZXY3RmsfNJmk4Yz4
 a+dQn5aqYwGn3+u09+Vcb5B4ZG4H5r/JAhAPXhgAnaAeGElw+zsS3I+Qv8Aw0zNI5ygU
 dEUw==
X-Gm-Message-State: AOAM531rmOIn3I/aX3F1J4o4KNMdeOQOA3Znwvts1ctpavLsSPKj4fZI
 0gqJXObrfLg1d1yEl3bHkpiHILWHRk1dECSnYfU=
X-Google-Smtp-Source: ABdhPJygeIxqbMxvOgiVU3fFkyFNYgKuWUq7HwWN3fRjLBeMZ1Xh93mspisn7y2qyjP3ivqp46la5MOLW2HGD2xwhRg=
X-Received: by 2002:a05:6402:1641:: with SMTP id
 s1mr421872edx.66.1598940758474; 
 Mon, 31 Aug 2020 23:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200831153228.229185-1-thuth@redhat.com>
 <CAAdtpL5vu9uO7tGiHLNTVCeZa3bw2zRE_PLn1tD=L-acMH_0Qw@mail.gmail.com>
 <7bea1d04-653f-f697-be6c-07e136fd6cd5@redhat.com>
In-Reply-To: <7bea1d04-653f-f697-be6c-07e136fd6cd5@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 1 Sep 2020 08:12:27 +0200
Message-ID: <CAAdtpL6NHQ0EjXck9Hm11HCiyJ4=Z9hwZYve=wiAvpLnF7Moyw@mail.gmail.com>
Subject: Re: [PATCH] gitlab-ci.yml: Run check-qtest and check-unit at the end
 of the fuzzer job
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.208.66;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-f66.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 02:12:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 1, 2020 at 8:05 AM Thomas Huth <thuth@redhat.com> wrote:
>
> On 31/08/2020 23.31, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi Thomas,
> >
> > Le lun. 31 ao=C3=BBt 2020 17:33, Thomas Huth <thuth@redhat.com
> > <mailto:thuth@redhat.com>> a =C3=A9crit :
> >
> >     The fuzzer job finishes quite early, so we can run the unit tests a=
nd
> >     qtests with -fsanitize=3Daddress here without extending the total t=
est
> >     time.
> >
> >     Signed-off-by: Thomas Huth <thuth@redhat.com <mailto:thuth@redhat.c=
om>>
> >     ---
> >      .gitlab-ci.yml | 5 +++--
> >      1 file changed, 3 insertions(+), 2 deletions(-)
> >
> >     diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> >     index 17f1f8fad9..417fda6909 100644
> >     --- a/.gitlab-ci.yml
> >     +++ b/.gitlab-ci.yml
> >     @@ -256,13 +256,14 @@ build-oss-fuzz:
> >          - mkdir build-oss-fuzz
> >          - CC=3D"clang" CXX=3D"clang++" CFLAGS=3D"-fsanitize=3Daddress"
> >            ./scripts/oss-fuzz/build.sh
> >     +    - export ASAN_OPTIONS=3D"fast_unwind_on_malloc=3D0"
> >          - for fuzzer in $(find ./build-oss-fuzz/DEST_DIR/ -executable
> >     -type f
> >                            | grep -v slirp); do
> >              grep "LLVMFuzzerTestOneInput" ${fuzzer} > /dev/null 2>&1 |=
|
> >     continue ;
> >              echo Testing ${fuzzer} ... ;
> >     -        ASAN_OPTIONS=3D"fast_unwind_on_malloc=3D0"
> >     -         "${fuzzer}" -runs=3D1000 -seed=3D1 || exit 1 ;
> >     +        "${fuzzer}" -runs=3D1000 -seed=3D1 || exit 1 ;
> >            done
> >     +    - cd build-oss-fuzz && make check-qtest-i386 check-unit
> >
> >
> > As this does not use the fuzzer main entry point, what is the point of
> > running that?
>
> Read the friendly patch description ;-) - the idea here is that we run
> the qtests and unit tests with -fsanitize=3Daddress in one of the
> pipelines.

Sorry, the description was not that obvious to me.
Can you add a comment before the 'make check*' line?

  # Unrelated to fuzzer: run tests with -fsanitize=3Daddress

> We could also use a different task for this, but since the
> fuzzer tests finish quite early and we already compiled the code with
> -fsanitize=3Daddress here anyway, it's IMHO simply a good fit here.
>
>  Thomas
>
>

