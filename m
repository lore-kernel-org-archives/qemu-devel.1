Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F412C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 09:14:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A10208C0
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 09:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A10208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAsVs-0007IQ-Qu
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 05:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAsTq-0005VL-NY
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 05:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAsTp-00043F-Of
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 05:12:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19536)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAsTp-00042n-Jf
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 05:12:01 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D1377C058CA4
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 09:12:00 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id z17so776621wru.13
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 02:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2MfIIxgkuEIKVH49mHvNtLwI3s5KKXC0tq6P/fB8s/g=;
 b=aRtP2xUbotorimPZTRovEsO/wb5PtQf0rxc16yxOuRMfBmcNJOhuExQjXOg5I3+Vfh
 Op4clWvSZg0VY5Ua7/d+5a7UW7mY+m81JNUtAA9DUP6Xg7+JmaV3i4PQZXCwj+x9PXWF
 mf54la41jjPk7HzwTBQ3y1aJ0C2RoBs2PDWzC6PVg5ezBa00+re+i4dRg4laJvDHJP0p
 zv7gbpWfmDPdovgprh/rPpKSe55D/Ik4C40HJUeUmKpu6WcE93agJ765JwsCUUNobV4L
 aZ4q5JVEwd6efYxNMXGCwBa1MKuiGi8G/o2Kyy66R4V9f8p6tpjE3W12DeIbKgcxrssf
 iM5w==
X-Gm-Message-State: APjAAAUFPZwq7wKGoEieJ7u8m26rZnya+B4W30ypBINWCekXac22K5dg
 Haq/UmZ2I4sZ2pes8RM9oLwvHwh6PENHqIKGgwaWqKLBOXaPjgUsujawkpcLzMaz46GdBMFijZK
 U1UwVJy0FUEq+wyQ=
X-Received: by 2002:adf:a350:: with SMTP id d16mr6112410wrb.326.1568884319626; 
 Thu, 19 Sep 2019 02:11:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyLX9h1clNnaakID0RwfiQmaRnf37SUF/uO3zvqEkDHoqp43XyUQACenKNAuWozyby9JtMI9A==
X-Received: by 2002:adf:a350:: with SMTP id d16mr6112387wrb.326.1568884319351; 
 Thu, 19 Sep 2019 02:11:59 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id c6sm9707810wrm.71.2019.09.19.02.11.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2019 02:11:58 -0700 (PDT)
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20190918222546.11696-1-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1519b32c-90c2-e0bd-18a5-bdeb079148b0@redhat.com>
Date: Thu, 19 Sep 2019 11:11:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190918222546.11696-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] docker: remove python2.7 from docker9-mxe
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
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/19/19 12:25 AM, John Snow wrote:
> When it was based on docker8 which uses python-minimal, it needed this.
> It no longer does.

Good catch, thanks!

> Goodbye, python2.7.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/docker/dockerfiles/debian9-mxe.docker | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/tests/docker/dockerfiles/debian9-mxe.docker b/tests/docker=
/dockerfiles/debian9-mxe.docker
> index 7431168dad..62ff1cecf2 100644
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

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

