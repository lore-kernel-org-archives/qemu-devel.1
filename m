Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB180C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 09:03:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4D952173E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 09:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uc9mIcGs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D952173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2XO6-0003I2-H5
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 05:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42345)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dmitry.fleytman@gmail.com>) id 1i2XMB-0002MZ-6X
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dmitry.fleytman@gmail.com>) id 1i2XMA-00027f-5x
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:01:39 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36877)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dmitry.fleytman@gmail.com>)
 id 1i2XM8-00025i-U6
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:01:38 -0400
Received: by mail-wr1-x444.google.com with SMTP id z11so17980137wrt.4
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 02:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=/keE+QFE3BTzahRXpcG4BZ6sWbzSSstrIR9kaQ9Zy+Y=;
 b=uc9mIcGsfYNgQLmzbMG29iHxhWWUvXRd3tZCz9EubyZ7P4EnRwpUxwDuQpvogAo0cT
 NjN+VxOHRKN/5AjsYHHdxUWeuJdxig/G4daebqBkr2FVVdvQs8BM9GkzALMF6EotCv4c
 6+T3nu4ucwkQgFxpwyqYFxp5jxjNzmRPXaD31CmNEUEAceC2fDatfjmM5SuE9R4YPR1+
 +zLIInYXHzWdbbwcpkg9HqQ0Xmk6YACde/Rvtklnt/HgjoClad+SshqeNIACqWOKVhXz
 6ICSsdiaBLW+cVSF1Y7BPN2lO/NE0VMSMkAkWyorloJeN7Se+zIruPDxQjxbA4KNzAYt
 mGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=/keE+QFE3BTzahRXpcG4BZ6sWbzSSstrIR9kaQ9Zy+Y=;
 b=WJgubMuutE+JsmBuW/Wozb+F1vtJMocb6iByWQ1eU/7hchvleDrHVpdkJbsAnpnSez
 kRqgNtvqFpH97Wki/rf4sXj9lD3bQq5Sr+PazWzzvVFx+P/RzyJi8rYH6IesMszu8nal
 Ju10yBsQ+JstseTu8bjBdkAY/6tKnpvhOQyzDRqxGMCDEIPgqsrpQPBpT4w/Ovu+Mzmr
 Sg4CKt+uwOxueHYsweyzAQwMLuId2Wv3mHpeZMu7wphHmcQrEfWwHwh4KEdiLLc3cGhd
 bNnckGCHLSPGj8oCSQVlzShrIV6nENKLTtqd+dKCSGJyW0gm+tUisJQ+W8XCaJqVNr/X
 QY/A==
X-Gm-Message-State: APjAAAWbMQtNpUmAwILZYnJWAz+ldkcYOSAd96gXVXzG5ixPGiBa298O
 TAGT2ewEAsScxxh69MQ3RAc=
X-Google-Smtp-Source: APXvYqzsIQGosMCDFV3ulpR060+OcrGddZ/vBd90zNcS8ITWAFRqzghfPRHnLPy4CjRW2+Jlo0fF/w==
X-Received: by 2002:a5d:4f05:: with SMTP id c5mr2577685wru.349.1566896495659; 
 Tue, 27 Aug 2019 02:01:35 -0700 (PDT)
Received: from [10.0.1.8] ([141.226.29.227])
 by smtp.gmail.com with ESMTPSA id f197sm6956225wme.22.2019.08.27.02.01.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Aug 2019 02:01:35 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
From: Dmitry Fleytman <dmitry.fleytman@gmail.com>
In-Reply-To: <20190822111218.12079-1-dgilbert@redhat.com>
Date: Tue, 27 Aug 2019 12:01:12 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <4C3590FE-0E9D-45CC-95AB-79E01B4B3F6F@gmail.com>
References: <20190822111218.12079-1-dgilbert@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH] hw/net/vmxnet3: Fix leftover
 unregister_savevm
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> On 22 Aug 2019, at 14:12, Dr. David Alan Gilbert (git) =
<dgilbert@redhat.com> wrote:
>=20
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Commit 78dd48df3 reworked vmxnet3's live migration but left a =
straggling
> unregister_savevm call.  Remove it, although it doesn't seem to have
> any bad effect.
>=20

Reviewed-by: Dmitry Fleytman <dmitry.fleytman@gmail.com>

> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
> hw/net/vmxnet3.c | 3 ---
> 1 file changed, 3 deletions(-)
>=20
> diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
> index b07adeed9c..39ff6624c5 100644
> --- a/hw/net/vmxnet3.c
> +++ b/hw/net/vmxnet3.c
> @@ -2242,13 +2242,10 @@ static void vmxnet3_instance_init(Object *obj)
>=20
> static void vmxnet3_pci_uninit(PCIDevice *pci_dev)
> {
> -    DeviceState *dev =3D DEVICE(pci_dev);
>     VMXNET3State *s =3D VMXNET3(pci_dev);
>=20
>     VMW_CBPRN("Starting uninit...");
>=20
> -    unregister_savevm(dev, "vmxnet3-msix", s);
> -
>     vmxnet3_net_uninit(s);
>=20
>     vmxnet3_cleanup_msix(s);
> --=20
> 2.21.0
>=20


