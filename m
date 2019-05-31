Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E754C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 06:24:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 622622644C
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 06:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622622644C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37394 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWayG-0003lD-Hw
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 02:24:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hWawQ-0002PI-4b
	for qemu-devel@nongnu.org; Fri, 31 May 2019 02:23:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hWawP-0001Ve-4Q
	for qemu-devel@nongnu.org; Fri, 31 May 2019 02:23:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hWawO-0001Sq-UV
	for qemu-devel@nongnu.org; Fri, 31 May 2019 02:23:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id p11so811361wre.7
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 23:23:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=fiVwaMFiUt1KXWz8h3KU3OQ3J2VpcW5poGSSHluVA6E=;
	b=g9CKSCe5dBQzglE61hgmQeCACu+87cYVZq/92qDljaKU9vSJBnNVGfM8QK4Pto34S2
	5qPqkHe2A3htV7l3HonKFSfrKJxjuizALUhin5gVnYMkNjJWj6y2a5Vo3L9JkuCLYrBJ
	yEoJEDSZnCPOx86VhMXIonLnqdUNisPXfjv/opEurKPXM8oDXDxPlyC4D5A1j+DCBHw3
	mpvVOCIftRKLLZwGnJpq4r3maybEzoqUdRTfmyDyMcpSWPY/K6mA3og7ACjqkFrBOjrU
	kXte0EefZsXPL/bBqJkhsV8A1V8FNnLsiyUV57QZ2Cc0tQieudVxuI8saRmMX6L4J0V9
	S8eg==
X-Gm-Message-State: APjAAAU4FLBqtehKqBPEDgr5E51lY2eznnt6wmEYd2/j3hkHNa55Uf4G
	YaQGbVe/f8uhqoVgfbLYY5e2tQ==
X-Google-Smtp-Source: APXvYqz5t8Q8DfCcLZPNZMNP2zt2CllNcI2z9MGNj4jEJHBQs5oXq2vFpmVH8U6OaXqnej8eMYBa7w==
X-Received: by 2002:adf:f544:: with SMTP id j4mr1514392wrp.150.1559283779936; 
	Thu, 30 May 2019 23:22:59 -0700 (PDT)
Received: from [192.168.1.43] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183]) by smtp.gmail.com with ESMTPSA id
	h90sm14779287wrh.15.2019.05.30.23.22.58
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 30 May 2019 23:22:59 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190530101603.22254-1-alex.bennee@linaro.org>
	<20190530101603.22254-11-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <79bebb86-be5e-d313-ead3-70e517d60097@redhat.com>
Date: Fri, 31 May 2019 08:22:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190530101603.22254-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v1 10/26] tests/vm: Port basevm to Python 3
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
Cc: Fam Zheng <fam@euphon.net>,
	Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/30/19 12:15 PM, Alex Bennée wrote:
> From: Wainer dos Santos Moschetta <wainersm@redhat.com>
> 
> Fixed tests/vm/basevm.py to run with Python 3:
>  - hashlib.sha1() requires an binary encoded object.
>  - uses floor division ("//") (PEP 238).
>  - decode bytes to unicode when needed.
> 
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Message-Id: <20190329210804.22121-3-wainersm@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/vm/basevm.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 0556bdcf9e9..083befce9f5 100755
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -85,12 +85,12 @@ class BaseVM(object):
>              if not sha256sum:
>                  return True
>              checksum = subprocess.check_output(["sha256sum", fname]).split()[0]
> -            return sha256sum == checksum
> +            return sha256sum == checksum.decode()
>  
>          cache_dir = os.path.expanduser("~/.cache/qemu-vm/download")
>          if not os.path.exists(cache_dir):
>              os.makedirs(cache_dir)
> -        fname = os.path.join(cache_dir, hashlib.sha1(url).hexdigest())
> +        fname = os.path.join(cache_dir, hashlib.sha1(url.encode()).hexdigest())
>          if os.path.exists(fname) and check_sha256sum(fname):
>              return fname
>          logging.debug("Downloading %s to %s...", url, fname)
> @@ -134,7 +134,7 @@ class BaseVM(object):
>          raise NotImplementedError
>  
>      def add_source_dir(self, src_dir):
> -        name = "data-" + hashlib.sha1(src_dir).hexdigest()[:5]
> +        name = "data-" + hashlib.sha1(src_dir.encode()).hexdigest()[:5]
>          tarfile = os.path.join(self._tmpdir, name + ".tar")
>          logging.debug("Creating archive %s for src_dir dir: %s", tarfile, src_dir)
>          subprocess.check_call(["./scripts/archive-source.sh", tarfile],
> @@ -204,7 +204,7 @@ def parse_args(vmcls):
>  
>      def get_default_jobs():
>          if kvm_available(vmcls.arch):
> -            return multiprocessing.cpu_count() / 2
> +            return multiprocessing.cpu_count() // 2
>          else:
>              return 1
>  
> 

