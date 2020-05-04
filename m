Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B32C47257
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 19:51:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C23B020721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 19:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="amqNlapu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C23B020721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVh7e-00007s-0T
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 15:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jVh6b-0007fw-2J
 for qemu-devel@nongnu.org; Mon, 04 May 2020 15:50:21 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51107)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jVh6Z-00016S-Hx
 for qemu-devel@nongnu.org; Mon, 04 May 2020 15:50:20 -0400
Received: by mail-wm1-x343.google.com with SMTP id x25so839496wmc.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 12:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=a67YNSvatIKbYT5Jcgh1feGwWaJFj+G91pmawsxC7Os=;
 b=amqNlapuAm2W/02Mw3x2FO/G7Imo8l1JPu9P7YhGL1chJ0eVHROt9u3RWj5H4/hSf5
 WiAUmFSZJZ4rUvDnuu3uuxCAFt0SF4+QLoo1LGWu3Gl5Hd3DRQ7HPXPv6O2fT7Lj7M3H
 qfgoostSWzDivmnL23gfqedeXkBng4mjWufV/B3jq7PGbrW3B3Nro60cz4hHu9BtMf0y
 P90O/QzWIa3QSsEZn5fcW3/7ldsOk5aaphXE27eI2a350GdDw4/aQR1/RiU4UgAvyt5D
 ffUrDJk0+D0may9QjIoUqLrs+j69q3gK23djHUQFssDo7jp3AG4LhFgEMADzFW5bWFLW
 NVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=a67YNSvatIKbYT5Jcgh1feGwWaJFj+G91pmawsxC7Os=;
 b=haSt5eGsadU+qjZ25x35BggOtGHcrNg7MnoBJdXhut2KpPnpu7Z8H2bWnDk0ALh6o2
 Fln+DPox8n2g6z0Y///37bSjjXop00JVgunpfSpePfqIEaMVlFHaVDfqzB+WiBIG2EWn
 hh/bPaBOrTSoQVjjb1w8bXBUhS46gezyAffb6od1qrqZTl/nMjSpvTBllqO19q31YqLh
 CAZrbFYF1JEZnzLsBF49wPulfF3gZHmSPXh8l4wRL4Tx5sd85LJLHFXoLC60d6OvqVLl
 6tI1aNq+97nuXw6q+6lYCweB/NCOKXWW4yj6ZVkqHpb+rIXtpvH98pxHGKT48g22Ajus
 NMHQ==
X-Gm-Message-State: AGi0Puajhjqll/4HV6aI6a49l28BsvkXTbkssIhc+yOy6fk/XCsbJkqo
 8EQ3sXurUcAN5zVsqSXTOGrVhg==
X-Google-Smtp-Source: APiQypIGTy6KcXCOvxP/g4tt3rpmdFe7LLFjnnGxtHA3gF1kJEQ6qppbRdcobXlsS5Pz0B1PJjmSYw==
X-Received: by 2002:a05:600c:2dcf:: with SMTP id
 e15mr17336452wmh.171.1588621817816; 
 Mon, 04 May 2020 12:50:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c25sm693564wmb.44.2020.05.04.12.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 12:50:16 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 83F1F1FF7E;
 Mon,  4 May 2020 20:50:15 +0100 (BST)
References: <20200501111505.4225-1-alex.bennee@linaro.org>
 <20200501111505.4225-3-alex.bennee@linaro.org>
 <20200501112105.GJ2203114@redhat.com>
User-agent: mu4e 1.4.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH  v1 2/4] .travis.yml: drop MacOSX
In-reply-to: <20200501112105.GJ2203114@redhat.com>
Date: Mon, 04 May 2020 20:50:15 +0100
Message-ID: <87o8r35vk8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, May 01, 2020 at 12:15:03PM +0100, Alex Benn=C3=A9e wrote:
>> This keeps breaking on Travis so lets just fall back to the Cirrus CI
>> builds which seem to be better maintained. Fix up the comments while
>> we are doing this as we never had a windows build.
>
> FYI the current problem with macOS biulds is not a Travis problem,
> it is a Homebrew problem, fixed by this patch:
>
> https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg04234.html

I had another go and it still went red with a timeout so I think I'll
stick with the original plan of dropping it and leaving it to Cirrus for
the coverage.

>
>
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  .travis.yml | 28 +---------------------------
>>  1 file changed, 1 insertion(+), 27 deletions(-)
>>=20
>> diff --git a/.travis.yml b/.travis.yml
>> index a4c3c6c805..49267b73b3 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -9,9 +9,8 @@ compiler:
>>  cache:
>>    # There is one cache per branch and compiler version.
>>    # characteristics of each job are used to identify the cache:
>> -  # - OS name (currently, linux, osx, or windows)
>> +  # - OS name (currently only linux)
>>    # - OS distribution (for Linux, xenial, trusty, or precise)
>> -  # - macOS image name (e.g., xcode7.2)
>>    # - Names and values of visible environment variables set in .travis.=
yml or Settings panel
>>    timeout: 1200
>>    ccache: true
>> @@ -271,31 +270,6 @@ jobs:
>>          - TEST_CMD=3D""
>>=20=20
>>=20=20
>> -    # MacOSX builds - cirrus.yml also tests some MacOS builds including=
 latest Xcode
>> -
>> -    - name: "OSX Xcode 10.3"
>> -      env:
>> -        - BASE_CONFIG=3D"--disable-docs --enable-tools"
>> -        - CONFIG=3D"--target-list=3Di386-softmmu,ppc-softmmu,ppc64-soft=
mmu,m68k-softmmu,x86_64-softmmu"
>> -      os: osx
>> -      osx_image: xcode10.3
>> -      compiler: clang
>> -      addons:
>> -        homebrew:
>> -          packages:
>> -            - ccache
>> -            - glib
>> -            - pixman
>> -            - gnu-sed
>> -            - python
>> -          update: true
>> -      before_script:
>> -        - brew link --overwrite python
>> -        - export PATH=3D"/usr/local/opt/ccache/libexec:$PATH"
>> -        - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
>> -        - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config=
.log && exit 1; }
>> -
>> -
>>      # Python builds
>>      - name: "GCC Python 3.5 (x86_64-softmmu)"
>>        env:
>> --=20
>> 2.20.1
>>=20
>>=20
>
> Regards,
> Daniel


--=20
Alex Benn=C3=A9e

