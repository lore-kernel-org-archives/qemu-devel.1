Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA781C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:31:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F37E20872
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F37E20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDFoX-0005or-3x
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 18:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDFlE-00037e-CJ
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDFlD-0000S8-8Y
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:27:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46740)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDFlC-0000Qe-Uf
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:27:47 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 00E9481F2F
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 22:27:46 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id a15so139060wrq.4
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 15:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/8/VLuQRVVSVgd3agef3moXHTyMzNwrrhnh2XFcbno8=;
 b=KQpov4S9WF8BkNylU6QCZjRJHAW/I6fgleYjVYArfozQ6SyNig7M3hqQmOkP7sq95V
 P00ZpPZAC6m83iqUExloYRwZNXt7U82Rz0q6O5/Zs+7Kj0aCJeUEdhTPAL2WOW0j0ttR
 AzXuCyVdRZSDQRw0D6+WeP7jqvnqfBjMK+HTxlOtc9Dz2X8SkcjhR4z8mEP3w3rEWzOq
 WaeEEwe+rOimMEX9KvBnXHHEEZI3hZ9iMQa3/M59Q18xTr8+wuOIlEOFbYT1G6WNF0yV
 r50SuLZtbBh9QRqBcHfZ/fFRK7wRAQ+EAeFpDixh1ORONX3b9SMiVsDda3KbnRLRfEVe
 G2Rw==
X-Gm-Message-State: APjAAAXs+fn7EOrOKH9PT91a3pPPCPjxJ8r6CAScgfvFq9R9Idu2eIDA
 xTF5ReRp5wHAvWuUFeIwIW3IJxVVx8e8LTuFrgmSil7Ebf4LjEwYuElOL6GVs50B0y4hIzzSd0a
 j5TXUqYqLNc9y8I8=
X-Received: by 2002:a5d:63c6:: with SMTP id c6mr400044wrw.117.1569450464782;
 Wed, 25 Sep 2019 15:27:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyuC7fwlKwiBqq9r60XEQT1NPX7uxbBvP2RUUz4I3uHKNkDGvhYhFyOi3UPvr/kw50HTW3a7w==
X-Received: by 2002:a5d:63c6:: with SMTP id c6mr400036wrw.117.1569450464587;
 Wed, 25 Sep 2019 15:27:44 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id z125sm725361wme.37.2019.09.25.15.27.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 15:27:44 -0700 (PDT)
Subject: Re: [PATCH v3 14/33] tests/docker: remove python2.7 from debian9-mxe
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190924210106.27117-1-alex.bennee@linaro.org>
 <20190924210106.27117-15-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <768da24b-211e-b2bb-17a3-51661a516d8e@redhat.com>
Date: Thu, 26 Sep 2019 00:27:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190924210106.27117-15-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
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
Cc: Fam Zheng <fam@euphon.net>, jsnow@redhat.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/19 11:00 PM, Alex Benn=C3=A9e wrote:
> From: John Snow <jsnow@redhat.com>
>=20
> When it was based on debian8 which uses python-minimal, it needed this.
> It no longer does.
>=20
> Goodbye, python2.7.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> Message-Id: <20190918222546.11696-1-jsnow@redhat.com>
> [AJB: fixed up commit message]
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/docker/dockerfiles/debian9-mxe.docker | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/tests/docker/dockerfiles/debian9-mxe.docker b/tests/docker=
/dockerfiles/debian9-mxe.docker
> index 7431168dad9..62ff1cecf2d 100644
> --- a/tests/docker/dockerfiles/debian9-mxe.docker
> +++ b/tests/docker/dockerfiles/debian9-mxe.docker
> @@ -16,7 +16,6 @@ RUN apt-key adv --keyserver keyserver.ubuntu.com --re=
cv-keys C6BF758A33A3A276 &&
>  RUN apt-get update && \
>      DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>      apt-get install -y --no-install-recommends \
> -        libpython2.7-stdlib \
>          $(apt-get -s install -y --no-install-recommends gw32.shared-mi=
ngw-w64 | egrep "^Inst mxe-x86-64-unknown-" | cut -d\  -f2)
> =20
> -ENV PATH $PATH:/usr/lib/mxe/usr/bin/=20
> +ENV PATH $PATH:/usr/lib/mxe/usr/bin/
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

