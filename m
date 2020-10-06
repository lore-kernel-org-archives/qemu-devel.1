Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2A1C4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 20:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFBA020760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 20:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBrJhfO1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFBA020760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPtab-000764-Gn
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 16:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <snizovtsev@gmail.com>)
 id 1kPsVv-0003LD-R7; Tue, 06 Oct 2020 15:20:43 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:45951)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <snizovtsev@gmail.com>)
 id 1kPsVs-0003nd-Gv; Tue, 06 Oct 2020 15:20:43 -0400
Received: by mail-lf1-x143.google.com with SMTP id r127so11762281lff.12;
 Tue, 06 Oct 2020 12:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=6AkVONyoTkSImby3ZNRNogUCs9cq0OC9dqQa6gInFYI=;
 b=MBrJhfO1pVMR6KL7AbXpcEAh9AGQ/iWA7Qluz6HJ8SHhjkXqHygkHdVDNy69H/6ZXT
 DemX8aLNm30UBhL+dCLWIRP7JHGIYQMfACAU7qImVpMqhFm4k6If1BspuTYm7KaJMRwU
 Dw10UJU/HZbR77JN61e0iRLRnGMwAP2iJio7qIiCOFPm8tWI0FikRzkOBIeSxmQPu/bk
 QuI6qwp3WduUThtaaKz5l44ESRVgAMsxkMD/noz4VNNfDvSI1TC/0hmLIgAfvjkWG6YT
 hUKZVyUH8UUz6aFRugtJZMn8unGVDQ3pKt9ZG6oh5dIW9qQf25Oq3dxiOhH4uA6wdhGa
 IZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=6AkVONyoTkSImby3ZNRNogUCs9cq0OC9dqQa6gInFYI=;
 b=RfQ2LIosoal7K6D80FrZqxhh7Plg2vi7ueWxQh7l74EHHtpO1YnMmOzfLUpewuZHrB
 S4cUi4QP6ZeMTGDDm922DrgZ++L52hupXTAeO0n5Kh/n6pq3GKUHygBwPiHa8Od5+A0m
 u7v4wAzgFKstQrxpikJZInmq0STUKBiUas6Ym6uFbfTt3d/77amtk894LJgqLcfsyANp
 hfetfaefsXlhFq5nCqbJiUY8aaCuXpTvgd1c6mcH1gUFCbRlfiiNT//weyQ6TWD9sEWC
 krfuNg9V7w8Op5mw/uSl9rf3OWITU8ikLnT7l7910QpzK1FDdYOrSJpbvcyTK32g79wL
 IgdQ==
X-Gm-Message-State: AOAM5300oRIaB6zS5GQVDQ2NSywKXmWRBG0qxTshGUFR/LsrKyKKAxYN
 Y8qlPSbX72v580zzMplpZf8=
X-Google-Smtp-Source: ABdhPJzp2Esgs4zuW9KK01JW3LLcymg4CNAKSBUSPd9rsG/uJsGcTmf8dsaMgLb4m7IGebC/PzbR2w==
X-Received: by 2002:a19:ae0e:: with SMTP id f14mr922046lfc.249.1602012037821; 
 Tue, 06 Oct 2020 12:20:37 -0700 (PDT)
Received: from winnie ([2a02:2168:a1e1:7f00:efc9:8465:4b3a:8d04])
 by smtp.gmail.com with ESMTPSA id m22sm712725lfb.27.2020.10.06.12.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 12:20:36 -0700 (PDT)
Message-ID: <ea2f637545fb0dbc21cb7d6ff2b7839307d06b3f.camel@gmail.com>
Subject: Re: [PATCH] qom: fix objects with improper parent type
From: snizovtsev@gmail.com
To: "Michael S. Tsirkin" <mst@redhat.com>
Date: Tue, 06 Oct 2020 22:20:35 +0300
In-Reply-To: <20201006015528-mutt-send-email-mst@kernel.org>
References: <CAHOaf96qxm6_qigD+DuoJ5GpS9rOqXe4Gv=2UnujiiwcfN0HHQ@mail.gmail.com>
 <20201006015528-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=snizovtsev@gmail.com; helo=mail-lf1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 06 Oct 2020 16:27:43 -0400
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
Cc: qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-10-06 at 01:55 -0400, Michael S. Tsirkin wrote:
> On Tue, Sep 29, 2020 at 04:47:14PM -0700, Sergey Nizovtsev wrote:
> > Some objects accidentally inherit ObjectClass instead of Object.
> > They compile silently but may crash after downcasting.
> > 
> > In this patch, we introduce a coccinelle script to find broken
> > declarations and fix them manually with proper base type.
> > 
> > Signed-off-by: Sergey Nizovtsev <snizovtsev@gmail.com>
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> 
> which tree should this go in through?

