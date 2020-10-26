Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64ABC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 22:23:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DACA20770
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 22:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cfe05G18"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DACA20770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXAth-0003Za-Kj
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 18:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXAfc-0003Il-Gu
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 18:08:52 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:37837)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXAfa-0006BA-9c
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 18:08:51 -0400
Received: by mail-ej1-x644.google.com with SMTP id p9so16106826eji.4
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 15:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=me26iJrznqyuvEhMdjJDmLgY+AMVVooodzRz1j0xz7E=;
 b=cfe05G18loL2dYPGJmie95wdqKPpkNrZ0v3c2+glP7WtIN4mjdWXUp4kT40eQ9YHjE
 9pnkRw963kFndOEQyZrnE0bWNgn2Db0EljGjoraKxtt5g/YZHuTirUKfZIWLjvNrVUhD
 bePgmoNUc7v7YgPAnY4uNllWUHEPjxrI2+hRBX0SPTiPremaQAxgiFxGbhcHibtfUuEu
 YLmF8fa0vt4Gl5+wmkUp4Mqm9US5/9jpQ7wF/wfxd6t/4pYQdY3HHgWMEIWK7a7vSR8x
 5Kjy2uZnFHIOBcjdj0uhloG9SPZ6M+SKPMvhpGua4QQODqsf8MCveeHyYWOTiEvpQXmK
 sreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=me26iJrznqyuvEhMdjJDmLgY+AMVVooodzRz1j0xz7E=;
 b=Zrrr5kKVmCosyrpSjZ+RC+hKARndZ4v3XIhVApvYovFz0TIp3VlkGCCjSCzUkeU5ov
 4DSEvjLCY3ZYl5wEBxf2UF4PfosjF5jEMZkcjvDBmx7mpLIEZRTjBXc7UnbqpQDHAnx7
 8rfj5KR5s46VuT5ULLcPjGGfwtMO/5gWc5AU1X+QDkBYGokD4xBC4Zn8IQzeQthpW4sI
 +NQD45jAyTffQ0gm1alJ2xZlO+mAtMWnYPCNU9bwBJrSr7ERLO2yqpb/rktc3uYCsU/s
 63KkB6oCP+ImUj4GzG8hgGkrgZYuUydgzrdOTrMLB0YVY4Z8MG420Z7CSAOQrRzV6eDC
 rQvA==
X-Gm-Message-State: AOAM532tTA7+nQSGyk2thKSBgFuGzN92JEvwgIzL6M6uuiopnvCiR6fP
 itGAUSgDLOTAdV4xhDZUOsfLAiRXEaKxrdtGfnGbJzi8yagBSw==
X-Google-Smtp-Source: ABdhPJweBg7c0vp13o9XkvWql8oUPONWfGXiHJwaWBe26jzg4YDQ+USWItCChnaBcb4rOdSNbayqPCtbCM/fXiCnaSo=
X-Received: by 2002:a17:906:af8d:: with SMTP id
 mj13mr17422451ejb.85.1603750128545; 
 Mon, 26 Oct 2020 15:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <20201023200645.1055-1-dbuono@linux.vnet.ibm.com>
 <20201023200645.1055-3-dbuono@linux.vnet.ibm.com>
 <96d4c76c-dfbb-f985-2718-0892ea1b83d4@redhat.com>
 <a5a32430-6eaa-1734-a402-4b0a3e079827@linux.vnet.ibm.com>
 <98a03470-4694-f63a-7104-ae576e4799ce@redhat.com>
In-Reply-To: <98a03470-4694-f63a-7104-ae576e4799ce@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Oct 2020 22:08:37 +0000
Message-ID: <CAFEAcA_9YiFoPE_8Yx7dbo+R=Y9Cu4ETx+EoZ0mn9r05MWKdsw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] configure: avoid new clang 11+ warnings
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Alexander Bulekov <alxndr@bu.edu>, Daniele Buono <dbuono@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 26 Oct 2020 at 15:13, Paolo Bonzini <pbonzini@redhat.com> wrote:
> This one seems okay because the union constrains the size to 4K. If
> "[0]" is enough to shut up the compiler, I'd say do that.

Do you mean converting a C flexible array member (declared as
"foo[]") into a gcc zero-length array (declared as "foo[0]") ?
That seems like it would be going backwards from the direction
we started in with commits f7795e4096d8bd1c and 880a7817c1a82
of preferring flexible arrays to the GNU extension, so it's
maybe not ideal, but I guess it's expedient.

thanks
-- PMM

