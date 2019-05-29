Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9A8C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 19:06:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF54024074
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 19:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mwyo64ON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF54024074
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59392 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hW3uO-0005Hz-Ty
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 15:06:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hW3tV-0004ja-5Z
	for qemu-devel@nongnu.org; Wed, 29 May 2019 15:05:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hW3tQ-0002J9-Rg
	for qemu-devel@nongnu.org; Wed, 29 May 2019 15:05:46 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hW3tP-0002H5-EB
	for qemu-devel@nongnu.org; Wed, 29 May 2019 15:05:44 -0400
Received: by mail-wr1-x442.google.com with SMTP id d18so2532374wrs.5
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 12:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=/INWBvRAbON2Xu2bC4ULLlad/s+TH1wrKFChs6/1vx0=;
	b=Mwyo64ON8z8Smfsa5cZTZaqw9DTyylnfRDCE/RYN12+4SfNw2n6LUHIzKA6ZbjXY/M
	tEazVbgFLMsJaK8VgAvGswfgMAduzb+tJ8xd3bfaWPwt44E8FByGNKQ3bLi3BjReWb+j
	bd3KjKoEfjlTnwcyyBYoEbd5ZlVn0Yybuo/hfXmgMF1XVZLx8HVuahJVUegk38HAIqUM
	326y5MqgH6q8B2PSGX/HF+/1QyvbLURyMIwGTXdIpXWeTQp5PqZ0jucO82qQlC32/ka1
	eSR/C0efDhqwSCj3iV0T/14sfAfRWITVgaCqJPD1iQxjGkpZyCUNc6oq4dtwz9HKAMxv
	L2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=/INWBvRAbON2Xu2bC4ULLlad/s+TH1wrKFChs6/1vx0=;
	b=VnlvgoqgZkOSL9gWQ5HIpsO1n0/JGuVDdZcNvEZnMEi5ENoWbo+5lW41DL9XWi9+Zb
	Skp2EhH5q7gQ8WT+AKQosNNSZbyd0BDSdWNyMa/Esrmug/IQ9aGPvjqPvNj3QIMCYQwL
	D1Pr6V+K1UyoP51nf2PxmfpEkxIPvg8Mxz8e2ecDOg0MMVDvfhK2XZUMdgZjfOTSae84
	jAIMMu4qSIwbpmGYavnnlel6hafv9C6LZfvKxiaSqIt0L+IUOoyz8uiZb4EP87fetm0P
	Uo13dYG3N6hzmHEiGcTEhZR4/ghimvYQRamgkj5W5jEJx99zgYla2N9iC6EvdiV/EIuX
	dK4w==
X-Gm-Message-State: APjAAAW0ty2UGqzuHdLpOzYhj+uK7e27tKWi8obSjCP7twXeMXpTQH35
	1Fwew7rsdb+WQTglLkI4ySOWgQ==
X-Google-Smtp-Source: APXvYqxUFquO8beZpdV/v88PBh6qfo567odzRQqYvOEw73+ptfYqXP8OLeqq7GAD5dMKxAFcIbBHqw==
X-Received: by 2002:adf:a749:: with SMTP id e9mr14851840wrd.64.1559156738301; 
	Wed, 29 May 2019 12:05:38 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id f10sm712635wrg.24.2019.05.29.12.05.36
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 29 May 2019 12:05:37 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 3653A1FF87;
	Wed, 29 May 2019 20:05:36 +0100 (BST)
References: <20190329210804.22121-1-wainersm@redhat.com>
	<20190329210804.22121-4-wainersm@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
In-reply-to: <20190329210804.22121-4-wainersm@redhat.com>
Date: Wed, 29 May 2019 20:05:36 +0100
Message-ID: <87a7f55ben.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH 3/5] tests/vm: Detect the image changed on
 server
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, peter.maydell@linaro.org, berrange@redhat.com,
	lersek@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
	philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Wainer dos Santos Moschetta <wainersm@redhat.com> writes:

> The current implementation of basevm does not check if the image
> file to be downloaded has changed on server side before honouring
> the cache. So any change on server-side file can go unnoticed,
> keeping the cached image.
>
> This change implements a simple mechanism to detect the image
> file changed by using the sha256sum file stored on server. It
> compares with the expected checksum and then abort the execution
> on mismatch.
>
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>  tests/vm/basevm.py | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 083befce9f..4dfad2dc9b 100755
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -27,6 +27,7 @@ import tempfile
>  import shutil
>  import multiprocessing
>  import traceback
> +import urllib.request
>
>  SSH_KEY =3D open(os.path.join(os.path.dirname(__file__),
>                 "..", "keys", "id_rsa")).read()
> @@ -81,6 +82,18 @@ class BaseVM(object):
>          self._data_args =3D []
>
>      def _download_with_cache(self, url, sha256sum=3DNone):
> +
> +        def fetch_image_hash(url):
> +            fetch_url =3D "%s.sha256sum" % url

OK this fails with the FreeBSD code as they use the form:

  https://download.freebsd.org/ftp/releases/ISO-IMAGES/12.0/CHECKSUM.SHA256=
-FreeBSD-12.0-RELEASE-amd64

I guess we need to have a method that can be overridden for this.

> +            try:
> +                with urllib.request.urlopen(fetch_url) as response:
> +                    content =3D response.read()
> +            except  urllib.error.URLError as error:
> +                logging.error("Failed to fetch image checksum file: %s",
> +                        fetch_url)
> +                raise error
> +            return content.decode().strip()
> +
>          def check_sha256sum(fname):
>              if not sha256sum:
>                  return True
> @@ -91,8 +104,24 @@ class BaseVM(object):
>          if not os.path.exists(cache_dir):
>              os.makedirs(cache_dir)
>          fname =3D os.path.join(cache_dir, hashlib.sha1(url.encode()).hex=
digest())
> -        if os.path.exists(fname) and check_sha256sum(fname):
> +
> +        if os.path.exists(fname) and sha256sum is None:
>              return fname
> +
> +        if sha256sum:
> +            image_checksum =3D fetch_image_hash(url)
> +            # Check the url points to a known image file.
> +            if image_checksum !=3D sha256sum:
> +                logging.error("Image %s checksum (%s) does not match " +
> +                        "expected (%s).", url, image_checksum, sha256sum)
> +                raise Exception("Image checksum failed.")
> +            # Check the cached image is up to date.
> +            if os.path.exists(fname):
> +                if check_sha256sum(fname):
> +                    return fname
> +                logging.warning("Invalid cached image. Attempt to downlo=
ad " +
> +                        "the updated one.")
> +
>          logging.debug("Downloading %s to %s...", url, fname)
>          subprocess.check_call(["wget", "-c", url, "-O", fname + ".downlo=
ad"],
>                                stdout=3Dself._stdout, stderr=3Dself._stde=
rr)


--
Alex Benn=C3=A9e

