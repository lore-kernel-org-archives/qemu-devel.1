Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BFBC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 11:49:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F6092098B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 11:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gUzfANaT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F6092098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlWZS-0006e2-ER
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 07:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jlWY3-0005mm-Eo
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 07:48:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52595
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jlWY1-0003sR-9Y
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 07:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592394484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n8ajvFHx2AP9NbkYZ2qylAsdAV5o7FpI1kCfV5H4mx4=;
 b=gUzfANaTdEsXnn+OnNjhGHfIVu8RdxmP7y/tq3Q/e3K5Ud7gwFhIuRKZKraI6iRIQIyqKN
 5+w9wpKyWEaVrdTn0DKAmMlwAkcNPHMfMtVHeRXh9zQO+WQhS9CW5LGv/OmCW+XA5c2kkX
 nK05Fhv/KSZ3bCymvmI9hUxjS9VZouw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-dmZ4gZIBMrCTuZ-HuSUpJA-1; Wed, 17 Jun 2020 07:48:02 -0400
X-MC-Unique: dmZ4gZIBMrCTuZ-HuSUpJA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFAD2805738;
 Wed, 17 Jun 2020 11:48:01 +0000 (UTC)
Received: from starship (unknown [10.35.206.176])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 535E819C71;
 Wed, 17 Jun 2020 11:48:00 +0000 (UTC)
