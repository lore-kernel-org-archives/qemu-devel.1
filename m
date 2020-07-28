Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523E3C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:09:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C4D02078E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IcDtnsod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4D02078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0SAF-00012z-Ab
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 12:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k0S9Z-0000Cu-2I
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:08:33 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42592)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k0S9X-0000UR-Bi
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:08:32 -0400
Received: by mail-wr1-x442.google.com with SMTP id r4so15878973wrx.9
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 09:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=NkuPx2jExbsJOYiwz+SulUS+aoZjUFHkJYjRaJq0iS8=;
 b=IcDtnsodZs57Ub3ynl45eFm+/Ys076PC3ldRvQZo0a/NCv2oMV7Jpt8fav6mpRmGab
 le9nsp7Erp5KKMEjWb0wfgs4jRdV8fAdck90PSO9fGQz/7ZAHrI0uKKPdE0D/d4Th0m4
 l6f5rp5VpteV/pr0KBO4gilcqbwMMVk9PqfMhPn9q7RmtMVGruQzYvM2E8VTVDx0DSRp
 Zctl+iF1/E45GJp4dxI2ZL9kk9jCsEkoW1J1oMscSK08MGH9mwL6jOhtGkJy+hAnXTS0
 AVLKZdF4Ofa3C/DdPcpQJpZhsQjlG1Ezf4bFaKgmr837vw0oaU+LAw5ACqEmiuCrLQ/Y
 hpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=NkuPx2jExbsJOYiwz+SulUS+aoZjUFHkJYjRaJq0iS8=;
 b=nz4cvrX0lq7Hh07S8pzCsxSr+di6cOJou/L/tC9UEvxhrpvgao0TzDmiyjPZhQPkVP
 qu0DN0/Uw4oMIGgMywW/QWqI9eU1p34ZAlNNRpkMPp+iXXf/p6hrC/nG0E/LZVEKkVjI
 JddKl8irwXkiuATe37/QFQ3wn1yzeyw+NrtCH91ihWvxdHeX9xAn2omPWxNY9FxV2KNH
 bsBsEWOCh28C03QzpkbCgdY6Xw5WbV0D0NmgCBC0GRpdn1Hvcbz/9dr7vJJAyvqfeySO
 XrPsg3MW8zf7dfYreH8BCYEY85wuTwDcw2PuLhgpkS/4rEwikNzPA7Cawf7NETX6NaVr
 SbHA==
X-Gm-Message-State: AOAM530x1AFxgg6vA2RoLpJfAqUxyphNRRcmx+DvxY/4Fu2c+iVtfxyf
 cB+KRGMSsfQSVCdz/YE3AeBu7sun1kU=
X-Google-Smtp-Source: ABdhPJwklrDGB2O06eG82dkg4dnDWPmC+DDOApTk2w6qwmvUvYmtp4kJ8ylIrlfGAwPTgCYLH1HlBQ==
X-Received: by 2002:adf:e94a:: with SMTP id m10mr13742669wrn.249.1595952509714; 
 Tue, 28 Jul 2020 09:08:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t2sm5427001wma.43.2020.07.28.09.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2020 09:08:28 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4CCB61FF7E;
 Tue, 28 Jul 2020 17:08:26 +0100 (BST)
References: <20200728141005.28664-1-alex.bennee@linaro.org>
 <20200728141005.28664-2-alex.bennee@linaro.org>
 <f48c70d8-b506-e86c-e0dd-9e0ed2db3d91@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 1/2] qemu-timer: gracefully handle the end of time
In-reply-to: <f48c70d8-b506-e86c-e0dd-9e0ed2db3d91@redhat.com>
Date: Tue, 28 Jul 2020 17:08:26 +0100
Message-ID: <87o8nz39mt.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: pavel.dovgaluk@ispras.ru, boost.lists@gmail.com, qemu-devel@nongnu.org,
 victor.clement@openwide.fr, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 28/07/20 16:10, Alex Benn=C3=A9e wrote:
>> +    /*
>> +     * Check to see if we have run out of time. Most of our time
>> +     * sources are nanoseconds since epoch (some time around the fall
>> +     * of Babylon 5, the start of the Enterprises five year mission
>> +     * and just before the arrival of the great evil ~ 2262CE).
>> +     * Although icount based time is ns since the start of emulation
>> +     * it is able to skip forward if the device is sleeping (think IoT
>> +     * device with a very long heartbeat). Either way we don't really
>> +     * handle running out of time so lets catch it and report it here.
>> +     */
>> +    if (current_time =3D=3D INT64_MAX) {
>> +        qemu_handle_outa_time();
>> +        goto out;
>> +    }
>> +
>
> Doing this here is a bit dangerous, I'd rather do nothing here and
> detect the situation in cpus.c where we can do
> qemu_system_shutdown_request() (and also do nothing).

You mean in notify_aio_contexts()? Sure we can do that.

I also figured it might be worth cleaning up the return progress stuff
because AFAICT no one seems to care.

>
> Paolo


--=20
Alex Benn=C3=A9e

