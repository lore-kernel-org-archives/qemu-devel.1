Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F048FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 04:11:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA75120679
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 04:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vBayN2To"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA75120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jghEU-0005HK-SE
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 00:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jghDm-0004mW-2q
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 00:11:14 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:32909)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jghDk-0002Z7-Uz
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 00:11:13 -0400
Received: by mail-il1-x142.google.com with SMTP id z2so4782045ilq.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 21:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wyZxx3pTLj22Szs6fZTvijp7cc+pVnWaWFmbcP5U4hI=;
 b=vBayN2ToDAe4RYwgacxIMUqHQICSsj0eVpUZ5viexygSJaoHUtZ+I/Aao1bZba9tZp
 LlZbdxxI3TZvYkeA94pAW6q1+1SaXXynkuP3m60oSO18n3d9FVUjmgYexnQklDzk50dm
 8y/ET7/HEZO8uQTnCUMEap9BDraVs1/zsAP6fuG5UZhlaJkEGsseTgZeklXrKYv0RU03
 LFjb3KErudwb3Na1P6132FbuF1V0p+L9bnXwusR1YAXf8vuUs/ni5jHRMXJAYbl3TFXF
 nOdGCUBzkViXRMznSbc0ZkUchikuAOTpl/2ce1j3bDvTZmxlj1u/YJAJONfpZsyPQGc+
 J6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wyZxx3pTLj22Szs6fZTvijp7cc+pVnWaWFmbcP5U4hI=;
 b=ukKerVLfQr+9Du8CeW9tSVZvJrJYgpK3Lq+48AgvcAOOmrTSEuT3ctynKf4XVETH9K
 26W8U+ZcoIF5vmUT3EYRHT2gisLCQkivzl8ByBarcFhrc/2DtrJFC4jyZavO8qjgnCit
 L6r9hBcSKoTcuMLq31OBaCmNJynJirrxJgdCcZ7SUxpaxYSE1CR2S91NiQGxVShhprkS
 I8s9Md75ZoSmBP9RASbvWz1ue5wLe/EAA211ArkEXOOHnQgIUDzletPZ71Hscfbdcop1
 3l87Kn7kWJAOHBah40NlC37hF2xgNBzsbStWpOS+G4VT8RGp5VTT1Oms4W3eXaeUCp1h
 J8Pw==
X-Gm-Message-State: AOAM533FkB+StXzRFNjFaFKDfQI6bN58XkZQTKyL5Wu8iS/bfmmvW8so
 zfyC74fN7R11Ph0DKeSCmzVGxVCS+hgQxb0G1b0=
X-Google-Smtp-Source: ABdhPJyD0VDKUbzSKpAf8QjparpFhV1jeWVvtsQUP7jJeut2yeBXULCMOOHLr3j4gRfM1UU6ZvNwyPdkxA1z2454VdA=
X-Received: by 2002:a92:d5c3:: with SMTP id d3mr2432454ilq.51.1591243871132;
 Wed, 03 Jun 2020 21:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <1588533678-23450-1-git-send-email-raphael.norwitz@nutanix.com>
In-Reply-To: <1588533678-23450-1-git-send-email-raphael.norwitz@nutanix.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 4 Jun 2020 00:11:00 -0400
Message-ID: <CAFubqFuH7rWT8Z7zn3_wEjPfF0B8yNyeZtT75p_APsp=6AnKZg@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] vhost-user: Lift Max Ram Slots Limitation
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x142.google.com
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
 QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping

On Thu, May 21, 2020 at 1:00 AM Raphael Norwitz
<raphael.norwitz@nutanix.com> wrote:
>
> In QEMU today, a VM with a vhost-user device can hot add memory a
> maximum of 8 times. See these threads, among others:
>
> [1] https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg01046.html
>     https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg01236.html
>
> [2] https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg04656.html
>
> This series introduces a new protocol feature
> VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS which, when enabled, lifts the
> restriction on the maximum number RAM slots imposed by vhost-user.
>
> Without vhost-user, a Qemu VM can support 256 ram slots (for ACPI targets=
),
> or potentially more (the KVM max is 512). With each region, a file descri=
ptor
> must be sent over the socket. If that many regions are sent in a single m=
essage
> there could be upwards of 256 file descriptors being opened in the backen=
d process
> at once. Opening that many fds could easily push the process past the ope=
n fd limit,
> especially considering one backend process could have multiple vhost thre=
ads,
> exposing different devices to different Qemu instances. Therefore to safe=
ly lift the
> limit, transmitting regions should be split up over multiple messages.
>
> In addition, the VHOST_USER_SET_MEM_TABLE message was not reused because
> as the number of regions grows, the message becomes very large. In practi=
ce, such
> large messages caused problems (truncated messages) and in the past it se=
ems
> the community has opted for smaller fixed size messages where possible. V=
RINGs,
> for example, are sent to the backend individually instead of in one massi=
ve
> message.
>
> The implementation details are explained in more detail in the commit
> messages, but at a high level the new protocol feature works as follows:
> - If the VHOST_USER_PROTCOL_F_CONFIGURE_MEM_SLOTS feature is enabled,
>   QEMU will send multiple VHOST_USER_ADD_MEM_REG and
>   VHOST_USER_REM_MEM_REG messages to map and unmap individual memory
>  regions instead of one large VHOST_USER_SET_MEM_TABLE message containing
>   all memory regions.
> - The vhost-user struct maintains a =E2=80=99shadow state=E2=80=99 of mem=
ory regions
>   already sent to the guest. Each time vhost_user_set_mem_table is called=
,
>   the shadow state is compared with the new device state. A
>   VHOST_USER_REM_MEM_REG will be sent for each region in the shadow state
>   not in the device state. Then, a VHOST_USER_ADD_MEM_REG will be sent
>   for each region in the device state but not the shadow state. After
>   these messages have been sent, the shadow state will be updated to
>   reflect the new device state.
>
> The series consists of 10 changes:
> 1. Add helper to populate vhost-user message regions:
>     This change adds a helper to populate a VhostUserMemoryRegion from a
>     struct vhost_memory_region, which needs to be done in multiple places=
 in
>     in this series.
>
> 2. Add vhost-user helper to get MemoryRegion data
>     This changes adds a helper to get a pointer to a MemoryRegion struct,=
 along
>     with it's offset address and associated file descriptor. This helper =
is used to
>     simplify other vhost-user code paths and will be needed elsewhere in =
this
>     series.
>
> 3. Add VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
>     This change adds the VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
>     protocol feature. At this point, if negotiated, the feature only allo=
ws the
>     backend to limit the number of max ram slots to a number less than
>     VHOST_MEMORY_MAX_NREGIONS =3D 8.
>
> 4. Transmit vhost-user memory regions individually
>     With this change, if the VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
>     protocol feature is enabled, Qemu will send regions to the backend us=
ing
>     individual VHOST_USER_ADD_MEM_REG and VHOST_USER_REM_MEM_REG
>     messages.
>     The max number of ram slots supported is still limited to 8.
>
> 5. Lift max memory slots imposed by vhost-user
>     With this change, if the VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
>     protocol feature is enabled, the backend can support a configurable n=
umber of
>     ram slots up to the maximum allowed by the target platform.
>
> 6. Refactor out libvhost-user fault generation logic
>     This cleanup moves some logic from vu_set_mem_table_exec_postcopy() t=
o a
>     separate helper, which will be needed elsewhere.
>
> 7. Support ram slot configuration in libvhost-user
>    This change adds support for processing VHOST_USER_GET_MAX_MEMSLOTS
>     messages in libvhost-user.
>     The VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS protocol is not yet
>     enabled in libvhost-user, so at this point this change is non-functio=
nal.
>
> 8. Support adding individual regions in libvhost-user
>     This change adds libvhost-user support for mapping in new memory regi=
ons
>     when receiving VHOST_USER_ADD_MEM_REG messages.
>     The VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS protocol is not yet
>     enabled in libvhost-user, so at this point this change is non-functio=
nal.
>
> 9. Support individual region unmap in libvhost-user
>     This change adds libvhost-user support for unmapping removed memory r=
egions
>     when receiving VHOST_USER_REM_MEM_REG messages.
>     The VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS protocol is not yet
>     enabled in libvhost-user, so at this point this change is non-functio=
nal.
>
> 10. Lift max ram slots limit in libvhost-user
>    This change makes libvhost-user try to negotiate the
>    VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS, and adds support for
>    backends built using libvhost-user to support hot adding memory up to =
the
>    32 times.
>
> The changes were tested with the vhost-user-bridge sample.
>
> Changes since V3:
>     * Fixed compiler warnings caused by using pointers to packed elements
>        (flagged by patchew building with -Waddress-of-packed-member)
>
> Changes since V2:
>     * Add support for VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
>        for backends build with libvhost-user
>     * Add support for postcopy live-migration when the
>        VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS protocol feature has
>        been negotiated.
>     * Add support for backends which want to support both
>        VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS and
>        VHOST_USER_PROTOCOL_F_REPLY_ACK
>     * Change feature name from VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS
>         to VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS, and any associated
>         variable names.
>     *Log a more descriptive message if the backend lowers the max ram slo=
ts limit
>        on reconnect.
>
> Changes since V1:
>     * Kept the assert in vhost_user_set_mem_table_postcopy, but moved it
>       to prevent corruption
>     * Made QEMU send a single VHOST_USER_GET_MAX_MEMSLOTS message at
>       startup and cache the returned value so that QEMU does not need to
>       query the backend every time vhost_backend_memslots_limit is called=
.
>
> Best,
> Raphael
>
> Raphael Norwitz (10):
>   Add helper to populate vhost-user message regions
>   Add vhost-user helper to get MemoryRegion data
>   Add VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
>   Transmit vhost-user memory regions individually
>   Lift max memory slots limit imposed by vhost-user
>   Refactor out libvhost-user fault generation logic
>   Support ram slot configuration in libvhost-user
>   Support adding individual regions in libvhost-user
>   Support individual region unmap in libvhost-user
>   Lift max ram slots limit in libvhost-user
>
>  contrib/libvhost-user/libvhost-user.c | 341 ++++++++++++++----
>  contrib/libvhost-user/libvhost-user.h |  24 +-
>  docs/interop/vhost-user.rst           |  44 +++
>  hw/virtio/vhost-user.c                | 638 ++++++++++++++++++++++++++++=
------
>  include/hw/virtio/vhost-user.h        |   1 +
>  5 files changed, 873 insertions(+), 175 deletions(-)
>
> --
> 1.8.3.1
>

