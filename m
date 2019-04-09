Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CD2C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 18:51:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 770CA20857
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 18:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770CA20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47710 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDvqg-0006FQ-QX
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 14:51:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDvpo-0005WE-HM
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 14:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDvpn-000680-LI
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 14:51:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDvpl-00066a-L3
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 14:51:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id z6so3024848wmi.0
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 11:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=fXCQid5zDokwG8s7SSF8KqXUy79Q+E/LguS1lSxxjxs=;
	b=J5q4iqM/8d1+84PDv6bKFr7dCMv2lBKMwysbPWiY7taxDyeel9RKFTZWmw00Y9fkCo
	IW+PofBOl9QbjR9hMiaHv42mbDXBRscfpEConvr+d7tHST1F+xSsP5oj+ks4YHM6sS86
	/aEfANpRhPjAM5a3bvbtRsc7GQpIFTazqJEfO7ryShr04NMVQkNkkVo9kmhqyljHBlXZ
	lhIvd1zGV3c6ZHYQxm+thAeW0JUDF9YP1P8gdnh8in+PwGpa1LDGOxwyMeKBfA7B5Noj
	HWcjEft+YeUIo1hvh5401sKUOCJe1i/E4gTcHF+vq5MMkrSJuw+TY0y+H4dSbUJDLHot
	8y+w==
X-Gm-Message-State: APjAAAUp/vNfRS2z0vD0Vz3yF27dWthtQL5OdHY6CKMc9gXgMJAGMR23
	sf/U965BcUh+rInhIZCZxnZbS/mh7SY=
X-Google-Smtp-Source: APXvYqwkU9Qbt6KAL3mh31z/3Y3Yy8f5wpcBFHkrUSQxjOBZbTCffjbDYqOLwwFg+qv+6RIr4o5hGA==
X-Received: by 2002:a05:600c:220b:: with SMTP id
	z11mr22199632wml.73.1554835860288; 
	Tue, 09 Apr 2019 11:51:00 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	x18sm20029309wmi.6.2019.04.09.11.50.59
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 11:50:59 -0700 (PDT)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
	qemu-devel@nongnu.org,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190409154435.28807-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <4c8c671d-88f1-7247-9371-c5d16d93d387@redhat.com>
Date: Tue, 9 Apr 2019 20:50:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409154435.28807-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH] docs: replace min-glib with fedora
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409185058.bNHYxKd9Kebc-EXuSPSBfNzYsXzpQHfbO_N9SQCe9BY@z>

On 4/9/19 5:44 PM, Marc-André Lureau wrote:
> min-glib.docker was removed in commit
> e7b3af81597db1a6b55f2c15d030d703c6b2c6ac ("glib: bump min required
> glib library version to 2.40").
> 
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  docs/devel/testing.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index 60f897d915..cec7d56c57 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -317,17 +317,17 @@ the container, with parameters defined by the make target):
>  
>  .. code::
>  
> -  make docker-test-build@min-glib
> +  make docker-test-build@fedora
>  
> -This will create a container instance using the ``min-glib`` image (the image
> +This will create a container instance using the ``fedora`` image (the image
>  is downloaded and initialized automatically), in which the ``test-build`` job
>  is executed.
>  
>  Images
>  ------
>  
> -Along with many other images, the ``min-glib`` image is defined in a Dockerfile
> -in ``tests/docker/dockefiles/``, called ``min-glib.docker``. ``make docker``
> +Along with many other images, the ``fedora`` image is defined in a Dockerfile
> +in ``tests/docker/dockefiles/``, called ``fedora.docker``. ``make docker``
>  command will list all the available images.
>  
>  To add a new image, simply create a new ``.docker`` file under the
> 

