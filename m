Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B309EC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:09:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81C91206D7
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GaCaRft8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C91206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVciy-0004k7-JM
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 11:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVcVj-0002vy-KP
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:55:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24885
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVcVi-0001wN-5q
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588604156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ICwKnCoy4EK2GbBD518wf9IypmFknKsi6JyIzyky8gk=;
 b=GaCaRft8OftA3CerB7uVq6Z6UoJX+VENWFFHn7FI/BjA4oqvPSEuhryyulIGH9g3J9/1V8
 igUdiYHqqjvf42Yfs2x+7isADZNQZKYQerYB9e684LhUgtoi4uvkgBNewnJ/aD1vkeJp6Y
 sLzf9Iw9INf+InsHUMejoyz3GU/QrWs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-SQVwhEPwNsebq_fm1mNdgA-1; Mon, 04 May 2020 10:55:51 -0400
X-MC-Unique: SQVwhEPwNsebq_fm1mNdgA-1
Received: by mail-wr1-f71.google.com with SMTP id o8so10851462wrm.11
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kd2smL6VkoY+rTNJp+yGYxUVgWUOpN5MDAYcmF3RhO0=;
 b=EP324yTqMMcFOAlrQn3RNVZQ/7Z7WgFw6znabt6EOb7GnRyD5E/i0i5iZYOTYAmmD6
 VvaFl2LYr4p5oC+7W7HtbXYq2AxMIz3Z3dUEAgZoF4YsIhhZHHoWoYpLkpiM2N6/53cb
 Ggc/pViWA4x8YZYRurZ5oRlRZ1sdkvM6jcD/KcnUWEZIFfbTz1QnHu7wdMzFJcWHAzae
 pn96lyunTFiPfYFm+GaTtuZW4zIv54Z/4yEqsy/qssbzmLvwRbQA0cmKbYVBBrvZkEeb
 m+tzpsKKxjvRI9B0RZtp7x12JnNuVRAyQ4Hn0Lv4Z/cwVpd5AAR+qzPdiSm895V3fh/7
 dYoQ==
X-Gm-Message-State: AGi0Pub5PhotAy6QschH8c2zK5iHkKe3X69CKqofY6Vyw8kqqWJAwBdZ
 BcOm5NYUXUsSSC3bxEk7YdfpuDuYTIv4yLMFx0w3s4S4s4NdyOtyLFpmqYkzoEW8Rz7sr8ACjrD
 0G4E3zttVTK+iO8k=
X-Received: by 2002:a1c:492:: with SMTP id 140mr15966162wme.9.1588604149956;
 Mon, 04 May 2020 07:55:49 -0700 (PDT)
X-Google-Smtp-Source: APiQypLNTNW/m5GrVDn4ITyfuICKNhpkv4vUR/7axRn+KlIi+BjJdsrnv6BbTu4QyZJpFPWtOkNoWg==
X-Received: by 2002:a1c:492:: with SMTP id 140mr15966148wme.9.1588604149754;
 Mon, 04 May 2020 07:55:49 -0700 (PDT)
Received: from [192.168.1.39] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id v7sm394316wmg.3.2020.05.04.07.55.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 07:55:49 -0700 (PDT)
Subject: Re: [PATCH 0/4] Add support for SafeStack
To: Daniele Buono <dbuono@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20200429194420.21147-1-dbuono@linux.vnet.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b7f933b9-6797-9186-0f06-44485f42febe@redhat.com>
Date: Mon, 4 May 2020 16:55:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200429194420.21147-1-dbuono@linux.vnet.ibm.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Tobin Feldman-Fitzthum <tobin@ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/29/20 9:44 PM, Daniele Buono wrote:
> LLVM supports SafeStack instrumentation to protect against stack buffer
> overflows, since version 3.7
>=20
>  From https://clang.llvm.org/docs/SafeStack.html:
> "It works by separating the program stack into two distinct regions: the
> safe stack and the unsafe stack. The safe stack stores return addresses,
> register spills, and local variables that are always accessed in a safe
> way, while the unsafe stack stores everything else. This separation
> ensures that buffer overflows on the unsafe stack cannot be used to
> overwrite anything on the safe stack."
>=20
> Unfortunately, the use of two stack regions does not cope well with
> QEMU's coroutines. The second stack region is not properly set up with
> both ucontext and sigaltstack, so multiple coroutines end up sharing the
> same memory area for the unsafe stack, causing undefined behaviors at
> runtime (and most iochecks to fail).
>=20
> This patch series fixes the implementation of the ucontext backend and
> make sure that sigaltstack is never used if the compiler is applying
> the SafeStack instrumentation. It also adds a configure flag to enable
> SafeStack, and enables iotests when SafeStack is used.
>=20
> This is an RFC mainly because of the low-level use of the SafeStack
> runtime.
> When running swapcontext(), we have to manually set the unsafe stack
> pointer to the new area allocated for the coroutine. LLVM does not allow
> this by using builtin, so we have to use implementation details that may
> change in the future.
> This patch has been tested briefly ( make check on an x86 system ) with
> clang v3.9, v4.0, v5.0, v6.0
> Heavier testing, with make check-acceptance has been performed with
> clang v7.0

Clang10:
Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

>=20
> Daniele Buono (4):
>    coroutine: support SafeStack in ucontext backend
>    coroutine: Add check for SafeStack in sigalstack
>    configure: add flag to enable SafeStack
>    check-block: Enable iotests with SafeStack
>=20
>   configure                    | 29 +++++++++++++++++++++++++++++
>   include/qemu/coroutine_int.h |  6 ++++++
>   tests/check-block.sh         | 12 +++++++++++-
>   util/coroutine-sigaltstack.c |  4 ++++
>   util/coroutine-ucontext.c    | 25 +++++++++++++++++++++++++
>   5 files changed, 75 insertions(+), 1 deletion(-)
>=20


