Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9566C433E5
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 17:16:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A499D206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 17:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qc2VpDqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A499D206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwTyR-0004Bl-UJ
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 13:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwTxS-0003VY-Ss
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 13:15:38 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:42580)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwTxR-0004zJ-8I
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 13:15:38 -0400
Received: by mail-oi1-x233.google.com with SMTP id t4so8580925oij.9
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 10:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HAGssdKmByeuvUTK1+H5YUaNV8wGyH+3ODKku0pmFDA=;
 b=qc2VpDqnKcYBkeVlQLMOFsGApl3vwlZmWPze0J1KXxoFum77fPsuziAk/eaI/j64Hs
 atjUuJEg4d25w2QlKzBMQD9+ATwgdE4sz97pVWTz0gV7sLMHvezbl27HC4qHoTinqGCg
 Z00Xi7qe1ymlj5AqDdBLtyqUZSsK9ercyB+WufHaGAztChhhm5Gr4B2hICkJfNccK0TX
 cyO+BRCbjtGB/xhrdS1d+muGYwhJDYZ3Mo9+0ZNPRK5E/fguY4A36Bj68OmjxKbHUWkI
 xA5q/abEiwC1ZOuaOUjf12l2SZZ3cDi3jxdL+1gEcpOkkuZz+SuMWopgxMvQgvA4Sncf
 zPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HAGssdKmByeuvUTK1+H5YUaNV8wGyH+3ODKku0pmFDA=;
 b=CNIyHuvk9YLpgM8RbPKeU3d98VosL13mI7U+KmesC+eFDZtcBRl5wzLC15aJCfxlLH
 TUq+ie/WT8on/9U+d+4oQOASZkOK6hRft/Ls8qfv1bIZkC4aIxM6hdn08ac1prpQTdM4
 JT9bE5wyUBMUr9xVxtD5Kixog1H87ZTJpgAeutcQPTw/NQm6AVpTNqHUl9LXev8HCUps
 hk58hXINB0tuE//MIUdgFhxzdXsDUbHT7CJEJF/shFZMW/6fRINSE3Ziw9jqdlf1AibX
 su4ctuQyGYTk2cLzvg6FQ6myTY1M3pskCm2PEaEls+6pS9KFCSxgfej7LoCcZpoEKWSv
 oAbA==
X-Gm-Message-State: AOAM530K9paR8x/8dg6AEVddN3FRkSo9Amivk9y8n8XJ2PPIxednSVio
 0wF3VzQEhOnE3ef4hCP1dreUFaG+JkXGhwGB8wJ3Cg==
X-Google-Smtp-Source: ABdhPJyE/dsRphqdOwIM2uqSU6xBUyAPttrLUWqcA3gtQewdSm9NZWESsC500jAmaZC+ntKmQHZDamce9t2HYSSi4as=
X-Received: by 2002:aca:54c9:: with SMTP id i192mr8415634oib.163.1595006135577; 
 Fri, 17 Jul 2020 10:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <CA+aXn+EkkyiXmKpNhbggy0pjKVpiHxa+TUqEnZLB4v_D=T+7tA@mail.gmail.com>
 <CA+aXn+HHXAmT6Ljj2tpovGAYSurHKSdtUL3y-89t31B0e7jpsA@mail.gmail.com>
 <adb25c78-2edc-115a-5264-ca9f97864ec7@redhat.com>
 <87365t18mp.fsf@dusky.pond.sub.org>
 <CA+aXn+Guvt34PDD=N3FsD5w1C-aDXZ7gS8H_AZN-JEM8j8wBiQ@mail.gmail.com>
 <87lfjkvo81.fsf@dusky.pond.sub.org> <20200716222130.GO1274972@habkost.net>
 <87tuy6k9pa.fsf@dusky.pond.sub.org> <20200717162312.GR1274972@habkost.net>
 <20200717163038.GQ244185@redhat.com>
In-Reply-To: <20200717163038.GQ244185@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jul 2020 18:15:24 +0100
Message-ID: <CAFEAcA-ZrH6vtncD_REPOY8Nmg7HdKWwrSRO9EEPvnjOLnVXoQ@mail.gmail.com>
Subject: Re: sysbus_create_simple Vs qdev_create
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x233.google.com
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Pratik Parvati <pratikp@vayavyalabs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Jul 2020 at 17:32, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> Personally I've not seen a problem with the term "parent" in
> this scenario. The class inheritance metaphor maps reasonably
> clearly to a parent/child metaphor.

It's not bad in itself; it's just that it means almost all
of our objects are in three different kinds of parent-child
relationship simultaneously, which is confusing if you're
not used to it...

thanks
-- PMM

