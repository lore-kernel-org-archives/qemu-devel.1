Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E082C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 16:57:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B2E62070D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 16:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dwG1SZBx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B2E62070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39659 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVfPo-0005DK-HP
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 12:57:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hVfFU-0005Mp-Sj
	for qemu-devel@nongnu.org; Tue, 28 May 2019 12:46:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hVfFQ-0005tE-Kn
	for qemu-devel@nongnu.org; Tue, 28 May 2019 12:46:50 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hVfFN-00054n-81
	for qemu-devel@nongnu.org; Tue, 28 May 2019 12:46:47 -0400
Received: by mail-ot1-x344.google.com with SMTP id j49so18350311otc.13
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 09:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=f6uPhcbzc3DGZEUHWi2LR+ruO0xWV4ctUDghO+B7y18=;
	b=dwG1SZBxq0Tiqd632YAxcmV4FIs939mIbEzcBiu/bFssMKeGlFdMlXoZeuOHNRtS+K
	+kxpg37Rq5P/2i7A2jh6D8A6qiTrXvTUNxyNmlagH8Lv4QW8KXObOfA3hkHHNWa5ikZF
	fI4Hrrc4PTo4TEnseNnyrB72b//zzErJ8TDX004RzRPIcvez4/3MDu+4X0z59RkrNgrj
	oO9nYq8DUsVx42dGU5BAVk1OAZ440XthR+zeOd0lGMZ9QRsmzmHCq/vdp1OkYIw/AbYJ
	UjpzE7Da1C+VOnsQwhW/Q5j7omAVolY1AdLxTvUkMmrlN5PnxTHj1Q0KH639IqXpgoef
	6srQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=f6uPhcbzc3DGZEUHWi2LR+ruO0xWV4ctUDghO+B7y18=;
	b=iwHMG4C8mCgB51a5aYz3hiSzNsBaiVPkU0a+vZBZNT3NtubEpgI++fAMRcWWG/KDTR
	2D8+5vX6VLCbixnW6E7jD3Io/CPfHPln37r7ko8RY2LvkKPI170RJsssEATNu2JCwFL2
	HPrYkHQShGFMV4cfhMbKByVFLmMvOfTvfsuX7KbQZG92vHgieBgcaObmW1Av4EOBq2ov
	Y7KpqLBlZS/ZPAXjDPk0KRzjkJ6PwJ/hs0vV7TMMPURvlg5ucGnzC/7uOYGcdbPfAr9E
	ZAUvMUV02Tn7+fZSF8IsDuamXYq+Zv1yPdiGXzme6hxWDHCbtPnfyU79t/dh1cIGJQLv
	c3NQ==
X-Gm-Message-State: APjAAAWREHloxOOQ3wkUZIhQSt9VnB08gTomJh/K3z1lF5y+sU04Xyhc
	vaCtj5MQnVREm1mOgTB+bWblkUkcWRocqVb0AK2LAA==
X-Google-Smtp-Source: APXvYqwg4QBMnd0xwsxxrLWAMF5gZIyx4nL5uKGxdpOPiQBWJ+dtfH7tacG0hCW/vkYh9Sq2SS9WXXVmDQEYB3NBk6k=
X-Received: by 2002:a05:6830:209a:: with SMTP id
	y26mr47405395otq.232.1559061977945; 
	Tue, 28 May 2019 09:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190528164020.32250-1-philmd@redhat.com>
	<20190528164020.32250-7-philmd@redhat.com>
In-Reply-To: <20190528164020.32250-7-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2019 17:46:06 +0100
Message-ID: <CAFEAcA-eGUW096e2Y6vinPHvF74ogwXBaP+orxYEoRhB-mhGFw@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v2 06/10] hw/audio/ac97: Use the QOM
 DEVICE() macro to access DeviceState.qdev
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
Cc: Fam Zheng <fam@euphon.net>, qemu-s390x <qemu-s390x@nongnu.org>,
	Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	QEMU Trivial <qemu-trivial@nongnu.org>,
	David Hildenbrand <david@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, Michael Walle <michael@walle.cc>,
	Gerd Hoffmann <kraxel@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 May 2019 at 17:42, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Rather than looking inside the definition of a DeviceState with
> "s->qdev", use the QOM prefered style: "DEVICE(s)".
>
> This patch was generated using the following Coccinelle script
> (with a bit of manual fix-up, removing an extra space to please
> checkpatch.pl):
>
>     // Use DEVICE() macros to access DeviceState.qdev
>     @use_device_macro_to_access_qdev@
>     expression obj;
>     identifier dev;
>     @@
>     -&obj->dev.qdev
>     +DEVICE(obj)
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/audio/ac97.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
> index 2265622d44..a4e8d99e77 100644
> --- a/hw/audio/ac97.c
> +++ b/hw/audio/ac97.c
> @@ -1388,7 +1388,7 @@ static void ac97_realize(PCIDevice *dev, Error **er=
rp)
>      pci_register_bar (&s->dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &s->io_nam)=
;
>      pci_register_bar (&s->dev, 1, PCI_BASE_ADDRESS_SPACE_IO, &s->io_nabm=
);
>      AUD_register_card ("ac97", &s->card);
> -    ac97_on_reset (&s->dev.qdev);
> +    ac97_on_reset(DEVICE(s));
>  }

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>.

As an aside, this function has a lot of uses of "&s->dev" to
get the PCIDevice* given an AC97LinkState*. This isn't
necessary as the function has been passed the PCIDevice*
as its argument, so all the uses of "&s->dev" here could
just be written as "dev".

thanks
-- PMM

