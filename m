Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190C6C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 10:45:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C76FE20989
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 10:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nf61diHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76FE20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52197 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOgYI-0007tp-St
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 06:45:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hOgXC-0007KR-7h
	for qemu-devel@nongnu.org; Thu, 09 May 2019 06:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hOgXB-0000Gl-2i
	for qemu-devel@nongnu.org; Thu, 09 May 2019 06:44:18 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1hOgXA-0000Eq-SK
	for qemu-devel@nongnu.org; Thu, 09 May 2019 06:44:17 -0400
Received: by mail-wr1-x444.google.com with SMTP id d12so2335314wrm.8
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 03:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=8cTyNOeKT+LqB/0z12z8ceiKW1jW3ES0q9uxaDs/4XA=;
	b=nf61diHXhVVIKo1jFlJ0CtAZYq+fR7UvyPeqAg7KD1qYbReMV1crLmqR++fMgI+k1c
	cBjlSOIRenp+vUfIh8cvOjA3M6LGaWc/vOb9HhdlN4aTHTN7sFX+R4kMw4oDoLP0FKD8
	QBZZvCpjlLR/f4FvOQHD9b/MaO/SblW03UObQT0fcW68fR+DXv+ThB7sPtxf8YyE2hdT
	65782if0mDpZzauJX5s6TYOhxeQ8oDo1IlaTy3sZq1MzVp924MnMT+AI3H2ucmAa9De2
	GEpHU064afjfcibKrj+ZE8sWOW4FjMTSGd+Iisd56/agprzdLdPA8Qce2uWnNRjXFyEx
	dWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=8cTyNOeKT+LqB/0z12z8ceiKW1jW3ES0q9uxaDs/4XA=;
	b=LThoqYZKoe8ylgz92r6hUBftdVA0TGuituNu/zDvZ26BqpIEBzkQXfeWjD4dcojLly
	0WZiwJlEJcYtGGx3xwqvOtAXMY+Y89qoCV9zkayJEvhknqcu07nAJ0fv8NSGUV7FUKqu
	0998JhenlkhNZeFNt76D2suCRXMkv3LIJudWxeQY3NXbBu+RbGSn0/t/tadgGzVAntYf
	QSZz5jw00K9vsYvorBYp9QIJLuZ5wK0BcyYobSH9Zbm8oKA9ePpNx0+ZHoxMIu0d1Z8z
	uMvRi++wLcKrSoB0f4xX7jjXseZj++o7yrjAuEUs/uVMvrWU92zHMysUgwV0gFNxZrsJ
	KfKQ==
X-Gm-Message-State: APjAAAWX1iOOvgD4i2ulWkArHvBzmIFe+8/IGnHzwdRcpH0qlJq+cCy6
	MdOsRmyWG1seDBVd2BCR/X0=
X-Google-Smtp-Source: APXvYqzt9fq12Py70NR2vFOPN4oXGcKPUiPIeigrYlmBxdvKsT7qjRB+/sgHi+wSI6t88T357FbbRQ==
X-Received: by 2002:adf:f701:: with SMTP id r1mr2673734wrp.130.1557398654947; 
	Thu, 09 May 2019 03:44:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2f0d:c0b:ba00:6fce:9bd8:fb12:6a42])
	by smtp.gmail.com with ESMTPSA id 7sm2754361wro.85.2019.05.09.03.44.13
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 03:44:13 -0700 (PDT)
To: Hou Qiming <hqm03ster@gmail.com>, qemu-devel@nongnu.org
References: <CABSdmrnNW6f=P64PviPP8CTJ5SVfYS8_6kmAtpw9yPObTEkpxg@mail.gmail.com>
	<CABSdmrnocrqLKWncgy_Lak33__GRPYfs-RzSA14e=vh4cRn2ag@mail.gmail.com>
	<20190509064848.wjhchsfov7q6komj@sirius.home.kraxel.org>
	<CABSdmrmm+wJ=+Ccav=X5Gw_oueQvPRejCWVG2SQeCw=K4BM9EA@mail.gmail.com>
	<CABSdmr=fCjBCVvDPGd+B9yGXFsCak3Z+0rOXYmxRLHNZMxcxAQ@mail.gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <e5877f82-70cd-7c2c-3e34-e5b4c1129344@gmail.com>
