Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0401CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 18:52:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2C6F2080F
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 18:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C6F2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRhSR-0001xT-0C
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 13:52:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47440)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iRhRE-0000yJ-ER
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:50:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iRhRD-0001HM-5U
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:50:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41902)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iRhRC-0001Gy-UE
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:50:51 -0500
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A187F3DD47
 for <qemu-devel@nongnu.org>; Mon,  4 Nov 2019 18:50:49 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id l3so2361022wrx.21
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 10:50:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KPhQaJQMP8yO1fvKpnP7jGFRAYNO9OB2BOs6o1XzbUY=;
 b=foqPtMx/YtZQehmtB8Fy754WbXr5EDQ+DXq4xoAjh1gykSPqss18UvP0zP1kdHUIcC
 A2EeNndjvgNnBKhWGPNA0HIQnAl1P8KfhkgA++V9tOfBVCEJhR6h418gafjSuRMs0kv5
 HZvzydHc0jtZSLam7Rjsv5x2vd/sPHMPD5sqWWW7E1+P2Pq1ClMde7sOeBSCCoswUjo0
 p+sjP94vnhWq6lwgwuqzrbL08URGQNUNKyEyVaZQGwsQqljW78TWh9NIBbLmeFCjws67
 jLtBPR5sh0XjhSY0pmnQyRrM5lHLC/E8uM2OzQAEAehj9/fY/xnkofs3Xthum2S1XMUp
 oqZw==
X-Gm-Message-State: APjAAAVqEUQU7HwPnLKYhx1NX6fj/RrDYqlw7v3Z4rskpR6HGC4mVY55
 AtFkBZiD019wp4/of7gCTvk8F4NawKHuR/Kule135wDzYbK2oFXwaUjrcFruLTCClo7t2pjD5GX
 LL/2u9i/Sku5hxZ4=
X-Received: by 2002:a5d:448a:: with SMTP id j10mr26138615wrq.79.1572893446389; 
 Mon, 04 Nov 2019 10:50:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqz5CyORBctv2tjo0B2xaWwvCYArmeV3au7HdgUxwGRu4NQuDngGl4WAbB17e3gtkCABnDo0xQ==
X-Received: by 2002:a5d:448a:: with SMTP id j10mr26138586wrq.79.1572893446207; 
 Mon, 04 Nov 2019 10:50:46 -0800 (PST)
Received: from [192.168.1.24] (lfbn-1-7864-228.w92-167.abo.wanadoo.fr.
 [92.167.33.228])
 by smtp.gmail.com with ESMTPSA id k125sm9463897wmf.2.2019.11.04.10.50.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2019 10:50:45 -0800 (PST)
Subject: Re: [PATCH v1 6/6] tests/vm: support sites with sha512 checksums
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191104173654.30125-1-alex.bennee@linaro.org>
 <20191104173654.30125-7-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <dd9bbe2b-4e51-30e3-9550-fe4f90f0214e@redhat.com>
Date: Mon, 4 Nov 2019 19:50:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191104173654.30125-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/4/19 6:36 PM, Alex Benn=C3=A9e wrote:
> The NetBSD project uses SHA512 for its checksums so lets support that
> in the download helper.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   tests/vm/basevm.py | 10 ++++++++--
>   tests/vm/netbsd    |  3 ++-
>   2 files changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 086bfb2c66d..91a9226026d 100755
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -95,19 +95,25 @@ class BaseVM(object):
>               logging.info("KVM not available, not using -enable-kvm")
>           self._data_args =3D []
>  =20
> -    def _download_with_cache(self, url, sha256sum=3DNone):
> +    def _download_with_cache(self, url, sha256sum=3DNone, sha512sum=3D=
None):
>           def check_sha256sum(fname):
>               if not sha256sum:
>                   return True
>               checksum =3D subprocess.check_output(["sha256sum", fname]=
).split()[0]
>               return sha256sum =3D=3D checksum.decode("utf-8")
>  =20
> +        def check_sha512sum(fname):
> +            if not sha512sum:
> +                return True
> +            checksum =3D subprocess.check_output(["sha512sum", fname])=
.split()[0]
> +            return sha512sum =3D=3D checksum.decode("utf-8")
> +
>           cache_dir =3D os.path.expanduser("~/.cache/qemu-vm/download")
>           if not os.path.exists(cache_dir):
>               os.makedirs(cache_dir)
>           fname =3D os.path.join(cache_dir,
>                                hashlib.sha1(url.encode("utf-8")).hexdig=
est())
> -        if os.path.exists(fname) and check_sha256sum(fname):
> +        if os.path.exists(fname) and check_sha256sum(fname) and check_=
sha512sum(fname):
>               return fname
>           logging.debug("Downloading %s to %s...", url, fname)
>           subprocess.check_call(["wget", "-c", url, "-O", fname + ".dow=
nload"],
> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> index 33779402dd1..89390e99fdd 100755
> --- a/tests/vm/netbsd
> +++ b/tests/vm/netbsd
> @@ -23,6 +23,7 @@ class NetBSDVM(basevm.BaseVM):
>       arch =3D "x86_64"
>  =20
>       link =3D "https://cdn.netbsd.org/pub/NetBSD/NetBSD-8.1/images/Net=
BSD-8.1-amd64.iso"
> +    csum =3D "718f275b7e0879599bdac95630c5e3f2184700032fdb6cdebf3bdd63=
687898c48ff3f08f57b89f4437a86cdd8ea07c01a39d432dbb37e1e4b008f4985f98da3f"
>       size =3D "20G"
>       pkgs =3D [
>           # tools
> @@ -70,7 +71,7 @@ class NetBSDVM(basevm.BaseVM):
>       ipv6 =3D False
>  =20
>       def build_image(self, img):
> -        cimg =3D self._download_with_cache(self.link)
> +        cimg =3D self._download_with_cache(self.link, sha512sum=3Dself=
.csum)
>           img_tmp =3D img + ".tmp"
>           iso =3D img + ".install.iso"
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