Message-ID: <f7ed95589e7636eabb3997ae5f7546d7b3cb261a.camel@redhat.com>
Subject: Re: [PATCH 2/2] iotests: filter few more luks specific create options
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Wed, 17 Jun 2020 14:47:59 +0300
In-Reply-To: <20200616131756.1073438-3-mreitz@redhat.com>
References: <20200616131756.1073438-1-mreitz@redhat.com>
 <20200616131756.1073438-3-mreitz@redhat.com>
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-06-16 at 15:17 +0200, Max Reitz wrote:
> From: Maxim Levitsky <mlevitsk@redhat.com>
> 
> This allows more tests to be able to have same output on both qcow2 luks encrypted images
> and raw luks images
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/087.out       | 6 +++---
>  tests/qemu-iotests/134.out       | 2 +-
>  tests/qemu-iotests/158.out       | 4 ++--
>  tests/qemu-iotests/188.out       | 2 +-
>  tests/qemu-iotests/189.out       | 4 ++--
>  tests/qemu-iotests/198.out       | 4 ++--
>  tests/qemu-iotests/263.out       | 4 ++--
>  tests/qemu-iotests/284.out       | 6 +++---
>  tests/qemu-iotests/common.filter | 5 +----
>  9 files changed, 17 insertions(+), 20 deletions(-)
> 
> diff --git a/tests/qemu-iotests/087.out b/tests/qemu-iotests/087.out
> index 2d92ea847b..b61ba638af 100644
> --- a/tests/qemu-iotests/087.out
> +++ b/tests/qemu-iotests/087.out
> @@ -34,7 +34,7 @@ QMP_VERSION
>  
>  === Encrypted image QCow ===
>  
> -Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encryption=on encrypt.key-secret=sec0
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encryption=on
>  Testing:
>  QMP_VERSION
>  {"return": {}}
> @@ -46,7 +46,7 @@ QMP_VERSION
>  
>  === Encrypted image LUKS ===
>  
> -Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encrypt.format=luks encrypt.key-secret=sec0
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
>  Testing:
>  QMP_VERSION
>  {"return": {}}
> @@ -58,7 +58,7 @@ QMP_VERSION
>  
>  === Missing driver ===
>  
> -Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encryption=on encrypt.key-secret=sec0
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encryption=on
>  Testing: -S
>  QMP_VERSION
>  {"return": {}}
> diff --git a/tests/qemu-iotests/134.out b/tests/qemu-iotests/134.out
> index 09d46f6b17..4abc5b5f7d 100644
> --- a/tests/qemu-iotests/134.out
> +++ b/tests/qemu-iotests/134.out
> @@ -1,5 +1,5 @@
>  QA output created by 134
> -Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encryption=on encrypt.key-secret=sec0
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encryption=on
>  
>  == reading whole image ==
>  read 134217728/134217728 bytes at offset 0
> diff --git a/tests/qemu-iotests/158.out b/tests/qemu-iotests/158.out
> index 6def216e55..f28a17626b 100644
> --- a/tests/qemu-iotests/158.out
> +++ b/tests/qemu-iotests/158.out
> @@ -1,6 +1,6 @@
>  QA output created by 158
>  == create base ==
> -Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728 encryption=on encrypt.key-secret=sec0
> +Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728 encryption=on
>  
>  == writing whole image ==
>  wrote 134217728/134217728 bytes at offset 0
> @@ -10,7 +10,7 @@ wrote 134217728/134217728 bytes at offset 0
>  read 134217728/134217728 bytes at offset 0
>  128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  == create overlay ==
> -Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base encryption=on encrypt.key-secret=sec0
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base encryption=on
>  
>  == writing part of a cluster ==
>  wrote 1024/1024 bytes at offset 0
> diff --git a/tests/qemu-iotests/188.out b/tests/qemu-iotests/188.out
> index c568ef3701..5426861b18 100644
> --- a/tests/qemu-iotests/188.out
> +++ b/tests/qemu-iotests/188.out
> @@ -1,5 +1,5 @@
>  QA output created by 188
> -Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=16777216 encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=16777216
>  
>  == reading whole image ==
>  read 16777216/16777216 bytes at offset 0
> diff --git a/tests/qemu-iotests/189.out b/tests/qemu-iotests/189.out
> index a0b7c9c24c..bc213cbe14 100644
> --- a/tests/qemu-iotests/189.out
> +++ b/tests/qemu-iotests/189.out
> @@ -1,6 +1,6 @@
>  QA output created by 189
>  == create base ==
> -Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=16777216 encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10
> +Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=16777216
>  
>  == writing whole image ==
>  wrote 16777216/16777216 bytes at offset 0
> @@ -10,7 +10,7 @@ wrote 16777216/16777216 bytes at offset 0
>  read 16777216/16777216 bytes at offset 0
>  16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  == create overlay ==
> -Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=16777216 backing_file=TEST_DIR/t.IMGFMT.base encrypt.format=luks encrypt.key-secret=sec1 encrypt.iter-time=10
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=16777216 backing_file=TEST_DIR/t.IMGFMT.base
>  
>  == writing part of a cluster ==
>  wrote 1024/1024 bytes at offset 0
> diff --git a/tests/qemu-iotests/198.out b/tests/qemu-iotests/198.out
> index 6280ae6eed..4b800e70db 100644
> --- a/tests/qemu-iotests/198.out
> +++ b/tests/qemu-iotests/198.out
> @@ -1,12 +1,12 @@
>  QA output created by 198
>  == create base ==
> -Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=16777216 encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10
> +Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=16777216
>  
>  == writing whole image base ==
>  wrote 16777216/16777216 bytes at offset 0
>  16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  == create overlay ==
> -Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=16777216 backing_file=TEST_DIR/t.IMGFMT.base encrypt.format=luks encrypt.key-secret=sec1 encrypt.iter-time=10
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=16777216 backing_file=TEST_DIR/t.IMGFMT.base
>  
>  == writing whole image layer ==
>  wrote 16777216/16777216 bytes at offset 0
> diff --git a/tests/qemu-iotests/263.out b/tests/qemu-iotests/263.out
> index 0c982c55cb..54bfbeeff8 100644
> --- a/tests/qemu-iotests/263.out
> +++ b/tests/qemu-iotests/263.out
> @@ -2,7 +2,7 @@ QA output created by 263
>  
>  testing LUKS qcow2 encryption
>  
> -Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
>  == reading the whole image ==
>  read 1048576/1048576 bytes at offset 0
>  1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> @@ -21,7 +21,7 @@ read 982528/982528 bytes at offset 66048
>  
>  testing legacy AES qcow2 encryption
>  
> -Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 encrypt.format=aes encrypt.key-secret=sec0
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
>  == reading the whole image ==
>  read 1048576/1048576 bytes at offset 0
>  1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> diff --git a/tests/qemu-iotests/284.out b/tests/qemu-iotests/284.out
> index 48216f5742..a929239302 100644
> --- a/tests/qemu-iotests/284.out
> +++ b/tests/qemu-iotests/284.out
> @@ -2,7 +2,7 @@ QA output created by 284
>  
>  testing LUKS qcow2 encryption
>  
> -Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
>  
>  == cluster size 512
>  == checking image refcounts ==
> @@ -21,7 +21,7 @@ wrote 1/1 bytes at offset 512
>  
>  == rechecking image refcounts ==
>  No errors were found on the image.
> -Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
>  
>  == cluster size 2048
>  == checking image refcounts ==
> @@ -40,7 +40,7 @@ wrote 1/1 bytes at offset 2048
>  
>  == rechecking image refcounts ==
>  No errors were found on the image.
> -Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
>  
>  == cluster size 32768
>  == checking image refcounts ==
> diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
> index f104ad7a9b..9ae7ac9891 100644
> --- a/tests/qemu-iotests/common.filter
> +++ b/tests/qemu-iotests/common.filter
> @@ -182,16 +182,13 @@ _filter_img_create()
>          echo "$options" \
>          | tr '\n' '\0' \
>          | sed -e 's/\x0$//' -e 's/ \([a-z0-9_.-]*\)=/\n\1=/g' \
> -        | grep -ae "^\(fmt\\|size\\|backing\\|preallocation\\|encrypt$grep_data_file\\)" \
> +        | grep -ae "^\(fmt\\|size\\|backing\\|preallocation\\|encryption$grep_data_file\\)" \
>          | $SED "${filename_filters[@]}" \
>              -e 's/^\(fmt\)/0-\1/' \
>              -e 's/^\(size\)/1-\1/' \
>              -e 's/^\(backing\)/2-\1/' \
>              -e 's/^\(data_file\)/3-\1/' \
>              -e 's/^\(encryption\)/4-\1/' \
> -            -e 's/^\(encrypt\.format\)/5-\1/' \
> -            -e 's/^\(encrypt\.key-secret\)/6-\1/' \
> -            -e 's/^\(encrypt\.iter-time\)/7-\1/' \
>              -e 's/^\(preallocation\)/8-\1/' \
>          | sort \
>          | $SED -e 's/^[0-9]-//' \
Looks OK to me,

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky



