Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A6EC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:17:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CFF520872
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sRc5vGVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CFF520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJGGe-0005Um-5C
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 09:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kJGBd-0000p2-8h
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 09:12:26 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34565)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kJGBY-0000Hu-IL
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 09:12:24 -0400
Received: by mail-wm1-x341.google.com with SMTP id l15so6678367wmh.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 06:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=93tReDInypswmn+yGGWSg8X8TQt7KwhmkaQMDk3W/r4=;
 b=sRc5vGVzdRhhlcf+WPS8kEyG6JUn/lm2o29XLO2qWEGUghaKm0nRsQUSN9uYZOwLpJ
 FrUL/Y1W6io37vG+K/l3MvAh08OHUXbJ4apejFXE/BSjzgZcwXwgvGjzGTDVRQeuVv6t
 DPI8NjaVVyPfyU5e0RNXODbAn51oQH0TiNny7ucJ5g87fSSuVWluMJz8G8+UYXAfBXmB
 CfZ/zU+zi40saq8pzct7zkyJPadzXCGbPC1opb+RUiiAVGxEUeLKj46AoD97U8hoJBsM
 2eqKW2z1buxylOJrrewOnufDA8GUkhfnWnRtikT4Re8QiZgMM4Rz6KNLVLj8S5l8yF4Y
 GHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=93tReDInypswmn+yGGWSg8X8TQt7KwhmkaQMDk3W/r4=;
 b=OvDepI+BHLO12+aU9vIhRFhoO8zr0WGBxBga82pcuocm5JIB8BlzuLoDe3ADrtlg0M
 YxJO/dcEKyrhG0adV5Y6u0KKiOdgIPeU3aOsVWRRdDFtKuiy+S1OFj1iaOl+y2vU5FD/
 JJKAQ6lArSzjoH83lkYNNPcbADGKcbxW3mFuPPWaifyRwIEP6QtVCEmxYh/NYC5/SLxR
 FhbuuMVvFiROUC1OyS+q/j/CBE56FCEHSOAWuxYj2LG6+F89TZxDy1zNdabwW/X0k9j+
 WpAaAOrmvCfaLi7Xq9ESKHR71FU1JXhgXx/Ll01zK94gwt43jRf+nBULlmH/U8zzFHzI
 wosg==
X-Gm-Message-State: AOAM530kxEyAelR2jz2l+pO6qh0NYdXdNeGxKK0ri+rQE7KEwbGUy95U
 kCzKPOQf78RsnAViajhEH547dQ==
X-Google-Smtp-Source: ABdhPJwHm6ReVkW5iXzfLUpf8UQajzDBj+U+ipeg/Flo5ifqsNEaM+E8wsWCyXjB8ID+CWTo1mm1iQ==
X-Received: by 2002:a7b:c210:: with SMTP id x16mr15162630wmi.37.1600434738585; 
 Fri, 18 Sep 2020 06:12:18 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v4sm4834841wml.46.2020.09.18.06.12.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 06:12:17 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8DE741FF7E;
 Fri, 18 Sep 2020 14:12:16 +0100 (BST)
References: <20200819144309.67579-1-liq3ea@163.com>
 <2a946eec-5158-0bca-e9c9-b7c81d557b1b@redhat.com>
 <CAKXe6S+0D-jnrq602X-cNHuC7PZXGqpqJM0qXQ8jPe3pRtOSjg@mail.gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Li Qiang <liq3ea@gmail.com>
Subject: Re: [PATCH] virtio: vdpa: omit check return of g_malloc
In-reply-to: <CAKXe6S+0D-jnrq602X-cNHuC7PZXGqpqJM0qXQ8jPe3pRtOSjg@mail.gmail.com>
Date: Fri, 18 Sep 2020 14:12:16 +0100
Message-ID: <87r1qzw7nz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
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
Cc: Li Qiang <liq3ea@163.com>, Jason Wang <jasowang@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Li Qiang <liq3ea@gmail.com> writes:

> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2020=E5=B9=B48=
=E6=9C=8819=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8811:07=E5=86=99=E9=
=81=93=EF=BC=9A
>>
>> On 8/19/20 4:43 PM, Li Qiang wrote:
>> > If g_malloc fails, the application will be terminated.
>>
>> Which we don't want... better to use g_try_malloc() instead?
>
> I don't think so. If g_malloc return NULL it means a critical
> situation I think terminate the application
> is OK. Though I don't find any rule/practices the qemu code base uses
> g_malloc far more than
> g_try_malloc.

g_try_malloc is only for cases you could recover from, by either
deferring or doing something else. A straight out of memory failure is
fatal.

Arguably a bunch of the try_malloc's in the code base should be straight
mallocs. The ELF loaders load_symbols does it because I guess having the
symbols is a bonus and you could still run the program if a) there was
enough memory to run and b) your symbol table was very large.

>
> Thanks,
> Li Qiang
>
>>
>> > No need to check the return value of g_malloc.
>> >
>> > Signed-off-by: Li Qiang <liq3ea@163.com>
>> > ---
>> >  hw/virtio/vhost-vdpa.c | 7 +------
>> >  1 file changed, 1 insertion(+), 6 deletions(-)
>> >
>> > diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>> > index 4580f3efd8..403ae3ae07 100644
>> > --- a/hw/virtio/vhost-vdpa.c
>> > +++ b/hw/virtio/vhost-vdpa.c
>> > @@ -320,10 +320,8 @@ static int vhost_vdpa_set_config(struct vhost_dev=
 *dev, const uint8_t *data,
>> >      struct vhost_vdpa_config *config;
>> >      int ret;
>> >      unsigned long config_size =3D offsetof(struct vhost_vdpa_config, =
buf);
>> > +
>> >      config =3D g_malloc(size + config_size);
>> > -    if (config =3D=3D NULL) {
>> > -        return -1;
>> > -    }
>> >      config->off =3D offset;
>> >      config->len =3D size;
>> >      memcpy(config->buf, data, size);
>> > @@ -340,9 +338,6 @@ static int vhost_vdpa_get_config(struct vhost_dev =
*dev, uint8_t *config,
>> >      int ret;
>> >
>> >      v_config =3D g_malloc(config_len + config_size);
>> > -    if (v_config =3D=3D NULL) {
>> > -        return -1;
>> > -    }
>> >      v_config->len =3D config_len;
>> >      v_config->off =3D 0;
>> >      ret =3D vhost_vdpa_call(dev, VHOST_VDPA_GET_CONFIG, v_config);
>> >
>>


--=20
Alex Benn=C3=A9e

