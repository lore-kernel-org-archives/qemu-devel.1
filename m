Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA462C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:26:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C10B2081B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C10B2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqbtP-0000ge-JZ
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 07:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48733)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hqbtE-0000Es-CK
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:26:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hqbtD-00049V-Bs
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:26:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39073)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hqbtD-00049I-6F
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:26:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id u25so34035818wmc.4
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 04:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GGa0SYJM3x6rdIsh6xrK4vTnt8HECxs+n2dvLRg8CBg=;
 b=LidhFjsILNmryAbqP1xcn+EcGxYVKblWvudO87o3/OXI0THY/jh7wVbNkcNBIIoxXN
 5C4DP3VhO0Pmr7xZ5Pm7xEyoHQuWUG2537i5G9RzYLLLLgUGIhq5Dn8re4GZkRADimcz
 KN3KS9eobQW4uiNlU4Vq8cT4sQ1YUSFCEXPFKXAGIjsPfgDWQddmr3/vb2PXT5DWb6OW
 bIzMQ8c6aUXIRzrcLEJ3PhQrqZm8qeXRK/hsuqmNmUQQMzDHoadfk9guKxjVttOUzS94
 if7aenBq4WqA8z8fxmUmefnZMbLvs5EBTwqYRYGBjxshQwH1wbzCNvaNE4/SxGrXjNZU
 PKHA==
X-Gm-Message-State: APjAAAXnc/CnPFJ5jrRGLFEt94vn/z1zRg2/jD0VMAP8EjVDvtHzay32
 8oNlOTQT2ZuN2DiNx7DzNaMrEw==
X-Google-Smtp-Source: APXvYqwILf7kNN1PUfUtQaxgai/+chbNAg50xlDqF+wQy1HpvXu+X1pvk5M+kzL0XKXXywCmzkN2tQ==
X-Received: by 2002:a7b:c106:: with SMTP id w6mr83660844wmi.80.1564053985890; 
 Thu, 25 Jul 2019 04:26:25 -0700 (PDT)
Received: from [192.168.1.37] (190.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.190])
 by smtp.gmail.com with ESMTPSA id x129sm47110132wmg.44.2019.07.25.04.26.25
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jul 2019 04:26:25 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20190725095920.28419-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a18ddb0b-c340-a4cf-2710-d590932e0e25@redhat.com>
Date: Thu, 25 Jul 2019 13:26:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190725095920.28419-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH] block: fix NetBSD qemu-iotests failure
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
Cc: Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/25/19 11:59 AM, Paolo Bonzini wrote:
> Opening a block device on NetBSD has an additional step compared to other OSes,
> corresponding to raw_normalize_devicepath.  The error message in that function
> is slightly different from that in raw_open_common and this was causing spurious
> failures in qemu-iotests.  However, in general it is not important to know what
> exact step was failing, for example in the qemu-iotests case the error message
> contains the fairly unequivocal "No such file or directory" text from strerror.
> We can thus fix the failures by standardizing on a single error message for
> both raw_open_common and raw_normalize_devicepath; in fact, we can even
> use error_setg_file_open to make sure the error message is the same as in
> the rest of QEMU.
> 
> Tested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/file-posix.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 73a001ceb7..a2089b1f87 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -217,7 +217,7 @@ static int raw_normalize_devicepath(const char **filename, Error **errp)
>      fname = *filename;
>      dp = strrchr(fname, '/');
>      if (lstat(fname, &sb) < 0) {
> -        error_setg_errno(errp, errno, "%s: stat failed", fname);
> +        error_setg_file_open(errp, errno, fname);
>          return -errno;
>      }
>  
> @@ -547,7 +547,7 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
>      ret = fd < 0 ? -errno : 0;
>  
>      if (ret < 0) {
> -        error_setg_errno(errp, -ret, "Could not open '%s'", filename);
> +        error_setg_file_open(errp, -ret, filename);
>          if (ret == -EROFS) {
>              ret = -EACCES;
>          }
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Maybe other candidates:

$ git grep error_setg_errno.*open.*file
block.c:1303:            error_setg_errno(errp, -ret, "Could not open
'%s'", bs->filename);
block/file-posix.c:925:                error_setg_errno(errp, errno,
"Could not reopen file");
hw/core/loader.c:358:        error_setg_errno(errp, errno, "Failed to
open file: %s", filename);
net/dump.c:113:        error_setg_errno(errp, errno, "net dump: can't
open %s", filename);
qga/commands-posix.c:367:            error_setg_errno(&local_err, errno,
"failed to open file '%s' "
qga/commands-posix.c:2308:        error_setg_errno(errp, errno, "open
sysfs file \"%s\"", pathname);
qga/commands-posix.c:2329:        error_setg_errno(errp, errno, "open
sysfs file \"%s\"", pathname);
util/oslib-posix.c:107:            error_setg_errno(errp, errno, "Cannot
open pid file");
util/vfio-helpers.c:278:        error_setg_errno(errp, errno, "Failed to
open VFIO group file: %s",

