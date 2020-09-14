Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075C4C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 09:14:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A063C20EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 09:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtwqkzGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A063C20EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHkYg-0002Rj-QN
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 05:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ameynarkhede03@gmail.com>)
 id 1kHkY0-0001a5-Sm
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 05:13:16 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:36314)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ameynarkhede03@gmail.com>)
 id 1kHkXz-0008J8-4r
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 05:13:16 -0400
Received: by mail-pg1-x541.google.com with SMTP id f2so9010118pgd.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 02:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=xj1d+Sx5/JOifWq4WQ0hc3mcoPyEEX5rtqoKh8IV/bM=;
 b=dtwqkzGhhPS024lVb1RMwfyz855O9tQYt/kiLM33fke68FsWqpnl5JfMtJ7iUTbIdg
 O54KeEYj2m0X7ZDg0LmACsFm5S88Og57MwpOWIxBYFypkr/viNBOBp1rTqLPt08l62Uc
 RfDmNYZxMddOYmFIBTEBWYuwzjyiCYLpn9us3zXqvFTm5AQlCEQULD4/YHNVG9EPVxG6
 bQ+Z6wA3JsENkszmpM67ClIJ89vjR/if0kS/9/lVPnVoAgy7fHHN53tRHrugMO5R53SB
 /RVoXEt7hQjgPwPhj9ar+LrX0onitqY7rxNYFZrbbDejJz9cb3Jc73izurFaYpFcc4nU
 L1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xj1d+Sx5/JOifWq4WQ0hc3mcoPyEEX5rtqoKh8IV/bM=;
 b=msTOFnCgQDmp4IwVF6QeDjshIx2GTq9dLsWqYWKbSOpk+HiRG9NWzrMwffglzAXi8g
 Gg/mqFFNpMVnb2JSOH6Qg0B20+fA6sfu2vxVpXkKSUr2hBB6K2dfS/s5p6eznfQdCOQw
 xiML2Zdz5GSNFWs9KagAdRd2zQIAD/oqwOwp6WAQx7XPsqrg6H8Ybn0gnl96Lp8Egcek
 U/upN3LukmT3pyh5HLFHvNmeyUwEU+bvnXXHBbGqPDACWtEwG0XfrhiQF++vH+c1wc0Q
 IvWoYNNkaE7zAqiETRARUkwK7Co6xhx6ghTiRg4+N4tLPk2xtplJt0BxDDJ3RT3B2qy2
 4ERw==
X-Gm-Message-State: AOAM5334uc0SFVG8AIadJrtIqj2Y1F3PEKvTQdjdDA1QhQW1nxHQgnsW
 LTGqgupezdkWPfFkG+DEwBs=
X-Google-Smtp-Source: ABdhPJzFT3qaS52jrV01wP40GU8hTV9Brd2Gmo/gqEdiFwbgZK5i47ISAiWYeAFYMogfPMwQvXGQUQ==
X-Received: by 2002:a05:6a00:808:b029:13e:d13d:a05d with SMTP id
 m8-20020a056a000808b029013ed13da05dmr12137017pfk.35.1600074793613; 
 Mon, 14 Sep 2020 02:13:13 -0700 (PDT)
Received: from localhost ([103.248.31.177])
 by smtp.gmail.com with ESMTPSA id j11sm7820924pgh.8.2020.09.14.02.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 02:13:13 -0700 (PDT)
Date: Mon, 14 Sep 2020 14:43:09 +0530
From: Amey Narkhede <ameynarkhede03@gmail.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/scsi/vmw_pvscsi.c: Fix wrong usage of gboolean types
 in PVSCSIState
Message-ID: <20200914091309.n6pvk4r5vsx6gzar@archlinux>
References: <20200913234451.170022-1-ameynarkhede03@gmail.com>
 <bee146be-e867-6c6f-4007-b61751be1e6c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hh4u5ljmqibfnas7"
