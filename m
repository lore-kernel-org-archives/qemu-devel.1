Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CB0C04E87
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 18:05:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C29A120863
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 18:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29A120863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39868 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSmf8-00082D-2p
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 14:05:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSmdT-00075P-Gu
	for qemu-devel@nongnu.org; Mon, 20 May 2019 14:03:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSmdS-00084O-Fa
	for qemu-devel@nongnu.org; Mon, 20 May 2019 14:03:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hSmdS-00082y-9g
	for qemu-devel@nongnu.org; Mon, 20 May 2019 14:03:42 -0400
Received: by mail-wm1-f65.google.com with SMTP id y3so276344wmm.2
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 11:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=CNzm76Se2dku2m1kzsRqw5zpyR14fhXwGHkHsHJnasA=;
	b=kjwrm/KPtOqXeNV9hngsZAG9lllE5x9xlL2aWxWhaCfgIhj5gP3gGl58wl2qWTpezA
	OnN/S1yjuMNkZRf+Lex0Ux/2Nj9jjDqsLEZJ4440IK52JM6nLHkhZf6dNZNxgVXoMxq7
	d0pJYdJiOLtBh6wH24jZX4u/QGdd0sjlxw7FWsvdeUXTEV98oaFqBps839WZ22JOUckg
	DdRTk4nwxpK6jHKliCzUeI1X2Wu1hUCzZkcGNZ2om3fk/bivYUqZyvpWtsx+tKv2huQJ
	60NwsnzGcalzgdrDlu+cTZDtlyuGXl9IrlWsmetNEmJkzAzWGU2OgViCSrC8ElWL44Zy
	NfxQ==
X-Gm-Message-State: APjAAAUrWbuMV7HHWU0dwgxnELc6L0rDVEex5btzVL/IQ4vltXLnhAV+
	aUxfTR/lnN6iy/m4//lUzrPyFA==
X-Google-Smtp-Source: APXvYqwojHiQEyeWI4vfF2KrMDcOe8QC4wiu2AqHLDD3SrlA0fVwckkwfLNoy1m0LPO2cBujHLTxHA==
X-Received: by 2002:a1c:a904:: with SMTP id s4mr289634wme.92.1558375421306;
	Mon, 20 May 2019 11:03:41 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	l8sm21059003wrw.56.2019.05.20.11.03.40
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 May 2019 11:03:40 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190520124716.30472-1-kraxel@redhat.com>
	<20190520124716.30472-6-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <14ca7dbb-4a43-d8f5-662d-85b17498e9d7@redhat.com>
Date: Mon, 20 May 2019 20:03:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520124716.30472-6-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v3 05/14] tests/vm: run test builds on
 snapshot
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
> The build script doesn't shutdown the guest VMs properly,
> which results in filesystem corruption and guest boot
> failures sooner or later.
> 
> Use the --snapshot to run builds on a snapshot,
> That way killing the VM doesn't corrupt the base image.

Yes!

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Tested-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/vm/Makefile.include | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index 992d823f6bd2..d628e0a986f6 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -53,6 +53,7 @@ vm-build-%: $(IMAGES_DIR)/%.img
>  		$(if $(V),--verbose) \
>  		--image "$<" \
>  		$(if $(BUILD_TARGET),--build-target $(BUILD_TARGET)) \
> +		--snapshot \
>  		--build-qemu $(SRC_PATH) -- \
>  		$(if $(TARGET_LIST),--target-list=$(TARGET_LIST)) \
>  		$(if $(EXTRA_CONFIGURE_OPTS),$(EXTRA_CONFIGURE_OPTS)), \
> 

