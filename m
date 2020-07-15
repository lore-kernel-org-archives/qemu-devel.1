Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF40C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 01:05:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7545B2065E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 01:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PnB+NWs5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7545B2065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvVrq-0006LR-On
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 21:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jvVpd-0004Nb-2G
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 21:03:33 -0400
Received: from mail-vk1-xa43.google.com ([2607:f8b0:4864:20::a43]:37581)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jvVpb-0001z4-12
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 21:03:32 -0400
Received: by mail-vk1-xa43.google.com with SMTP id q85so77680vke.4
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 18:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=83BTdgqk2KTDBDoZVUCfxxT/ZpwNjfPo/xuQCgcojwQ=;
 b=PnB+NWs5mX1L0TpgbOdGbU40mWfMZjK35zU7yRyUNhqCHctF1EAlXtVXB6lgHV0qEl
 G4/oN5JbaSQ5KxPDf1SDh3YvQDIZC+MpSgLFXIT45J1iG+BluziNx439QiOWuX1QLK51
 mdZ4YYiK/0F0/ppw3iv0QBgvKxEt5RMKcj3+wsABok4Bi9CaC53dtLKP2GOThGZiqIWp
 mHR8TAul4PgqsjP6dWaNxLxM4hiYI8cP2LgfREGoZkszVDlRWAbAMwnlaS4+PedP/jwX
 BLigfziqGg89INhGxuj6Z9Fyyy3VgBhWTrcrZvDKObd8MLzGWEjTvDa69TIV/eEtsD5l
 qO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=83BTdgqk2KTDBDoZVUCfxxT/ZpwNjfPo/xuQCgcojwQ=;
 b=CEj3mrt99rsEtDFt4WMXaBoZLNUty5G0u8uvFPWMNNekS2yW2nHdQEqvabpLERpldh
 FJihH1YvhlLSy8jbB2Z9jl1ABXEpBr+UptPsYdXiUCOfLzwu645qcIf3EHmry+8ca5bF
 ALHt+WqeVXIEOiesK1bl4Wq5p4XNjzGLs3TxlZE8x7z5w/mruMzYtt8eQcYJ1qjOsojt
 b5eyyxq83prlN0jYUBQ2ZzBD/9Ugo5zWvepBezBDVnF4n5Q7gdyXvX0v1+mu4FRbYrCg
 5BLo+RiVLAINt/I2IUo8oRtdgwElI9eoPGeBcuIkACla3aMqsFSalJ5ysqL/6Zt9d9d4
 8szQ==
X-Gm-Message-State: AOAM532WSjc1rCS5q4cidSqOd3jY3xkAyT96i39Gy9e0GMBqpgE5l2t3
 dGNiXaheEoe0wSoaTDSt87nZ4PEuFem4g7qPs5M7Lw==
X-Google-Smtp-Source: ABdhPJzyqFKQgQXS6bIdsf/7xmMgp7JHcduW+l6R/cJZtWySwk2sbB7CRHO9gIRRUZG5boCu9cuLyh4SalTv9smksN4=
X-Received: by 2002:a1f:9144:: with SMTP id t65mr5983958vkd.50.1594775008092; 
 Tue, 14 Jul 2020 18:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200709003608.3834629-1-hskinnemoen@google.com>
 <20200709003608.3834629-5-hskinnemoen@google.com>
 <3ec30463-03f8-98e9-9a14-01b0bb698c9b@kaod.org>
 <CAFQmdRYQxMz_qSr4i_cyqRPEGuq7At=VEOGvsupR3=W7pE3q=g@mail.gmail.com>
 <7c978e82-8890-9ba4-096a-92d7cff60b0a@amsat.org>
 <877dv63x2e.fsf@dusky.pond.sub.org>
 <11c410d4-b310-faf1-5116-2ab62270c3cb@amsat.org>
In-Reply-To: <11c410d4-b310-faf1-5116-2ab62270c3cb@amsat.org>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Tue, 14 Jul 2020 18:03:16 -0700
Message-ID: <CAFQmdRZKnP=NCzoVtPz5LFXFKrboTFxY1EWxOD_w9CCFd-dYiA@mail.gmail.com>
Subject: Re: [PATCH v5 04/11] hw/arm: Add NPCM730 and NPCM750 SoC models
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>,
 QEMU Developers <qemu-devel@nongnu.org>, 
 CS20 KFTing <kfting@nuvoton.com>, qemu-arm <qemu-arm@nongnu.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a43;
 envelope-from=hskinnemoen@google.com; helo=mail-vk1-xa43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 14, 2020 at 10:11 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> On 7/14/20 6:01 PM, Markus Armbruster wrote:
> > Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
> >
> >> +Markus
> >>
> >> On 7/14/20 2:44 AM, Havard Skinnemoen wrote:
> >>> On Mon, Jul 13, 2020 at 8:02 AM C=C3=A9dric Le Goater <clg@kaod.org> =
wrote:
> >>>>
> >>>> On 7/9/20 2:36 AM, Havard Skinnemoen wrote:
> >>>>> The Nuvoton NPCM7xx SoC family are used to implement Baseboard
> >>>>> Management Controllers in servers. While the family includes four S=
oCs,
> >>>>> this patch implements limited support for two of them: NPCM730 (tar=
geted
> >>>>> for Data Center applications) and NPCM750 (targeted for Enterprise
> >>>>> applications).
> >>>>>
> >>>>> This patch includes little more than the bare minimum needed to boo=
t a
> >>>>> Linux kernel built with NPCM7xx support in direct-kernel mode:
> >>>>>
> >>>>>   - Two Cortex-A9 CPU cores with built-in periperhals.
> >>>>>   - Global Configuration Registers.
> >>>>>   - Clock Management.
> >>>>>   - 3 Timer Modules with 5 timers each.
> >>>>>   - 4 serial ports.
> >>>>>
> >>>>> The chips themselves have a lot more features, some of which will b=
e
> >>>>> added to the model at a later stage.
> >>>>>
> >>>>> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> >>>>> Reviewed-by: Joel Stanley <joel@jms.id.au>
> >>>>> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> >>>>> ---
> >> ...
> >>
> >>>>> +static void npcm7xx_realize(DeviceState *dev, Error **errp)
> >>>>> +{
> >>>>> +    NPCM7xxState *s =3D NPCM7XX(dev);
> >>>>> +    NPCM7xxClass *nc =3D NPCM7XX_GET_CLASS(s);
> >>>>> +    int i;
> >>>>> +
> >>>>> +    /* CPUs */
> >>>>> +    for (i =3D 0; i < nc->num_cpus; i++) {
> >>>>> +        object_property_set_int(OBJECT(&s->cpu[i]),
> >>>>> +                                arm_cpu_mp_affinity(i, NPCM7XX_MAX=
_NUM_CPUS),
> >>>>> +                                "mp-affinity", &error_abort);
> >>>>> +        object_property_set_int(OBJECT(&s->cpu[i]), NPCM7XX_GIC_CP=
U_IF_ADDR,
> >>>>> +                                "reset-cbar", &error_abort);
> >>>>> +        object_property_set_bool(OBJECT(&s->cpu[i]), true,
> >>>>> +                                 "reset-hivecs", &error_abort);
> >>>>> +
> >>>>> +        /* Disable security extensions. */
> >>>>> +        object_property_set_bool(OBJECT(&s->cpu[i]), false, "has_e=
l3",
> >>>>> +                                 &error_abort);
> >>>>> +
> >>>>> +        qdev_realize(DEVICE(&s->cpu[i]), NULL, &error_abort);
> >>>>
> >>>> I would check the error:
> >>>>
> >>>>         if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
> >>>>             return;
> >>>>         }
> >>>>
> >>>> same for the sysbus_realize() below.
> >>>
> >>> Hmm, I used to propagate these errors until Philippe told me not to
> >>> (or at least that's how I understood it).
> >>
> >> It was before Markus simplification API were merged, you had to
> >> propagate after each call, since this is a non hot-pluggable SoC
> >> I suggested to use &error_abort to simplify.
> >>
> >>> I'll be happy to do it
> >>> either way (and the new API makes it really easy to propagate errors)=
,
> >>> but I worry that I don't fully understand when to propagate errors an=
d
> >>> when not to.
> >>
> >> Markus explained it on the mailing list recently (as I found the doc
> >> not obvious). I can't find the thread. I suppose once the work result
> >> after the "Questionable aspects of QEMU Error's design" discussion is
> >> merged, the documentation will be clarified.
> >
> > The Error API evolved recently.  Please peruse the big comment in
> > include/qapi/error.h.  If still unsure, don't hesitate to ask here.
> >
> >> My rule of thumb so far is:
> >> - programming error (can't happen) -> &error_abort
> >
> > Correct.  Quote the big comment:
> >
> >  * Call a function aborting on errors:
> >  *     foo(arg, &error_abort);
> >  * This is more concise and fails more nicely than
> >  *     Error *err =3D NULL;
> >  *     foo(arg, &err);
> >  *     assert(!err); // don't do this
> >
> >> - everything triggerable by user or management layer (via QMP command)
> >>   -> &error_fatal, as we can't risk loose the user data, we need to
> >>   shutdown gracefully.
> >
> > Quote the big comment:
> >
> >  * Call a function treating errors as fatal:
> >  *     foo(arg, &error_fatal);
> >  * This is more concise than
> >  *     Error *err =3D NULL;
> >  *     foo(arg, &err);
> >  *     if (err) { // don't do this
> >  *         error_report_err(err);
> >  *         exit(1);
> >  *     }
> >
> > Terminating the process is generally fine during initial startup,
> > i.e. before the guest runs.
> >
> > It's generally not fine once the guest runs.  Errors need to be handled
> > more gracefully then.  A QMP command, for instance, should fail cleanly=
,
> > propagating the error to the monitor core, which then sends it to the
> > QMP client, and loops to process the next command.
> >
> >>> It makes sense to me to propagate errors from *_realize() and
> >>> error_abort on failure to set simple properties, but I'd like to know
> >>> if Philippe is on board with that.
> >
> > Realize methods must not use &error_fatal.  Instead, they should clean
> > up and fail.
> >
> > "Clean up" is the part we often neglect.  The big advantage of
> > &error_fatal is that you don't have to bother :)
> >
> > Questions?
>
> One on my side. So in this realize(), all &error_abort uses has
> to be replaced by local_err + propagate ...:
>
> static void npcm7xx_realize(DeviceState *dev, Error **errp)
> {
>     NPCM7xxState *s =3D NPCM7XX(dev);
>     NPCM7xxClass *nc =3D NPCM7XX_GET_CLASS(s);
>     int i;
>
>     /* CPUs */
>     for (i =3D 0; i < nc->num_cpus; i++) {
>         object_property_set_int(OBJECT(&s->cpu[i]),
>                                 arm_cpu_mp_affinity(i,
> NPCM7XX_MAX_NUM_CPUS),
>                                 "mp-affinity", &error_abort);
>         object_property_set_int(OBJECT(&s->cpu[i]), NPCM7XX_GIC_CPU_IF_AD=
DR,
>                                 "reset-cbar", &error_abort);
>         object_property_set_bool(OBJECT(&s->cpu[i]), true,
>                                  "reset-hivecs", &error_abort);
>
>         /* Disable security extensions. */
>         object_property_set_bool(OBJECT(&s->cpu[i]), false, "has_el3",
>                                  &error_abort);
>
>         qdev_realize(DEVICE(&s->cpu[i]), NULL, &error_abort);
>     }
>     [...]
>
> ... but the caller does:
>
> static void quanta_gsj_init(MachineState *machine)
> {
>     NPCM7xxState *soc;
>
>     soc =3D npcm7xx_create_soc(machine, QUANTA_GSJ_POWER_ON_STRAPS);
>     npcm7xx_connect_dram(soc, machine->ram);
>     qdev_realize(DEVICE(soc), NULL, &error_abort);
>                                     ^^^^^^^^^^^^
>     npcm7xx_load_kernel(machine, soc);
> }
>
> So we overload the code...
>
> My question: Do you confirm this is worth it to propagate?

Here's my understanding. Please let me know if it sounds right.

1. Internal code failing to set simple properties to predefined values
is a programming error, so error_abort is appropriate.
2. qdev_realize() may fail due to user input, so errors should be propagate=
d.
3. machine init can't propagate errors any further, so all errors are
fatal. But if all realize() functions follow (1) and (2), only user
errors are propagated, so error_fatal should be used to produce a nice
error message rather than "Unexpected error, aborting!"

If any of this can ever be hot-plugged, then it means errors may
propagate somewhere other than the machine init code, so it becomes
extra important not to let bad user input crash the whole qemu
process. I don't know if this is a concern when none of these devices
can currently be hot-plugged.

For example, if the user tries to create a machine with 64 MB RAM, the
gcr device will report an error because it can't represent less than
128 MB of memory. Currently, this is reported as

$ ./arm-softmmu/qemu-system-arm -machine npcm750-evb -nographic -m 64
Unexpected error in npcm7xx_gcr_realize() at
/usr/local/google/home/hskinnemoen/qemu/for-upstream/hw/misc/npcm7xx_gcr.c:=
151:
qemu-system-arm: npcm7xx_gcr: DRAM size 67108864 is too small (128 MiB mini=
mum)
Aborted

But if I change npcm7xx_realize() to propagate errors from
sysbus_realize(gcr), and change npcm750_evb_init() to use error_fatal
instead of error_abort, I get

$ ./arm-softmmu/qemu-system-arm -machine npcm750-evb -nographic -m 64
qemu-system-arm: npcm7xx_gcr: DRAM size 67108864 is too small (128 MiB mini=
mum)

which seems less scary and more accurate.

Havard