Content-Disposition: inline
In-Reply-To: <bee146be-e867-6c6f-4007-b61751be1e6c@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=ameynarkhede03@gmail.com; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--hh4u5ljmqibfnas7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20/09/14 08:32AM, Philippe Mathieu-Daud=E9 wrote:
> Hi Amey,
>
> On 9/14/20 1:44 AM, Amey Narkhede wrote:
> > rings_info_valid, msg_ring_info_valid and use_msg fields of struct
> > PVSCSIState are using gboolean TRUE/FALSE values with the type uint8_t.
> > Change their type to bool along with the usage of initialization macro
> > VMSTATE_BOOL during initialization of vmstate_pvscsi and
> > pvscsi_properties.
> >
> > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > ---
> >  hw/scsi/vmw_pvscsi.c | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
> > index c071e0c7aa..86f00e3d7e 100644
> > --- a/hw/scsi/vmw_pvscsi.c
> > +++ b/hw/scsi/vmw_pvscsi.c
> > @@ -123,9 +123,9 @@ typedef struct {
> >      /* Collector for current command data */
> >      uint32_t curr_cmd_data[PVSCSI_MAX_CMD_DATA_WORDS];
> >
> > -    uint8_t rings_info_valid;            /* Whether data rings initial=
ized   */
> > -    uint8_t msg_ring_info_valid;         /* Whether message ring initi=
alized */
> > -    uint8_t use_msg;                     /* Whether to use message rin=
g      */
> > +    bool rings_info_valid;            /* Whether data rings initialize=
d   */
> > +    bool msg_ring_info_valid;         /* Whether message ring initiali=
zed */
> > +    bool use_msg;                     /* Whether to use message ring  =
    */
> >
> >      uint8_t msi_used;                    /* For migration compatibilit=
y      */
> >      PVSCSIRingInfo rings;                /* Data transfer rings manage=
r      */
> > @@ -349,8 +349,8 @@ pvscsi_reset_state(PVSCSIState *s)
> >      s->reg_command_status =3D PVSCSI_COMMAND_PROCESSING_SUCCEEDED;
> >      s->reg_interrupt_status =3D 0;
> >      pvscsi_ring_cleanup(&s->rings);
> > -    s->rings_info_valid =3D FALSE;
> > -    s->msg_ring_info_valid =3D FALSE;
> > +    s->rings_info_valid =3D false;
> > +    s->msg_ring_info_valid =3D false;
> >      QTAILQ_INIT(&s->pending_queue);
> >      QTAILQ_INIT(&s->completion_queue);
> >  }
> > @@ -792,7 +792,7 @@ pvscsi_on_cmd_setup_rings(PVSCSIState *s)
> >      pvscsi_dbg_dump_tx_rings_config(rc);
> >      pvscsi_ring_init_data(&s->rings, rc);
> >
> > -    s->rings_info_valid =3D TRUE;
> > +    s->rings_info_valid =3D true;
> >      return PVSCSI_COMMAND_PROCESSING_SUCCEEDED;
> >  }
> >
> > @@ -874,7 +874,7 @@ pvscsi_on_cmd_setup_msg_ring(PVSCSIState *s)
> >          if (pvscsi_ring_init_msg(&s->rings, rc) < 0) {
> >              return PVSCSI_COMMAND_PROCESSING_FAILED;
> >          }
> > -        s->msg_ring_info_valid =3D TRUE;
> > +        s->msg_ring_info_valid =3D true;
> >      }
> >      return sizeof(PVSCSICmdDescSetupMsgRing) / sizeof(uint32_t);
> >  }
> > @@ -1232,9 +1232,9 @@ static const VMStateDescription vmstate_pvscsi =
=3D {
> >          VMSTATE_UINT32(curr_cmd_data_cntr, PVSCSIState),
> >          VMSTATE_UINT32_ARRAY(curr_cmd_data, PVSCSIState,
> >                               ARRAY_SIZE(((PVSCSIState *)NULL)->curr_cm=
d_data)),
> > -        VMSTATE_UINT8(rings_info_valid, PVSCSIState),
> > -        VMSTATE_UINT8(msg_ring_info_valid, PVSCSIState),
> > -        VMSTATE_UINT8(use_msg, PVSCSIState),
> > +        VMSTATE_BOOL(rings_info_valid, PVSCSIState),
> > +        VMSTATE_BOOL(msg_ring_info_valid, PVSCSIState),
> > +        VMSTATE_BOOL(use_msg, PVSCSIState),
>
> I believe this change the migration data structure. This
> area is described in "Changing migration data structures"
> in docs/devel/migration.rst.
>
> If this structure were not affected, your change would be
> a good cleanup. However changing migration can become a
> nightmare, so ... cleaning this is hard.
>
> Cc'ing Dave (a migration maintainer) as I'm not sure there
> already is a document describing easily this problem.
>
So should I drop those migration related changes?
> >
> >          VMSTATE_UINT64(rings.rs_pa, PVSCSIState),
> >          VMSTATE_UINT32(rings.txr_len_mask, PVSCSIState),
> > @@ -1255,7 +1255,7 @@ static const VMStateDescription vmstate_pvscsi =
=3D {
> >  };
> >
> >  static Property pvscsi_properties[] =3D {
> > -    DEFINE_PROP_UINT8("use_msg", PVSCSIState, use_msg, 1),
> > +    DEFINE_PROP_BOOL("use_msg", PVSCSIState, use_msg, true),
> >      DEFINE_PROP_BIT("x-old-pci-configuration", PVSCSIState, compat_fla=
gs,
> >                      PVSCSI_COMPAT_OLD_PCI_CONFIGURATION_BIT, false),
> >      DEFINE_PROP_BIT("x-disable-pcie", PVSCSIState, compat_flags,
> > --
> > 2.28.0
> >
> > This is my first qemu patch. Let know if there are any mistakes
> >
>

--hh4u5ljmqibfnas7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEb5tNK+B4oWmn+0Z9BBTsy/Z3yzYFAl9fNCUACgkQBBTsy/Z3
yzbHSAf/Z7BRjPoG7+JmWwmCwcvnD3cMNEbosUZmDcROaCdNAbO5AzWqwKLGWqmK
qg4iRU/HjxTMI0FRzSkj80s5Z3WyP7vDFx9ShO+cYIPocXPo3tnS0+6iAYOj7fqR
1egRTntquyA73jsJi1n3wifj/z3q50+XlTrgagfDFHbFDvh+r8mARybVlIKgFV+i
XE8nStVMRFTODoBaRNlHil/+0cyZEFDkq3lCJsLv2EEjLKfyWIEVL+mhfr2M8wME
W2Z7gFd4E4QcjAtGAR1GMTowErJYODd2pQExt/DmZVMneX5vPfurI145yPrx+GRp
lTTYSdRaQtjMe7gwTCCd/XBcQa4nCQ==
=0b/J
-----END PGP SIGNATURE-----

--hh4u5ljmqibfnas7--

