Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6BCC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:04:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A0C32063A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fcqoZCBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0C32063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOcG-0007OP-6K
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 06:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jLONI-00066h-67
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jLONH-00007S-0V
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:49:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52674
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jLONG-000076-TA
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586166538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zx6ljWQa4ufzT+sGCkKeazRIX01pt37O7hokSXVaVdg=;
 b=fcqoZCBpUNL0donJHDqZS7N4VlfQVumb+5Jxw1UsiWyujbJMG6iigRZoCf7sNxokHEsoV7
 jym5x1mCPEAuB28hiGVWL/ryp6lLLi95L6aKktq0Bmigtd0PigYvsVVfRLJ7d15AN6CySS
 xmye52zYqIwIs+DA1B6hJoQ7HrCEg1M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-lSKAMj5mP9WLYE1Q1WRF9Q-1; Mon, 06 Apr 2020 05:48:54 -0400
X-MC-Unique: lSKAMj5mP9WLYE1Q1WRF9Q-1
Received: by mail-wm1-f71.google.com with SMTP id p18so4693871wmk.9
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 02:48:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ivXOdHgT3FPYEbMditzG3UBfc1yPMw24EoFG2EoodFk=;
 b=HJjnpgUbtJsSwIaK6khil3vhlQezHQJA1mmy2kNSct6LK4xkD23xsV7vwP6iKA7tpZ
 WjPS9e0trauAEz9PdBQ2NiBsP38ArApDplVh/XimBEwWWrDWzsjS8tsm5jtqBDP43Bb/
 eCIaewzd5YKaBosmPPtUJCixkW+eF0nip8saIfY7CRBh9HNPHFnxZDYFXbNjBe2hqVE/
 nxb71VMiQoT4/0zqETz0AOQlt5pTGnNHVdPBTgQB09IWeQtlrMQBSZsejMnKOtxY+Gtd
 K5xAXDZYqbMeP9SL1ULfOfkeGJY9ceqrQs/sDvonGpdVQWxfBE6Ng4T+jAkyR+9YXgEv
 RD3g==
X-Gm-Message-State: AGi0PubgjNqUlwg/sPGrKrGuGDqXZZ/Yis3sCGjSmaFKxOhlHmnmHket
 8kQOvC7WtOtmjJ8L8VPe5QAIvjoHxbG07RX4us126fbIIGLhVBsaenYdHPUHqRarf2Kq9ad9i+p
 vYCWccpOeeFMoUhk=
X-Received: by 2002:a05:600c:2106:: with SMTP id
 u6mr23195982wml.161.1586166533003; 
 Mon, 06 Apr 2020 02:48:53 -0700 (PDT)
X-Google-Smtp-Source: APiQypIMzO3WbpNBxuk/YRNTp+eDXY0Bx0IljxzDe5f0Ffyrfq4czBjLbxI24y3f54TyhexGsKgd5w==
X-Received: by 2002:a05:600c:2106:: with SMTP id
 u6mr23195965wml.161.1586166532790; 
 Mon, 06 Apr 2020 02:48:52 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id h2sm23699466wmb.16.2020.04.06.02.48.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2020 02:48:52 -0700 (PDT)
Subject: Re: Requesting review about a bugfix in touch_all_pages
To: =?UTF-8?B?YmF1ZXJjaGVuKOmZiOiSmeiSmSk=?= <bauerchen@tencent.com>,
 qemu-devel <qemu-devel@nongnu.org>
References: <cfc67cbb15584a25bf44b3a644f44abc@tencent.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <170eef43-9c08-4d68-78b1-85bc6eaf8f2c@redhat.com>
Date: Mon, 6 Apr 2020 11:48:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <cfc67cbb15584a25bf44b3a644f44abc@tencent.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/04/20 05:13, bauerchen(=E9=99=88=E8=92=99=E8=92=99) wrote:
>=20
> From faf903f7b8892179e64bd1a37fe3585a6441bc51 Mon Sep 17 00:00:00 2001
> From: Bauerchen <bauerchen@tencent.com>
> Date: Mon, 6 Apr 2020 10:36:54 +0800
> Subject: [PATCH] Fix: In touch_all_pages, maybe we need a lock to protect
> =C2=A0qemu_cond_boardcast, or qemu_cond_boardcast may be called before al=
l touch
> =C2=A0page threads enter qemu_cond_wait. In this case, =C2=A0main thread =
waits touch
> =C2=A0page threads return, touch page threads wait main thread waking up,=
 that is a
> =C2=A0dead lock ,vm will be in pause state forever;
>=20
> Signed-off-by: Bauerchen <bauerchen@tencent.com>
> ---
> =C2=A0util/oslib-posix.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 4dd6d7d..062236a 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -492,8 +492,11 @@ static bool touch_all_pages(char *area, size_t hpage=
size, size_t numpages,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 QEMU_THREAD_JOINABLE);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr +=3D memset_thread[i].numpages * h=
pagesize;
> =C2=A0 =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0qemu_mutex_lock(&page_mutex);
> =C2=A0 =C2=A0 =C2=A0threads_created_flag =3D true;
> =C2=A0 =C2=A0 =C2=A0qemu_cond_broadcast(&page_cond);
> + =C2=A0 =C2=A0qemu_mutex_unlock(&page_mutex);
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < memset_num_threads; i++) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_thread_join(&memset_thread[i].pgth=
read);
> --=C2=A0
> 1.8.3.1
>=20

Queued, thanks.

Paolo


