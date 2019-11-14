Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78445C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 09:54:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 451782063A
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 09:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEaT5I2X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451782063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVBpE-0006Hw-Vn
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 04:54:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pdurrant@gmail.com>) id 1iVBng-0004wU-1z
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:52:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pdurrant@gmail.com>) id 1iVBnd-0008Aa-22
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:52:27 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33850)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pdurrant@gmail.com>) id 1iVBnc-0008AF-Qm
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 04:52:25 -0500
Received: by mail-pf1-x444.google.com with SMTP id n13so3863195pff.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 01:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ks6ZMzeQ8Hqs4DUYx85GDL216MhZLdSTeq5jMObCwZc=;
 b=KEaT5I2XDutXUdg+ZHxY4g44RBjKlFb+73IxC2N+ecw6YAEVRJ/4+bL1M8LqR5ikDO
 pdNNYBKCpnujqfJ8opZXqTkUx0AHkYe+ybzLSXnU/Bx73JDMre9XKxPrK/8if6J44NhB
 lS3LggV2AgippMYHUsrvQ4uAD1vHOojT25x79AoyDKjZWWRLzvub1hj63XOb19fALSzP
 5uELEZHmGvqRqN/dj0fdwT+VGCWeimBwdgZOMovt0BmTUas6/X4OIFMvAE3wXmuyLH1C
 YVa6tyuo8MapU8OjAeOJG6Nc4lgnuZzMrVdWrSgnRiAUH5IZdTmBM12L4OeeiyRvcV4X
 K+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ks6ZMzeQ8Hqs4DUYx85GDL216MhZLdSTeq5jMObCwZc=;
 b=jkIjbzRsPXNSZCzpQ+RM91awvklNxntSQFaORHIPUfsfdXNIWFqhxuYgVa4GpX3QoX
 GrLeyNHndQNy9/MNJRgIwHiXB7Tlx9Wv7rjBa8SMdEgck2jkFCqo46t1qIkXXqk93goq
 hHfkOniX6ax32+zOCcC4zrVqdbl3rHT9elMQZj4QcI0UB7h28aLSLdXhUR5tpAEi+9vt
 CSDFguV1OTaiG24E94Hc4yIKFHgHEvsPrdy8NLPkCWGR8lzxjh3sTlQ7Fe7b8mnq1btb
 FMroJImDEcjptQaPLpRmZSavb4OMYRQgj6tQ8bgtYXd9OmcFvGjuAJFU/4uxjBMUHGXT
 wkIA==
X-Gm-Message-State: APjAAAX8zkL3qqwITbXeRs5rv1bxZPrS+ln8cRJ4khbHaUdRW+jiZ9Nr
 /Vds8jS/Bdrrm1WwKf18ftKW0JlYesJkJSTNK0A=
X-Google-Smtp-Source: APXvYqxzXX4gMr/8AZMK3C3UoQrg/vLLalfJKwzG7hT2vr5WUapQUxySziwmUkR3kprEI/EcdLg0BrJjrRJ1Ozk1a+M=
X-Received: by 2002:a17:90b:4386:: with SMTP id
 in6mr11353486pjb.33.1573725143421; 
 Thu, 14 Nov 2019 01:52:23 -0800 (PST)
MIME-Version: 1.0
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
 <1573655945-14912-14-git-send-email-pbonzini@redhat.com>
 <CACCGGhB=Sp8jcp+hhQjU0sXqhyQ8ug7nT-PuijS-eXPq4kog-w@mail.gmail.com>
 <3b5cbfb9-0de9-ae52-6695-12579bc42c09@redhat.com>
In-Reply-To: <3b5cbfb9-0de9-ae52-6695-12579bc42c09@redhat.com>
From: Paul Durrant <pdurrant@gmail.com>
Date: Thu, 14 Nov 2019 09:52:12 +0000
Message-ID: <CACCGGhBvZgrm+pvYcb9uPePHNAfo8MPHktURbBh+icf=FPUOsw@mail.gmail.com>
Subject: Re: [PATCH 13/16] xen: convert "-machine igd-passthru" to an
 accelerator property
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: Thomas Huth <thuth@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 xen-devel <xen-devel@lists.xenproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 Nov 2019 at 09:47, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 14/11/19 10:39, Paul Durrant wrote:
> > On Wed, 13 Nov 2019 at 14:53, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >>
> >> The first machine property to fall is Xen's Intel integrated graphics
> >> passthrough.  The "-machine igd-passthru" option does not set anymore
> >> a property on the machine object, but desugars to a GlobalProperty on
> >> accelerator objects.
> >>
> >> The setter is very simple, since the value ends up in a
> >> global variable, so this patch also provides an example before the more
> >> complicated cases that follow it.
> >>
> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >
> > Did something go wrong with get_maintainers here? The Xen maintainers
> > ought to have been cc-ed. The Xen toolstack will require consequent
> > modification.
>
> No, I just didn't use getmaintainers, my bad.  But backwards-compatible
> syntactic sugar is provided, so no modifications are needed to Xen.  See
> here in the code:
>
> +    if (g_str_equal(qom_name, "igd-passthru")) {
> +        object_register_sugar_prop(ACCEL_CLASS_NAME("xen"), qom_name, value);
> +        return 0;
> +    }

