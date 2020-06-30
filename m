Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11BEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:17:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C16E206BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="szR1BTiz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C16E206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqG92-0001VA-Nc
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 09:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jqG8D-0000Zt-Rh
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 09:17:01 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34478)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jqG8B-0003BV-7S
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 09:17:01 -0400
Received: by mail-oi1-x241.google.com with SMTP id e4so9276655oib.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 06:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=KoO8IdXRS1Xvt3wYeZX5y6sGdbVy2nRfMEpFfU+MFTs=;
 b=szR1BTizkRu4VPdBh7wfp0IIIsMeulpZ8QJ8wKoi9+pbWaeAfcfd6/BZwT74ljjKDg
 89EEXBzWXYrry9F9BvLrg2329r2e3MUPiHlO8+GQd1uZls2GgYcwqHpCAmCKnFjkZvTB
 qASa3DS40FzsieXcF6y0J0N9DzEEWbgKRVu8tWmMcTBMFFUU/fRHmx3nZMD2+XKW2via
 9/kCSXbV2aazSNcndWXNoEMPIQ+r+ogJp44rhQ1HdD+206z6coSloLrHeHOrf0S/YQPg
 oQj5ZgazPBongvWhJn+CqHJEsg+ubPI/wpvtmydYRpu/FxS8wAZTbZFavUE1xyw+ym7B
 5l3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KoO8IdXRS1Xvt3wYeZX5y6sGdbVy2nRfMEpFfU+MFTs=;
 b=nCeyMg1k0GqzL/GGr9mmGvHqmavJ99bE/z7ON2in6ZN8vEhiHhHNW0x16j95jEW4EO
 Y6gbGX65L0xvBWYKpT2BU+k21qmrx8EjsfqCctklNTN55CqMkUOJcOBwukkIvytm9Jwi
 aV5ecz0Bt4Bv0bsyoTnqTZKiJNB0iNdIip9BdfOxZ+yUEvT7y5frdg19N2VPSswyxckt
 b91Yjw5M4IHgdEAbaq94nc+shRTM4e7M+xnph7gXusltv2pcuVO+M0o2n/oNqGZJlZ4v
 13qe2z2t+1Sv+LowECRAgUuazQwiLb+/4EeTsrBsrakpwfb39rX4VWP7ox/dv53Po1GE
 DBTA==
X-Gm-Message-State: AOAM530i4cOK/aqrOUyCQwN8QhanKHKbmDoOBDZaBKCMe+EeIhvwSNOq
 GC3MUeIV3GRIgcf6QyPp9XLlyQRLYr2viNBtx1OEBQ==
X-Google-Smtp-Source: ABdhPJzGjssE81diYIBMzuWEUOSR0CwhqdXorP+dFY6g7R5WyBOo72zEM5RTHOP1GZMLd11lMRYmVmbw77Xk38McIpY=
X-Received: by 2002:aca:54c9:: with SMTP id i192mr9415502oib.163.1593523016956; 
 Tue, 30 Jun 2020 06:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200629173821.22037-1-f4bug@amsat.org>
 <20200629173821.22037-6-f4bug@amsat.org>
 <87zh8kg8qu.fsf@dusky.pond.sub.org>
In-Reply-To: <87zh8kg8qu.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jun 2020 14:16:45 +0100
Message-ID: <CAFEAcA9cajf=MKv4ZD6ivyDTrK4hWLfBP_9T2mJ6LrWjwGMFGA@mail.gmail.com>
Subject: Re: [PATCH 5/5] hw/i2c: Document the I2C qdev helpers
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Corey Minyard <cminyard@mvista.com>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Jan Kiszka <jan.kiszka@web.de>, David Gibson <david@gibson.dropbear.id.au>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jun 2020 at 11:15, Markus Armbruster <armbru@redhat.com> wrote:
>
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>
> > In commit d88c42ff2c we added new prototype but neglected to
> > add their documentation. Fix that.
> >
> > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> > + * This function is useful if you have created @dev via qdev_new(),
> > + * i2c_slave_new() or i2c_slave_try_new() (which take a reference to
> > + * the device it returns to you), so that you can set properties on it
> > + * before realizing it. If you don't need to set properties then
> > + * i2c_slave_create_simple() is probably better (as it does the create=
,
> > + * init and realize in one step).
> > + *
> > + * If you are embedding the I2C slave into another QOM device and
> > + * initialized it via some variant on object_initialize_child() then
> > + * do not use this function, because that family of functions arrange
> > + * for the only reference to the child device to be held by the parent
> > + * via the child<> property, and so the reference-count-drop done here
> > + * would be incorrect.  (Instead you would want i2c_slave_realize(),
> > + * which doesn't currently exist but would be trivial to create if we
> > + * had any code that wanted it.)
> > + */
>
> The advice on use is more elaborate qdev_realize_and_unref()'s.  That
> one simply shows intended use.  I doubt we need more.  But as the person
> who wrote qdev_realize_and_unref(), I'm singularly unqualified judging
> the need ;)

If qdev_realize_and_unref() has documentation which gives
the use-cases similar to the text above, then we could make
this text say "This function follows the patterns and
intended usecases for qdev_realize_and_unref(); see the
documentation for that function for whether you would be
better off using i2c_realize() or (the not-yet-existing)
i2c_slave_realize()" or similar. I originally wrote the
version of the above text for ssi_realize_and_unref()
as essentially the documentation I would have liked
qdev_realize_and_unref() to have, ie including the nuances
which I had to figure out for myself.

thanks
-- PMM

