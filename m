Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A3EC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 12:13:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C429F2081C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 12:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qA88Qeel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C429F2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53670 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU94k-0008Nv-2E
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 08:13:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hU91H-0005QB-0R
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:09:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hU8pm-0001op-P2
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:58:03 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46889)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hU8pm-0001oL-JV
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:58:02 -0400
Received: by mail-ot1-x343.google.com with SMTP id j49so8393060otc.13
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 04:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=PltKjoDHQGaqX+zwe7ldhYz18ggIoDZwmZo/+n9kFWU=;
	b=qA88Qeelf0jojBHKuMD3uTzBO/r6dni1Hsa73V7Bede1AkX3evPjLfNIZQHvqtFZEn
	rWE817R9odfmOKAM1lzcPEj5RmDlD4R89zPxtPZN/QJ77oP5jVd67iplNX3u+1NNDy4b
	hUZFwfcA6VGaAosWoHCfW/vxyxSeSgu37Csu1MgRwJi85/lLtqAPdpjepymkMbvZF/02
	qumw/i4pX0Yy+xU/KjKSswgNSC/5i9besppSBgVKFCNioL/MphrChr+QLbtHHaFLgoE8
	1Cd5MXPCMsLk5HviyMmGmDwyYK4am8uxXHcLOxcwk0eaZt7frG3ccrWkeH5xIoAg1oH+
	CoIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=PltKjoDHQGaqX+zwe7ldhYz18ggIoDZwmZo/+n9kFWU=;
	b=bCYFJrXcXPsa0d60kAu419CkA3R7bjAL8evk+yQaGYnDMRuKQ1/27vvafQpZlvlOfa
	kXuFcf9nQlYIk5Xza0SVRA8XQFKzPxSkCLtTTxKBVX2zwBPfVWnKz5210BxMfMZzhqkS
	9Klg+hMvDl9/MIEPzuCOC+jbGQMascaWeLgu+fd2BBgUWzCgMVIrNzC83VrxZwtMh4xc
	8ayZFtbg6XNqP/M8eI+4NVB0Vl1ftIeJJV8lXqMESYN0R6VgDdHtK5UA69/U+XiiUjXn
	whu+fzMgT7l9CKhELXFrhH3BLaNnHiV+G5uEwx1D6Q3kYhwd2Q83jK8TNmip2c+zE8+q
	gPzA==
X-Gm-Message-State: APjAAAWxnM3LXXGs9pP8LMa/2Cfqjm1oxEYM/10qiepiLqpkpsN1E9bB
	coKMxU4FyaUYfBNfuq7kQHmvaNl/KIryqHWB4mo=
X-Google-Smtp-Source: APXvYqyjjHNzxGxDDZQdGUS9rBVOJdjQsCpvNWcZdimUdVeHPeJ7B1HuQ9zTC0VURp5ZcIQwtLYrN2wwvPOl+38m8sM=
X-Received: by 2002:a05:6830:1386:: with SMTP id
	d6mr1331660otq.149.1558699081190; 
	Fri, 24 May 2019 04:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190524063553.5339-1-philmd@redhat.com>
	<20190524063553.5339-2-philmd@redhat.com>
In-Reply-To: <20190524063553.5339-2-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 24 May 2019 19:57:25 +0800
Message-ID: <CAKXe6SLLtt=DnvMqGA=ztD8EWy_7X0nQoWr-W1_TUY_2tXWXVA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 01/20] hw/i386/pc: Use unsigned type to
 index arrays
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
Cc: Yang Zhong <yang.zhong@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
	Rob Bradford <robert.bradford@intel.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Qemu Developers <qemu-devel@nongnu.org>,
	Samuel Ortiz <sameo@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2019=E5=B9=B45=E6=
=9C=8824=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=882:40=E5=86=99=E9=81=
=93=EF=BC=9A

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>

Reviewed-by: Li Qiang <liq3ea@gmail.com>


> ---
>  hw/i386/pc.c         | 5 +++--
>  include/hw/i386/pc.h | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 2632b73f80..fc38b59d2d 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -870,7 +870,7 @@ static void handle_a20_line_change(void *opaque, int
> irq, int level)
>
>  int e820_add_entry(uint64_t address, uint64_t length, uint32_t type)
>  {
> -    int index =3D le32_to_cpu(e820_reserve.count);
> +    unsigned int index =3D le32_to_cpu(e820_reserve.count);
>      struct e820_entry *entry;
>
>      if (type !=3D E820_RAM) {
> @@ -902,7 +902,8 @@ int e820_get_num_entries(void)
>      return e820_entries;
>  }
>
> -bool e820_get_entry(int idx, uint32_t type, uint64_t *address, uint64_t
> *length)
> +bool e820_get_entry(unsigned int idx, uint32_t type,
> +                    uint64_t *address, uint64_t *length)
>  {
>      if (idx < e820_entries && e820_table[idx].type =3D=3D cpu_to_le32(ty=
pe)) {
>          *address =3D le64_to_cpu(e820_table[idx].address);
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 43df7230a2..ad3a75d8fa 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -291,7 +291,7 @@ void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
>
>  int e820_add_entry(uint64_t, uint64_t, uint32_t);
>  int e820_get_num_entries(void);
> -bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
> +bool e820_get_entry(unsigned int, uint32_t, uint64_t *, uint64_t *);
>
>  extern GlobalProperty pc_compat_4_0[];
>  extern const size_t pc_compat_4_0_len;
> --
> 2.20.1
>
>
>