Ah, no immediate danger. Thanks for pointing this out.

Cheers,
  Paul

>
> Paolo
>
> > Cc-ing (rest of) Xen maintainers and xen-devel manually.
> >
> >   Paul
> >
> >> ---
> >>  hw/core/machine.c   | 20 --------------------
> >>  hw/xen/xen-common.c | 16 ++++++++++++++++
> >>  include/hw/boards.h |  1 -
> >>  qemu-options.hx     |  9 +++++----
> >>  vl.c                | 14 ++++----------
> >>  5 files changed, 25 insertions(+), 35 deletions(-)
> >>
> >> diff --git a/hw/core/machine.c b/hw/core/machine.c
> >> index 45ddfb6..d7a0356 100644
> >> --- a/hw/core/machine.c
> >> +++ b/hw/core/machine.c
> >> @@ -412,20 +412,6 @@ static void machine_set_graphics(Object *obj, bool value, Error **errp)
> >>      ms->enable_graphics = value;
> >>  }
> >>
> >> -static bool machine_get_igd_gfx_passthru(Object *obj, Error **errp)
> >> -{
> >> -    MachineState *ms = MACHINE(obj);
> >> -
> >> -    return ms->igd_gfx_passthru;
> >> -}
> >> -
> >> -static void machine_set_igd_gfx_passthru(Object *obj, bool value, Error **errp)
> >> -{
> >> -    MachineState *ms = MACHINE(obj);
> >> -
> >> -    ms->igd_gfx_passthru = value;
> >> -}
> >> -
> >>  static char *machine_get_firmware(Object *obj, Error **errp)
> >>  {
> >>      MachineState *ms = MACHINE(obj);
> >> @@ -862,12 +848,6 @@ static void machine_class_init(ObjectClass *oc, void *data)
> >>      object_class_property_set_description(oc, "graphics",
> >>          "Set on/off to enable/disable graphics emulation", &error_abort);
> >>
> >> -    object_class_property_add_bool(oc, "igd-passthru",
> >> -        machine_get_igd_gfx_passthru, machine_set_igd_gfx_passthru,
> >> -        &error_abort);
> >> -    object_class_property_set_description(oc, "igd-passthru",
> >> -        "Set on/off to enable/disable igd passthrou", &error_abort);
> >> -
> >>      object_class_property_add_str(oc, "firmware",
> >>          machine_get_firmware, machine_set_firmware,
> >>          &error_abort);
> >> diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
> >> index 5284b0d..6cba30c 100644
> >> --- a/hw/xen/xen-common.c
> >> +++ b/hw/xen/xen-common.c
> >> @@ -124,6 +124,16 @@ static void xen_change_state_handler(void *opaque, int running,
> >>      }
> >>  }
> >>
> >> +static bool xen_get_igd_gfx_passthru(Object *obj, Error **errp)
> >> +{
> >> +    return has_igd_gfx_passthru;
> >> +}
> >> +
> >> +static void xen_set_igd_gfx_passthru(Object *obj, bool value, Error **errp)
> >> +{
> >> +    has_igd_gfx_passthru = value;
> >> +}
> >> +
> >>  static void xen_setup_post(MachineState *ms, AccelState *accel)
> >>  {
> >>      int rc;
> >> @@ -177,6 +187,12 @@ static void xen_accel_class_init(ObjectClass *oc, void *data)
> >>      ac->compat_props = g_ptr_array_new();
> >>
> >>      compat_props_add(ac->compat_props, compat, G_N_ELEMENTS(compat));
> >> +
> >> +    object_class_property_add_bool(oc, "igd-passthru",
> >> +        xen_get_igd_gfx_passthru, xen_set_igd_gfx_passthru,
> >> +        &error_abort);
> >> +    object_class_property_set_description(oc, "igd-passthru",
> >> +        "Set on/off to enable/disable igd passthrou", &error_abort);
> >>  }
> >>
> >>  #define TYPE_XEN_ACCEL ACCEL_CLASS_NAME("xen")
> >> diff --git a/include/hw/boards.h b/include/hw/boards.h
> >> index 36fcbda..cdcf481 100644
> >> --- a/include/hw/boards.h
> >> +++ b/include/hw/boards.h
> >> @@ -287,7 +287,6 @@ struct MachineState {
> >>      bool mem_merge;
> >>      bool usb;
> >>      bool usb_disabled;
> >> -    bool igd_gfx_passthru;
> >>      char *firmware;
> >>      bool iommu;
> >>      bool suppress_vmdesc;
> >> diff --git a/qemu-options.hx b/qemu-options.hx
> >> index 3931f90..5b43a83 100644
> >> --- a/qemu-options.hx
> >> +++ b/qemu-options.hx
> >> @@ -37,7 +37,6 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
> >>      "                kvm_shadow_mem=size of KVM shadow MMU in bytes\n"
> >>      "                dump-guest-core=on|off include guest memory in a core dump (default=on)\n"
> >>      "                mem-merge=on|off controls memory merge support (default: on)\n"
> >> -    "                igd-passthru=on|off controls IGD GFX passthrough support (default=off)\n"
> >>      "                aes-key-wrap=on|off controls support for AES key wrapping (default=on)\n"
> >>      "                dea-key-wrap=on|off controls support for DEA key wrapping (default=on)\n"
> >>      "                suppress-vmdesc=on|off disables self-describing migration (default=off)\n"
> >> @@ -71,8 +70,6 @@ more than one accelerator specified, the next one is used if the previous one
> >>  fails to initialize.
> >>  @item kernel_irqchip=on|off
> >>  Controls in-kernel irqchip support for the chosen accelerator when available.
> >> -@item gfx_passthru=on|off
> >> -Enables IGD GFX passthrough support for the chosen machine when available.
> >>  @item vmport=on|off|auto
> >>  Enables emulation of VMWare IO port, for vmmouse etc. auto says to select the
> >>  value based on accel. For accel=xen the default is off otherwise the default
> >> @@ -118,8 +115,9 @@ Select CPU model (@code{-cpu help} for list and additional feature selection)
> >>  ETEXI
> >>
> >>  DEF("accel", HAS_ARG, QEMU_OPTION_accel,
> >> -    "-accel [accel=]accelerator[,thread=single|multi]\n"
> >> +    "-accel [accel=]accelerator[,prop[=value][,...]]\n"
> >>      "                select accelerator (kvm, xen, hax, hvf, whpx or tcg; use 'help' for a list)\n"
> >> +    "                igd-passthru=on|off (enable Xen integrated Intel graphics passthrough, default=off)\n"
> >>      "                tb-size=n (TCG translation block cache size)\n"
> >>      "                thread=single|multi (enable multi-threaded TCG)\n", QEMU_ARCH_ALL)
> >>  STEXI
> >> @@ -130,6 +128,9 @@ kvm, xen, hax, hvf, whpx or tcg can be available. By default, tcg is used. If th
> >>  more than one accelerator specified, the next one is used if the previous one
> >>  fails to initialize.
> >>  @table @option
> >> +@item igd-passthru=on|off
> >> +When Xen is in use, this option controls whether Intel integrated graphics
> >> +devices can be passed through to the guest (default=off)
> >>  @item tb-size=@var{n}
> >>  Controls the size (in MiB) of the TCG translation block cache.
> >>  @item thread=single|multi
> >> diff --git a/vl.c b/vl.c
> >> index 06c6ad9..7d8fed1 100644
> >> --- a/vl.c
> >> +++ b/vl.c
> >> @@ -1256,13 +1256,6 @@ static void configure_msg(QemuOpts *opts)
> >>  }
> >>
> >>
> >> -/* Now we still need this for compatibility with XEN. */
> >> -bool has_igd_gfx_passthru;
> >> -static void igd_gfx_passthru(void)
> >> -{
> >> -    has_igd_gfx_passthru = current_machine->igd_gfx_passthru;
> >> -}
> >> -
> >>  /***********************************************************/
> >>  /* USB devices */
> >>
> >> @@ -2645,6 +2638,10 @@ static int machine_set_property(void *opaque,
> >>      if (g_str_equal(qom_name, "accel")) {
> >>          return 0;
> >>      }
> >> +    if (g_str_equal(qom_name, "igd-passthru")) {
> >> +        object_register_sugar_prop(ACCEL_CLASS_NAME("xen"), qom_name, value);
> >> +        return 0;
> >> +    }
> >>
> >>      r = object_parse_property_opt(opaque, name, value, "type", errp);
> >>      g_free(qom_name);
> >> @@ -4449,9 +4446,6 @@ int main(int argc, char **argv, char **envp)
> >>              exit(1);
> >>      }
> >>
> >> -    /* Check if IGD GFX passthrough. */
> >> -    igd_gfx_passthru();
> >> -
> >>      /* init generic devices */
> >>      rom_set_order_override(FW_CFG_ORDER_OVERRIDE_DEVICE);
> >>      qemu_opts_foreach(qemu_find_opts("device"),
> >> --
> >> 1.8.3.1
> >>
> >>
> >>
> >
>

