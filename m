Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95E0C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 11:19:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D88E21921
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 11:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D88E21921
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpspS-0000Ch-Ns
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 07:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50891)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hpspF-0008AT-7B
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 07:19:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hpspD-0000Pj-SY
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 07:19:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38728)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hpspC-0000Nj-Rb
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 07:19:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id g17so42762862wrr.5
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 04:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=U2e5T3SvpGMsuYUnGNBmA/W+O7VMa82QR6Hgr6hCl5c=;
 b=HikwMfEt9Pu5WIKGNVMQi//lo8MTc/2seTZGaY09GZ5WWe/mpZtQL2dcUwLPekTk7t
 0zEQdwp1A1uXFf/lMHRPbG7eAEiZUarpRjbbJAD7HZwZmXvh1GC1qmR97fpK12lxx4K7
 M6eD47GA66VqCKAmQKAdcy1Yx7qQclVsMtIBhmKeXK5tCXAgqP2gsc61225xh6RLWHAq
 WkUrteNmiyNY2m6yJt6bHzqcS7LSTXyC7iWX9YrCkDjXHG9lAbfJcwwfoBruMdSF5RrW
 XyTWGCI3ZveRFxm2zItoObNwb25HRwrGKyl3pMVIIZSrbxoxHRx2OgbpgfhfyQRG0xl+
 KrCQ==
X-Gm-Message-State: APjAAAXIF8TCTjTJ4lLgzRB8xQT5BU96l5iYlkcm6tUnQ7BnIkw0KKCm
 wg+tA7Goxykk2uBjgu01ivXYLA==
X-Google-Smtp-Source: APXvYqxK/nrRjinA+P2KMluRqLtFYm7CgITLgw8T21ppLEaR9Gzmjb8BGIvjsI4HCB5DlxSPWcqSEQ==
X-Received: by 2002:adf:e883:: with SMTP id d3mr84158123wrm.330.1563880755857; 
 Tue, 23 Jul 2019 04:19:15 -0700 (PDT)
Received: from [192.168.1.38] (190.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.190])
 by smtp.gmail.com with ESMTPSA id q18sm49262744wrw.36.2019.07.23.04.19.14
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Jul 2019 04:19:15 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org
References: <20190723111201.1926-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f79363ae-6198-004e-840d-e0bfd5ac1a75@redhat.com>
Date: Tue, 23 Jul 2019 13:19:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190723111201.1926-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH] tests/qemu-iotests: Don't use 'seq' in the
 iotests
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
Cc: Kevin Wolf <kwolf@redhat.com>, peter.maydell@linaro.org,
 Kamil Rytarowski <kamil@netbsd.org>, Brad Smith <brad@comstyle.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Brad, the OpenBSD maintainer.

