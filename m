Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505BCC10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 22:22:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 109CD205F4
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 22:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 109CD205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45052 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIhKO-0006xH-3Q
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 18:22:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIhIk-0005eV-MC
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 18:20:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIhIj-0000Fa-QB
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 18:20:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hIhIj-0000F1-KR
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 18:20:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id c5so8605481wrs.11
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 15:20:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=0grNEupLi0LznXGJWK3xOvSKsCfdUeSsH3oFVBNe3KA=;
	b=RuTjVyJJFRL12evm4jfwi9q3DuQ+y7nDVzx8/pWWZ3BIPDxsjmaFTTsvV11Hipzi8A
	w1CY+KynOlVR238ApF2Lhhd/Vvb1vSejLSm5F4aH4f5VOfQZaj/4QvUaa1qXJKVqw76O
	hQdGI+lVxfX4d4GzlhLfAqvAAbTyVuGKOHKBLIq6OG1OMjYfvsKxUpqBuBTxvjG8nuwK
	/eE1K/t1e4Rts0bzq09C6/S1KEX76iZDn+8ZHu/0AvdvSwGE8E4AqbtkIRHFnk/qROV1
	5HA+lnqps2YvIsDA6jMGyZwiZcRFtaxlOI3ZcmBaVmJK/QeSXItKoe5mLIf/aBoluuJ4
	S7pg==
X-Gm-Message-State: APjAAAWcmBwCBdBBZc4REgCZUB7yj+o1L267XAnB7F9mcaTuiR820HmF
	8MvTqVx2RQlXADBtDt++An2p0Q==
X-Google-Smtp-Source: APXvYqyTYjL6vAki/8Ze7SD0TC/sN5VLtDYhi3i3MEJW6vt52LcxKfHqgF5L3A33205x3Uxx4QZEgA==
X-Received: by 2002:adf:e2c3:: with SMTP id d3mr6585281wrj.189.1555971636717; 
	Mon, 22 Apr 2019 15:20:36 -0700 (PDT)
Received: from [192.168.1.25] (atoulouse-656-1-803-163.w86-221.abo.wanadoo.fr.
	[86.221.12.163]) by smtp.gmail.com with ESMTPSA id
	s189sm27371096wmf.45.2019.04.22.15.20.35
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 22 Apr 2019 15:20:36 -0700 (PDT)
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20190422210448.2488-1-ehabkost@redhat.com>
	<20190422210448.2488-4-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c1aa85de-849d-fe69-2059-244c2bb3e197@redhat.com>
Date: Tue, 23 Apr 2019 00:20:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422210448.2488-4-ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH 3/3] accel: Remove unused
 AccelClass::available field
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422222035.xt4whmFM4wazpUI9o9q7xXc0Ii7M_ZytBoFWDxi3piY@z>

On 4/22/19 11:04 PM, Eduardo Habkost wrote:
> The field is not used anymore, we can remove it.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
mingw64:
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  include/sysemu/accel.h | 1 -
>  accel/accel.c          | 5 -----
>  2 files changed, 6 deletions(-)
> 
> diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
> index 5565e00a96..70e9e2f2a1 100644
> --- a/include/sysemu/accel.h
> +++ b/include/sysemu/accel.h
> @@ -38,7 +38,6 @@ typedef struct AccelClass {
>  
>      const char *opt_name;
>      const char *name;
> -    int (*available)(void);
>      int (*init_machine)(MachineState *ms);
>      void (*setup_post)(MachineState *ms, AccelState *accel);
>      bool *allowed;
> diff --git a/accel/accel.c b/accel/accel.c
> index 454fef9d92..5fa31717b4 100644
> --- a/accel/accel.c
> +++ b/accel/accel.c
> @@ -107,11 +107,6 @@ void configure_accelerator(MachineState *ms, const char *progname)
>          if (!acc) {
>              continue;
>          }
> -        if (acc->available && !acc->available()) {
> -            printf("%s not supported for this target\n",
> -                   acc->name);
> -            continue;
> -        }
>          ret = accel_init_machine(acc, ms);
>          if (ret < 0) {
>              init_failed = true;
> 

