Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1B2C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:14:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 691E62064C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muHVAY0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691E62064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jif1W-0007lB-Ha
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 10:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jif07-0006Cm-OO
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 10:13:15 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:35542)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jif06-0007dt-Ob
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 10:13:15 -0400
Received: by mail-io1-xd44.google.com with SMTP id s18so22930483ioe.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 07:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jBI/G+2kacHYS4ekKzUfoS/oR5nHTx+iZrfD6ET/XE0=;
 b=muHVAY0rk6uJsYxnuQI6QXpL72p4gxYARxNNAJDAhtJT94Mh/mAHIWoeGTfNYug9jL
 TWtj6K5GAOUzehl8w502KZYQli+q9YWnQX+O19VnSZPg9sSHBBEufmPfsygXQ6ZGFxn9
 E9YZ0OGVDjK6BMRskUdDQAeAatsRMwcxEu9zYHtw2/T2eEY3yPEm6zHIPLCcIfq6UwDm
 46MXpUF9oRFBBYApT/eLbID4HU8IkVGM/q3RvphT4AJDNNYDdb0uBp5DYJZ9Gtksp/RC
 aqIxx6ddPyCweKSHZ9TJIhA8n3zouP/8ho8yliJ0TnbrBzEflj5k9osELWWOGyhNehZc
 Pv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jBI/G+2kacHYS4ekKzUfoS/oR5nHTx+iZrfD6ET/XE0=;
 b=TCHghkqJgapiiAxwPYgXqoBD9MWuHbjFPKqEHSWKQ7Kdpx+sFfi58hWhTeWve87DQf
 ZjZ5XzgQ9pBSvxdswI8G4mLDzOt6vXzHcbGucECOJoBQ8jXpnuq59OKWx2sIvPAfbRln
 DcUcezFaqSn/53t1VyRGO1kOuTEpiHcMHwUxoo54y0v0ejM3lUElyZ5khCm1WxTZIJTz
 022eDN/OiT5DacGR8ZWmR44/y80z6oGLqE0foloFvN5VihjBI4BMGpEMX8K2xv09rZpn
 9TpgGH325C6j8Rh3H1nFjjX4Cg1YdGaoUTjMUO/+VOPEMING8sBrHYfg2CvPuBjlZN/C
 dt9A==
X-Gm-Message-State: AOAM533XlaBkluFROvb3ozhfa4KxmY///yWP+0yzmZwvCK16+XBGhbFb
 jFZF9+ZB4a2gk7cm1M6DZK/YcAdoY9aBWQHrfQw=
X-Google-Smtp-Source: ABdhPJyE1/GLykqdoqSLsbntQxJFgHhOpyr6dADSiOx4S+AxVmzH5bEsZvCeAHS5pSmE3SwC8Lp21MdF0mhspNj9JD4=
X-Received: by 2002:a02:b0d1:: with SMTP id w17mr27147126jah.75.1591711993179; 
 Tue, 09 Jun 2020 07:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <1588533678-23450-1-git-send-email-raphael.norwitz@nutanix.com>
 <1588533678-23450-5-git-send-email-raphael.norwitz@nutanix.com>
 <CAJ+F1C+mdTwe9xzTYpf_mS8bZRDQDJnE+CTFJD4=Ju4yJPKipA@mail.gmail.com>
In-Reply-To: <CAJ+F1C+mdTwe9xzTYpf_mS8bZRDQDJnE+CTFJD4=Ju4yJPKipA@mail.gmail.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Tue, 9 Jun 2020 10:13:02 -0400
Message-ID: <CAFubqFsFA9B_otn128-OaPsK6XKnaWJvS9xUMV-r00vY57b=zA@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] Transmit vhost-user memory regions individually
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Peter Turschmid <peter.turschm@nutanix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 4, 2020 at 10:45 AM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Thu, May 21, 2020 at 7:00 AM Raphael Norwitz <raphael.norwitz@nutanix.=
com> wrote:
>>
>> With this change, when the VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
>> protocol feature has been negotiated, Qemu no longer sends the backend
>> all the memory regions in a single message. Rather, when the memory
>> tables are set or updated, a series of VHOST_USER_ADD_MEM_REG and
>> VHOST_USER_REM_MEM_REG messages are sent to transmit the regions to map
>> and/or unmap instead of sending send all the regions in one fixed size
>> VHOST_USER_SET_MEM_TABLE message.
>>
>> The vhost_user struct maintains a shadow state of the VM=E2=80=99s memor=
y
>> regions. When the memory tables are modified, the
>> vhost_user_set_mem_table() function compares the new device memory state
>> to the shadow state and only sends regions which need to be unmapped or
>> mapped in. The regions which must be unmapped are sent first, followed
>> by the new regions to be mapped in. After all the messages have been
>> sent, the shadow state is set to the current virtual device state.
>>
>> Existing backends which do not support
>> VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS are unaffected.
>>
>> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
>> Signed-off-by: Swapnil Ingle <swapnil.ingle@nutanix.com>
>> Signed-off-by: Peter Turschmid <peter.turschm@nutanix.com>
>> Suggested-by: Mike Cui <cui@nutanix.com>
> >
> >
> > The change is a bit tricky, why not add more pre-condition/post-conditi=
on checks? This could really help in case we missed some OOB conditions.

Here are a few conditions I could think of:

1. I can ensure that new regions won't overrun the shadow table - just
putting an assert(u->num_shadow_regions + add_idx - rm_idx <
VHOST_MEMORY_MAX_NREGIONS); at the end of scrub_shadow_regions()

2. I could add a precondition asserting that none of the regions in
the shadow table are overlapping.

3. i could add a post condition check that all remove regions are in
the shadow table but not the device memory state and that all add
regions are in the device memory state but not in the shadow table.

Can you think of any others?

(1) is simple but (2) and (3) are more involved and will introduce
overhead. I'm not sure how valuable they are, but if you want I can
tack them on to the end of the series.

>
> > I would also use longer names: rem->remove, reg->registry, etc.. I thin=
k they improve readability.

Sure - happy to change the variable names.

>
> > Nonetheless, it looks ok and apparently 4 people already looked at it, =
so for now:
> > Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Also did you have any comments on the rest of the libvhost-user
patches before I ship a V5?


>
>> ---
>>  docs/interop/vhost-user.rst |  33 ++-
>>  hw/virtio/vhost-user.c      | 510 +++++++++++++++++++++++++++++++++++++=
-------
>>  2 files changed, 469 insertions(+), 74 deletions(-)

