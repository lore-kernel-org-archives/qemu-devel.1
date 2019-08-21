Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E096C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 23:02:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4224C22CF7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 23:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4224C22CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Zck-0001Vv-BU
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 19:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nsoffer@redhat.com>) id 1i0Zbc-0000s9-W3
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 19:01:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nsoffer@redhat.com>) id 1i0Zba-0002k7-U7
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 19:01:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53792)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1i0Zba-0002ih-MK
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 19:01:26 -0400
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9FA9981DEB
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 23:01:23 +0000 (UTC)
Received: by mail-ot1-f71.google.com with SMTP id k70so2084587otk.6
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 16:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=utdTuOANsYp6akr6TuptOY3FFvw9I5EJ6kUkl0/s8cQ=;
 b=arh6Z9byKQWQ3dupHrvmvplVwHDtpAr4/U/sFqa37c7YTwBXB6B00AN+pdbxlkg1eA
 picu5EPf04MveFqz+y+V/qO960nkCOYF4U6X+ZIAtHmY4JFGysYnDU56oySlGDG6NqYP
 RfzbR7GJlNBmhxG4TfjZv1dX3j7FkzLXClQ5n5XmhVE7Bf0BwFofZqoW2XtCNGcFZyJF
 lpCteQv/uLfVYyaAFDAcnn+c72Cqnj80r/WTnlIk2bcIbnlWYnIWYXm/eiK5C+jtBFyT
 If3NozjKWngXa68A8h8yZDDJjih342AC+59yiANKYr0tFmwcDfJ378NKS5becKeAW2S9
 1iDg==
X-Gm-Message-State: APjAAAXIgLSFfWJpYgaF9f6Nd9T3e1w9/Ps5xR//vaLVupRiXhw9zbgn
 YvOZrR3LvYLKPuBX+rIRSp51v4Z/n+ei/k3YS8KAlqJyJTShIAFpcYftpWZ+GqRcCBxVwmoSA5q
 Qd6HXSaXRq0vyLI39V7NUhJ/NaWEwCv8=
X-Received: by 2002:a05:6830:2018:: with SMTP id
 e24mr10810897otp.315.1566428483084; 
 Wed, 21 Aug 2019 16:01:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxQ6/2ZpsECOvDoS+Rpyh8thsu/rulr0jnGvych24WDB5EtbpcXv7ihHMDZ5WP2uQ2b4QaQIIU8ZE3y8G73nS0=
X-Received: by 2002:a05:6830:2018:: with SMTP id
 e24mr10810850otp.315.1566428482626; 
 Wed, 21 Aug 2019 16:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-6-mlevitsk@redhat.com>
In-Reply-To: <20190814202219.1870-6-mlevitsk@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Thu, 22 Aug 2019 02:01:09 +0300
Message-ID: <CAMRbyyvaOPSD0jxxFzkpnjEWyeNpbbU3r+2U+RKE=4x_1RteOw@mail.gmail.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 05/13] qcrypto-luks: clear the
 masterkey and password before freeing them always
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 14, 2019, 23:23 Maxim Levitsky <mlevitsk@redhat.com> wrote:

> While there are other places where these are still stored in memory,
> this is still one less key material area that can be sniffed with
> various side channel attacks
>
>
>
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  crypto/block-luks.c | 52 ++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 44 insertions(+), 8 deletions(-)
>
> diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> index e1a4df94b7..336e633df4 100644
> --- a/crypto/block-luks.c
> +++ b/crypto/block-luks.c
> @@ -1023,8 +1023,18 @@ qcrypto_block_luks_load_key(QCryptoBlock *block,
>   cleanup:
>      qcrypto_ivgen_free(ivgen);
>      qcrypto_cipher_free(cipher);
> -    g_free(splitkey);
> -    g_free(possiblekey);
> +
> +    if (splitkey) {
> +        memset(splitkey, 0, splitkeylen);
>

I think we need memset_s() or similar replacement, see

https://www.cryptologie.net/article/419/zeroing-memory-compiler-optimizations-and-memset_s/

+        g_free(splitkey);
> +    }
> +
> +    if (possiblekey) {
> +        memset(possiblekey, 0, masterkeylen(luks));
> +        g_free(possiblekey);
> +
> +    }
> +
>      return ret;
>  }
>
> @@ -1161,16 +1171,34 @@ qcrypto_block_luks_open(QCryptoBlock *block,
>      block->sector_size = QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
>      block->payload_offset = luks->header.payload_offset *
> block->sector_size;
>
> -    g_free(masterkey);
> -    g_free(password);
> +    if (masterkey) {
> +        memset(masterkey, 0, masterkeylen(luks));
> +        g_free(masterkey);
> +    }
> +
> +    if (password) {
> +        memset(password, 0, strlen(password));
> +        g_free(password);
> +    }
> +
>      return 0;
>
>   fail:
> -    g_free(masterkey);
> +
> +    if (masterkey) {
> +        memset(masterkey, 0, masterkeylen(luks));
> +        g_free(masterkey);
> +    }
> +
> +    if (password) {
> +        memset(password, 0, strlen(password));
> +        g_free(password);
> +    }
> +
>      qcrypto_block_free_cipher(block);
>      qcrypto_ivgen_free(block->ivgen);
> +
>      g_free(luks);
> -    g_free(password);
>      return ret;
>  }
>
> @@ -1459,7 +1487,10 @@ qcrypto_block_luks_create(QCryptoBlock *block,
>
>      memset(masterkey, 0, luks->header.key_bytes);
>      g_free(masterkey);
> +
> +    memset(password, 0, strlen(password));
>      g_free(password);
> +
>      g_free(cipher_mode_spec);
>
>      return 0;
> @@ -1467,9 +1498,14 @@ qcrypto_block_luks_create(QCryptoBlock *block,
>   error:
>      if (masterkey) {
>          memset(masterkey, 0, luks->header.key_bytes);
> +        g_free(masterkey);
>      }
> -    g_free(masterkey);
> -    g_free(password);
> +
> +    if (password) {
> +        memset(password, 0, strlen(password));
> +        g_free(password);
> +    }
> +
>      g_free(cipher_mode_spec);
>
>      qcrypto_block_free_cipher(block);
> --
> 2.17.2
>
>
>