On 7/23/19 1:12 PM, Thomas Huth wrote:
> The 'seq' command is not available by default on OpenBSD, so these
> iotests are currently failing there. It could be installed as 'gseq'
> from the coreutils package - but since it is using a different name
> there and we are running the iotests with the "bash" shell anyway,
> let's simply use the built-in double parentheses for the for-loops
> instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qemu-iotests/007            | 2 +-
>  tests/qemu-iotests/011            | 2 +-
>  tests/qemu-iotests/032            | 2 +-
>  tests/qemu-iotests/035            | 2 +-
>  tests/qemu-iotests/037            | 2 +-
>  tests/qemu-iotests/046            | 2 +-
>  tests/qemu-iotests/common.pattern | 4 ++--
>  7 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/qemu-iotests/007 b/tests/qemu-iotests/007
> index 6abd402423..7d3544b479 100755
> --- a/tests/qemu-iotests/007
> +++ b/tests/qemu-iotests/007
> @@ -48,7 +48,7 @@ echo
>  echo "creating image"
>  _make_test_img 1M
>  
> -for i in `seq 1 10`; do
> +for ((i=1;i<=10;i++)); do
>      echo "savevm $i"
>      $QEMU -nographic -hda "$TEST_IMG" -serial none -monitor stdio >/dev/null 2>&1 <<EOF
>  savevm test-$i
> diff --git a/tests/qemu-iotests/011 b/tests/qemu-iotests/011
> index 8b1fce069a..56f704b5b9 100755
> --- a/tests/qemu-iotests/011
> +++ b/tests/qemu-iotests/011
> @@ -49,7 +49,7 @@ _make_test_img $size
>  
>  echo
>  echo "overlapping I/O"
> -for i in `seq 1 10`; do
> +for ((i=1;i<=10;i++)); do
>      let mb=1024*1024
>      let off1=$i*$mb
>      let off2=$off1+512
> diff --git a/tests/qemu-iotests/032 b/tests/qemu-iotests/032
> index 23c216c549..988a8c5d8f 100755
> --- a/tests/qemu-iotests/032
> +++ b/tests/qemu-iotests/032
> @@ -52,7 +52,7 @@ _make_test_img 64M
>  
>  # Allocate every other cluster so that afterwards a big write request will
>  # actually loop a while and issue many I/O requests for the lower layer
> -for i in $(seq 0 128 4096); do echo "write ${i}k 64k"; done | $QEMU_IO "$TEST_IMG" | _filter_qemu_io
> +for ((i=0;i<=4096;i+=128)); do echo "write ${i}k 64k"; done | $QEMU_IO "$TEST_IMG" | _filter_qemu_io
>  
>  echo
>  echo === AIO request during close ===
> diff --git a/tests/qemu-iotests/035 b/tests/qemu-iotests/035
> index ad6fa3115a..d950a0dd1e 100755
> --- a/tests/qemu-iotests/035
> +++ b/tests/qemu-iotests/035
> @@ -49,7 +49,7 @@ echo "creating image"
>  _make_test_img $size
>  
>  generate_requests() {
> -    for i in $(seq 0 63); do
> +    for ((i=0;i<=63;i++)); do
>          echo "aio_write ${i}M 512"
>          echo "aio_write ${i}M 512"
>          echo "aio_write ${i}M 512"
> diff --git a/tests/qemu-iotests/037 b/tests/qemu-iotests/037
> index 819a2a52d2..4946b9be92 100755
> --- a/tests/qemu-iotests/037
> +++ b/tests/qemu-iotests/037
> @@ -61,7 +61,7 @@ backing_io()
>      local pattern=0
>      local cur_sec=0
>  
> -    for i in $(seq 0 $((sectors - 1))); do
> +    for ((i=0;i<=$((sectors - 1));i++)); do
>          cur_sec=$((offset / 512 + i))
>          pattern=$(( ( (cur_sec % 256) + (cur_sec / 256)) % 256 ))
>  
> diff --git a/tests/qemu-iotests/046 b/tests/qemu-iotests/046
> index 543355c64f..4e03ead7b1 100755
> --- a/tests/qemu-iotests/046
> +++ b/tests/qemu-iotests/046
> @@ -55,7 +55,7 @@ backing_io()
>      local pattern=0
>      local cur_sec=0
>  
> -    for i in $(seq 0 $((sectors - 1))); do
> +    for ((i=0;i<=$((sectors - 1));i++)); do
>          cur_sec=$((offset / 65536 + i))
>          pattern=$(( ( (cur_sec % 128) + (cur_sec / 128)) % 128 ))
>  
> diff --git a/tests/qemu-iotests/common.pattern b/tests/qemu-iotests/common.pattern
> index 25aa0d01c1..4f5e5bcea0 100644
> --- a/tests/qemu-iotests/common.pattern
> +++ b/tests/qemu-iotests/common.pattern
> @@ -22,7 +22,7 @@ do_is_allocated() {
>      local step=$3
>      local count=$4
>  
> -    for i in `seq 1 $count`; do
> +    for ((i=1;i<=$count;i++)); do
>          echo alloc $(( start + (i - 1) * step )) $size
>      done
>  }
> @@ -40,7 +40,7 @@ do_io() {
>      local pattern=$6
>  
>      echo === IO: pattern $pattern >&2
> -    for i in `seq 1 $count`; do
> +    for ((i=1;i<=$count;i++)); do
>          echo $op -P $pattern $(( start + (i - 1) * step )) $size
>      done
>  }
> 

