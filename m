Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D31C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:06:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FFFE20734
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ApUIxs2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FFFE20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlYhv-0008By-CP
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 10:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlYhI-0007fr-9I
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:05:48 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40014)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlYhG-0002a1-Cs
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:05:47 -0400
Received: by mail-wr1-x441.google.com with SMTP id h5so2486877wrc.7
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 07:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=e3yChC0NSJTGCIyR8dyhtLZK2t0FE0O8XwV75zGR6Z4=;
 b=ApUIxs2nBmozNO5JSyueovcwJ4kmvLaf0tFcdUhyv0wQkvQYjQvZMA38/xwhDHNNHr
 fVAMgY4ChsLXh9fbL6EAjmZdOzc/Czt0IwksRE35aOELN/u8sDqhObKTzAgOtjU+l83w
 GNR7m0Q6yhPAXokppEeqDNgt20KxHcg8V5tNAOvhvOnjgnPBb/PVlSp82onWdPAGuXRx
 GlWZ23iak8Zj6D4yZuVGOZuS/fMLnjhGIsAKN6kGfILe6ZLnybotRPrJ7C1NubxkBisj
 2MSBiojPaqR1f5UaIUK+uREYeWtvlTyWb+PJhDxi2pxm6IbWTKFmE53kCCMpDh7XzHaF
 PK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=e3yChC0NSJTGCIyR8dyhtLZK2t0FE0O8XwV75zGR6Z4=;
 b=RToS6fyXlPHoJtcKYivP+O6/AWugOAcmlWpMMv+6qfoMFtLVEwJ+baUkYNBvwEyJwM
 lIr5SW1Ev41xrCIv1DKPbv6R0gg0dMq9BpmlMwnqaEP9iY6Y8aoybsJmZwMXEmDA+5e4
 2fJVUNSAupRCOH1xyYrewFUpUP/hHxtR271yVkJUfU1rZQ/R4+MkQj3yNHZshKrEL5qq
 TloXYrog+eAD05u7HDNxBdatLxRALizAC6tx8U7gHbK/XuMAEd89IDFFEj+CmF/icHev
 Dcq1G+QP9zDYbGZlkF78ryg0WDkl3r63zsG3OJnIJN+DDDRwVBS/ZyZgGvyPxMTuc6CK
 ddJA==
X-Gm-Message-State: AOAM532rFEDZ+4z6HUfLv+3bd+vUc9oT7S4OIMB0MF9xEqWAnPGa/YbJ
 vL/yq4dH2/We5dP0seUbV4XlEA==
X-Google-Smtp-Source: ABdhPJxt/FZM3cszb/mqYvlm3TAdmEjKHm/CGmhjoK8BI1xB0dtEC45L8DhN/SmZa1a0zhmEIfNQNQ==
X-Received: by 2002:adf:f812:: with SMTP id s18mr8248665wrp.28.1592402743570; 
 Wed, 17 Jun 2020 07:05:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p9sm474244wma.48.2020.06.17.07.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 07:05:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 917811FF7E;
 Wed, 17 Jun 2020 15:05:41 +0100 (BST)
References: <20200617053934.122642-1-ppandit@redhat.com>
 <20200617063956.GA12597@umbus.fritz.box> <20200617070621.29051d4b@x1.home>
 <8357f8a5-83e3-47a7-57c9-b88edfa3812c@redhat.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 0/6] Add various undefined MMIO r/w functions
In-reply-to: <8357f8a5-83e3-47a7-57c9-b88edfa3812c@redhat.com>
Date: Wed, 17 Jun 2020 15:05:41 +0100
Message-ID: <87tuz9wzwq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>, Li Qiang <liq3ea@163.com>,
 Li Qiang <liq3ea@gmail.com>, qemu-devel@nongnu.org, P J P <ppandit@redhat.com>,
 Lei Sun <slei.casper@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?Herv=C3=A9?= Poussineau <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Li Qiang <pangpei.lq@antfin.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 6/17/20 3:06 PM, Alex Williamson wrote:
>> On Wed, 17 Jun 2020 16:39:56 +1000
>> David Gibson <david@gibson.dropbear.id.au> wrote:
>>=20
>>> On Wed, Jun 17, 2020 at 11:09:27AM +0530, P J P wrote:
>>>> From: Prasad J Pandit <pjp@fedoraproject.org>
>>>>
>>>> Hello,
>>>>
>>>> This series adds various undefined MMIO read/write functions
>>>> to avoid potential guest crash via a NULL pointer dereference.=20=20
>>>
>>> Hrm.  If this is such a common problem, maybe we should just add a
>>> NULL check in the common paths.
>>=20
>> +1, clearly the behavior is already expected.  Thanks,
>
> 20 months ago Peter suggested:
>
> "assert that every MemoryRegionOps has pointers to callbacks
>  in it, when it is registered in memory_region_init_io() and
>  memory_region_init_rom_device_nomigrate()."
>
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg573310.html
>
> Li Qiang refers to this post from Paolo:
>
>>  static const MemoryRegionOps notdirty_mem_ops =3D {
>> +    .read =3D notdirty_mem_read,
>>      .write =3D notdirty_mem_write,
>>      .valid.accepts =3D notdirty_mem_accepts,
>>      .endianness =3D DEVICE_NATIVE_ENDIAN,
>
> "This cannot happen, since TLB_NOTDIRTY is only added
>  to the addr_write member (see accel/tcg/cputlb.c)."
>
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg561345.html

What about catching it in memory_region_dispatch_write:

    if (mr->ops->write) {
        return access_with_adjusted_size(addr, &data, size,
                                         mr->ops->impl.min_access_size,
                                         mr->ops->impl.max_access_size,
                                         memory_region_write_accessor, mr,
                                         attrs);
    } else if (mr->ops->write_with_attrs) {
        return
            access_with_adjusted_size(addr, &data, size,
                                      mr->ops->impl.min_access_size,
                                      mr->ops->impl.max_access_size,
                                      memory_region_write_with_attrs_access=
or,
                                      mr, attrs);
    } else {
        qemu_log_mask(LOG_UNIMP|LOG_GUEST_ERROR, "%s: %s un-handled write\n=
",
                      __func__, mr->name);
    }


--=20
Alex Benn=C3=A9e

