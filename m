Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA72C3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 22:42:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9C5720874
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 22:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C5720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i21De-000595-Vd
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 18:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nsoffer@redhat.com>) id 1i21Cl-0004dR-PY
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 18:41:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nsoffer@redhat.com>) id 1i21Cj-00059n-RN
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 18:41:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60554)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1i21Cj-00059H-JE
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 18:41:45 -0400
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AB9644E924
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 22:41:44 +0000 (UTC)
Received: by mail-ot1-f71.google.com with SMTP id c1so9132830otb.22
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 15:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DNngUipcs3GdQZaPHnj65qLdCql6atYI42AGYOnVIWA=;
 b=CmY3EtQNlUcYEKjnnYo4ANUYnZ+nXBOL+ixxGKrAwrPeaGg4Tmmutwirxnl8Ovorn1
 OAVnu00FhnZPvaZxBwzJZ8G87qKhiqD530ETMsZLzNZ36vvJPhwH3H7dRRDR+wkEXlEx
 srZL7RMKsE6hAqahu6ccYbzD9oN9q25UdPQJnZAEBWm/IREXHDnN11Ny8Pk+9b7Dv19L
 qdMRSWy8iEeGjM7xuff/wtFFxpYPWO1QuQQx7Vim+FxCKOQRvALzN2uMEwACJoQt78n/
 gjWLRDnGX7MpSCGG0idWR6ljfEvQgAaifWd/ZvB25oc6/rNH9/P2WAt2qa2iRuF/4a8i
 ZVyg==
X-Gm-Message-State: APjAAAUvtdSVf+ycSLG9c9dBUn6a2R+G/MOwNnSZooFN444HAroCt/dS
 c6PGbq+90LwMDIyOFyRjBj+u3IqfzjIZp/jEWAWKfVczSBNnylulF8F7WdhH3SphBuNDitndgbw
 A4OPT94I6wgNw12/9wqQQR2lcowykEmo=
X-Received: by 2002:aca:1714:: with SMTP id j20mr9604581oii.135.1566772904082; 
 Sun, 25 Aug 2019 15:41:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxcF8u4Pmuak7hbw9YRQKEJk6UuqyBKAbzt0ofi6o+dc/o6iqGmdxpg8OxCApOVR3OApEuNaM1sms0ICA7phP0=
X-Received: by 2002:aca:1714:: with SMTP id j20mr9604576oii.135.1566772903737; 
 Sun, 25 Aug 2019 15:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190825220329.7942-1-nsoffer@redhat.com>
 <20190825220329.7942-3-nsoffer@redhat.com>
In-Reply-To: <20190825220329.7942-3-nsoffer@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Mon, 26 Aug 2019 01:41:32 +0300
Message-ID: <CAMRbyysOt2PDxvd4=mfs58sW+Hr7+pzzOjWVdzf_GREWT+8X5Q@mail.gmail.com>
To: Nir Soffer <nirsof@gmail.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v2 2/2] iotests: Test
 allocate_first_block() with O_DIRECT
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 26, 2019 at 1:03 AM Nir Soffer <nirsof@gmail.com> wrote:

> Using block_resize we can test allocate_first_block() with file
> descriptor opened with O_DIRECT, ensuring that it works for any size
> larger than 4096 bytes.
>
> Testing smaller sizes is tricky as the result depends on the filesystem
> used for testing. For example on NFS any size will work since O_DIRECT
> does not require any alignment.
>

Forgot to add:

Signed-off-by: Nir Soffer <nsoffer@redhat.com>

---
>  tests/qemu-iotests/175     | 25 +++++++++++++++++++++++++
>  tests/qemu-iotests/175.out |  8 ++++++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
> index d54cb43c39..60cc251eb2 100755
> --- a/tests/qemu-iotests/175
> +++ b/tests/qemu-iotests/175
> @@ -49,6 +49,23 @@ _filter_blocks()
>          -e "s/blocks=$((extra_blocks + img_size /
> 512))\\(\$\\|[^0-9]\\)/max allocation/"
>  }
>
> +# Resize image using block_resize.
> +# Parameter 1: image path
> +# Parameter 2: new size
> +_block_resize()
> +{
> +    local path=$1
> +    local size=$2
> +
> +    $QEMU -qmp stdio -nographic -nodefaults \
> +        -blockdev file,node-name=file,filename=$path,cache.direct=on \
> +        <<EOF
> +{'execute': 'qmp_capabilities'}
> +{'execute': 'block_resize', 'arguments': {'node-name': 'file', 'size':
> $size}}
> +{'execute': 'quit'}
> +EOF
> +}
> +
>  # get standard environment, filters and checks
>  . ./common.rc
>  . ./common.filter
> @@ -79,6 +96,14 @@ for mode in off full falloc; do
>      stat -c "size=%s, blocks=%b" $TEST_IMG | _filter_blocks $extra_blocks
> $min_blocks $size
>  done
>
> +for new_size in 4096 1048576; do
> +    echo
> +    echo "== resize empty image with block_resize =="
> +    _make_test_img 0 | _filter_imgfmt
> +    _block_resize $TEST_IMG $new_size >/dev/null
> +    stat -c "size=%s, blocks=%b" $TEST_IMG | _filter_blocks $extra_blocks
> $min_blocks $new_size
> +done
> +
>  # success, all done
>  echo "*** done"
>  rm -f $seq.full
> diff --git a/tests/qemu-iotests/175.out b/tests/qemu-iotests/175.out
> index 263e521262..39c2ee0f62 100644
> --- a/tests/qemu-iotests/175.out
> +++ b/tests/qemu-iotests/175.out
> @@ -15,4 +15,12 @@ size=1048576, max allocation
>  == creating image with preallocation falloc ==
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
> preallocation=falloc
>  size=1048576, max allocation
> +
> +== resize empty image with block_resize ==
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=0
> +size=4096, min allocation
> +
> +== resize empty image with block_resize ==
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=0
> +size=1048576, min allocation
>   *** done
> --
> 2.20.1
>
>
