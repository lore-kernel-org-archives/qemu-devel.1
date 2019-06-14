Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B590EC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:45:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 894AE2133D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 894AE2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52242 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbnSg-0005cA-RM
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 10:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58341)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbn0s-0007fw-Ib
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:17:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbn0q-00088L-Fy
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:17:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51492)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hbn0q-00087b-9T
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:17:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so2563339wma.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 07:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9f7dMOl+7Oct5Wiii17pc1u4GTDpX7aHmo1VOVPKsMI=;
 b=TjBbA9H4lSp6wzm2cIRXoo/GF4SAP4dZVX+2VBVLp47Uqwn4ewXfESijOeX8qfq72v
 o+q3qUvzjlayHGAzK4EWT5VS34L2b+GOhcvIO8LuHD4aG07knOncsDY8Dbjo6IgZTk8c
 iYk8Ohc6MfmK+3Y0R8TNtsnOQ4AXYARfYr9m8Rp3+vewOA0qGIvS4+uLTm2k3PRdIf4t
 6qvaz5E5uX5Gc94eMNPlqtx/WHzCEx9HVIvn7ofq6IGXluBp2U01VkJg7Uv2ZWtGJK/v
 SSCX+GUeS6OvsBt/axSy9OB5qUphRxfz1C+W69BsSfvWKIvk3AHoCpOmntnt13+9AWno
 ruOQ==
X-Gm-Message-State: APjAAAUEcHgH1gVfiNezUpJz7LwugioZ+1Z0uvSxNBNtqF3CePOLQd2N
 ZFcK31TXhsqcfPCWbwbEHuR/9g==
X-Google-Smtp-Source: APXvYqySCbX5hhuvjkqsHe9dw+WvKwwR5oA1j9nsM60XqqXn7it4U3dK67HdKTKy8qauG7DZMTRbqg==
X-Received: by 2002:a1c:730d:: with SMTP id d13mr7958224wmb.88.1560521822542; 
 Fri, 14 Jun 2019 07:17:02 -0700 (PDT)
Received: from [192.168.1.103] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id a2sm4269234wmj.9.2019.06.14.07.17.01
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Jun 2019 07:17:02 -0700 (PDT)
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20190607152223.9467-1-crosa@redhat.com>
 <20190607152223.9467-3-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <815afba4-b00d-6186-2119-56035c427cf1@redhat.com>
Date: Fri, 14 Jun 2019 16:17:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190607152223.9467-3-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH 2/8] tests/requirements.txt: pin paramiko
 version requirement
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/7/19 5:22 PM, Cleber Rosa wrote:
> It's a good practice (I'd really say a must) to pin as much as
> possible of the software versions used during test, so let's apply
> that to paramiko.
> 
> According to https://pypi.org/project/paramiko/, 2.4.2 is the latest
> released version.  It's also easily obtainable on systems such as
> Fedora 30.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/requirements.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/requirements.txt b/tests/requirements.txt
> index 3ae0e29ad7..bd1f7590ed 100644
> --- a/tests/requirements.txt
> +++ b/tests/requirements.txt
> @@ -2,4 +2,4 @@
>  # in the tests/venv Python virtual environment. For more info,
>  # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
>  avocado-framework==68.0
> -paramiko
> +paramiko==2.4.2
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

