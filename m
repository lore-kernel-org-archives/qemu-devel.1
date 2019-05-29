Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DACC28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 11:35:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D04920B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 11:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D04920B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52123 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVwrO-0000hs-K4
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 07:35:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVwph-0008CJ-G7
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:33:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVwpd-0004U6-NZ
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:33:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hVwpd-0004SY-F5
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:33:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id x4so1510555wrt.6
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 04:33:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=mGIuQOqfzcGfov1TxNeYB2SdMwWS4JQoUuv/DQAtIDw=;
	b=seld44WoQGh/Log4TrS8qQt2lUxe1GFleMc9sLwWFpnrSby6REqkC63RcGOxRpWAFt
	C5XyKk+kV6mjzH0AMDVsjgQeV2OjiuLr7wuFc+gLRzyrGQluc60vUTcVXt/uqj+/wLNQ
	tSQxq0vYsbv+zPvNTi2FZ/iXR1WK/V76oyABnu07pidvx00EE8qDjtAxPXaQ0g2RUgNb
	kaithxz1jFmYaq5BVpDFWtbBMNRdNtV0z9jSL6cCOMPmlWiUAZlD0ua2cpm9V7Fz9A49
	3WFED+Hbo4mSvQzBPByW5dccwJobxyXZ3QVgjrQKvoUAnAs43SWEqzlWEjFnzTovtSjt
	tltg==
X-Gm-Message-State: APjAAAVFwSCwLIVgbVPuzs0iUiIyvATqctpA+IJNXa0QRjSqKl1UTAFa
	JEsnlWyza3dLNZYekDiOMUp7awCsZOE=
X-Google-Smtp-Source: APXvYqycg2JuSVnoGIgMOokVIKVE2PGc3sSgNTvnvrePvu7IpcsJmvIf+O6AjFFfhWS62dldQRrWBA==
X-Received: by 2002:adf:feca:: with SMTP id q10mr5476369wrs.308.1559129599148; 
	Wed, 29 May 2019 04:33:19 -0700 (PDT)
Received: from [10.32.224.40] (red-hat-inc.vlan560.asr1.mad1.gblx.net.
	[159.63.51.90]) by smtp.gmail.com with ESMTPSA id
	f18sm2287501wrt.21.2019.05.29.04.33.17
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 29 May 2019 04:33:18 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190520124716.30472-1-kraxel@redhat.com>
	<20190520124716.30472-3-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a77c28f4-ac7a-6363-0099-413414b37068@redhat.com>
Date: Wed, 29 May 2019 13:33:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520124716.30472-3-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v3 02/14] tests/vm: python3 fixes
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
	Kamil Rytarowski <kamil@netbsd.org>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/19 2:47 PM, Gerd Hoffmann wrote:
> Add proper unicode handling when processing strings.
> Also need to explicitly say we want int not float.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  tests/vm/basevm.py | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 0556bdcf9e9f..3126fb10a819 100755
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -73,7 +73,7 @@ class BaseVM(object):
>              "-vnc", "127.0.0.1:0,to=20",
>              "-serial", "file:%s" % os.path.join(self._tmpdir, "serial.out")]
>          if vcpus and vcpus > 1:
> -            self._args += ["-smp", str(vcpus)]
> +            self._args += ["-smp", "%d" % vcpus]
>          if kvm_available(self.arch):
>              self._args += ["-enable-kvm"]
>          else:
> @@ -85,12 +85,12 @@ class BaseVM(object):
>              if not sha256sum:
>                  return True
>              checksum = subprocess.check_output(["sha256sum", fname]).split()[0]
> -            return sha256sum == checksum
> +            return sha256sum == checksum.decode("utf-8")
>  
>          cache_dir = os.path.expanduser("~/.cache/qemu-vm/download")
>          if not os.path.exists(cache_dir):
>              os.makedirs(cache_dir)
> -        fname = os.path.join(cache_dir, hashlib.sha1(url).hexdigest())
> +        fname = os.path.join(cache_dir, hashlib.sha1(url.encode("utf-8")).hexdigest())
>          if os.path.exists(fname) and check_sha256sum(fname):
>              return fname
>          logging.debug("Downloading %s to %s...", url, fname)
> @@ -134,7 +134,7 @@ class BaseVM(object):
>          raise NotImplementedError
>  
>      def add_source_dir(self, src_dir):
> -        name = "data-" + hashlib.sha1(src_dir).hexdigest()[:5]
> +        name = "data-" + hashlib.sha1(src_dir.encode("utf-8")).hexdigest()[:5]
>          tarfile = os.path.join(self._tmpdir, name + ".tar")
>          logging.debug("Creating archive %s for src_dir dir: %s", tarfile, src_dir)
>          subprocess.check_call(["./scripts/archive-source.sh", tarfile],
> @@ -256,7 +256,7 @@ def main(vmcls):
>              vm.add_source_dir(args.build_qemu)
>              cmd = [vm.BUILD_SCRIPT.format(
>                     configure_opts = " ".join(argv),
> -                   jobs=args.jobs,
> +                   jobs=int(args.jobs),
>                     target=args.build_target,
>                     verbose = "V=1" if args.verbose else "")]
>          else:
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

