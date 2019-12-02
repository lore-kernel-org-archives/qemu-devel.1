Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC36EC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:19:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7826620717
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ASCeWhO/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7826620717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibnTe-0001Ea-J8
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 10:19:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45018)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ibnSY-0000cb-37
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:17:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ibnSW-0005uM-NM
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:17:57 -0500
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:35393)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ibnSW-0005tQ-HK
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:17:56 -0500
Received: by mail-io1-xd42.google.com with SMTP id v18so9942807iol.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 07:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AyEE6rm28fohnOjDpM5iW4SydDnsLq70FLgX6leZw3U=;
 b=ASCeWhO/c0PXzxb1EKZ9JwisA4d7avcb5i9V5AUNEiX3VKJ4JWHl4cFir95re3yO8+
 j7GHk0haozWM7Z0K5TnQ1mjIEcyHnEzpP6gK2b5aeKXKwuUPs+h6Ij9qSzBoo3qFRTAW
 fr6HzKEULDWo6RH/jeRDPITxHpxQKfDuuVAFGvEIzQ96PHw8b1r43vaG/gQQvrnyauTY
 3Jwrgp9XTy5K5w5Npr+cZiLcavABnToS1RXPuLg8A5Q796xBK3Sr/heS6oVbGSSPTM2M
 1sjI59r3B+8hFF+WxS6GyviP1ogc3FlA8UpOWr4fK35JulrW62c/4Z4mTK5542KjiZYi
 Olhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AyEE6rm28fohnOjDpM5iW4SydDnsLq70FLgX6leZw3U=;
 b=E8MTPYiyTZD305RbhlBcGPKeZNuWJCwPBliW4tKO8kmVMbHp+k77j/1dAVf08KU6SW
 jiaqBqdMYTs+dppy+F2rItQofTBJEiHZ2BYuA+NZ58AnynPAvRIKqpve+wAhGdqkdFyF
 Yq32/Z3ISHuRZfCrknwV6B/os/VlUIEEkRRjaVscf/vCbaspMtvbopr6VhkO1cpqwgT7
 72fQsZJ9ZTs3F4K1eP4QYCfUWefrYOq17IBvMthIrbPnDrst0XGV29SmbIv+jENPbamD
 sZZEjBs95A97y8D8S01TcpvpWNnVs/miWyojBA17pHdBEWrU9/Jv1mMdPWXR4NEc/vkX
 je9A==
X-Gm-Message-State: APjAAAW7Vh6LkvEjcMv0CGcByvbG+94xiUV0197nv7fCEa5j/4gbzbEl
 ZxNnAERUAjQDB8ZZ6L4wr68gyYIJbnOyPWTaUUEOUw==
X-Google-Smtp-Source: APXvYqzsY0Nf/Exi6eu3LA3kM1tDshhmSOrUYHmKFtN9/sNVwW6JZFc/0LcOO6LH0jzPmYTVKev1Je9g8eXFVwmI4d8=
X-Received: by 2002:a02:a148:: with SMTP id m8mr26271758jah.69.1575299875215; 
 Mon, 02 Dec 2019 07:17:55 -0800 (PST)
MIME-Version: 1.0
References: <20190904125531.27545-1-damien.hedde@greensocs.com>
 <20190904125531.27545-7-damien.hedde@greensocs.com>
In-Reply-To: <20190904125531.27545-7-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2019 15:17:43 +0000
Message-ID: <CAFEAcA-N=pBSMrALSYTHFFk4K=G+Zv_BO0ytF1FBS_PG6WMr2w@mail.gmail.com>
Subject: Re: [PATCH v6 6/9] docs/clocks: add device's clock documentation
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 4 Sep 2019 at 13:56, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> Add the documentation about the clock inputs and outputs in devices.
>
> This is based on the original work of Frederic Konrad.
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
>  docs/devel/clock.txt | 246 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 246 insertions(+)
>  create mode 100644 docs/devel/clock.txt

Could you convert this to rst format, please?



> +Changing a clock output
> +=======================
> +
> +A device can change its outputs using the clock_set_frequency function. It
> +will trigger updates on every connected inputs.

"input"

> +
> +For example, let's say that we have an output clock "clkout" and we have a
> +pointer to it in the device state because we did the following in init phase:
> +dev->clkout = qdev_init_clock_out(DEVICE(dev), "clkout");
> +
> +Then at any time (apart from the cases listed below), it is possible to
> +change the clock value by doing:
> +clock_set_frequency(dev->clkout, 1000 * 1000 * 1000); /* 1Ghz */
> +This operation must be done while holding the qemu io lock.
> +
> +One can change clocks only when it is allowed to have side effects on other
> +objects. In consequence, it is forbidden:
> ++ during migration,
> ++ and in the init phase of reset.
> +
> +Forwarding clocks
> +=================
> +
> +Sometimes, one needs to forward, or inherit, a clock from another device.
> +Typically, when doing device composition, a device might expose a sub-device's
> +clock without interfering with it.
> +The function qdev_pass_clock() can be used to achieve this behaviour. Note, that

"Note that"

> +it is possible to expose the clock under a different name. This works for both
> +inputs or outputs.

"inputs and outputs"


> +Migration
> +=========
> +
> +Only the ClockIn object has a state. ClockOut is not concerned by migration.

"has any state".

"ClockOut has no state and does not need special handling for migration."

> +
> +In case the frequency of in input clock is needed for a device's migration,
> +this state must be migrated.

Are you trying to say that if an input clock is known to be a
fixed frequency we don't need to migrate anything? I wonder
if we need to worry about that or if we could/should just say that
input clocks should always be migrated.

> The VMSTATE_CLOCKIN macro defines an entry to
> +be added in a vmstate description.
> +
> +For example, if a device has a clock input and the device state looks like:
> +MyDeviceState {
> +    DeviceState parent_obj;
> +    ClockIn *clk;
> +};
> +
> +Then, to add the clock frequency to the device's migrated state, the vmstate
> +description is:
> +VMStateDescription my_device_vmstate = {
> +    .name = "my_device",
> +    .fields = (VMStateField[]) {
> +        VMSTATE_CLOCKIN(clk, MyDeviceState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +When adding a input clock support to an existing device, you must care about
> +migration compatibility. To this end, you can use the clock_init_frequency in
> +a pre_load function to setup a default value in case the source vm does not
> +migrate the frequency.

thanks
-- PMM