Well, since this may only affect some generic QOM walking code, i
suggest it goes in QOM/QObject/QMP related tree.

So, `scripts/get_maintainer.pl -f qom/object.c`:

+CC Paolo Bonzini <pbonzini@redhat.com>
-CC Ben Warren <ben@skyportsystems.com>

On Tue, 2020-10-06 at 00:06 +0400, Marc-André Lureau wrote:
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

On Mon, 2020-10-05 at 18:47 +0200, Igor Mammedov wrote:
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> > ---
> >  scripts/coccinelle/qobject-parent-type.cocci | 26
> > ++++++++++++++++++++
> >  include/hw/acpi/vmgenid.h                    |  2 +-
> >  include/hw/misc/vmcoreinfo.h                 |  2 +-
> >  include/net/can_host.h                       |  2 +-
> >  MAINTAINERS                                  |  1 +
> >  5 files changed, 30 insertions(+), 3 deletions(-)
> >  create mode 100644 scripts/coccinelle/qobject-parent-type.cocci
> > 
> > diff --git a/scripts/coccinelle/qobject-parent-type.cocci
> > b/scripts/coccinelle/qobject-parent-type.cocci
> > new file mode 100644
> > index 0000000000..9afb3edd97
> > --- /dev/null
> > +++ b/scripts/coccinelle/qobject-parent-type.cocci
> > @@ -0,0 +1,26 @@
> > +// Highlight object declarations that don't look like object class
> > but
> > +// accidentally inherit from it.
> > +
> > +@match@
> > +identifier obj_t, fld;
> > +type parent_t =~ ".*Class$";
> > +@@
> > +struct obj_t {
> > +    parent_t fld;
> > +    ...
> > +};
> > +
> > +@script:python filter depends on match@
> > +obj_t << match.obj_t;
> > +@@
> > +is_class_obj = obj_t.endswith('Class')
> > +cocci.include_match(not is_class_obj)
> > +
> > +@replacement depends on filter@
> > +identifier match.obj_t, match.fld;
> > +type match.parent_t;
> > +@@
> > +struct obj_t {
> > +*   parent_t fld;
> > +    ...
> > +};
> > diff --git a/include/hw/acpi/vmgenid.h b/include/hw/acpi/vmgenid.h
> > index d50fbacb8e..cb4ad37fc5 100644
> > --- a/include/hw/acpi/vmgenid.h
> > +++ b/include/hw/acpi/vmgenid.h
> > @@ -19,7 +19,7 @@
> >  OBJECT_DECLARE_SIMPLE_TYPE(VmGenIdState, VMGENID)
> > 
> >  struct VmGenIdState {
> > -    DeviceClass parent_obj;
> > +    DeviceState parent_obj;
> >      QemuUUID guid;                /* The 128-bit GUID seen by the
> > guest */
> >      uint8_t vmgenid_addr_le[8];   /* Address of the GUID (little-
> > endian) */
> >  };
> > diff --git a/include/hw/misc/vmcoreinfo.h
> > b/include/hw/misc/vmcoreinfo.h
> > index ebada6617a..0b7b55d400 100644
> > --- a/include/hw/misc/vmcoreinfo.h
> > +++ b/include/hw/misc/vmcoreinfo.h
> > @@ -24,7 +24,7 @@ DECLARE_INSTANCE_CHECKER(VMCoreInfoState,
> > VMCOREINFO,
> >  typedef struct fw_cfg_vmcoreinfo FWCfgVMCoreInfo;
> > 
> >  struct VMCoreInfoState {
> > -    DeviceClass parent_obj;
> > +    DeviceState parent_obj;
> > 
> >      bool has_vmcoreinfo;
> >      FWCfgVMCoreInfo vmcoreinfo;
> > diff --git a/include/net/can_host.h b/include/net/can_host.h
> > index 4e3ce3f954..caab71bdda 100644
> > --- a/include/net/can_host.h
> > +++ b/include/net/can_host.h
> > @@ -35,7 +35,7 @@
> >  OBJECT_DECLARE_TYPE(CanHostState, CanHostClass, CAN_HOST)
> > 
> >  struct CanHostState {
> > -    ObjectClass oc;
> > +    Object oc;
> > 
> >      CanBusState *bus;
> >      CanBusClientState bus_client;
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5eed1e692b..2160b8196a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2402,6 +2402,7 @@ F: qobject/
> >  F: include/qapi/qmp/
> >  X: include/qapi/qmp/dispatch.h
> >  F: scripts/coccinelle/qobject.cocci
> > +F: scripts/coccinelle/qobject-parent-type.cocci
> >  F: tests/check-qdict.c
> >  F: tests/check-qjson.c
> >  F: tests/check-qlist.c
> > -- 
> > 2.28.0


