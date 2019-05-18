Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932A4C04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 22:19:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57F2420848
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 22:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F2420848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39240 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS7g5-0004Pc-MG
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 18:19:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hS7f8-00046i-8e
	for qemu-devel@nongnu.org; Sat, 18 May 2019 18:18:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hS7f5-0007TP-NA
	for qemu-devel@nongnu.org; Sat, 18 May 2019 18:18:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hS7f3-0007RA-3o
	for qemu-devel@nongnu.org; Sat, 18 May 2019 18:18:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id r4so10538797wro.10
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 15:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=cZWg/59P+t4hOhNeKFF0YRay969EAq3ZDtyXlYpEBTU=;
	b=s6vCtDmcHNA3T3bYS+x1YKPTFtt66Ex2bLZKwtYu4y9VsTVTRUpfLOHGxtck11nCH8
	4JAvDDJBmXCmYVwss9XGrtvSajpreOjIeBRtqpnqEwzq8v+a2mblii7E60JzWPcdqtMC
	1uzrXtC8UShNIcidp/l1436AcguAmChDINJJJIesZhFRVNVCQaNCpppPDg8DNECQb/Kf
	W8IE7RllQK8piWtuUD8KLTTg4JxrxIFGlnQ+LYchGyUHNSak6wqSercLFpSmujjyAk1C
	X2Zu6Gmmq688TAetwDJ4WFNuzueu99LhyVZBHclb3a3PlJM5Gjme3zuSPJPAiunqwuP9
	W87w==
X-Gm-Message-State: APjAAAXhGklMV4OATG0Y8k2gIvE/YX/+oxrG3L2xGDOJTmlFBJpmraxe
	XIGnkJqOszWXX0/GodNUGNHujA==
X-Google-Smtp-Source: APXvYqyNh9F8WrsP27Kuu4MKBKnRz8Yg2jni1IITdPdzhb6YqZinlroCGfnIhgy7xbh6ER4P68bxrA==
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr27684445wrp.175.1558217916058; 
	Sat, 18 May 2019 15:18:36 -0700 (PDT)
Received: from [192.168.1.38] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	t13sm26244844wra.81.2019.05.18.15.18.35
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 15:18:35 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190510104633.9428-1-kraxel@redhat.com>
	<20190510104633.9428-14-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <cd10fa30-5849-8511-897e-540d3c4bdd3b@redhat.com>
Date: Sun, 19 May 2019 00:18:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510104633.9428-14-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v2 13/13] tests/vm: ubuntu.i386: apt proxy
 setup
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

On 5/10/19 12:46 PM, Gerd Hoffmann wrote:
> Configure apt proxy so package downloads
> can be cached and can pass firewalls.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  tests/vm/ubuntu.i386 | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
> index a22d137e76df..b869afd212fa 100755
> --- a/tests/vm/ubuntu.i386
> +++ b/tests/vm/ubuntu.i386
> @@ -51,6 +51,10 @@ class UbuntuX86VM(basevm.BaseVM):
>                            "    ssh-authorized-keys:\n",
>                            "    - %s\n" % basevm.SSH_PUB_KEY,
>                            "locale: en_US.UTF-8\n"])
> +        proxy = os.environ.get("http_proxy")
> +        if not proxy is None:
> +            udata.writelines(["apt:\n",
> +                              "  proxy: %s" % proxy])
>          udata.close()
>          subprocess.check_call(["genisoimage", "-output", "cloud-init.iso",
>                                 "-volid", "cidata", "-joliet", "-rock",
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

