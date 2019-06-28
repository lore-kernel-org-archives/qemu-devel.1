Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEEDC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:02:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 335DC20828
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 335DC20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgsOG-0000k2-GH
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 11:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40864)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hgrsi-0004wO-Si
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 10:29:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hgrsh-0007JT-N8
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 10:29:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34869)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hgrsf-0007H8-W3
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 10:29:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id c6so9212973wml.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 07:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kzyDs37IHkXapkdFzVROwyva8sAh39D6I+iSdvtITHE=;
 b=DSLmjV7xBvBiZcnNvl/3Xud591TOD+uieZLX4DLJ57+gVTdlr+7hqj3RP3XRcyaVVZ
 LaH3TY3wySuZY7EXG5O2zwlsD07NeH19ybQZamSH0TVxu1yZXaNCKKeTS+e51Gki26Kj
 +IDuIavtJO+uVB+R4KfHUQy8gC7sMici9Vos8ifaNWq4RNACLB1e9txms8YkPNpLeaAC
 8AWsj7UahVL69PAqxRiLpBnqUClqFhDu1odN+3DNyDfFTe0XldglS8WlPGXShrhBovr7
 i24shLsnJzodsQSgm6XHbEaJh/fToHVAOQrrfhfrTkH+8OBeDi5Sg6eZ4TNrJzNwqrLQ
 or4Q==
X-Gm-Message-State: APjAAAU57Ke5fs2XaJPNe4Q9SzpvTviOFwH1x0YdzAC3w/LSddkMnnzd
 zsFRP6J4eMMMC0kLB4kdaQfmMFoTv8Q=
X-Google-Smtp-Source: APXvYqzy+X3cX8o+7lOJXg84BtnZfQ53sSdApCH7vMn1fxSCNSxZGa/et8u/SL4Y7RTfL5ItyVxA9g==
X-Received: by 2002:a1c:f319:: with SMTP id q25mr7170520wmq.129.1561732176670; 
 Fri, 28 Jun 2019 07:29:36 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id q12sm3935422wrp.50.2019.06.28.07.29.35
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Jun 2019 07:29:36 -0700 (PDT)
To: Liam Merwick <liam.merwick@oracle.com>, qemu-trivial@nongnu.org
References: <1561727317-30655-1-git-send-email-liam.merwick@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <bc12ed80-a2d2-d03e-2cf0-f066a214a344@redhat.com>
Date: Fri, 28 Jun 2019 16:29:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1561727317-30655-1-git-send-email-liam.merwick@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH] docs/devel/testing: Fix typo in dockerfile
 path
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/28/19 3:08 PM, Liam Merwick wrote:
> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
> ---
>  docs/devel/testing.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index da2d0fc9646f..3ef50a61db4d 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -327,7 +327,7 @@ Images
>  ------
>  
>  Along with many other images, the ``min-glib`` image is defined in a Dockerfile
> -in ``tests/docker/dockefiles/``, called ``min-glib.docker``. ``make docker``
> +in ``tests/docker/dockerfiles/``, called ``min-glib.docker``. ``make docker``
>  command will list all the available images.
>  
>  To add a new image, simply create a new ``.docker`` file under the
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

