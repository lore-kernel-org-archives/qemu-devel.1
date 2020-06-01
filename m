Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5991FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 10:30:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23F75206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 10:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aZIWUYOJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F75206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfhiY-0003D0-Ch
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 06:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jfhgY-0000nO-PX
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 06:28:50 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36835)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jfhgX-0001Lm-Nu
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 06:28:50 -0400
Received: by mail-wr1-x444.google.com with SMTP id q11so10998313wrp.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 03:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Ah63wGHHXS2VZ29vNXLvh/ioAgsrzKNIki2Ec1dc9ck=;
 b=aZIWUYOJNZoDrIhi+bGCa/oTVa2mrNySNobx7qs4C7LH1/VmmbOuIdPTbcYCKZgHcn
 VzW6o8CIMIZRTVX4mXdGi6480RMPR5ZvDKVz55Fqjb8SCezjhmcsfq8Fov4IHJQZeeX1
 KZJ9LNtztwdo6AcD4hrBJY0Jq4ywnsrajOD2UzS8qLnScC3b5Dmc5N7zYIcTQmszWtTO
 Tp3+q3uY0skDzirIpLcB/Fp6whv3L9ElKqwwP6kiNS+RfkV6A15CrApknQV/6h54l9P7
 ZzmlEJSj05QWevZoQpleREgPI7kVsKKYk7g2g9/ej4VHzYaEwS+Tb2BhITRMYxG88GBy
 bmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Ah63wGHHXS2VZ29vNXLvh/ioAgsrzKNIki2Ec1dc9ck=;
 b=Uf+u9HJsYd2AuaHweKQhCMN9T0XDuEL6Y0XTMsvfBAP8HEqcKwD+h+rPaZ03akFxSH
 OdZg1sKJia+4NoVuRGeVFjfQboe0MSLmkl1K9OwCOt6+Bcl0gFlyfpsP/LPCU7cN4P46
 y8JjrxpowmMBfC9NEPWMLynlWG9+15xgRimrnAI+mw1eoyo/2O/IbqhPC3uDxNxsJ9qr
 VbaMXtfMtc/5pnP95YrD+9Bz9WFEGUazFdEGGjeR0/6GDzJdx6m7EEg/63leSsPcDHn7
 O4aQcsmEFQwrFSp0/U1h3WvV5s8oZw+hM1SwLyjgMvo/ZTzGpptuwfZdCfHrhScxSB8v
 Elig==
X-Gm-Message-State: AOAM5301yVqH80wyOoFW4jD8eFVietQJbjoScG/DoRyALz3Xo/nf/auW
 qYiKBR+6KA3LMpPUkO6OFRuMSs9OYDo=
X-Google-Smtp-Source: ABdhPJyKzh1+JYL8WHELPBq3irFAh5Ofy+7VE8qkyQ8ZHlvi2X88BxLMFUY9GXBgbD8CpLszZpni6Q==
X-Received: by 2002:a5d:6a4b:: with SMTP id t11mr20929727wrw.404.1591007327343; 
 Mon, 01 Jun 2020 03:28:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x205sm11434344wmx.21.2020.06.01.03.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 03:28:45 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D7A381FF7E;
 Mon,  1 Jun 2020 11:28:44 +0100 (BST)
References: <20191025100152.6638-1-stefanha@redhat.com>
 <20191025100152.6638-2-stefanha@redhat.com>
 <20191026174745-mutt-send-email-mst@kernel.org>
 <20191027123623.GO4472@stefanha-x1.localdomain>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC 1/3] WIP virtiofsd: import Linux <fuse.h> header file
In-reply-to: <20191027123623.GO4472@stefanha-x1.localdomain>
Date: Mon, 01 Jun 2020 11:28:44 +0100
Message-ID: <87zh9n6pwj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 virtio-fs@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Sat, Oct 26, 2019 at 05:49:11PM -0400, Michael S. Tsirkin wrote:
>> On Fri, Oct 25, 2019 at 12:01:50PM +0200, Stefan Hajnoczi wrote:
>> > tests/vhost-user-fs-test.c needs fuse.h.  The private copy that
>> > virtiofsd has can be replaced with a properly imported file using
>> > update-linux-headers.sh.
>> >=20
>> > TODO rerun update-linux-headers.sh with upstream kernel tree!
>> >=20
>> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>=20
>> OK I would just add this with the virtiofsd patchset.
>
> Yes, I'll talk to David.

Catching up after the fact I see this didn't get merged. Was there a
reason?

--=20
Alex Benn=C3=A9e