Date: Thu, 9 May 2019 13:44:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CABSdmr=fCjBCVvDPGd+B9yGXFsCak3Z+0rOXYmxRLHNZMxcxAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH 1/3] ramfb enhancement
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Qiming,

On 5/9/19 10:57 AM, Hou Qiming wrote:
>

Please format the commit subject with a prefix and do not use the same 
subject for all the pacthes
in the series, for this patch it can be something like:

Next version should also have a V2 in the prefix, for this patch it can 
look something like:
    [PATCH v2 1/3] hw/display/ramfb: fix guest memory un-mapping


> Pulled back the `qemu_create_displaysurface_guestmem` function to create
> the display surface so that the guest memory gets properly unmaped.
>
> Signed-off-by: HOU Qiming <hqm03ster@gmail.com 
> <mailto:hqm03ster@gmail.com>>
> ---
>  hw/display/ramfb.c | 53 ++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 42 insertions(+), 11 deletions(-)
>
> diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
> index 25c8ad7..c27fcc7 100644
> --- a/hw/display/ramfb.c
> +++ b/hw/display/ramfb.c
> @@ -29,13 +29,50 @@ struct QEMU_PACKED RAMFBCfg {
>  struct RAMFBState {
>      DisplaySurface *ds;
>      uint32_t width, height;
> +    hwaddr addr, length;
>      struct RAMFBCfg cfg;
>  };
>
> +static void qemu_unmap_displaysurface_guestmem(pixman_image_t *image,
> +                                               void *unused)
> +{
> +    void *data = pixman_image_get_data(image);
> +    uint32_t size = pixman_image_get_stride(image) *
> +        pixman_image_get_height(image);
> +    cpu_physical_memory_unmap(data, size, 0, 0);
> +}
> +
> +static DisplaySurface *qemu_create_displaysurface_guestmem(
> +    int width, int height,
> +    pixman_format_code_t format,
> +    int linesize, uint64_t addr)
> +{
> +    DisplaySurface *surface;
> +    hwaddr size;
> +    void *data;
> +
> +    if (linesize == 0) {
> +        linesize = width * PIXMAN_FORMAT_BPP(format) / 8;
> +    }
> +
> +    size = (hwaddr)linesize * height;
> +    data = cpu_physical_memory_map(addr, &size, 0);
> +    if (size != (hwaddr)linesize * height) {
> +        cpu_physical_memory_unmap(data, size, 0, 0);
> +        return NULL;

Will this result in a silent failure? So we need to add something to the 
log?

Thanks,
Marcel

> +    }
> +
> +    surface = qemu_create_displaysurface_from
> +        (width, height, format, linesize, data);
> +    pixman_image_set_destroy_function
> +        (surface->image, qemu_unmap_displaysurface_guestmem, NULL);
> +
> +    return surface;
> +}
> +
>  static void ramfb_fw_cfg_write(void *dev, off_t offset, size_t len)
>  {
>      RAMFBState *s = dev;
> -    void *framebuffer;
>      uint32_t fourcc, format;
>      hwaddr stride, addr, length;
>
> @@ -49,16 +86,10 @@ static void ramfb_fw_cfg_write(void *dev, off_t 
> offset, size_t len)
>
>      fprintf(stderr, "%s: %dx%d @ 0x%" PRIx64 "\n", __func__,
>              s->width, s->height, addr);
> -    framebuffer = address_space_map(&address_space_memory,
> -                                    addr, &length, false,
> -                                    MEMTXATTRS_UNSPECIFIED);
> -    if (!framebuffer || length < stride * s->height) {
> -        s->width = 0;
> -        s->height = 0;
> -        return;
> -    }
> -    s->ds = qemu_create_displaysurface_from(s->width, s->height,
> -                                            format, stride, framebuffer);
> +    s->addr = addr;
> +    s->length = length;
> +    s->ds = qemu_create_displaysurface_guestmem(s->width, s->height,
> +                                                format, stride, s->addr);
>  }
>
>  void ramfb_display_update(QemuConsole *con, RAMFBState *s)
> -- 
> 2.17.1
>
>


