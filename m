Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A340C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:56:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56C00216C4
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="muC7X6Qd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C00216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50931 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOeqw-0002Qo-KW
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 04:56:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOepp-00016p-NG
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOepo-0008Jh-NG
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:55:25 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hOepo-0008JH-Ho
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:55:24 -0400
Received: by mail-ot1-x342.google.com with SMTP id g18so1360358otj.11
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 01:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=XLEmEkjZq4OymaDjVn1hpScKxddqgCPY3xRcisMsna4=;
	b=muC7X6Qdbr/jKwfsZp10mDsp9gaICbQKoBJ87Y9aNgsq9H/AU5VJg5yzeIbwsJs0c0
	Wj62u97Ay9e81qQJQwNN2PispPC0h57JREmSWipleuDJWiBOqB5eg2SW1hdGvXGIDBZK
	h0unqFUrn2vHNZyJHhEGBAmWXbaAPIE8u8Pq3tP/6nDnQnvpWARxcKEtMFQISdUR1XA4
	Db3nf9oOxCKnDUfI7EZ60d3sEyUaxSxA38k17691o9IDqBTDsz3yunWI7NgwVPibxPd9
	Acb6zo0NILlAu+5ELnU/WXgSYrcC+i7gu+g56g2Um/UXfakCasXKd/7KYhBJYwgixIJK
	HaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=XLEmEkjZq4OymaDjVn1hpScKxddqgCPY3xRcisMsna4=;
	b=AjTOlUbCFrtsGOI+oGkT04WzBDJLKyvtJ+g4BvHVb3pLL5ZxKhJKwng8mxZzTYDB7+
	ww/6rg2Xl46z51ILiOb6XzaOOnn3U17Tlda1qso8ZaGjVhnf4CmdE2pGw3PlLFrzVxwY
	DOFxoatYPrph3wMbBG0bsj2PSowFO+/toQdZIf8ICjVhcXmk616CjNFZR4GQEyMln+Bg
	5PwoPcLJHof3z4mRGECo4+taST2dYvXn3ImwFYB18RRQTVXlX6sA90HvVGhMVFd10DY+
	7Vmh3m+8ly5MvwMgZrZUFW3NSOU8Kjm1S1NYmAigSJ7X6GUKeEEH83C8Py+rfV603Ifu
	GYAg==
X-Gm-Message-State: APjAAAUdp7/7L3alu27QHc4sR8H+MCA1sZqSqw8SWWIZ3KjhE30ajVZE
	6xI/AkNSqw5ttVyUy7vsM/f3gzCA6BlmzLNjqYbNSA==
X-Google-Smtp-Source: APXvYqxh8EgMpL8ma9TwYvxGPAl3PyP4olTsWY2q9yRdd2O5f6I722OjtyMZlSzZK0iGl3opDL8QrwmSLAo99of7vxc=
X-Received: by 2002:a9d:61c6:: with SMTP id h6mr1624008otk.316.1557392123903; 
	Thu, 09 May 2019 01:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190423222005.246981-1-ek@google.com>
	<CAFEAcA_C4BQgYmZrzFZ_bwWVWcfcV1NF_PWp1wHsvqB9iPu0kQ@mail.gmail.com>
	<CAAedzxpgv9A9cFbsDynCcZKxyDkQ0dL+m60ckwWcfD=j8TmSHw@mail.gmail.com>
In-Reply-To: <CAAedzxpgv9A9cFbsDynCcZKxyDkQ0dL+m60ckwWcfD=j8TmSHw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 May 2019 09:55:12 +0100
Message-ID: <CAFEAcA9BTg7E=Yq3TxO2G88Qgi=K5Q3tPvw0sVPW4q=tFc5EtQ@mail.gmail.com>
To: Erik Kline <ek@loon.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH] The ioctl(SIOCGIFNAME) call requires a
 struct ifreq.
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>,
	Laurent Vivier <Laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ah, just noticed the linux-user maintainers weren't
cc'd on this patch. Laurent, could you pick this patch up,
please?

thanks
-- PMM

On Wed, 8 May 2019 at 23:54, Erik Kline <ek@loon.com> wrote:
>
> Anything else I need to do?
>
> On Wed, 24 Apr 2019 at 02:10, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Tue, 23 Apr 2019 at 23:28, Erik Kline via Qemu-devel
>> <qemu-devel@nongnu.org> wrote:
>> >
>> > Signed-off-by: Erik Kline <ek@google.com>
>> > Buglink: https://bugs.launchpad.net/qemu/+bug/1814352
>> > ---
>> >  linux-user/ioctls.h | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
>> > index ae8951625f..37501f575c 100644
>> > --- a/linux-user/ioctls.h
>> > +++ b/linux-user/ioctls.h
>> > @@ -178,7 +178,7 @@
>> >  #endif /* CONFIG_USBFS */
>> >
>> >    IOCTL(SIOCATMARK, IOC_R, MK_PTR(TYPE_INT))
>> > -  IOCTL(SIOCGIFNAME, IOC_RW, MK_PTR(TYPE_INT))
>> > +  IOCTL(SIOCGIFNAME, IOC_RW, MK_PTR(MK_STRUCT(STRUCT_int_ifreq)))
>> >    IOCTL(SIOCGIFFLAGS, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
>> >    IOCTL(SIOCSIFFLAGS, IOC_W, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
>> >    IOCTL(SIOCGIFADDR, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_sockaddr_ifreq)))
>> > --
>> > 2.21.0.593.g511ec345e18-goog
>> >
>>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>
>> thanks
>> -- PMM

