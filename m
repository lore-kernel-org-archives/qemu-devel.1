Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396ABC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 10:44:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FB0220FC3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 10:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLt6Kjfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB0220FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVuYd-0005JP-Tk
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 06:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kVuV5-0003ur-Sh; Fri, 23 Oct 2020 06:40:48 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635]:32973)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kVuUw-0003Tg-Bv; Fri, 23 Oct 2020 06:40:47 -0400
Received: by mail-ej1-x635.google.com with SMTP id c15so1736329ejs.0;
 Fri, 23 Oct 2020 03:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OTCP+7tOW8pgVD5HSCtXE6V5/LW40go9ZT+dWuc0rTQ=;
 b=TLt6KjfvA5doH758/uu+kT3VZaOap4y5DiSNWpNtr4Usd0NZXKIBJI025HCAcaFK/V
 vKWaBGvbEJoop0NFvg6QHqmLeYJhsljlZ+7idoDIa+H5o+0/7iJ60om+6guzXLORnNvH
 x6PUZOCar0CNW+tnMJRS+Y18vEvAWEPdLY2Gn8illgVUyucctcM+AM3fIY/RHo/v66+J
 +gaUL9II7vsLm2m2PG2HVf6WkZWlxIK4cnKkcutak/7JwPQ928mkSD/XMZw3Dmfi9TP/
 4yIWmgmlkttn+O2o28TIVNBKBqSd6vIGLT5/qEt0VArktjGpGm6fGJQJaCV//CNF56Ds
 W4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OTCP+7tOW8pgVD5HSCtXE6V5/LW40go9ZT+dWuc0rTQ=;
 b=NiD+S+Rvd6C7qM9HuM0NZrgzPcRHPAxMcu0P7E+kviQcraz6RUPI3KEPx+OuHvD2aS
 RLmpy+oZ6eOcFtTsNYP71P4kPFjJw5DmvFEHWEL+DUz4cjiB/q59UrNkwkUGYNGlxEV4
 YHVuqWBi8SR+2IIMy0TPZkHkJDk7JMUcb78Wo2iWVagDmbprm8aVCDeL8nj1PAPzmNFA
 nIqWGJskIlvoI6rfqysowPCDQdktsUiATkPITG4DsDSybMcaX0sKuGawmPWKpFFqFD5E
 45Nj0CTCA2xokSJzV/ey+VTma8Uwmg7iN5YIF0UWfmX++o3ig4neCPKPsB6imPCcYS2G
 6UUw==
X-Gm-Message-State: AOAM532ActNw4ojwlZgMZV6JofYKtNN7X0CgbyoXDJF4H0+4BO7Z0CgV
 5ZOHsGJ7P6/VL1xsTSHhpWUKlfsSURfX7G2li3dt+lJs8ZZYwQ==
X-Google-Smtp-Source: ABdhPJwiZTqn1gAynHkrNoqAo0Rkt/Y/mShf3UIPQ0nE+q07gzQNgPxhbdYO2AB8u+5en1WeLGAYis8Ukv0sIdIEvGU=
X-Received: by 2002:a17:906:388d:: with SMTP id
 q13mr1248494ejd.92.1603449636132; 
 Fri, 23 Oct 2020 03:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201023101222.250147-1-kwolf@redhat.com>
 <20201023101222.250147-4-kwolf@redhat.com>
In-Reply-To: <20201023101222.250147-4-kwolf@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 23 Oct 2020 14:40:23 +0400
Message-ID: <CAJ+F1CJAzbRwab5E7XQUEpTXX1e+DE_QkknoEgvYqmHAeqY2MQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] qapi: Remove wrapper struct for simple unions
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000fa1b4b05b25435c6"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x635.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000fa1b4b05b25435c6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Oct 23, 2020 at 2:14 PM Kevin Wolf <kwolf@redhat.com> wrote:

> Variants of simple unions are always contained in a wrapper object
> called 'data' that serves no real use. When mapping a QAPI object to the
> command line, this becomes very visible to users because they have to
> add one or more useless 'data.' to many option names.
>
> As a first step towards avoiding this painful CLI experience, this gets
> rid of the 'data' indirection internally: The QAPI parser doesn't use a
> wrapper object as the variant type any more, so the indirection is
> removed from the generated C types. As a result, the C type looks the
> same for flat and simple unions now. A large part of this patch is
> mechanical conversion of C code to remove the 'data' indirection.
>
> Conceptually, the important change is that variants can now have flat
> and wrapped representations. For a transitioning period, we'll allow
> variants to support both representations in a later patch. Eventually,
> the plan is to deprecate and remove wrapped representations entirely,
> unifying simple and flat unions.
>
> The externally visible interfaces stay unchanged: Visitors still expect
> the 'data' wrappers, and introspection still shows it.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>

breaks the build for me:

../chardev/spice.c: In function =E2=80=98qemu_chr_open_spice_vmc=E2=80=99:
../chardev/spice.c:261:56: error: =E2=80=98ChardevSpiceChannel=E2=80=99 has=
 no member named
=E2=80=98data=E2=80=99
  261 |     ChardevSpiceChannel *spicevmc =3D backend->u.spicevmc.data;
      |                                                        ^
../chardev/spice.c: In function =E2=80=98qemu_chr_open_spice_port=E2=80=99:
../chardev/spice.c:297:55: error: =E2=80=98ChardevSpicePort=E2=80=99 has no=
 member named
=E2=80=98data=E2=80=99
  297 |     ChardevSpicePort *spiceport =3D backend->u.spiceport.data;
      |                                                       ^
../chardev/spice.c: In function =E2=80=98qemu_chr_parse_spice_vmc=E2=80=99:
../chardev/spice.c:331:35: error: =E2=80=98ChardevSpiceChannel=E2=80=99 has=
 no member named
=E2=80=98data=E2=80=99
  331 |     spicevmc =3D backend->u.spicevmc.data =3D
g_new0(ChardevSpiceChannel, 1);
      |                                   ^
../chardev/spice.c: In function =E2=80=98qemu_chr_parse_spice_port=E2=80=99=
:
../chardev/spice.c:347:37: error: =E2=80=98ChardevSpicePort=E2=80=99 has no=
 member named
=E2=80=98data=E2=80=99
  347 |     spiceport =3D backend->u.spiceport.data =3D
g_new0(ChardevSpicePort, 1);
      |                                     ^
../ui/spice-app.c: In function =E2=80=98chr_spice_backend_new=E2=80=99:
../ui/spice-app.c:63:20: error: =E2=80=98ChardevSpicePort=E2=80=99 has no m=
ember named
=E2=80=98data=E2=80=99
   63 |     be->u.spiceport.data =3D g_new0(ChardevSpicePort, 1);
      |                    ^
../ui/spice-app.c: In function =E2=80=98vc_chr_open=E2=80=99:
../ui/spice-app.c:86:20: error: =E2=80=98ChardevSpicePort=E2=80=99 has no m=
ember named
=E2=80=98data=E2=80=99
   86 |     be->u.spiceport.data->fqdn =3D fqdn ?
      |                    ^
../ui/spice-app.c: In function =E2=80=98spice_app_display_init=E2=80=99:
../ui/spice-app.c:185:20: error: =E2=80=98ChardevSpicePort=E2=80=99 has no =
member named
=E2=80=98data=E2=80=99
  185 |     be->u.spiceport.data->fqdn =3D g_strdup("org.qemu.monitor.qmp.0=
");
      |                    ^


> ---
>  docs/devel/qapi-code-gen.txt           | 32 ++++++++----
>  backends/tpm/tpm_emulator.c            |  3 +-
>  backends/tpm/tpm_passthrough.c         |  4 +-
>  block/crypto.c                         |  3 +-
>  block/qcow2.c                          |  9 ++--
>  block/vmdk.c                           | 14 ++----
>  blockdev.c                             | 36 ++++++-------
>  chardev/char-file.c                    |  5 +-
>  chardev/char-mux.c                     |  5 +-
>  chardev/char-parallel.c                |  5 +-
>  chardev/char-pipe.c                    |  7 ++-
>  chardev/char-ringbuf.c                 |  5 +-
>  chardev/char-serial.c                  |  5 +-
>  chardev/char-socket.c                  | 13 ++---
>  chardev/char-stdio.c                   |  5 +-
>  chardev/char-udp.c                     | 11 ++--
>  chardev/char.c                         | 10 ++--
>  chardev/msmouse.c                      |  4 +-
>  chardev/wctablet.c                     |  4 +-
>  hw/core/numa.c                         |  6 +--
>  hw/display/xenfb.c                     |  8 +--
>  hw/input/hid.c                         |  8 +--
>  hw/input/ps2.c                         |  6 +--
>  hw/input/virtio-input-hid.c            |  8 +--
>  hw/mem/pc-dimm.c                       | 18 +++----
>  hw/virtio/virtio-mem-pci.c             |  3 +-
>  hw/virtio/virtio-pmem-pci.c            |  3 +-
>  monitor/hmp-cmds.c                     | 14 +++---
>  qemu-keymap.c                          |  2 +-
>  replay/replay-input.c                  | 46 +++++++----------
>  tests/test-char.c                      | 12 ++---
>  tests/test-clone-visitor.c             | 14 +++---
>  tests/test-qmp-cmds.c                  |  2 +-
>  tests/test-qobject-input-visitor.c     | 24 ++++-----
>  tests/test-qobject-output-visitor.c    | 24 ++++-----
>  ui/console.c                           |  5 +-
>  ui/input-keymap.c                      | 12 ++---
>  ui/input-legacy.c                      | 12 ++---
>  ui/input.c                             | 43 ++++++++--------
>  util/qemu-sockets.c                    |  8 +--
>  scripts/qapi/introspect.py             |  7 ++-
>  scripts/qapi/schema.py                 | 48 ++++++++++++++----
>  scripts/qapi/visit.py                  | 28 +++++++++++
>  tests/qapi-schema/doc-good.out         |  8 +--
>  tests/qapi-schema/qapi-schema-test.out | 70 +++++++-------------------
>  45 files changed, 308 insertions(+), 311 deletions(-)
>
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index c6438c6aa9..9722c1a204 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -310,7 +310,20 @@ The BRANCH's STRING name is the branch name.
>  The BRANCH's value defines the branch's properties, in particular its
>  type.  The form TYPE-REF is shorthand for { 'type': TYPE-REF }.
>
> -A simple union type defines a mapping from automatic discriminator
> +Each branch can have flat or wrapped representation in the Client JSON
> +Protocol.
> +
> +Wrapped representation of a branch means that it is represented by a
> +'data' member that is of the specified data type corresponding to the
> +discriminator value.
> +
> +Flat representation means that the union forms a single object that
> +contains both common members (from the base type) and the selected
> +branch's members, without any additional nesting.  The two sets of
> +member names must be disjoint.
> +
> +A simple union type automatically contains the 'type' member as a
> +discriminator and defines a mapping from automatic discriminator
>  values to data types like in this example:
>
>   { 'struct': 'BlockdevOptionsFile', 'data': { 'filename': 'str' } }
> @@ -321,10 +334,8 @@ values to data types like in this example:
>     'data': { 'file': 'BlockdevOptionsFile',
>               'qcow2': 'BlockdevOptionsQcow2' } }
>
> -In the Client JSON Protocol, a simple union is represented by an
> -object that contains the 'type' member as a discriminator, and a
> -'data' member that is of the specified data type corresponding to the
> -discriminator value, as in these examples:
> +In the Client JSON Protocol, all simple union branches have wrapped
> +representation, as in these examples:
>
>   { "type": "file", "data": { "filename": "/some/place/my-image" } }
>   { "type": "qcow2", "data": { "backing": "/some/place/my-image",
> @@ -344,13 +355,12 @@ object, it defines common members just like a struc=
t
> type's 'data'
>  member defines struct type members.  If it is a STRING, it names a
>  struct type whose members are the common members.
>
> -All flat union branches must be of struct type.
> +Member 'discriminator' must name a non-optional enum-typed member of
> +the base struct and defines the option that should server as the
> +discrimiator.
>
> -In the Client JSON Protocol, a flat union is represented by an object
> -with the common members (from the base type) and the selected branch's
> -members.  The two sets of member names must be disjoint.  Member
> -'discriminator' must name a non-optional enum-typed member of the base
> -struct.
> +All flat union branches must be of struct type.  They have always flat
> +representation.
>
>  The following example enhances the above simple union example by
>  adding an optional common member 'read-only', renaming the
> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> index 201cd38503..7d2dc2b19d 100644
> --- a/backends/tpm/tpm_emulator.c
> +++ b/backends/tpm/tpm_emulator.c
> @@ -629,7 +629,8 @@ static TpmTypeOptions
> *tpm_emulator_get_tpm_options(TPMBackend *tb)
>      TpmTypeOptions *options =3D g_new0(TpmTypeOptions, 1);
>
>      options->type =3D TPM_TYPE_OPTIONS_KIND_EMULATOR;
> -    options->u.emulator.data =3D QAPI_CLONE(TPMEmulatorOptions,
> tpm_emu->options);
> +    QAPI_CLONE_MEMBERS(TPMEmulatorOptions, &options->u.emulator,
> +                       tpm_emu->options);
>
>      return options;
>  }
> diff --git a/backends/tpm/tpm_passthrough.c
> b/backends/tpm/tpm_passthrough.c
> index 8f6f4998a5..7fa7c84f5a 100644
> --- a/backends/tpm/tpm_passthrough.c
> +++ b/backends/tpm/tpm_passthrough.c
> @@ -322,8 +322,8 @@ static TpmTypeOptions
> *tpm_passthrough_get_tpm_options(TPMBackend *tb)
>      TpmTypeOptions *options =3D g_new0(TpmTypeOptions, 1);
>
>      options->type =3D TPM_TYPE_OPTIONS_KIND_PASSTHROUGH;
> -    options->u.passthrough.data =3D QAPI_CLONE(TPMPassthroughOptions,
> -
>  TPM_PASSTHROUGH(tb)->options);
> +    QAPI_CLONE_MEMBERS(TPMPassthroughOptions, &options->u.passthrough,
> +                       TPM_PASSTHROUGH(tb)->options);
>
>      return options;
>  }
> diff --git a/block/crypto.c b/block/crypto.c
> index 0807557763..0e7838d70a 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -775,8 +775,7 @@ block_crypto_get_specific_info_luks(BlockDriverState
> *bs, Error **errp)
>
>      spec_info =3D g_new(ImageInfoSpecific, 1);
>      spec_info->type =3D IMAGE_INFO_SPECIFIC_KIND_LUKS;
> -    spec_info->u.luks.data =3D g_new(QCryptoBlockInfoLUKS, 1);
> -    *spec_info->u.luks.data =3D info->u.luks;
> +    spec_info->u.luks =3D info->u.luks;
>
>      /* Blank out pointers we've just stolen to avoid double free */
>      memset(&info->u.luks, 0, sizeof(info->u.luks));
> diff --git a/block/qcow2.c b/block/qcow2.c
> index b05512718c..104fd8ad06 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -5052,10 +5052,9 @@ static ImageInfoSpecific
> *qcow2_get_specific_info(BlockDriverState *bs,
>      spec_info =3D g_new(ImageInfoSpecific, 1);
>      *spec_info =3D (ImageInfoSpecific){
>          .type  =3D IMAGE_INFO_SPECIFIC_KIND_QCOW2,
> -        .u.qcow2.data =3D g_new0(ImageInfoSpecificQCow2, 1),
>      };
>      if (s->qcow_version =3D=3D 2) {
> -        *spec_info->u.qcow2.data =3D (ImageInfoSpecificQCow2){
> +        spec_info->u.qcow2 =3D (ImageInfoSpecificQCow2){
>              .compat             =3D g_strdup("0.10"),
>              .refcount_bits      =3D s->refcount_bits,
>          };
> @@ -5068,7 +5067,7 @@ static ImageInfoSpecific
> *qcow2_get_specific_info(BlockDriverState *bs,
>              qapi_free_QCryptoBlockInfo(encrypt_info);
>              return NULL;
>          }
> -        *spec_info->u.qcow2.data =3D (ImageInfoSpecificQCow2){
> +        spec_info->u.qcow2 =3D (ImageInfoSpecificQCow2){
>              .compat             =3D g_strdup("1.1"),
>              .lazy_refcounts     =3D s->compatible_features &
>                                    QCOW2_COMPAT_LAZY_REFCOUNTS,
> @@ -5112,8 +5111,8 @@ static ImageInfoSpecific
> *qcow2_get_specific_info(BlockDriverState *bs,
>          memset(&encrypt_info->u, 0, sizeof(encrypt_info->u));
>          qapi_free_QCryptoBlockInfo(encrypt_info);
>
> -        spec_info->u.qcow2.data->has_encrypt =3D true;
> -        spec_info->u.qcow2.data->encrypt =3D qencrypt;
> +        spec_info->u.qcow2.has_encrypt =3D true;
> +        spec_info->u.qcow2.encrypt =3D qencrypt;
>      }
>
>      return spec_info;
> diff --git a/block/vmdk.c b/block/vmdk.c
> index a00dc00eb4..fc4ddcc351 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -2932,18 +2932,14 @@ static ImageInfoSpecific
> *vmdk_get_specific_info(BlockDriverState *bs,
>
>      *spec_info =3D (ImageInfoSpecific){
>          .type =3D IMAGE_INFO_SPECIFIC_KIND_VMDK,
> -        .u =3D {
> -            .vmdk.data =3D g_new0(ImageInfoSpecificVmdk, 1),
> +        .u.vmdk =3D (ImageInfoSpecificVmdk) {
> +            .create_type =3D g_strdup(s->create_type),
> +            .cid =3D s->cid,
> +            .parent_cid =3D s->parent_cid,
>          },
>      };
>
> -    *spec_info->u.vmdk.data =3D (ImageInfoSpecificVmdk) {
> -        .create_type =3D g_strdup(s->create_type),
> -        .cid =3D s->cid,
> -        .parent_cid =3D s->parent_cid,
> -    };
> -
> -    next =3D &spec_info->u.vmdk.data->extents;
> +    next =3D &spec_info->u.vmdk.extents;
>      for (i =3D 0; i < s->num_extents; i++) {
>          *next =3D g_new0(ImageInfoList, 1);
>          (*next)->value =3D vmdk_get_extent_info(&s->extents[i]);
> diff --git a/blockdev.c b/blockdev.c
> index fe6fb5dc1d..2602298a26 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -1090,7 +1090,7 @@ void qmp_blockdev_snapshot_sync(bool has_device,
> const char *device,
>      };
>      TransactionAction action =3D {
>          .type =3D TRANSACTION_ACTION_KIND_BLOCKDEV_SNAPSHOT_SYNC,
> -        .u.blockdev_snapshot_sync.data =3D &snapshot,
> +        .u.blockdev_snapshot_sync =3D snapshot,
>      };
>      blockdev_do_action(&action, errp);
>  }
> @@ -1104,7 +1104,7 @@ void qmp_blockdev_snapshot(const char *node, const
> char *overlay,
>      };
>      TransactionAction action =3D {
>          .type =3D TRANSACTION_ACTION_KIND_BLOCKDEV_SNAPSHOT,
> -        .u.blockdev_snapshot.data =3D &snapshot_data,
> +        .u.blockdev_snapshot =3D snapshot_data,
>      };
>      blockdev_do_action(&action, errp);
>  }
> @@ -1119,7 +1119,7 @@ void qmp_blockdev_snapshot_internal_sync(const char
> *device,
>      };
>      TransactionAction action =3D {
>          .type =3D TRANSACTION_ACTION_KIND_BLOCKDEV_SNAPSHOT_INTERNAL_SYN=
C,
> -        .u.blockdev_snapshot_internal_sync.data =3D &snapshot,
> +        .u.blockdev_snapshot_internal_sync =3D snapshot,
>      };
>      blockdev_do_action(&action, errp);
>  }
> @@ -1289,7 +1289,7 @@ static void internal_snapshot_prepare(BlkActionStat=
e
> *common,
>
>      g_assert(common->action->type =3D=3D
>               TRANSACTION_ACTION_KIND_BLOCKDEV_SNAPSHOT_INTERNAL_SYNC);
> -    internal =3D common->action->u.blockdev_snapshot_internal_sync.data;
> +    internal =3D &common->action->u.blockdev_snapshot_internal_sync;
>      state =3D DO_UPCAST(InternalSnapshotState, common, common);
>
>      /* 1. parse input */
> @@ -1453,7 +1453,7 @@ static void external_snapshot_prepare(BlkActionStat=
e
> *common,
>      switch (action->type) {
>      case TRANSACTION_ACTION_KIND_BLOCKDEV_SNAPSHOT:
>          {
> -            BlockdevSnapshot *s =3D action->u.blockdev_snapshot.data;
> +            BlockdevSnapshot *s =3D &action->u.blockdev_snapshot;
>              device =3D s->node;
>              node_name =3D s->node;
>              new_image_file =3D NULL;
> @@ -1462,7 +1462,7 @@ static void external_snapshot_prepare(BlkActionStat=
e
> *common,
>          break;
>      case TRANSACTION_ACTION_KIND_BLOCKDEV_SNAPSHOT_SYNC:
>          {
> -            BlockdevSnapshotSync *s =3D
> action->u.blockdev_snapshot_sync.data;
> +            BlockdevSnapshotSync *s =3D &action->u.blockdev_snapshot_syn=
c;
>              device =3D s->has_device ? s->device : NULL;
>              node_name =3D s->has_node_name ? s->node_name : NULL;
>              new_image_file =3D s->snapshot_file;
> @@ -1507,7 +1507,7 @@ static void external_snapshot_prepare(BlkActionStat=
e
> *common,
>      }
>
>      if (action->type =3D=3D TRANSACTION_ACTION_KIND_BLOCKDEV_SNAPSHOT_SY=
NC) {
> -        BlockdevSnapshotSync *s =3D action->u.blockdev_snapshot_sync.dat=
a;
> +        BlockdevSnapshotSync *s =3D &action->u.blockdev_snapshot_sync;
>          const char *format =3D s->has_format ? s->format : "qcow2";
>          enum NewImageMode mode;
>          const char *snapshot_node_name =3D
> @@ -1712,7 +1712,7 @@ static void drive_backup_prepare(BlkActionState
> *common, Error **errp)
>      int ret;
>
>      assert(common->action->type =3D=3D TRANSACTION_ACTION_KIND_DRIVE_BAC=
KUP);
> -    backup =3D common->action->u.drive_backup.data;
> +    backup =3D &common->action->u.drive_backup;
>
>      if (!backup->has_mode) {
>          backup->mode =3D NEW_IMAGE_MODE_ABSOLUTE_PATHS;
> @@ -1907,7 +1907,7 @@ static void blockdev_backup_prepare(BlkActionState
> *common, Error **errp)
>      int ret;
>
>      assert(common->action->type =3D=3D
> TRANSACTION_ACTION_KIND_BLOCKDEV_BACKUP);
> -    backup =3D common->action->u.blockdev_backup.data;
> +    backup =3D &common->action->u.blockdev_backup;
>
>      bs =3D bdrv_lookup_bs(backup->device, backup->device, errp);
>      if (!bs) {
> @@ -2012,7 +2012,7 @@ static void
> block_dirty_bitmap_add_prepare(BlkActionState *common,
>          return;
>      }
>
> -    action =3D common->action->u.block_dirty_bitmap_add.data;
> +    action =3D &common->action->u.block_dirty_bitmap_add;
>      /* AIO context taken and released within qmp_block_dirty_bitmap_add =
*/
>      qmp_block_dirty_bitmap_add(action->node, action->name,
>                                 action->has_granularity,
> action->granularity,
> @@ -2033,7 +2033,7 @@ static void
> block_dirty_bitmap_add_abort(BlkActionState *common)
>      BlockDirtyBitmapState *state =3D DO_UPCAST(BlockDirtyBitmapState,
>                                               common, common);
>
> -    action =3D common->action->u.block_dirty_bitmap_add.data;
> +    action =3D &common->action->u.block_dirty_bitmap_add;
>      /* Should not be able to fail: IF the bitmap was added via .prepare(=
),
>       * then the node reference and bitmap name must have been valid.
>       */
> @@ -2053,7 +2053,7 @@ static void
> block_dirty_bitmap_clear_prepare(BlkActionState *common,
>          return;
>      }
>
> -    action =3D common->action->u.block_dirty_bitmap_clear.data;
> +    action =3D &common->action->u.block_dirty_bitmap_clear;
>      state->bitmap =3D block_dirty_bitmap_lookup(action->node,
>                                                action->name,
>                                                &state->bs,
> @@ -2098,7 +2098,7 @@ static void
> block_dirty_bitmap_enable_prepare(BlkActionState *common,
>          return;
>      }
>
> -    action =3D common->action->u.block_dirty_bitmap_enable.data;
> +    action =3D &common->action->u.block_dirty_bitmap_enable;
>      state->bitmap =3D block_dirty_bitmap_lookup(action->node,
>                                                action->name,
>                                                NULL,
> @@ -2136,7 +2136,7 @@ static void
> block_dirty_bitmap_disable_prepare(BlkActionState *common,
>          return;
>      }
>
> -    action =3D common->action->u.block_dirty_bitmap_disable.data;
> +    action =3D &common->action->u.block_dirty_bitmap_disable;
>      state->bitmap =3D block_dirty_bitmap_lookup(action->node,
>                                                action->name,
>                                                NULL,
> @@ -2174,7 +2174,7 @@ static void
> block_dirty_bitmap_merge_prepare(BlkActionState *common,
>          return;
>      }
>
> -    action =3D common->action->u.block_dirty_bitmap_merge.data;
> +    action =3D &common->action->u.block_dirty_bitmap_merge;
>
>      state->bitmap =3D block_dirty_bitmap_merge(action->node, action->tar=
get,
>                                               action->bitmaps,
> &state->backup,
> @@ -2192,7 +2192,7 @@ static void
> block_dirty_bitmap_remove_prepare(BlkActionState *common,
>          return;
>      }
>
> -    action =3D common->action->u.block_dirty_bitmap_remove.data;
> +    action =3D &common->action->u.block_dirty_bitmap_remove;
>
>      state->bitmap =3D block_dirty_bitmap_remove(action->node, action->na=
me,
>                                                false, &state->bs, errp);
> @@ -2895,7 +2895,7 @@ void qmp_drive_backup(DriveBackup *backup, Error
> **errp)
>  {
>      TransactionAction action =3D {
>          .type =3D TRANSACTION_ACTION_KIND_DRIVE_BACKUP,
> -        .u.drive_backup.data =3D backup,
> +        .u.drive_backup =3D *backup,
>      };
>      blockdev_do_action(&action, errp);
>  }
> @@ -2918,7 +2918,7 @@ void qmp_blockdev_backup(BlockdevBackup *backup,
> Error **errp)
>  {
>      TransactionAction action =3D {
>          .type =3D TRANSACTION_ACTION_KIND_BLOCKDEV_BACKUP,
> -        .u.blockdev_backup.data =3D backup,
> +        .u.blockdev_backup =3D *backup,
>      };
>      blockdev_do_action(&action, errp);
>  }
> diff --git a/chardev/char-file.c b/chardev/char-file.c
> index 2fd80707e5..3f0f0b6045 100644
> --- a/chardev/char-file.c
> +++ b/chardev/char-file.c
> @@ -39,7 +39,7 @@ static void qmp_chardev_open_file(Chardev *chr,
>                                    bool *be_opened,
>                                    Error **errp)
>  {
> -    ChardevFile *file =3D backend->u.file.data;
> +    ChardevFile *file =3D &backend->u.file;
>  #ifdef _WIN32
>      HANDLE out;
>      DWORD accessmode;
> @@ -100,14 +100,13 @@ static void qemu_chr_parse_file_out(QemuOpts *opts,
> ChardevBackend *backend,
>                                      Error **errp)
>  {
>      const char *path =3D qemu_opt_get(opts, "path");
> -    ChardevFile *file;
> +    ChardevFile *file =3D &backend->u.file;
>
>      backend->type =3D CHARDEV_BACKEND_KIND_FILE;
>      if (path =3D=3D NULL) {
>          error_setg(errp, "chardev: file: no filename given");
>          return;
>      }
> -    file =3D backend->u.file.data =3D g_new0(ChardevFile, 1);
>      qemu_chr_parse_common(opts, qapi_ChardevFile_base(file));
>      file->out =3D g_strdup(path);
>
> diff --git a/chardev/char-mux.c b/chardev/char-mux.c
> index 6f980bb836..bfb4bc6b8b 100644
> --- a/chardev/char-mux.c
> +++ b/chardev/char-mux.c
> @@ -314,7 +314,7 @@ static void qemu_chr_open_mux(Chardev *chr,
>                                bool *be_opened,
>                                Error **errp)
>  {
> -    ChardevMux *mux =3D backend->u.mux.data;
> +    ChardevMux *mux =3D &backend->u.mux;
>      Chardev *drv;
>      MuxChardev *d =3D MUX_CHARDEV(chr);
>
> @@ -336,14 +336,13 @@ static void qemu_chr_parse_mux(QemuOpts *opts,
> ChardevBackend *backend,
>                                 Error **errp)
>  {
>      const char *chardev =3D qemu_opt_get(opts, "chardev");
> -    ChardevMux *mux;
> +    ChardevMux *mux =3D &backend->u.mux;
>
>      if (chardev =3D=3D NULL) {
>          error_setg(errp, "chardev: mux: no chardev given");
>          return;
>      }
>      backend->type =3D CHARDEV_BACKEND_KIND_MUX;
> -    mux =3D backend->u.mux.data =3D g_new0(ChardevMux, 1);
>      qemu_chr_parse_common(opts, qapi_ChardevMux_base(mux));
>      mux->chardev =3D g_strdup(chardev);
>  }
> diff --git a/chardev/char-parallel.c b/chardev/char-parallel.c
> index 05e7efbd6c..a17157a3be 100644
> --- a/chardev/char-parallel.c
> +++ b/chardev/char-parallel.c
> @@ -244,7 +244,7 @@ static void qmp_chardev_open_parallel(Chardev *chr,
>                                        bool *be_opened,
>                                        Error **errp)
>  {
> -    ChardevHostdev *parallel =3D backend->u.parallel.data;
> +    ChardevHostdev *parallel =3D &backend->u.parallel;
>      int fd;
>
>      fd =3D qmp_chardev_open_file_source(parallel->device, O_RDWR, errp);
> @@ -258,14 +258,13 @@ static void qemu_chr_parse_parallel(QemuOpts *opts,
> ChardevBackend *backend,
>                                      Error **errp)
>  {
>      const char *device =3D qemu_opt_get(opts, "path");
> -    ChardevHostdev *parallel;
> +    ChardevHostdev *parallel =3D &backend->u.parallel;
>
>      if (device =3D=3D NULL) {
>          error_setg(errp, "chardev: parallel: no device path given");
>          return;
>      }
>      backend->type =3D CHARDEV_BACKEND_KIND_PARALLEL;
> -    parallel =3D backend->u.parallel.data =3D g_new0(ChardevHostdev, 1);
>      qemu_chr_parse_common(opts, qapi_ChardevHostdev_base(parallel));
>      parallel->device =3D g_strdup(device);
>  }
> diff --git a/chardev/char-pipe.c b/chardev/char-pipe.c
> index 7eca5d9a56..eb19d9a526 100644
> --- a/chardev/char-pipe.c
> +++ b/chardev/char-pipe.c
> @@ -109,7 +109,7 @@ static void qemu_chr_open_pipe(Chardev *chr,
>                                 bool *be_opened,
>                                 Error **errp)
>  {
> -    ChardevHostdev *opts =3D backend->u.pipe.data;
> +    ChardevHostdev *opts =3D &backend->u.pipe;
>      const char *filename =3D opts->device;
>
>      if (win_chr_pipe_init(chr, filename, errp) < 0) {
> @@ -124,7 +124,7 @@ static void qemu_chr_open_pipe(Chardev *chr,
>                                 bool *be_opened,
>                                 Error **errp)
>  {
> -    ChardevHostdev *opts =3D backend->u.pipe.data;
> +    ChardevHostdev *opts =3D &backend->u.pipe;
>      int fd_in, fd_out;
>      char *filename_in;
>      char *filename_out;
> @@ -158,14 +158,13 @@ static void qemu_chr_parse_pipe(QemuOpts *opts,
> ChardevBackend *backend,
>                                  Error **errp)
>  {
>      const char *device =3D qemu_opt_get(opts, "path");
> -    ChardevHostdev *dev;
> +    ChardevHostdev *dev =3D &backend->u.pipe;
>
>      if (device =3D=3D NULL) {
>          error_setg(errp, "chardev: pipe: no device path given");
>          return;
>      }
>      backend->type =3D CHARDEV_BACKEND_KIND_PIPE;
> -    dev =3D backend->u.pipe.data =3D g_new0(ChardevHostdev, 1);
>      qemu_chr_parse_common(opts, qapi_ChardevHostdev_base(dev));
>      dev->device =3D g_strdup(device);
>  }
> diff --git a/chardev/char-ringbuf.c b/chardev/char-ringbuf.c
> index d40d21d3cf..0ef2a17f90 100644
> --- a/chardev/char-ringbuf.c
> +++ b/chardev/char-ringbuf.c
> @@ -97,7 +97,7 @@ static void qemu_chr_open_ringbuf(Chardev *chr,
>                                    bool *be_opened,
>                                    Error **errp)
>  {
> -    ChardevRingbuf *opts =3D backend->u.ringbuf.data;
> +    ChardevRingbuf *opts =3D &backend->u.ringbuf;
>      RingBufChardev *d =3D RINGBUF_CHARDEV(chr);
>
>      d->size =3D opts->has_size ? opts->size : 65536;
> @@ -210,10 +210,9 @@ static void qemu_chr_parse_ringbuf(QemuOpts *opts,
> ChardevBackend *backend,
>                                     Error **errp)
>  {
>      int val;
> -    ChardevRingbuf *ringbuf;
> +    ChardevRingbuf *ringbuf =3D &backend->u.ringbuf;
>
>      backend->type =3D CHARDEV_BACKEND_KIND_RINGBUF;
> -    ringbuf =3D backend->u.ringbuf.data =3D g_new0(ChardevRingbuf, 1);
>      qemu_chr_parse_common(opts, qapi_ChardevRingbuf_base(ringbuf));
>
>      val =3D qemu_opt_get_size(opts, "size", 0);
> diff --git a/chardev/char-serial.c b/chardev/char-serial.c
> index 7c3d84ae24..baec955ecf 100644
> --- a/chardev/char-serial.c
> +++ b/chardev/char-serial.c
> @@ -263,7 +263,7 @@ static void qmp_chardev_open_serial(Chardev *chr,
>                                      bool *be_opened,
>                                      Error **errp)
>  {
> -    ChardevHostdev *serial =3D backend->u.serial.data;
> +    ChardevHostdev *serial =3D &backend->u.serial;
>      int fd;
>
>      fd =3D qmp_chardev_open_file_source(serial->device, O_RDWR | O_NONBL=
OCK,
> @@ -283,14 +283,13 @@ static void qemu_chr_parse_serial(QemuOpts *opts,
> ChardevBackend *backend,
>                                    Error **errp)
>  {
>      const char *device =3D qemu_opt_get(opts, "path");
> -    ChardevHostdev *serial;
> +    ChardevHostdev *serial =3D &backend->u.serial;
>
>      if (device =3D=3D NULL) {
>          error_setg(errp, "chardev: serial/tty: no device path given");
>          return;
>      }
>      backend->type =3D CHARDEV_BACKEND_KIND_SERIAL;
> -    serial =3D backend->u.serial.data =3D g_new0(ChardevHostdev, 1);
>      qemu_chr_parse_common(opts, qapi_ChardevHostdev_base(serial));
>      serial->device =3D g_strdup(device);
>  }
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 95e45812d5..5332439d34 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1301,7 +1301,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
>                                      Error **errp)
>  {
>      SocketChardev *s =3D SOCKET_CHARDEV(chr);
> -    ChardevSocket *sock =3D backend->u.socket.data;
> +    ChardevSocket *sock =3D &backend->u.socket;
>      bool do_nodelay     =3D sock->has_nodelay ? sock->nodelay : false;
>      bool is_listen      =3D sock->has_server  ? sock->server  : true;
>      bool is_telnet      =3D sock->has_telnet  ? sock->telnet  : false;
> @@ -1403,7 +1403,7 @@ static void qemu_chr_parse_socket(QemuOpts *opts,
> ChardevBackend *backend,
>      }
>
>      backend->type =3D CHARDEV_BACKEND_KIND_SOCKET;
> -    sock =3D backend->u.socket.data =3D g_new0(ChardevSocket, 1);
> +    sock =3D &backend->u.socket;
>      qemu_chr_parse_common(opts, qapi_ChardevSocket_base(sock));
>
>      sock->has_nodelay =3D qemu_opt_get(opts, "delay");
> @@ -1435,16 +1435,14 @@ static void qemu_chr_parse_socket(QemuOpts *opts,
> ChardevBackend *backend,
>
>      addr =3D g_new0(SocketAddressLegacy, 1);
>      if (path) {
> -        UnixSocketAddress *q_unix;
> +        UnixSocketAddress *q_unix =3D &addr->u.q_unix;
>          addr->type =3D SOCKET_ADDRESS_LEGACY_KIND_UNIX;
> -        q_unix =3D addr->u.q_unix.data =3D g_new0(UnixSocketAddress, 1);
>          q_unix->path =3D g_strdup(path);
>          q_unix->tight =3D tight;
>          q_unix->abstract =3D abstract;
>      } else if (host) {
>          addr->type =3D SOCKET_ADDRESS_LEGACY_KIND_INET;
> -        addr->u.inet.data =3D g_new(InetSocketAddress, 1);
> -        *addr->u.inet.data =3D (InetSocketAddress) {
> +        addr->u.inet =3D (InetSocketAddress) {
>              .host =3D g_strdup(host),
>              .port =3D g_strdup(port),
>              .has_to =3D qemu_opt_get(opts, "to"),
> @@ -1456,8 +1454,7 @@ static void qemu_chr_parse_socket(QemuOpts *opts,
> ChardevBackend *backend,
>          };
>      } else if (fd) {
>          addr->type =3D SOCKET_ADDRESS_LEGACY_KIND_FD;
> -        addr->u.fd.data =3D g_new(String, 1);
> -        addr->u.fd.data->str =3D g_strdup(fd);
> +        addr->u.fd.str =3D g_strdup(fd);
>      } else {
>          g_assert_not_reached();
>      }
> diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
> index 403da308c9..81ee655a21 100644
> --- a/chardev/char-stdio.c
> +++ b/chardev/char-stdio.c
> @@ -87,7 +87,7 @@ static void qemu_chr_open_stdio(Chardev *chr,
>                                  bool *be_opened,
>                                  Error **errp)
>  {
> -    ChardevStdio *opts =3D backend->u.stdio.data;
> +    ChardevStdio *opts =3D &backend->u.stdio;
>      struct sigaction act;
>
>      if (is_daemonized()) {
> @@ -120,10 +120,9 @@ static void qemu_chr_open_stdio(Chardev *chr,
>  static void qemu_chr_parse_stdio(QemuOpts *opts, ChardevBackend *backend=
,
>                                   Error **errp)
>  {
> -    ChardevStdio *stdio;
> +    ChardevStdio *stdio =3D &backend->u.stdio;
>
>      backend->type =3D CHARDEV_BACKEND_KIND_STDIO;
> -    stdio =3D backend->u.stdio.data =3D g_new0(ChardevStdio, 1);
>      qemu_chr_parse_common(opts, qapi_ChardevStdio_base(stdio));
>      stdio->has_signal =3D true;
>      stdio->signal =3D qemu_opt_get_bool(opts, "signal", true);
> diff --git a/chardev/char-udp.c b/chardev/char-udp.c
> index 16b5dbce58..3b1bdddbbd 100644
> --- a/chardev/char-udp.c
> +++ b/chardev/char-udp.c
> @@ -140,7 +140,7 @@ static void qemu_chr_parse_udp(QemuOpts *opts,
> ChardevBackend *backend,
>      const char *localport =3D qemu_opt_get(opts, "localport");
>      bool has_local =3D false;
>      SocketAddressLegacy *addr;
> -    ChardevUdp *udp;
> +    ChardevUdp *udp =3D &backend->u.udp;
>
>      backend->type =3D CHARDEV_BACKEND_KIND_UDP;
>      if (host =3D=3D NULL || strlen(host) =3D=3D 0) {
> @@ -161,13 +161,11 @@ static void qemu_chr_parse_udp(QemuOpts *opts,
> ChardevBackend *backend,
>          has_local =3D true;
>      }
>
> -    udp =3D backend->u.udp.data =3D g_new0(ChardevUdp, 1);
>      qemu_chr_parse_common(opts, qapi_ChardevUdp_base(udp));
>
>      addr =3D g_new0(SocketAddressLegacy, 1);
>      addr->type =3D SOCKET_ADDRESS_LEGACY_KIND_INET;
> -    addr->u.inet.data =3D g_new(InetSocketAddress, 1);
> -    *addr->u.inet.data =3D (InetSocketAddress) {
> +    addr->u.inet =3D (InetSocketAddress) {
>          .host =3D g_strdup(host),
>          .port =3D g_strdup(port),
>          .has_ipv4 =3D qemu_opt_get(opts, "ipv4"),
> @@ -181,8 +179,7 @@ static void qemu_chr_parse_udp(QemuOpts *opts,
> ChardevBackend *backend,
>          udp->has_local =3D true;
>          addr =3D g_new0(SocketAddressLegacy, 1);
>          addr->type =3D SOCKET_ADDRESS_LEGACY_KIND_INET;
> -        addr->u.inet.data =3D g_new(InetSocketAddress, 1);
> -        *addr->u.inet.data =3D (InetSocketAddress) {
> +        addr->u.inet =3D (InetSocketAddress) {
>              .host =3D g_strdup(localaddr),
>              .port =3D g_strdup(localport),
>          };
> @@ -195,7 +192,7 @@ static void qmp_chardev_open_udp(Chardev *chr,
>                                   bool *be_opened,
>                                   Error **errp)
>  {
> -    ChardevUdp *udp =3D backend->u.udp.data;
> +    ChardevUdp *udp =3D &backend->u.udp;
>      SocketAddress *local_addr =3D socket_address_flatten(udp->local);
>      SocketAddress *remote_addr =3D socket_address_flatten(udp->remote);
>      QIOChannelSocket *sioc =3D qio_channel_socket_new();
> diff --git a/chardev/char.c b/chardev/char.c
> index 028612c333..5192964694 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -238,7 +238,7 @@ static void qemu_char_open(Chardev *chr,
> ChardevBackend *backend,
>  {
>      ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);
>      /* Any ChardevCommon member would work */
> -    ChardevCommon *common =3D backend ? backend->u.null.data : NULL;
> +    ChardevCommon *common =3D backend ? &backend->u.null : NULL;
>
>      if (common && common->has_logfile) {
>          int flags =3D O_WRONLY | O_CREAT;
> @@ -625,9 +625,8 @@ ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts,
> Error **errp)
>              return NULL;
>          }
>      } else {
> -        ChardevCommon *ccom =3D g_new0(ChardevCommon, 1);
> -        qemu_chr_parse_common(opts, ccom);
> -        backend->u.null.data =3D ccom; /* Any ChardevCommon member would
> work */
> +        /* Any ChardevCommon member would work */
> +        qemu_chr_parse_common(opts, &backend->u.null);
>      }
>
>      return backend;
> @@ -690,8 +689,7 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
> GMainContext *context,
>          qapi_free_ChardevBackend(backend);
>          backend =3D g_new0(ChardevBackend, 1);
>          backend->type =3D CHARDEV_BACKEND_KIND_MUX;
> -        backend->u.mux.data =3D g_new0(ChardevMux, 1);
> -        backend->u.mux.data->chardev =3D g_strdup(bid);
> +        backend->u.mux.chardev =3D g_strdup(bid);
>          mux =3D qemu_chardev_new(id, TYPE_CHARDEV_MUX, backend, context,
> errp);
>          if (mux =3D=3D NULL) {
>              object_unparent(OBJECT(chr));
> diff --git a/chardev/msmouse.c b/chardev/msmouse.c
> index eb9231dcdb..98b0ef8cd7 100644
> --- a/chardev/msmouse.c
> +++ b/chardev/msmouse.c
> @@ -111,12 +111,12 @@ static void msmouse_input_event(DeviceState *dev,
> QemuConsole *src,
>
>      switch (evt->type) {
>      case INPUT_EVENT_KIND_REL:
> -        move =3D evt->u.rel.data;
> +        move =3D &evt->u.rel;
>          mouse->axis[move->axis] +=3D move->value;
>          break;
>
>      case INPUT_EVENT_KIND_BTN:
> -        btn =3D evt->u.btn.data;
> +        btn =3D &evt->u.btn;
>          mouse->btns[btn->button] =3D btn->down;
>          mouse->btnc[btn->button] =3D true;
>          break;
> diff --git a/chardev/wctablet.c b/chardev/wctablet.c
> index 95e005f5a5..8479f59183 100644
> --- a/chardev/wctablet.c
> +++ b/chardev/wctablet.c
> @@ -154,12 +154,12 @@ static void wctablet_input_event(DeviceState *dev,
> QemuConsole *src,
>
>      switch (evt->type) {
>      case INPUT_EVENT_KIND_ABS:
> -        move =3D evt->u.abs.data;
> +        move =3D &evt->u.abs;
>          tablet->axis[move->axis] =3D move->value;
>          break;
>
>      case INPUT_EVENT_KIND_BTN:
> -        btn =3D evt->u.btn.data;
> +        btn =3D &evt->u.btn;
>          tablet->btns[btn->button] =3D btn->down;
>          break;
>
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index 7c4dd4e68e..24fe0e11d8 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -765,19 +765,19 @@ static void numa_stat_memory_devices(NumaNodeMem
> node_mem[])
>              case MEMORY_DEVICE_INFO_KIND_DIMM:
>              case MEMORY_DEVICE_INFO_KIND_NVDIMM:
>                  pcdimm_info =3D value->type =3D=3D MEMORY_DEVICE_INFO_KI=
ND_DIMM
> ?
> -                              value->u.dimm.data : value->u.nvdimm.data;
> +                              &value->u.dimm : &value->u.nvdimm;
>                  node_mem[pcdimm_info->node].node_mem +=3D pcdimm_info->s=
ize;
>                  node_mem[pcdimm_info->node].node_plugged_mem +=3D
>                      pcdimm_info->size;
>                  break;
>              case MEMORY_DEVICE_INFO_KIND_VIRTIO_PMEM:
> -                vpi =3D value->u.virtio_pmem.data;
> +                vpi =3D &value->u.virtio_pmem;
>                  /* TODO: once we support numa, assign to right node */
>                  node_mem[0].node_mem +=3D vpi->size;
>                  node_mem[0].node_plugged_mem +=3D vpi->size;
>                  break;
>              case MEMORY_DEVICE_INFO_KIND_VIRTIO_MEM:
> -                vmi =3D value->u.virtio_mem.data;
> +                vmi =3D &value->u.virtio_mem;
>                  node_mem[vmi->node].node_mem +=3D vmi->size;
>                  node_mem[vmi->node].node_plugged_mem +=3D vmi->size;
>                  break;
> diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
> index 838260b6ad..6aa6010774 100644
> --- a/hw/display/xenfb.c
> +++ b/hw/display/xenfb.c
> @@ -201,7 +201,7 @@ static void xenfb_key_event(DeviceState *dev,
> QemuConsole *src,
>                              InputEvent *evt)
>  {
>      struct XenInput *xenfb =3D (struct XenInput *)dev;
> -    InputKeyEvent *key =3D evt->u.key.data;
> +    InputKeyEvent *key =3D &evt->u.key;
>      int qcode =3D qemu_input_key_value_to_qcode(key->key);
>      int lnx;
>
> @@ -236,7 +236,7 @@ static void xenfb_mouse_event(DeviceState *dev,
> QemuConsole *src,
>
>      switch (evt->type) {
>      case INPUT_EVENT_KIND_BTN:
> -        btn =3D evt->u.btn.data;
> +        btn =3D &evt->u.btn;
>          switch (btn->button) {
>          case INPUT_BUTTON_LEFT:
>              xenfb_send_key(xenfb, btn->down, BTN_LEFT);
> @@ -263,7 +263,7 @@ static void xenfb_mouse_event(DeviceState *dev,
> QemuConsole *src,
>          break;
>
>      case INPUT_EVENT_KIND_ABS:
> -        move =3D evt->u.abs.data;
> +        move =3D &evt->u.abs;
>          if (xenfb->raw_pointer_wanted) {
>              xenfb->axis[move->axis] =3D move->value;
>          } else {
> @@ -289,7 +289,7 @@ static void xenfb_mouse_event(DeviceState *dev,
> QemuConsole *src,
>          break;
>
>      case INPUT_EVENT_KIND_REL:
> -        move =3D evt->u.rel.data;
> +        move =3D &evt->u.rel;
>          xenfb->axis[move->axis] +=3D move->value;
>          break;
>
> diff --git a/hw/input/hid.c b/hw/input/hid.c
> index 89239b5634..2472c5a902 100644
> --- a/hw/input/hid.c
> +++ b/hw/input/hid.c
> @@ -126,7 +126,7 @@ static void hid_pointer_event(DeviceState *dev,
> QemuConsole *src,
>
>      switch (evt->type) {
>      case INPUT_EVENT_KIND_REL:
> -        move =3D evt->u.rel.data;
> +        move =3D &evt->u.rel;
>          if (move->axis =3D=3D INPUT_AXIS_X) {
>              e->xdx +=3D move->value;
>          } else if (move->axis =3D=3D INPUT_AXIS_Y) {
> @@ -135,7 +135,7 @@ static void hid_pointer_event(DeviceState *dev,
> QemuConsole *src,
>          break;
>
>      case INPUT_EVENT_KIND_ABS:
> -        move =3D evt->u.abs.data;
> +        move =3D &evt->u.abs;
>          if (move->axis =3D=3D INPUT_AXIS_X) {
>              e->xdx =3D move->value;
>          } else if (move->axis =3D=3D INPUT_AXIS_Y) {
> @@ -144,7 +144,7 @@ static void hid_pointer_event(DeviceState *dev,
> QemuConsole *src,
>          break;
>
>      case INPUT_EVENT_KIND_BTN:
> -        btn =3D evt->u.btn.data;
> +        btn =3D &evt->u.btn;
>          if (btn->down) {
>              e->buttons_state |=3D bmap[btn->button];
>              if (btn->button =3D=3D INPUT_BUTTON_WHEEL_UP) {
> @@ -230,7 +230,7 @@ static void hid_keyboard_event(DeviceState *dev,
> QemuConsole *src,
>      HIDState *hs =3D (HIDState *)dev;
>      int scancodes[3], i, count;
>      int slot;
> -    InputKeyEvent *key =3D evt->u.key.data;
> +    InputKeyEvent *key =3D &evt->u.key;
>
>      count =3D qemu_input_key_value_to_scancode(key->key,
>                                               key->down,
> diff --git a/hw/input/ps2.c b/hw/input/ps2.c
> index f8746d2f52..1176ccc88c 100644
> --- a/hw/input/ps2.c
> +++ b/hw/input/ps2.c
> @@ -284,7 +284,7 @@ static void ps2_keyboard_event(DeviceState *dev,
> QemuConsole *src,
>                                 InputEvent *evt)
>  {
>      PS2KbdState *s =3D (PS2KbdState *)dev;
> -    InputKeyEvent *key =3D evt->u.key.data;
> +    InputKeyEvent *key =3D &evt->u.key;
>      int qcode;
>      uint16_t keycode =3D 0;
>      int mod;
> @@ -727,7 +727,7 @@ static void ps2_mouse_event(DeviceState *dev,
> QemuConsole *src,
>
>      switch (evt->type) {
>      case INPUT_EVENT_KIND_REL:
> -        move =3D evt->u.rel.data;
> +        move =3D &evt->u.rel;
>          if (move->axis =3D=3D INPUT_AXIS_X) {
>              s->mouse_dx +=3D move->value;
>          } else if (move->axis =3D=3D INPUT_AXIS_Y) {
> @@ -736,7 +736,7 @@ static void ps2_mouse_event(DeviceState *dev,
> QemuConsole *src,
>          break;
>
>      case INPUT_EVENT_KIND_BTN:
> -        btn =3D evt->u.btn.data;
> +        btn =3D &evt->u.btn;
>          if (btn->down) {
>              s->mouse_buttons |=3D bmap[btn->button];
>              if (btn->button =3D=3D INPUT_BUTTON_WHEEL_UP) {
> diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
> index a7a244a95d..1c7b07cf42 100644
> --- a/hw/input/virtio-input-hid.c
> +++ b/hw/input/virtio-input-hid.c
> @@ -83,7 +83,7 @@ static void virtio_input_handle_event(DeviceState *dev,
> QemuConsole *src,
>
>      switch (evt->type) {
>      case INPUT_EVENT_KIND_KEY:
> -        key =3D evt->u.key.data;
> +        key =3D &evt->u.key;
>          qcode =3D qemu_input_key_value_to_qcode(key->key);
>          if (qcode < qemu_input_map_qcode_to_linux_len &&
>              qemu_input_map_qcode_to_linux[qcode]) {
> @@ -99,7 +99,7 @@ static void virtio_input_handle_event(DeviceState *dev,
> QemuConsole *src,
>          }
>          break;
>      case INPUT_EVENT_KIND_BTN:
> -        btn =3D evt->u.btn.data;
> +        btn =3D &evt->u.btn;
>          if (vhid->wheel_axis &&
>              (btn->button =3D=3D INPUT_BUTTON_WHEEL_UP ||
>               btn->button =3D=3D INPUT_BUTTON_WHEEL_DOWN) &&
> @@ -123,14 +123,14 @@ static void virtio_input_handle_event(DeviceState
> *dev, QemuConsole *src,
>          }
>          break;
>      case INPUT_EVENT_KIND_REL:
> -        move =3D evt->u.rel.data;
> +        move =3D &evt->u.rel;
>          event.type  =3D cpu_to_le16(EV_REL);
>          event.code  =3D cpu_to_le16(axismap_rel[move->axis]);
>          event.value =3D cpu_to_le32(move->value);
>          virtio_input_send(vinput, &event);
>          break;
>      case INPUT_EVENT_KIND_ABS:
> -        move =3D evt->u.abs.data;
> +        move =3D &evt->u.abs;
>          event.type  =3D cpu_to_le16(EV_ABS);
>          event.code  =3D cpu_to_le16(axismap_abs[move->axis]);
>          event.value =3D cpu_to_le32(move->value);
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index c30351070b..3d6f836621 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -236,11 +236,19 @@ static MemoryRegion
> *pc_dimm_md_get_memory_region(MemoryDeviceState *md,
>  static void pc_dimm_md_fill_device_info(const MemoryDeviceState *md,
>                                          MemoryDeviceInfo *info)
>  {
> -    PCDIMMDeviceInfo *di =3D g_new0(PCDIMMDeviceInfo, 1);
> +    PCDIMMDeviceInfo *di;
>      const DeviceClass *dc =3D DEVICE_GET_CLASS(md);
>      const PCDIMMDevice *dimm =3D PC_DIMM(md);
>      const DeviceState *dev =3D DEVICE(md);
>
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
> +        di =3D &info->u.nvdimm;
> +        info->type =3D MEMORY_DEVICE_INFO_KIND_NVDIMM;
> +    } else {
> +        di =3D &info->u.dimm;
> +        info->type =3D MEMORY_DEVICE_INFO_KIND_DIMM;
> +    }
> +
>      if (dev->id) {
>          di->has_id =3D true;
>          di->id =3D g_strdup(dev->id);
> @@ -253,14 +261,6 @@ static void pc_dimm_md_fill_device_info(const
> MemoryDeviceState *md,
>      di->size =3D object_property_get_uint(OBJECT(dimm), PC_DIMM_SIZE_PRO=
P,
>                                          NULL);
>      di->memdev =3D object_get_canonical_path(OBJECT(dimm->hostmem));
> -
> -    if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
> -        info->u.nvdimm.data =3D di;
> -        info->type =3D MEMORY_DEVICE_INFO_KIND_NVDIMM;
> -    } else {
> -        info->u.dimm.data =3D di;
> -        info->type =3D MEMORY_DEVICE_INFO_KIND_DIMM;
> -    }
>  }
>
>  static void pc_dimm_class_init(ObjectClass *oc, void *data)
> diff --git a/hw/virtio/virtio-mem-pci.c b/hw/virtio/virtio-mem-pci.c
> index 913f4a3326..f93572fc27 100644
> --- a/hw/virtio/virtio-mem-pci.c
> +++ b/hw/virtio/virtio-mem-pci.c
> @@ -58,7 +58,7 @@ static uint64_t virtio_mem_pci_get_plugged_size(const
> MemoryDeviceState *md,
>  static void virtio_mem_pci_fill_device_info(const MemoryDeviceState *md,
>                                              MemoryDeviceInfo *info)
>  {
> -    VirtioMEMDeviceInfo *vi =3D g_new0(VirtioMEMDeviceInfo, 1);
> +    VirtioMEMDeviceInfo *vi =3D &info->u.virtio_mem;
>      VirtIOMEMPCI *pci_mem =3D VIRTIO_MEM_PCI(md);
>      VirtIOMEM *vmem =3D VIRTIO_MEM(&pci_mem->vdev);
>      VirtIOMEMClass *vpc =3D VIRTIO_MEM_GET_CLASS(vmem);
> @@ -72,7 +72,6 @@ static void virtio_mem_pci_fill_device_info(const
> MemoryDeviceState *md,
>      /* let the real device handle everything else */
>      vpc->fill_device_info(vmem, vi);
>
> -    info->u.virtio_mem.data =3D vi;
>      info->type =3D MEMORY_DEVICE_INFO_KIND_VIRTIO_MEM;
>  }
>
> diff --git a/hw/virtio/virtio-pmem-pci.c b/hw/virtio/virtio-pmem-pci.c
> index 2b2a0b1eae..adf17f873b 100644
> --- a/hw/virtio/virtio-pmem-pci.c
> +++ b/hw/virtio/virtio-pmem-pci.c
> @@ -63,7 +63,7 @@ static uint64_t virtio_pmem_pci_get_plugged_size(const
> MemoryDeviceState *md,
>  static void virtio_pmem_pci_fill_device_info(const MemoryDeviceState *md=
,
>                                               MemoryDeviceInfo *info)
>  {
> -    VirtioPMEMDeviceInfo *vi =3D g_new0(VirtioPMEMDeviceInfo, 1);
> +    VirtioPMEMDeviceInfo *vi =3D &info->u.virtio_pmem;
>      VirtIOPMEMPCI *pci_pmem =3D VIRTIO_PMEM_PCI(md);
>      VirtIOPMEM *pmem =3D VIRTIO_PMEM(&pci_pmem->vdev);
>      VirtIOPMEMClass *vpc =3D VIRTIO_PMEM_GET_CLASS(pmem);
> @@ -77,7 +77,6 @@ static void virtio_pmem_pci_fill_device_info(const
> MemoryDeviceState *md,
>      /* let the real device handle everything else */
>      vpc->fill_device_info(pmem, vi);
>
> -    info->u.virtio_pmem.data =3D vi;
>      info->type =3D MEMORY_DEVICE_INFO_KIND_VIRTIO_PMEM;
>  }
>
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 9789f4277f..0324caa114 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -918,7 +918,7 @@ void hmp_info_tpm(Monitor *mon, const QDict *qdict)
>
>          switch (ti->options->type) {
>          case TPM_TYPE_OPTIONS_KIND_PASSTHROUGH:
> -            tpo =3D ti->options->u.passthrough.data;
> +            tpo =3D &ti->options->u.passthrough;
>              monitor_printf(mon, "%s%s%s%s",
>                             tpo->has_path ? ",path=3D" : "",
>                             tpo->has_path ? tpo->path : "",
> @@ -926,7 +926,7 @@ void hmp_info_tpm(Monitor *mon, const QDict *qdict)
>                             tpo->has_cancel_path ? tpo->cancel_path : "")=
;
>              break;
>          case TPM_TYPE_OPTIONS_KIND_EMULATOR:
> -            teo =3D ti->options->u.emulator.data;
> +            teo =3D &ti->options->u.emulator;
>              monitor_printf(mon, ",chardev=3D%s", teo->chardev);
>              break;
>          case TPM_TYPE_OPTIONS_KIND__MAX:
> @@ -1728,14 +1728,14 @@ void hmp_sendkey(Monitor *mon, const QDict *qdict=
)
>                  goto err_out;
>              }
>              keylist->value->type =3D KEY_VALUE_KIND_NUMBER;
> -            keylist->value->u.number.data =3D value;
> +            keylist->value->u.number =3D value;
>          } else {
>              int idx =3D index_from_key(keys, keyname_len);
>              if (idx =3D=3D Q_KEY_CODE__MAX) {
>                  goto err_out;
>              }
>              keylist->value->type =3D KEY_VALUE_KIND_QCODE;
> -            keylist->value->u.qcode.data =3D idx;
> +            keylist->value->u.qcode =3D idx;
>          }
>
>          if (!*separator) {
> @@ -1860,7 +1860,7 @@ void hmp_info_memory_devices(Monitor *mon, const
> QDict *qdict)
>              case MEMORY_DEVICE_INFO_KIND_DIMM:
>              case MEMORY_DEVICE_INFO_KIND_NVDIMM:
>                  di =3D value->type =3D=3D MEMORY_DEVICE_INFO_KIND_DIMM ?
> -                     value->u.dimm.data : value->u.nvdimm.data;
> +                     &value->u.dimm : &value->u.nvdimm;
>                  monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
>                                 MemoryDeviceInfoKind_str(value->type),
>                                 di->id ? di->id : "");
> @@ -1875,7 +1875,7 @@ void hmp_info_memory_devices(Monitor *mon, const
> QDict *qdict)
>                                 di->hotpluggable ? "true" : "false");
>                  break;
>              case MEMORY_DEVICE_INFO_KIND_VIRTIO_PMEM:
> -                vpi =3D value->u.virtio_pmem.data;
> +                vpi =3D &value->u.virtio_pmem;
>                  monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
>                                 MemoryDeviceInfoKind_str(value->type),
>                                 vpi->id ? vpi->id : "");
> @@ -1884,7 +1884,7 @@ void hmp_info_memory_devices(Monitor *mon, const
> QDict *qdict)
>                  monitor_printf(mon, "  memdev: %s\n", vpi->memdev);
>                  break;
>              case MEMORY_DEVICE_INFO_KIND_VIRTIO_MEM:
> -                vmi =3D value->u.virtio_mem.data;
> +                vmi =3D &value->u.virtio_mem;
>                  monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
>                                 MemoryDeviceInfoKind_str(value->type),
>                                 vmi->id ? vmi->id : "");
> diff --git a/qemu-keymap.c b/qemu-keymap.c
> index 536e8f2385..52637c449c 100644
> --- a/qemu-keymap.c
> +++ b/qemu-keymap.c
> @@ -38,7 +38,7 @@ static uint32_t qcode_to_number(uint32_t qcode)
>      uint32_t number;
>
>      keyvalue.type =3D KEY_VALUE_KIND_QCODE;
> -    keyvalue.u.qcode.data =3D qcode;
> +    keyvalue.u.qcode =3D qcode;
>      number =3D qemu_input_key_value_to_number(&keyvalue);
>      assert(number !=3D 0);
>      return number;
> diff --git a/replay/replay-input.c b/replay/replay-input.c
> index 1147e3d34e..c1eb1b79e1 100644
> --- a/replay/replay-input.c
> +++ b/replay/replay-input.c
> @@ -26,16 +26,16 @@ void replay_save_input_event(InputEvent *evt)
>
>      switch (evt->type) {
>      case INPUT_EVENT_KIND_KEY:
> -        key =3D evt->u.key.data;
> +        key =3D &evt->u.key;
>          replay_put_dword(key->key->type);
>
>          switch (key->key->type) {
>          case KEY_VALUE_KIND_NUMBER:
> -            replay_put_qword(key->key->u.number.data);
> +            replay_put_qword(key->key->u.number);
>              replay_put_byte(key->down);
>              break;
>          case KEY_VALUE_KIND_QCODE:
> -            replay_put_dword(key->key->u.qcode.data);
> +            replay_put_dword(key->key->u.qcode);
>              replay_put_byte(key->down);
>              break;
>          case KEY_VALUE_KIND__MAX:
> @@ -44,17 +44,17 @@ void replay_save_input_event(InputEvent *evt)
>          }
>          break;
>      case INPUT_EVENT_KIND_BTN:
> -        btn =3D evt->u.btn.data;
> +        btn =3D &evt->u.btn;
>          replay_put_dword(btn->button);
>          replay_put_byte(btn->down);
>          break;
>      case INPUT_EVENT_KIND_REL:
> -        move =3D evt->u.rel.data;
> +        move =3D &evt->u.rel;
>          replay_put_dword(move->axis);
>          replay_put_qword(move->value);
>          break;
>      case INPUT_EVENT_KIND_ABS:
> -        move =3D evt->u.abs.data;
> +        move =3D &evt->u.abs;
>          replay_put_dword(move->axis);
>          replay_put_qword(move->value);
>          break;
> @@ -68,26 +68,21 @@ InputEvent *replay_read_input_event(void)
>  {
>      InputEvent evt;
>      KeyValue keyValue;
> -    InputKeyEvent key;
> -    key.key =3D &keyValue;
> -    InputBtnEvent btn;
> -    InputMoveEvent rel;
> -    InputMoveEvent abs;
> +    evt.u.key.key =3D &keyValue;
>
>      evt.type =3D replay_get_dword();
>      switch (evt.type) {
>      case INPUT_EVENT_KIND_KEY:
> -        evt.u.key.data =3D &key;
> -        evt.u.key.data->key->type =3D replay_get_dword();
> +        evt.u.key.key->type =3D replay_get_dword();
>
> -        switch (evt.u.key.data->key->type) {
> +        switch (evt.u.key.key->type) {
>          case KEY_VALUE_KIND_NUMBER:
> -            evt.u.key.data->key->u.number.data =3D replay_get_qword();
> -            evt.u.key.data->down =3D replay_get_byte();
> +            evt.u.key.key->u.number =3D replay_get_qword();
> +            evt.u.key.down =3D replay_get_byte();
>              break;
>          case KEY_VALUE_KIND_QCODE:
> -            evt.u.key.data->key->u.qcode.data =3D
> (QKeyCode)replay_get_dword();
> -            evt.u.key.data->down =3D replay_get_byte();
> +            evt.u.key.key->u.qcode =3D (QKeyCode)replay_get_dword();
> +            evt.u.key.down =3D replay_get_byte();
>              break;
>          case KEY_VALUE_KIND__MAX:
>              /* keep gcc happy */
> @@ -95,19 +90,16 @@ InputEvent *replay_read_input_event(void)
>          }
>          break;
>      case INPUT_EVENT_KIND_BTN:
> -        evt.u.btn.data =3D &btn;
> -        evt.u.btn.data->button =3D (InputButton)replay_get_dword();
> -        evt.u.btn.data->down =3D replay_get_byte();
> +        evt.u.btn.button =3D (InputButton)replay_get_dword();
> +        evt.u.btn.down =3D replay_get_byte();
>          break;
>      case INPUT_EVENT_KIND_REL:
> -        evt.u.rel.data =3D &rel;
> -        evt.u.rel.data->axis =3D (InputAxis)replay_get_dword();
> -        evt.u.rel.data->value =3D replay_get_qword();
> +        evt.u.rel.axis =3D (InputAxis)replay_get_dword();
> +        evt.u.rel.value =3D replay_get_qword();
>          break;
>      case INPUT_EVENT_KIND_ABS:
> -        evt.u.abs.data =3D &abs;
> -        evt.u.abs.data->axis =3D (InputAxis)replay_get_dword();
> -        evt.u.abs.data->value =3D replay_get_qword();
> +        evt.u.abs.axis =3D (InputAxis)replay_get_dword();
> +        evt.u.abs.value =3D replay_get_qword();
>          break;
>      case INPUT_EVENT_KIND__MAX:
>          /* keep gcc happy */
> diff --git a/tests/test-char.c b/tests/test-char.c
> index 9196e566e9..0e7a033a90 100644
> --- a/tests/test-char.c
> +++ b/tests/test-char.c
> @@ -1220,7 +1220,7 @@ static void char_file_fifo_test(void)
>                           .has_in =3D true,
>                           .out =3D out };
>      ChardevBackend backend =3D { .type =3D CHARDEV_BACKEND_KIND_FILE,
> -                               .u.file.data =3D &file };
> +                               .u.file =3D file };
>      FeHandler fe =3D { 0, };
>      int fd, ret;
>
> @@ -1273,19 +1273,17 @@ static void char_file_test_internal(Chardev
> *ext_chr, const char *filepath)
>      char *out;
>      Chardev *chr;
>      char *contents =3D NULL;
> -    ChardevFile file =3D {};
> -    ChardevBackend backend =3D { .type =3D CHARDEV_BACKEND_KIND_FILE,
> -                               .u.file.data =3D &file };
> +    ChardevBackend backend =3D { .type =3D CHARDEV_BACKEND_KIND_FILE };
>      gsize length;
>      int ret;
>
>      if (ext_chr) {
>          chr =3D ext_chr;
>          out =3D g_strdup(filepath);
> -        file.out =3D out;
> +        backend.u.file.out =3D out;
>      } else {
>          out =3D g_build_filename(tmp_path, "out", NULL);
> -        file.out =3D out;
> +        backend.u.file.out =3D out;
>          chr =3D qemu_chardev_new(NULL, TYPE_CHARDEV_FILE, &backend,
>                                 NULL, &error_abort);
>      }
> @@ -1384,7 +1382,7 @@ static void char_hotswap_test(void)
>      char *filename =3D g_build_filename(tmp_path, "file", NULL);
>      ChardevFile file =3D { .out =3D filename };
>      ChardevBackend backend =3D { .type =3D CHARDEV_BACKEND_KIND_FILE,
> -                               .u.file.data =3D &file };
> +                               .u.file =3D file };
>      ChardevReturn *ret;
>
>      int port;
> diff --git a/tests/test-clone-visitor.c b/tests/test-clone-visitor.c
> index 5e1e8b2f5e..0a62704bed 100644
> --- a/tests/test-clone-visitor.c
> +++ b/tests/test-clone-visitor.c
> @@ -110,7 +110,7 @@ static void test_clone_complex1(void)
>      dst =3D QAPI_CLONE(UserDefListUnion, src);
>      g_assert(dst);
>      g_assert_cmpint(dst->type, =3D=3D, src->type);
> -    g_assert(!dst->u.string.data);
> +    g_assert(!dst->u.string);
>
>      qapi_free_UserDefListUnion(src);
>      qapi_free_UserDefListUnion(dst);
> @@ -155,30 +155,30 @@ static void test_clone_complex3(void)
>      tmp =3D src->array =3D g_new0(__org_qemu_x_Union1List, 1);
>      tmp->value =3D g_new0(__org_qemu_x_Union1, 1);
>      tmp->value->type =3D ORG_QEMU_X_UNION1_KIND___ORG_QEMU_X_BRANCH;
> -    tmp->value->u.__org_qemu_x_branch.data =3D g_strdup("one");
> +    tmp->value->u.__org_qemu_x_branch =3D g_strdup("one");
>      tmp =3D tmp->next =3D g_new0(__org_qemu_x_Union1List, 1);
>      tmp->value =3D g_new0(__org_qemu_x_Union1, 1);
>      tmp->value->type =3D ORG_QEMU_X_UNION1_KIND___ORG_QEMU_X_BRANCH;
> -    tmp->value->u.__org_qemu_x_branch.data =3D g_strdup("two");
> +    tmp->value->u.__org_qemu_x_branch =3D g_strdup("two");
>      tmp =3D tmp->next =3D g_new0(__org_qemu_x_Union1List, 1);
>      tmp->value =3D g_new0(__org_qemu_x_Union1, 1);
>      tmp->value->type =3D ORG_QEMU_X_UNION1_KIND___ORG_QEMU_X_BRANCH;
> -    tmp->value->u.__org_qemu_x_branch.data =3D g_strdup("three");
> +    tmp->value->u.__org_qemu_x_branch =3D g_strdup("three");
>
>      dst =3D QAPI_CLONE(__org_qemu_x_Struct2, src);
>      g_assert(dst);
>      tmp =3D dst->array;
>      g_assert(tmp);
>      g_assert(tmp->value);
> -    g_assert_cmpstr(tmp->value->u.__org_qemu_x_branch.data, =3D=3D, "one=
");
> +    g_assert_cmpstr(tmp->value->u.__org_qemu_x_branch, =3D=3D, "one");
>      tmp =3D tmp->next;
>      g_assert(tmp);
>      g_assert(tmp->value);
> -    g_assert_cmpstr(tmp->value->u.__org_qemu_x_branch.data, =3D=3D, "two=
");
> +    g_assert_cmpstr(tmp->value->u.__org_qemu_x_branch, =3D=3D, "two");
>      tmp =3D tmp->next;
>      g_assert(tmp);
>      g_assert(tmp->value);
> -    g_assert_cmpstr(tmp->value->u.__org_qemu_x_branch.data, =3D=3D, "thr=
ee");
> +    g_assert_cmpstr(tmp->value->u.__org_qemu_x_branch, =3D=3D, "three");
>      tmp =3D tmp->next;
>      g_assert(!tmp);
>
> diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
> index d3413bfef0..3d699fbb66 100644
> --- a/tests/test-qmp-cmds.c
> +++ b/tests/test-qmp-cmds.c
> @@ -136,7 +136,7 @@ __org_qemu_x_Union1
> *qmp___org_qemu_x_command(__org_qemu_x_EnumList *a,
>      __org_qemu_x_Union1 *ret =3D g_new0(__org_qemu_x_Union1, 1);
>
>      ret->type =3D ORG_QEMU_X_UNION1_KIND___ORG_QEMU_X_BRANCH;
> -    ret->u.__org_qemu_x_branch.data =3D strdup("blah1");
> +    ret->u.__org_qemu_x_branch =3D strdup("blah1");
>
>      /* Also test that 'wchar-t' was munged to 'q_wchar_t' */
>      if (b && b->value && !b->value->has_q_wchar_t) {
> diff --git a/tests/test-qobject-input-visitor.c
> b/tests/test-qobject-input-visitor.c
> index e41b91a2a6..b976ab9763 100644
> --- a/tests/test-qobject-input-visitor.c
> +++ b/tests/test-qobject-input-visitor.c
> @@ -710,7 +710,7 @@ static void
> test_list_union_integer_helper(TestInputVisitorData *data,
>      switch (kind) {
>      case USER_DEF_LIST_UNION_KIND_INTEGER: {
>          intList *elem =3D NULL;
> -        for (i =3D 0, elem =3D cvalue->u.integer.data;
> +        for (i =3D 0, elem =3D cvalue->u.integer;
>               elem; elem =3D elem->next, i++) {
>              g_assert_cmpint(elem->value, =3D=3D, i);
>          }
> @@ -718,56 +718,56 @@ static void
> test_list_union_integer_helper(TestInputVisitorData *data,
>      }
>      case USER_DEF_LIST_UNION_KIND_S8: {
>          int8List *elem =3D NULL;
> -        for (i =3D 0, elem =3D cvalue->u.s8.data; elem; elem =3D elem->n=
ext,
> i++) {
> +        for (i =3D 0, elem =3D cvalue->u.s8; elem; elem =3D elem->next, =
i++) {
>              g_assert_cmpint(elem->value, =3D=3D, i);
>          }
>          break;
>      }
>      case USER_DEF_LIST_UNION_KIND_S16: {
>          int16List *elem =3D NULL;
> -        for (i =3D 0, elem =3D cvalue->u.s16.data; elem; elem =3D elem->=
next,
> i++) {
> +        for (i =3D 0, elem =3D cvalue->u.s16; elem; elem =3D elem->next,=
 i++) {
>              g_assert_cmpint(elem->value, =3D=3D, i);
>          }
>          break;
>      }
>      case USER_DEF_LIST_UNION_KIND_S32: {
>          int32List *elem =3D NULL;
> -        for (i =3D 0, elem =3D cvalue->u.s32.data; elem; elem =3D elem->=
next,
> i++) {
> +        for (i =3D 0, elem =3D cvalue->u.s32; elem; elem =3D elem->next,=
 i++) {
>              g_assert_cmpint(elem->value, =3D=3D, i);
>          }
>          break;
>      }
>      case USER_DEF_LIST_UNION_KIND_S64: {
>          int64List *elem =3D NULL;
> -        for (i =3D 0, elem =3D cvalue->u.s64.data; elem; elem =3D elem->=
next,
> i++) {
> +        for (i =3D 0, elem =3D cvalue->u.s64; elem; elem =3D elem->next,=
 i++) {
>              g_assert_cmpint(elem->value, =3D=3D, i);
>          }
>          break;
>      }
>      case USER_DEF_LIST_UNION_KIND_U8: {
>          uint8List *elem =3D NULL;
> -        for (i =3D 0, elem =3D cvalue->u.u8.data; elem; elem =3D elem->n=
ext,
> i++) {
> +        for (i =3D 0, elem =3D cvalue->u.u8; elem; elem =3D elem->next, =
i++) {
>              g_assert_cmpint(elem->value, =3D=3D, i);
>          }
>          break;
>      }
>      case USER_DEF_LIST_UNION_KIND_U16: {
>          uint16List *elem =3D NULL;
> -        for (i =3D 0, elem =3D cvalue->u.u16.data; elem; elem =3D elem->=
next,
> i++) {
> +        for (i =3D 0, elem =3D cvalue->u.u16; elem; elem =3D elem->next,=
 i++) {
>              g_assert_cmpint(elem->value, =3D=3D, i);
>          }
>          break;
>      }
>      case USER_DEF_LIST_UNION_KIND_U32: {
>          uint32List *elem =3D NULL;
> -        for (i =3D 0, elem =3D cvalue->u.u32.data; elem; elem =3D elem->=
next,
> i++) {
> +        for (i =3D 0, elem =3D cvalue->u.u32; elem; elem =3D elem->next,=
 i++) {
>              g_assert_cmpint(elem->value, =3D=3D, i);
>          }
>          break;
>      }
>      case USER_DEF_LIST_UNION_KIND_U64: {
>          uint64List *elem =3D NULL;
> -        for (i =3D 0, elem =3D cvalue->u.u64.data; elem; elem =3D elem->=
next,
> i++) {
> +        for (i =3D 0, elem =3D cvalue->u.u64; elem; elem =3D elem->next,=
 i++) {
>              g_assert_cmpint(elem->value, =3D=3D, i);
>          }
>          break;
> @@ -868,7 +868,7 @@ static void
> test_visitor_in_list_union_bool(TestInputVisitorData *data,
>      g_assert(cvalue !=3D NULL);
>      g_assert_cmpint(cvalue->type, =3D=3D, USER_DEF_LIST_UNION_KIND_BOOLE=
AN);
>
> -    for (i =3D 0, elem =3D cvalue->u.boolean.data; elem; elem =3D elem->=
next,
> i++) {
> +    for (i =3D 0, elem =3D cvalue->u.boolean; elem; elem =3D elem->next,=
 i++) {
>          g_assert_cmpint(elem->value, =3D=3D, (i % 3 =3D=3D 0) ? 1 : 0);
>      }
>
> @@ -900,7 +900,7 @@ static void
> test_visitor_in_list_union_string(TestInputVisitorData *data,
>      g_assert(cvalue !=3D NULL);
>      g_assert_cmpint(cvalue->type, =3D=3D, USER_DEF_LIST_UNION_KIND_STRIN=
G);
>
> -    for (i =3D 0, elem =3D cvalue->u.string.data; elem; elem =3D elem->n=
ext,
> i++) {
> +    for (i =3D 0, elem =3D cvalue->u.string; elem; elem =3D elem->next, =
i++) {
>          gchar str[8];
>          sprintf(str, "%d", i);
>          g_assert_cmpstr(elem->value, =3D=3D, str);
> @@ -936,7 +936,7 @@ static void
> test_visitor_in_list_union_number(TestInputVisitorData *data,
>      g_assert(cvalue !=3D NULL);
>      g_assert_cmpint(cvalue->type, =3D=3D, USER_DEF_LIST_UNION_KIND_NUMBE=
R);
>
> -    for (i =3D 0, elem =3D cvalue->u.number.data; elem; elem =3D elem->n=
ext,
> i++) {
> +    for (i =3D 0, elem =3D cvalue->u.number; elem; elem =3D elem->next, =
i++) {
>          GString *double_expected =3D g_string_new("");
>          GString *double_actual =3D g_string_new("");
>
> diff --git a/tests/test-qobject-output-visitor.c
> b/tests/test-qobject-output-visitor.c
> index 1c856d9bd2..202f848062 100644
> --- a/tests/test-qobject-output-visitor.c
> +++ b/tests/test-qobject-output-visitor.c
> @@ -444,7 +444,7 @@ static void init_list_union(UserDefListUnion *cvalue)
>      int i;
>      switch (cvalue->type) {
>      case USER_DEF_LIST_UNION_KIND_INTEGER: {
> -        intList **list =3D &cvalue->u.integer.data;
> +        intList **list =3D &cvalue->u.integer;
>          for (i =3D 0; i < 32; i++) {
>              *list =3D g_new0(intList, 1);
>              (*list)->value =3D i;
> @@ -454,7 +454,7 @@ static void init_list_union(UserDefListUnion *cvalue)
>          break;
>      }
>      case USER_DEF_LIST_UNION_KIND_S8: {
> -        int8List **list =3D &cvalue->u.s8.data;
> +        int8List **list =3D &cvalue->u.s8;
>          for (i =3D 0; i < 32; i++) {
>              *list =3D g_new0(int8List, 1);
>              (*list)->value =3D i;
> @@ -464,7 +464,7 @@ static void init_list_union(UserDefListUnion *cvalue)
>          break;
>      }
>      case USER_DEF_LIST_UNION_KIND_S16: {
> -        int16List **list =3D &cvalue->u.s16.data;
> +        int16List **list =3D &cvalue->u.s16;
>          for (i =3D 0; i < 32; i++) {
>              *list =3D g_new0(int16List, 1);
>              (*list)->value =3D i;
> @@ -474,7 +474,7 @@ static void init_list_union(UserDefListUnion *cvalue)
>          break;
>      }
>      case USER_DEF_LIST_UNION_KIND_S32: {
> -        int32List **list =3D &cvalue->u.s32.data;
> +        int32List **list =3D &cvalue->u.s32;
>          for (i =3D 0; i < 32; i++) {
>              *list =3D g_new0(int32List, 1);
>              (*list)->value =3D i;
> @@ -484,7 +484,7 @@ static void init_list_union(UserDefListUnion *cvalue)
>          break;
>      }
>      case USER_DEF_LIST_UNION_KIND_S64: {
> -        int64List **list =3D &cvalue->u.s64.data;
> +        int64List **list =3D &cvalue->u.s64;
>          for (i =3D 0; i < 32; i++) {
>              *list =3D g_new0(int64List, 1);
>              (*list)->value =3D i;
> @@ -494,7 +494,7 @@ static void init_list_union(UserDefListUnion *cvalue)
>          break;
>      }
>      case USER_DEF_LIST_UNION_KIND_U8: {
> -        uint8List **list =3D &cvalue->u.u8.data;
> +        uint8List **list =3D &cvalue->u.u8;
>          for (i =3D 0; i < 32; i++) {
>              *list =3D g_new0(uint8List, 1);
>              (*list)->value =3D i;
> @@ -504,7 +504,7 @@ static void init_list_union(UserDefListUnion *cvalue)
>          break;
>      }
>      case USER_DEF_LIST_UNION_KIND_U16: {
> -        uint16List **list =3D &cvalue->u.u16.data;
> +        uint16List **list =3D &cvalue->u.u16;
>          for (i =3D 0; i < 32; i++) {
>              *list =3D g_new0(uint16List, 1);
>              (*list)->value =3D i;
> @@ -514,7 +514,7 @@ static void init_list_union(UserDefListUnion *cvalue)
>          break;
>      }
>      case USER_DEF_LIST_UNION_KIND_U32: {
> -        uint32List **list =3D &cvalue->u.u32.data;
> +        uint32List **list =3D &cvalue->u.u32;
>          for (i =3D 0; i < 32; i++) {
>              *list =3D g_new0(uint32List, 1);
>              (*list)->value =3D i;
> @@ -524,7 +524,7 @@ static void init_list_union(UserDefListUnion *cvalue)
>          break;
>      }
>      case USER_DEF_LIST_UNION_KIND_U64: {
> -        uint64List **list =3D &cvalue->u.u64.data;
> +        uint64List **list =3D &cvalue->u.u64;
>          for (i =3D 0; i < 32; i++) {
>              *list =3D g_new0(uint64List, 1);
>              (*list)->value =3D i;
> @@ -534,7 +534,7 @@ static void init_list_union(UserDefListUnion *cvalue)
>          break;
>      }
>      case USER_DEF_LIST_UNION_KIND_BOOLEAN: {
> -        boolList **list =3D &cvalue->u.boolean.data;
> +        boolList **list =3D &cvalue->u.boolean;
>          for (i =3D 0; i < 32; i++) {
>              *list =3D g_new0(boolList, 1);
>              (*list)->value =3D QEMU_IS_ALIGNED(i, 3);
> @@ -544,7 +544,7 @@ static void init_list_union(UserDefListUnion *cvalue)
>          break;
>      }
>      case USER_DEF_LIST_UNION_KIND_STRING: {
> -        strList **list =3D &cvalue->u.string.data;
> +        strList **list =3D &cvalue->u.string;
>          for (i =3D 0; i < 32; i++) {
>              *list =3D g_new0(strList, 1);
>              (*list)->value =3D g_strdup_printf("%d", i);
> @@ -554,7 +554,7 @@ static void init_list_union(UserDefListUnion *cvalue)
>          break;
>      }
>      case USER_DEF_LIST_UNION_KIND_NUMBER: {
> -        numberList **list =3D &cvalue->u.number.data;
> +        numberList **list =3D &cvalue->u.number;
>          for (i =3D 0; i < 32; i++) {
>              *list =3D g_new0(numberList, 1);
>              (*list)->value =3D (double)i / 3;
> diff --git a/ui/console.c b/ui/console.c
> index 820e408170..2f93723ed6 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -2212,7 +2212,7 @@ static void vc_chr_open(Chardev *chr,
>                          bool *be_opened,
>                          Error **errp)
>  {
> -    ChardevVC *vc =3D backend->u.vc.data;
> +    ChardevVC *vc =3D &backend->u.vc;
>      VCChardev *drv =3D VC_CHARDEV(chr);
>      QemuConsole *s;
>      unsigned width =3D 0;
> @@ -2362,10 +2362,9 @@ void qemu_display_help(void)
>  void qemu_chr_parse_vc(QemuOpts *opts, ChardevBackend *backend, Error
> **errp)
>  {
>      int val;
> -    ChardevVC *vc;
> +    ChardevVC *vc =3D &backend->u.vc;
>
>      backend->type =3D CHARDEV_BACKEND_KIND_VC;
> -    vc =3D backend->u.vc.data =3D g_new0(ChardevVC, 1);
>      qemu_chr_parse_common(opts, qapi_ChardevVC_base(vc));
>
>      val =3D qemu_opt_get_number(opts, "width", 0);
> diff --git a/ui/input-keymap.c b/ui/input-keymap.c
> index 1b756a6970..0232e25124 100644
> --- a/ui/input-keymap.c
> +++ b/ui/input-keymap.c
> @@ -33,13 +33,13 @@ int qemu_input_linux_to_qcode(unsigned int lnx)
>  int qemu_input_key_value_to_number(const KeyValue *value)
>  {
>      if (value->type =3D=3D KEY_VALUE_KIND_QCODE) {
> -        if (value->u.qcode.data >=3D qemu_input_map_qcode_to_qnum_len) {
> +        if (value->u.qcode >=3D qemu_input_map_qcode_to_qnum_len) {
>              return 0;
>          }
> -        return qemu_input_map_qcode_to_qnum[value->u.qcode.data];
> +        return qemu_input_map_qcode_to_qnum[value->u.qcode];
>      } else {
>          assert(value->type =3D=3D KEY_VALUE_KIND_NUMBER);
> -        return value->u.number.data;
> +        return value->u.number;
>      }
>  }
>
> @@ -54,10 +54,10 @@ int qemu_input_key_number_to_qcode(unsigned int nr)
>  int qemu_input_key_value_to_qcode(const KeyValue *value)
>  {
>      if (value->type =3D=3D KEY_VALUE_KIND_QCODE) {
> -        return value->u.qcode.data;
> +        return value->u.qcode;
>      } else {
>          assert(value->type =3D=3D KEY_VALUE_KIND_NUMBER);
> -        return qemu_input_key_number_to_qcode(value->u.number.data);
> +        return qemu_input_key_number_to_qcode(value->u.number);
>      }
>  }
>
> @@ -68,7 +68,7 @@ int qemu_input_key_value_to_scancode(const KeyValue
> *value, bool down,
>      int count =3D 0;
>
>      if (value->type =3D=3D KEY_VALUE_KIND_QCODE &&
> -        value->u.qcode.data =3D=3D Q_KEY_CODE_PAUSE) {
> +        value->u.qcode =3D=3D Q_KEY_CODE_PAUSE) {
>          /* specific case */
>          int v =3D down ? 0 : 0x80;
>          codes[count++] =3D 0xe1;
> diff --git a/ui/input-legacy.c b/ui/input-legacy.c
> index 9fc78a639b..5a32b010d4 100644
> --- a/ui/input-legacy.c
> +++ b/ui/input-legacy.c
> @@ -75,9 +75,9 @@ static KeyValue *copy_key_value(KeyValue *src)
>      KeyValue *dst =3D g_new(KeyValue, 1);
>      memcpy(dst, src, sizeof(*src));
>      if (dst->type =3D=3D KEY_VALUE_KIND_NUMBER) {
> -        QKeyCode code =3D
> qemu_input_key_number_to_qcode(dst->u.number.data);
> +        QKeyCode code =3D qemu_input_key_number_to_qcode(dst->u.number);
>          dst->type =3D KEY_VALUE_KIND_QCODE;
> -        dst->u.qcode.data =3D code;
> +        dst->u.qcode =3D code;
>      }
>      return dst;
>  }
> @@ -113,7 +113,7 @@ static void legacy_kbd_event(DeviceState *dev,
> QemuConsole *src,
>  {
>      QEMUPutKbdEntry *entry =3D (QEMUPutKbdEntry *)dev;
>      int scancodes[3], i, count;
> -    InputKeyEvent *key =3D evt->u.key.data;
> +    InputKeyEvent *key =3D &evt->u.key;
>
>      if (!entry || !entry->put_kbd) {
>          return;
> @@ -159,7 +159,7 @@ static void legacy_mouse_event(DeviceState *dev,
> QemuConsole *src,
>
>      switch (evt->type) {
>      case INPUT_EVENT_KIND_BTN:
> -        btn =3D evt->u.btn.data;
> +        btn =3D &evt->u.btn;
>          if (btn->down) {
>              s->buttons |=3D bmap[btn->button];
>          } else {
> @@ -181,11 +181,11 @@ static void legacy_mouse_event(DeviceState *dev,
> QemuConsole *src,
>          }
>          break;
>      case INPUT_EVENT_KIND_ABS:
> -        move =3D evt->u.abs.data;
> +        move =3D &evt->u.abs;
>          s->axis[move->axis] =3D move->value;
>          break;
>      case INPUT_EVENT_KIND_REL:
> -        move =3D evt->u.rel.data;
> +        move =3D &evt->u.rel;
>          s->axis[move->axis] +=3D move->value;
>          break;
>      default:
> diff --git a/ui/input.c b/ui/input.c
> index 4791b089c7..a4078780ee 100644
> --- a/ui/input.c
> +++ b/ui/input.c
> @@ -164,10 +164,10 @@ void qmp_input_send_event(bool has_device, const
> char *device,
>          InputEvent *evt =3D e->value;
>
>          if (evt->type =3D=3D INPUT_EVENT_KIND_KEY &&
> -            evt->u.key.data->key->type =3D=3D KEY_VALUE_KIND_NUMBER) {
> -            KeyValue *key =3D evt->u.key.data->key;
> -            QKeyCode code =3D
> qemu_input_key_number_to_qcode(key->u.number.data);
> -            qemu_input_event_send_key_qcode(con, code,
> evt->u.key.data->down);
> +            evt->u.key.key->type =3D=3D KEY_VALUE_KIND_NUMBER) {
> +            KeyValue *key =3D evt->u.key.key;
> +            QKeyCode code =3D qemu_input_key_number_to_qcode(key->u.numb=
er);
> +            qemu_input_event_send_key_qcode(con, code, evt->u.key.down);
>          } else {
>              qemu_input_event_send(con, evt);
>          }
> @@ -183,7 +183,7 @@ static int qemu_input_transform_invert_abs_value(int
> value)
>
>  static void qemu_input_transform_abs_rotate(InputEvent *evt)
>  {
> -    InputMoveEvent *move =3D evt->u.abs.data;
> +    InputMoveEvent *move =3D &evt->u.abs;
>      switch (graphic_rotate) {
>      case 90:
>          if (move->axis =3D=3D INPUT_AXIS_X) {
> @@ -220,16 +220,16 @@ static void qemu_input_event_trace(QemuConsole *src=
,
> InputEvent *evt)
>      }
>      switch (evt->type) {
>      case INPUT_EVENT_KIND_KEY:
> -        key =3D evt->u.key.data;
> +        key =3D &evt->u.key;
>          switch (key->key->type) {
>          case KEY_VALUE_KIND_NUMBER:
> -            qcode =3D
> qemu_input_key_number_to_qcode(key->key->u.number.data);
> +            qcode =3D qemu_input_key_number_to_qcode(key->key->u.number)=
;
>              name =3D QKeyCode_str(qcode);
> -            trace_input_event_key_number(idx, key->key->u.number.data,
> +            trace_input_event_key_number(idx, key->key->u.number,
>                                           name, key->down);
>              break;
>          case KEY_VALUE_KIND_QCODE:
> -            name =3D QKeyCode_str(key->key->u.qcode.data);
> +            name =3D QKeyCode_str(key->key->u.qcode);
>              trace_input_event_key_qcode(idx, name, key->down);
>              break;
>          case KEY_VALUE_KIND__MAX:
> @@ -238,17 +238,17 @@ static void qemu_input_event_trace(QemuConsole *src=
,
> InputEvent *evt)
>          }
>          break;
>      case INPUT_EVENT_KIND_BTN:
> -        btn =3D evt->u.btn.data;
> +        btn =3D &evt->u.btn;
>          name =3D InputButton_str(btn->button);
>          trace_input_event_btn(idx, name, btn->down);
>          break;
>      case INPUT_EVENT_KIND_REL:
> -        move =3D evt->u.rel.data;
> +        move =3D &evt->u.rel;
>          name =3D InputAxis_str(move->axis);
>          trace_input_event_rel(idx, name, move->value);
>          break;
>      case INPUT_EVENT_KIND_ABS:
> -        move =3D evt->u.abs.data;
> +        move =3D &evt->u.abs;
>          name =3D InputAxis_str(move->axis);
>          trace_input_event_abs(idx, name, move->value);
>          break;
> @@ -355,7 +355,7 @@ void qemu_input_event_send(QemuConsole *src,
> InputEvent *evt)
>      /* Expect all parts of QEMU to send events with QCodes exclusively.
>       * Key numbers are only supported as end-user input via QMP */
>      assert(!(evt->type =3D=3D INPUT_EVENT_KIND_KEY &&
> -             evt->u.key.data->key->type =3D=3D KEY_VALUE_KIND_NUMBER));
> +             evt->u.key.key->type =3D=3D KEY_VALUE_KIND_NUMBER));
>
>
>      /*
> @@ -367,8 +367,8 @@ void qemu_input_event_send(QemuConsole *src,
> InputEvent *evt)
>       * neeed to deal with this mistake
>       */
>      if (evt->type =3D=3D INPUT_EVENT_KIND_KEY &&
> -        evt->u.key.data->key->u.qcode.data =3D=3D Q_KEY_CODE_SYSRQ) {
> -        evt->u.key.data->key->u.qcode.data =3D Q_KEY_CODE_PRINT;
> +        evt->u.key.key->u.qcode =3D=3D Q_KEY_CODE_SYSRQ) {
> +        evt->u.key.key->u.qcode =3D Q_KEY_CODE_PRINT;
>      }
>
>      if (!runstate_is_running() && !runstate_check(RUN_STATE_SUSPENDED)) =
{
> @@ -407,10 +407,9 @@ void qemu_input_event_sync(void)
>  static InputEvent *qemu_input_event_new_key(KeyValue *key, bool down)
>  {
>      InputEvent *evt =3D g_new0(InputEvent, 1);
> -    evt->u.key.data =3D g_new0(InputKeyEvent, 1);
>      evt->type =3D INPUT_EVENT_KIND_KEY;
> -    evt->u.key.data->key =3D key;
> -    evt->u.key.data->down =3D down;
> +    evt->u.key.key =3D key;
> +    evt->u.key.down =3D down;
>      return evt;
>  }
>
> @@ -440,7 +439,7 @@ void qemu_input_event_send_key_qcode(QemuConsole *src=
,
> QKeyCode q, bool down)
>  {
>      KeyValue *key =3D g_new0(KeyValue, 1);
>      key->type =3D KEY_VALUE_KIND_QCODE;
> -    key->u.qcode.data =3D q;
> +    key->u.qcode =3D q;
>      qemu_input_event_send_key(src, key, down);
>  }
>
> @@ -469,7 +468,7 @@ void qemu_input_queue_btn(QemuConsole *src,
> InputButton btn, bool down)
>      };
>      InputEvent evt =3D {
>          .type =3D INPUT_EVENT_KIND_BTN,
> -        .u.btn.data =3D &bevt,
> +        .u.btn =3D bevt,
>      };
>
>      qemu_input_event_send(src, &evt);
> @@ -520,7 +519,7 @@ void qemu_input_queue_rel(QemuConsole *src, InputAxis
> axis, int value)
>      };
>      InputEvent evt =3D {
>          .type =3D INPUT_EVENT_KIND_REL,
> -        .u.rel.data =3D &move,
> +        .u.rel =3D move,
>      };
>
>      qemu_input_event_send(src, &evt);
> @@ -537,7 +536,7 @@ void qemu_input_queue_abs(QemuConsole *src, InputAxis
> axis, int value,
>      };
>      InputEvent evt =3D {
>          .type =3D INPUT_EVENT_KIND_ABS,
> -        .u.abs.data =3D &move,
> +        .u.abs =3D move,
>      };
>
>      qemu_input_event_send(src, &evt);
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index 05e5c73f9d..59e317cbb8 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -1365,21 +1365,21 @@ SocketAddress
> *socket_address_flatten(SocketAddressLegacy *addr_legacy)
>      case SOCKET_ADDRESS_LEGACY_KIND_INET:
>          addr->type =3D SOCKET_ADDRESS_TYPE_INET;
>          QAPI_CLONE_MEMBERS(InetSocketAddress, &addr->u.inet,
> -                           addr_legacy->u.inet.data);
> +                           &addr_legacy->u.inet);
>          break;
>      case SOCKET_ADDRESS_LEGACY_KIND_UNIX:
>          addr->type =3D SOCKET_ADDRESS_TYPE_UNIX;
>          QAPI_CLONE_MEMBERS(UnixSocketAddress, &addr->u.q_unix,
> -                           addr_legacy->u.q_unix.data);
> +                           &addr_legacy->u.q_unix);
>          break;
>      case SOCKET_ADDRESS_LEGACY_KIND_VSOCK:
>          addr->type =3D SOCKET_ADDRESS_TYPE_VSOCK;
>          QAPI_CLONE_MEMBERS(VsockSocketAddress, &addr->u.vsock,
> -                           addr_legacy->u.vsock.data);
> +                           &addr_legacy->u.vsock);
>          break;
>      case SOCKET_ADDRESS_LEGACY_KIND_FD:
>          addr->type =3D SOCKET_ADDRESS_TYPE_FD;
> -        QAPI_CLONE_MEMBERS(String, &addr->u.fd, addr_legacy->u.fd.data);
> +        QAPI_CLONE_MEMBERS(String, &addr->u.fd, &addr_legacy->u.fd);
>          break;
>      default:
>          abort();
> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> index fafec94e02..1c4e3407a3 100644
> --- a/scripts/qapi/introspect.py
> +++ b/scripts/qapi/introspect.py
> @@ -188,7 +188,12 @@ const QLitObject %(c_name)s =3D %(c_string)s;
>                  'variants': [self._gen_variant(v) for v in variants]}
>
>      def _gen_variant(self, variant):
> -        obj =3D {'case': variant.name, 'type':
> self._use_type(variant.type)}
> +        if variant.wrapped:
> +            obj =3D {'case': variant.name,
> +                   'type': self._use_type(variant.wrapper_type)}
> +        else:
> +            obj =3D {'case': variant.name,
> +                   'type': self._use_type(variant.type)}
>          return _make_tree(obj, variant.ifcond, None)
>
>      def visit_builtin_type(self, name, info, json_type):
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index 720449feee..17525b4216 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -216,6 +216,11 @@ class QAPISchemaBuiltinType(QAPISchemaType):
>          self._json_type_name =3D json_type
>          self._c_type_name =3D c_type
>
> +    def check(self, schema):
> +        # Don't check twice, it would fail an assertion
> +        if not self._checked:
> +            super().check(schema)
> +
>      def c_name(self):
>          return self.name
>
> @@ -593,18 +598,21 @@ class QAPISchemaVariants:
>                          "branch '%s' is not a value of %s"
>                          % (v.name, self.tag_member.type.describe()))
>                  if (not isinstance(v.type, QAPISchemaObjectType)
> -                        or v.type.variants):
> +                        or v.type.variants) and v.flat:
>                      raise QAPISemError(
>                          self.info,
>                          "%s cannot use %s"
>                          % (v.describe(self.info), v.type.describe()))
> -                v.type.check(schema)
> +                if isinstance(v.type, QAPISchemaObjectType):
> +                    v.type.check(schema)
>
>      def check_clash(self, info, seen):
>          for v in self.variants:
>              # Reset seen map for each variant, since qapi names from one
> -            # branch do not affect another branch
> -            v.type.check_clash(info, dict(seen))
> +            # branch do not affect another branch.  Variants that are
> +            # never flat don't even conflict with the base.
> +            if isinstance(v.type, QAPISchemaObjectType):
> +                v.type.check_clash(info, dict(seen) if v.flat else {})
>
>
>  class QAPISchemaMember:
> @@ -705,9 +713,22 @@ class QAPISchemaObjectTypeMember(QAPISchemaMember):
>  class QAPISchemaVariant(QAPISchemaObjectTypeMember):
>      role =3D 'branch'
>
> -    def __init__(self, name, info, typ, ifcond=3DNone):
> +    def __init__(self, name, info, typ, ifcond=3DNone, flat=3DTrue,
> +                 wrapper_type=3DNone):
>          super().__init__(name, info, typ, False, ifcond)
>
> +        self.flat =3D flat
> +        self.wrapped =3D bool(wrapper_type)
> +        self.wrapper_type =3D wrapper_type
> +
> +        # For now, unions are either flat or wrapped, never both
> +        assert self.flat or self.wrapped
> +        assert not (self.flat and self.wrapped)
> +
> +    def check(self, schema):
> +        super().check(schema)
> +        if self.wrapped:
> +            self.wrapper_type.check(schema)
>
>  class QAPISchemaCommand(QAPISchemaEntity):
>      meta =3D 'command'
> @@ -1017,14 +1038,19 @@ class QAPISchema:
>      def _make_variant(self, case, typ, ifcond, info):
>          return QAPISchemaVariant(case, info, typ, ifcond)
>
> -    def _make_simple_variant(self, case, typ, ifcond, info):
> +    def _make_simple_variant(self, union_name, case, typ, ifcond, info):
>          if isinstance(typ, list):
>              assert len(typ) =3D=3D 1
>              typ =3D self._make_array_type(typ[0], info)
> -        typ =3D self._make_implicit_object_type(
> -            typ, info, self.lookup_type(typ),
> -            'wrapper', [self._make_member('data', typ, None, None, info)=
])
> -        return QAPISchemaVariant(case, info, typ, ifcond)
> +
> +        # The wrapper type is only used for introspection compatibility.
> +        # Don't add it to the entity list of the schema.
> +        wrapper_name =3D 'q_obj_%s-%s-wrapper' % (union_name, case)
> +        wrapper_member =3D self._make_member('data', typ, None, None, in=
fo)
> +        wrapper_type =3D QAPISchemaObjectType(wrapper_name, info, None,
> ifcond,
> +                                            None, None, [wrapper_member]=
,
> None)
> +        return QAPISchemaVariant(case, info, typ, ifcond, flat=3DFalse,
> +                                 wrapper_type=3Dwrapper_type)
>
>      def _def_union_type(self, expr, info, doc):
>          name =3D expr['union']
> @@ -1044,7 +1070,7 @@ class QAPISchema:
>                          for (key, value) in data.items()]
>              members =3D []
>          else:
> -            variants =3D [self._make_simple_variant(key, value['type'],
> +            variants =3D [self._make_simple_variant(name, key,
> value['type'],
>                                                    value.get('if'), info)
>                          for (key, value) in data.items()]
>              enum =3D [{'name': v.name, 'if': v.ifcond} for v in variants=
]
> diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
> index 339f152152..f72567cbcc 100644
> --- a/scripts/qapi/visit.py
> +++ b/scripts/qapi/visit.py
> @@ -118,6 +118,34 @@ bool visit_type_%(c_name)s_members(Visitor *v,
> %(c_name)s *obj, Error **errp)
>          break;
>  ''',
>                               case=3Dcase_str)
> +            elif not isinstance(var.type, QAPISchemaObjectType):
> +                assert not var.flat
> +                ret +=3D mcgen('''
> +    case %(case)s:
> +        return visit_type_%(c_type)s(v, "data", &obj->u.%(c_name)s, errp=
);
> +''',
> +                             case=3Dcase_str,
> +                             c_type=3Dvar.type.c_name(), c_name=3Dc_name=
(
> var.name))
> +            elif var.wrapped:
> +                ret +=3D mcgen('''
> +    case %(case)s:
> +    {
> +        bool ok;
> +
> +        if (!visit_start_struct(v, "data", NULL, 0, errp)) {
> +            return false;
> +        }
> +        ok =3D visit_type_%(c_type)s_members(v, &obj->u.%(c_name)s, errp=
);
> +        if (ok) {
> +            ok =3D visit_check_struct(v, errp);
> +        }
> +        visit_end_struct(v, NULL);
> +        return ok;
> +    }
> +''',
> +                             case=3Dcase_str,
> +                             c_type=3Dvar.type.c_name(), c_name=3Dc_name=
(
> var.name))
> +
>              else:
>                  ret +=3D mcgen('''
>      case %(case)s:
> diff --git a/tests/qapi-schema/doc-good.out
> b/tests/qapi-schema/doc-good.out
> index 419284dae2..bcbcbd2fce 100644
> --- a/tests/qapi-schema/doc-good.out
> +++ b/tests/qapi-schema/doc-good.out
> @@ -31,10 +31,6 @@ object Object
>      case two: Variant2
>          if ['IFTWO']
>      feature union-feat1
> -object q_obj_Variant1-wrapper
> -    member data: Variant1 optional=3DFalse
> -object q_obj_Variant2-wrapper
> -    member data: Variant2 optional=3DFalse
>  enum SugaredUnionKind
>      member one
>      member two
> @@ -42,8 +38,8 @@ enum SugaredUnionKind
>  object SugaredUnion
>      member type: SugaredUnionKind optional=3DFalse
>      tag type
> -    case one: q_obj_Variant1-wrapper
> -    case two: q_obj_Variant2-wrapper
> +    case one: Variant1
> +    case two: Variant2
>          if ['IFTWO']
>      feature union-feat2
>  alternate Alternate
> diff --git a/tests/qapi-schema/qapi-schema-test.out
> b/tests/qapi-schema/qapi-schema-test.out
> index 8868ca0dca..a4e4051c61 100644
> --- a/tests/qapi-schema/qapi-schema-test.out
> +++ b/tests/qapi-schema/qapi-schema-test.out
> @@ -125,36 +125,6 @@ alternate AltStrObj
>      tag type
>      case s: str
>      case o: TestStruct
> -object q_obj_intList-wrapper
> -    member data: intList optional=3DFalse
> -object q_obj_int8List-wrapper
> -    member data: int8List optional=3DFalse
> -object q_obj_int16List-wrapper
> -    member data: int16List optional=3DFalse
> -object q_obj_int32List-wrapper
> -    member data: int32List optional=3DFalse
> -object q_obj_int64List-wrapper
> -    member data: int64List optional=3DFalse
> -object q_obj_uint8List-wrapper
> -    member data: uint8List optional=3DFalse
> -object q_obj_uint16List-wrapper
> -    member data: uint16List optional=3DFalse
> -object q_obj_uint32List-wrapper
> -    member data: uint32List optional=3DFalse
> -object q_obj_uint64List-wrapper
> -    member data: uint64List optional=3DFalse
> -object q_obj_numberList-wrapper
> -    member data: numberList optional=3DFalse
> -object q_obj_boolList-wrapper
> -    member data: boolList optional=3DFalse
> -object q_obj_strList-wrapper
> -    member data: strList optional=3DFalse
> -object q_obj_sizeList-wrapper
> -    member data: sizeList optional=3DFalse
> -object q_obj_anyList-wrapper
> -    member data: anyList optional=3DFalse
> -object q_obj_StatusList-wrapper
> -    member data: StatusList optional=3DFalse
>  enum UserDefListUnionKind
>      member integer
>      member s8
> @@ -174,21 +144,21 @@ enum UserDefListUnionKind
>  object UserDefListUnion
>      member type: UserDefListUnionKind optional=3DFalse
>      tag type
> -    case integer: q_obj_intList-wrapper
> -    case s8: q_obj_int8List-wrapper
> -    case s16: q_obj_int16List-wrapper
> -    case s32: q_obj_int32List-wrapper
> -    case s64: q_obj_int64List-wrapper
> -    case u8: q_obj_uint8List-wrapper
> -    case u16: q_obj_uint16List-wrapper
> -    case u32: q_obj_uint32List-wrapper
> -    case u64: q_obj_uint64List-wrapper
> -    case number: q_obj_numberList-wrapper
> -    case boolean: q_obj_boolList-wrapper
> -    case string: q_obj_strList-wrapper
> -    case sizes: q_obj_sizeList-wrapper
> -    case any: q_obj_anyList-wrapper
> -    case user: q_obj_StatusList-wrapper
> +    case integer: intList
> +    case s8: int8List
> +    case s16: int16List
> +    case s32: int32List
> +    case s64: int64List
> +    case u8: uint8List
> +    case u16: uint16List
> +    case u32: uint32List
> +    case u64: uint64List
> +    case number: numberList
> +    case boolean: boolList
> +    case string: strList
> +    case sizes: sizeList
> +    case any: anyList
> +    case user: StatusList
>  include include/sub-module.json
>  command user_def_cmd None -> None
>      gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconf=
ig=3DFalse
> @@ -263,14 +233,12 @@ object __org.qemu_x-Struct
>      base __org.qemu_x-Base
>      member __org.qemu_x-member2: str optional=3DFalse
>      member wchar-t: int optional=3DTrue
> -object q_obj_str-wrapper
> -    member data: str optional=3DFalse
>  enum __org.qemu_x-Union1Kind
>      member __org.qemu_x-branch
>  object __org.qemu_x-Union1
>      member type: __org.qemu_x-Union1Kind optional=3DFalse
>      tag type
> -    case __org.qemu_x-branch: q_obj_str-wrapper
> +    case __org.qemu_x-branch: str
>  alternate __org.qemu_x-Alt1
>      tag type
>      case __org.qemu_x-branch: str
> @@ -305,8 +273,6 @@ enum TestIfEnum
>      member bar
>          if ['defined(TEST_IF_ENUM_BAR)']
>      if ['defined(TEST_IF_ENUM)']
> -object q_obj_TestStruct-wrapper
> -    member data: TestStruct optional=3DFalse
>  enum TestIfUnionKind
>      member foo
>      member union_bar
> @@ -315,8 +281,8 @@ enum TestIfUnionKind
>  object TestIfUnion
>      member type: TestIfUnionKind optional=3DFalse
>      tag type
> -    case foo: q_obj_TestStruct-wrapper
> -    case union_bar: q_obj_str-wrapper
> +    case foo: TestStruct
> +    case union_bar: str
>          if ['defined(TEST_IF_UNION_BAR)']
>      if ['defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)']
>  object q_obj_TestIfUnionCmd-arg
> --
> 2.28.0
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000fa1b4b05b25435c6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 23, 2020 at 2:14 PM Kev=
in Wolf &lt;<a href=3D"mailto:kwolf@redhat.com">kwolf@redhat.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Variants of=
 simple unions are always contained in a wrapper object<br>
called &#39;data&#39; that serves no real use. When mapping a QAPI object t=
o the<br>
command line, this becomes very visible to users because they have to<br>
add one or more useless &#39;data.&#39; to many option names.<br>
<br>
As a first step towards avoiding this painful CLI experience, this gets<br>
rid of the &#39;data&#39; indirection internally: The QAPI parser doesn&#39=
;t use a<br>
wrapper object as the variant type any more, so the indirection is<br>
removed from the generated C types. As a result, the C type looks the<br>
same for flat and simple unions now. A large part of this patch is<br>
mechanical conversion of C code to remove the &#39;data&#39; indirection.<b=
r>
<br>
Conceptually, the important change is that variants can now have flat<br>
and wrapped representations. For a transitioning period, we&#39;ll allow<br=
>
variants to support both representations in a later patch. Eventually,<br>
the plan is to deprecate and remove wrapped representations entirely,<br>
unifying simple and flat unions.<br>
<br>
The externally visible interfaces stay unchanged: Visitors still expect<br>
the &#39;data&#39; wrappers, and introspection still shows it.<br>
<br>
Signed-off-by: Kevin Wolf &lt;<a href=3D"mailto:kwolf@redhat.com" target=3D=
"_blank">kwolf@redhat.com</a>&gt;<br></blockquote><div><br></div><div>break=
s the build for me:<br></div><div><br></div><div>../chardev/spice.c: In fun=
ction =E2=80=98qemu_chr_open_spice_vmc=E2=80=99:<br>../chardev/spice.c:261:=
56: error: =E2=80=98ChardevSpiceChannel=E2=80=99 has no member named =E2=80=
=98data=E2=80=99<br>=C2=A0 261 | =C2=A0 =C2=A0 ChardevSpiceChannel *spicevm=
c =3D backend-&gt;u.spicevmc.data;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>../chardev/spice.c: In function =E2=
=80=98qemu_chr_open_spice_port=E2=80=99:<br>../chardev/spice.c:297:55: erro=
r: =E2=80=98ChardevSpicePort=E2=80=99 has no member named =E2=80=98data=E2=
=80=99<br>=C2=A0 297 | =C2=A0 =C2=A0 ChardevSpicePort *spiceport =3D backen=
d-&gt;u.spiceport.data;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ^<br>../chardev/spice.c: In function =E2=80=98qemu_chr_pa=
rse_spice_vmc=E2=80=99:<br>../chardev/spice.c:331:35: error: =E2=80=98Chard=
evSpiceChannel=E2=80=99 has no member named =E2=80=98data=E2=80=99<br>=C2=
=A0 331 | =C2=A0 =C2=A0 spicevmc =3D backend-&gt;u.spicevmc.data =3D g_new0=
(ChardevSpiceChannel, 1);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>../chardev/spice.c: In function =E2=80=98qemu=
_chr_parse_spice_port=E2=80=99:<br>../chardev/spice.c:347:37: error: =E2=80=
=98ChardevSpicePort=E2=80=99 has no member named =E2=80=98data=E2=80=99<br>=
=C2=A0 347 | =C2=A0 =C2=A0 spiceport =3D backend-&gt;u.spiceport.data =3D g=
_new0(ChardevSpicePort, 1);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>../ui/spice-app.c: In function =E2=80=
=98chr_spice_backend_new=E2=80=99:<br>../ui/spice-app.c:63:20: error: =E2=
=80=98ChardevSpicePort=E2=80=99 has no member named =E2=80=98data=E2=80=99<=
br>=C2=A0 =C2=A063 | =C2=A0 =C2=A0 be-&gt;u.spiceport.data =3D g_new0(Chard=
evSpicePort, 1);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>../ui/spice-app.c: In function =
=E2=80=98vc_chr_open=E2=80=99:<br>../ui/spice-app.c:86:20: error: =E2=80=98=
ChardevSpicePort=E2=80=99 has no member named =E2=80=98data=E2=80=99<br>=C2=
=A0 =C2=A086 | =C2=A0 =C2=A0 be-&gt;u.spiceport.data-&gt;fqdn =3D fqdn ?<br=
>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0^<br>../ui/spice-app.c: In function =E2=80=98spice_app_=
display_init=E2=80=99:<br>../ui/spice-app.c:185:20: error: =E2=80=98Chardev=
SpicePort=E2=80=99 has no member named =E2=80=98data=E2=80=99<br>=C2=A0 185=
 | =C2=A0 =C2=A0 be-&gt;u.spiceport.data-&gt;fqdn =3D g_strdup(&quot;org.qe=
mu.monitor.qmp.0&quot;);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0docs/devel/qapi-code-gen.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| 32 ++++++++----<br>
=C2=A0backends/tpm/tpm_emulator.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
|=C2=A0 3 +-<br>
=C2=A0backends/tpm/tpm_passthrough.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 4 +-<br>
=C2=A0block/crypto.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 +-<br>
=C2=A0block/qcow2.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 9 ++--<br>
=C2=A0block/vmdk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 14 ++----<br>
=C2=A0blockdev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 36 ++++++-------<br>
=C2=A0chardev/char-file.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 5 +-<br>
=C2=A0chardev/char-mux.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 5 +-<br>
=C2=A0chardev/char-parallel.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 5 +-<br>
=C2=A0chardev/char-pipe.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 7 ++-<br>
=C2=A0chardev/char-ringbuf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 5 +-<br>
=C2=A0chardev/char-serial.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 5 +-<br>
=C2=A0chardev/char-socket.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | 13 ++---<br>
=C2=A0chardev/char-stdio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 5 +-<br>
=C2=A0chardev/char-udp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 11 ++--<br>
=C2=A0chardev/char.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 10 ++--<br>
=C2=A0chardev/msmouse.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 +-<br>
=C2=A0chardev/wctablet.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4 +-<br>
=C2=A0hw/core/numa.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6 +--<br>
=C2=A0hw/display/xenfb.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 8 +--<br>
=C2=A0hw/input/hid.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 8 +--<br>
=C2=A0hw/input/ps2.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6 +--<br>
=C2=A0hw/input/virtio-input-hid.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
|=C2=A0 8 +--<br>
=C2=A0hw/mem/pc-dimm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 18 +++----<br>
=C2=A0hw/virtio/virtio-mem-pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 3 +-<br>
=C2=A0hw/virtio/virtio-pmem-pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
|=C2=A0 3 +-<br>
=C2=A0monitor/hmp-cmds.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 14 +++---<br>
=C2=A0qemu-keymap.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0replay/replay-input.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | 46 +++++++----------<br>
=C2=A0tests/test-char.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 12 ++---<br>
=C2=A0tests/test-clone-visitor.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 14 +++---<br>
=C2=A0tests/test-qmp-cmds.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0tests/test-qobject-input-visitor.c=C2=A0 =C2=A0 =C2=A0| 24 ++++-----<=
br>
=C2=A0tests/test-qobject-output-visitor.c=C2=A0 =C2=A0 | 24 ++++-----<br>
=C2=A0ui/console.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 5 +-<br>
=C2=A0ui/input-keymap.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 12 ++---<br>
=C2=A0ui/input-legacy.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 12 ++---<br>
=C2=A0ui/input.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 43 ++++++++--------<br>
=C2=A0util/qemu-sockets.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 8 +--<br>
=C2=A0scripts/qapi/introspect.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 7 ++-<br>
=C2=A0scripts/qapi/schema.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 48 ++++++++++++++----<br>
=C2=A0scripts/qapi/visit.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | 28 +++++++++++<br>
=C2=A0tests/qapi-schema/doc-good.out=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 8 +--<br>
=C2=A0tests/qapi-schema/qapi-schema-test.out | 70 +++++++------------------=
-<br>
=C2=A045 files changed, 308 insertions(+), 311 deletions(-)<br>
<br>
diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt<br=
>
index c6438c6aa9..9722c1a204 100644<br>
--- a/docs/devel/qapi-code-gen.txt<br>
+++ b/docs/devel/qapi-code-gen.txt<br>
@@ -310,7 +310,20 @@ The BRANCH&#39;s STRING name is the branch name.<br>
=C2=A0The BRANCH&#39;s value defines the branch&#39;s properties, in partic=
ular its<br>
=C2=A0type.=C2=A0 The form TYPE-REF is shorthand for { &#39;type&#39;: TYPE=
-REF }.<br>
<br>
-A simple union type defines a mapping from automatic discriminator<br>
+Each branch can have flat or wrapped representation in the Client JSON<br>
+Protocol.<br>
+<br>
+Wrapped representation of a branch means that it is represented by a<br>
+&#39;data&#39; member that is of the specified data type corresponding to =
the<br>
+discriminator value.<br>
+<br>
+Flat representation means that the union forms a single object that<br>
+contains both common members (from the base type) and the selected<br>
+branch&#39;s members, without any additional nesting.=C2=A0 The two sets o=
f<br>
+member names must be disjoint.<br>
+<br>
+A simple union type automatically contains the &#39;type&#39; member as a<=
br>
+discriminator and defines a mapping from automatic discriminator<br>
=C2=A0values to data types like in this example:<br>
<br>
=C2=A0 { &#39;struct&#39;: &#39;BlockdevOptionsFile&#39;, &#39;data&#39;: {=
 &#39;filename&#39;: &#39;str&#39; } }<br>
@@ -321,10 +334,8 @@ values to data types like in this example:<br>
=C2=A0 =C2=A0 &#39;data&#39;: { &#39;file&#39;: &#39;BlockdevOptionsFile&#3=
9;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;qcow2&#39;: &#39;Bloc=
kdevOptionsQcow2&#39; } }<br>
<br>
-In the Client JSON Protocol, a simple union is represented by an<br>
-object that contains the &#39;type&#39; member as a discriminator, and a<b=
r>
-&#39;data&#39; member that is of the specified data type corresponding to =
the<br>
-discriminator value, as in these examples:<br>
+In the Client JSON Protocol, all simple union branches have wrapped<br>
+representation, as in these examples:<br>
<br>
=C2=A0 { &quot;type&quot;: &quot;file&quot;, &quot;data&quot;: { &quot;file=
name&quot;: &quot;/some/place/my-image&quot; } }<br>
=C2=A0 { &quot;type&quot;: &quot;qcow2&quot;, &quot;data&quot;: { &quot;bac=
king&quot;: &quot;/some/place/my-image&quot;,<br>
@@ -344,13 +355,12 @@ object, it defines common members just like a struct =
type&#39;s &#39;data&#39;<br>
=C2=A0member defines struct type members.=C2=A0 If it is a STRING, it names=
 a<br>
=C2=A0struct type whose members are the common members.<br>
<br>
-All flat union branches must be of struct type.<br>
+Member &#39;discriminator&#39; must name a non-optional enum-typed member =
of<br>
+the base struct and defines the option that should server as the<br>
+discrimiator.<br>
<br>
-In the Client JSON Protocol, a flat union is represented by an object<br>
-with the common members (from the base type) and the selected branch&#39;s=
<br>
-members.=C2=A0 The two sets of member names must be disjoint.=C2=A0 Member=
<br>
-&#39;discriminator&#39; must name a non-optional enum-typed member of the =
base<br>
-struct.<br>
+All flat union branches must be of struct type.=C2=A0 They have always fla=
t<br>
+representation.<br>
<br>
=C2=A0The following example enhances the above simple union example by<br>
=C2=A0adding an optional common member &#39;read-only&#39;, renaming the<br=
>
diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c<br>
index 201cd38503..7d2dc2b19d 100644<br>
--- a/backends/tpm/tpm_emulator.c<br>
+++ b/backends/tpm/tpm_emulator.c<br>
@@ -629,7 +629,8 @@ static TpmTypeOptions *tpm_emulator_get_tpm_options(TPM=
Backend *tb)<br>
=C2=A0 =C2=A0 =C2=A0TpmTypeOptions *options =3D g_new0(TpmTypeOptions, 1);<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0options-&gt;type =3D TPM_TYPE_OPTIONS_KIND_EMULATOR;<br=
>
-=C2=A0 =C2=A0 options-&gt;u.emulator.data =3D QAPI_CLONE(TPMEmulatorOption=
s, tpm_emu-&gt;options);<br>
+=C2=A0 =C2=A0 QAPI_CLONE_MEMBERS(TPMEmulatorOptions, &amp;options-&gt;u.em=
ulator,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tpm_emu-&gt;options);<br>
<br>
=C2=A0 =C2=A0 =C2=A0return options;<br>
=C2=A0}<br>
diff --git a/backends/tpm/tpm_passthrough.c b/backends/tpm/tpm_passthrough.=
c<br>
index 8f6f4998a5..7fa7c84f5a 100644<br>
--- a/backends/tpm/tpm_passthrough.c<br>
+++ b/backends/tpm/tpm_passthrough.c<br>
@@ -322,8 +322,8 @@ static TpmTypeOptions *tpm_passthrough_get_tpm_options(=
TPMBackend *tb)<br>
=C2=A0 =C2=A0 =C2=A0TpmTypeOptions *options =3D g_new0(TpmTypeOptions, 1);<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0options-&gt;type =3D TPM_TYPE_OPTIONS_KIND_PASSTHROUGH;=
<br>
-=C2=A0 =C2=A0 options-&gt;u.passthrough.data =3D QAPI_CLONE(TPMPassthrough=
Options,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0TPM_PASSTHROUGH(tb)-&gt;options);<br>
+=C2=A0 =C2=A0 QAPI_CLONE_MEMBERS(TPMPassthroughOptions, &amp;options-&gt;u=
.passthrough,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0TPM_PASSTHROUGH(tb)-&gt;options);<br>
<br>
=C2=A0 =C2=A0 =C2=A0return options;<br>
=C2=A0}<br>
diff --git a/block/crypto.c b/block/crypto.c<br>
index 0807557763..0e7838d70a 100644<br>
--- a/block/crypto.c<br>
+++ b/block/crypto.c<br>
@@ -775,8 +775,7 @@ block_crypto_get_specific_info_luks(BlockDriverState *b=
s, Error **errp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0spec_info =3D g_new(ImageInfoSpecific, 1);<br>
=C2=A0 =C2=A0 =C2=A0spec_info-&gt;type =3D IMAGE_INFO_SPECIFIC_KIND_LUKS;<b=
r>
-=C2=A0 =C2=A0 spec_info-&gt;u.luks.data =3D g_new(QCryptoBlockInfoLUKS, 1)=
;<br>
-=C2=A0 =C2=A0 *spec_info-&gt;u.luks.data =3D info-&gt;u.luks;<br>
+=C2=A0 =C2=A0 spec_info-&gt;u.luks =3D info-&gt;u.luks;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Blank out pointers we&#39;ve just stolen to avoid do=
uble free */<br>
=C2=A0 =C2=A0 =C2=A0memset(&amp;info-&gt;u.luks, 0, sizeof(info-&gt;u.luks)=
);<br>
diff --git a/block/qcow2.c b/block/qcow2.c<br>
index b05512718c..104fd8ad06 100644<br>
--- a/block/qcow2.c<br>
+++ b/block/qcow2.c<br>
@@ -5052,10 +5052,9 @@ static ImageInfoSpecific *qcow2_get_specific_info(Bl=
ockDriverState *bs,<br>
=C2=A0 =C2=A0 =C2=A0spec_info =3D g_new(ImageInfoSpecific, 1);<br>
=C2=A0 =C2=A0 =C2=A0*spec_info =3D (ImageInfoSpecific){<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type=C2=A0 =3D IMAGE_INFO_SPECIFIC_KIND_=
QCOW2,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .u.qcow2.data =3D g_new0(ImageInfoSpecificQCow=
2, 1),<br>
=C2=A0 =C2=A0 =C2=A0};<br>
=C2=A0 =C2=A0 =C2=A0if (s-&gt;qcow_version =3D=3D 2) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *spec_info-&gt;u.qcow2.data =3D (ImageInfoSpec=
ificQCow2){<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 spec_info-&gt;u.qcow2 =3D (ImageInfoSpecificQC=
ow2){<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.compat=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D g_strdup(&quot;0.10&quot;),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.refcount_bits=C2=A0 =C2=A0=
 =C2=A0 =3D s-&gt;refcount_bits,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
@@ -5068,7 +5067,7 @@ static ImageInfoSpecific *qcow2_get_specific_info(Blo=
ckDriverState *bs,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qapi_free_QCryptoBlockInfo(=
encrypt_info);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *spec_info-&gt;u.qcow2.data =3D (ImageInfoSpec=
ificQCow2){<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 spec_info-&gt;u.qcow2 =3D (ImageInfoSpecificQC=
ow2){<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.compat=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D g_strdup(&quot;1.1&quot;),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.lazy_refcounts=C2=A0 =C2=
=A0 =C2=A0=3D s-&gt;compatible_features &amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QCOW2_COMPAT_LAZY_REFCO=
UNTS,<br>
@@ -5112,8 +5111,8 @@ static ImageInfoSpecific *qcow2_get_specific_info(Blo=
ckDriverState *bs,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(&amp;encrypt_info-&gt;u, 0, sizeof=
(encrypt_info-&gt;u));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qapi_free_QCryptoBlockInfo(encrypt_info);=
<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 spec_info-&gt;u.qcow2.data-&gt;has_encrypt =3D=
 true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 spec_info-&gt;u.qcow2.data-&gt;encrypt =3D qen=
crypt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 spec_info-&gt;u.qcow2.has_encrypt =3D true;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 spec_info-&gt;u.qcow2.encrypt =3D qencrypt;<br=
>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0return spec_info;<br>
diff --git a/block/vmdk.c b/block/vmdk.c<br>
index a00dc00eb4..fc4ddcc351 100644<br>
--- a/block/vmdk.c<br>
+++ b/block/vmdk.c<br>
@@ -2932,18 +2932,14 @@ static ImageInfoSpecific *vmdk_get_specific_info(Bl=
ockDriverState *bs,<br>
<br>
=C2=A0 =C2=A0 =C2=A0*spec_info =3D (ImageInfoSpecific){<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type =3D IMAGE_INFO_SPECIFIC_KIND_VMDK,<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .u =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .vmdk.data =3D g_new0(ImageInfoS=
pecificVmdk, 1),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .u.vmdk =3D (ImageInfoSpecificVmdk) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .create_type =3D g_strdup(s-&gt;=
create_type),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .cid =3D s-&gt;cid,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent_cid =3D s-&gt;parent_cid=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
=C2=A0 =C2=A0 =C2=A0};<br>
<br>
-=C2=A0 =C2=A0 *spec_info-&gt;u.vmdk.data =3D (ImageInfoSpecificVmdk) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .create_type =3D g_strdup(s-&gt;create_type),<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cid =3D s-&gt;cid,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent_cid =3D s-&gt;parent_cid,<br>
-=C2=A0 =C2=A0 };<br>
-<br>
-=C2=A0 =C2=A0 next =3D &amp;spec_info-&gt;u.vmdk.data-&gt;extents;<br>
+=C2=A0 =C2=A0 next =3D &amp;spec_info-&gt;u.vmdk.extents;<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; s-&gt;num_extents; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*next =3D g_new0(ImageInfoList, 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(*next)-&gt;value =3D vmdk_get_extent_inf=
o(&amp;s-&gt;extents[i]);<br>
diff --git a/blockdev.c b/blockdev.c<br>
index fe6fb5dc1d..2602298a26 100644<br>
--- a/blockdev.c<br>
+++ b/blockdev.c<br>
@@ -1090,7 +1090,7 @@ void qmp_blockdev_snapshot_sync(bool has_device, cons=
t char *device,<br>
=C2=A0 =C2=A0 =C2=A0};<br>
=C2=A0 =C2=A0 =C2=A0TransactionAction action =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type =3D TRANSACTION_ACTION_KIND_BLOCKDE=
V_SNAPSHOT_SYNC,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .u.blockdev_snapshot_sync.data =3D &amp;snapsh=
ot,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .u.blockdev_snapshot_sync =3D snapshot,<br>
=C2=A0 =C2=A0 =C2=A0};<br>
=C2=A0 =C2=A0 =C2=A0blockdev_do_action(&amp;action, errp);<br>
=C2=A0}<br>
@@ -1104,7 +1104,7 @@ void qmp_blockdev_snapshot(const char *node, const ch=
ar *overlay,<br>
=C2=A0 =C2=A0 =C2=A0};<br>
=C2=A0 =C2=A0 =C2=A0TransactionAction action =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type =3D TRANSACTION_ACTION_KIND_BLOCKDE=
V_SNAPSHOT,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .u.blockdev_snapshot.data =3D &amp;snapshot_da=
ta,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .u.blockdev_snapshot =3D snapshot_data,<br>
=C2=A0 =C2=A0 =C2=A0};<br>
=C2=A0 =C2=A0 =C2=A0blockdev_do_action(&amp;action, errp);<br>
=C2=A0}<br>
@@ -1119,7 +1119,7 @@ void qmp_blockdev_snapshot_internal_sync(const char *=
device,<br>
=C2=A0 =C2=A0 =C2=A0};<br>
=C2=A0 =C2=A0 =C2=A0TransactionAction action =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type =3D TRANSACTION_ACTION_KIND_BLOCKDE=
V_SNAPSHOT_INTERNAL_SYNC,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .u.blockdev_snapshot_internal_sync.data =3D &a=
mp;snapshot,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .u.blockdev_snapshot_internal_sync =3D snapsho=
t,<br>
=C2=A0 =C2=A0 =C2=A0};<br>
=C2=A0 =C2=A0 =C2=A0blockdev_do_action(&amp;action, errp);<br>
=C2=A0}<br>
@@ -1289,7 +1289,7 @@ static void internal_snapshot_prepare(BlkActionState =
*common,<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_assert(common-&gt;action-&gt;type =3D=3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TRANSACTION_ACTION_KIND_BL=
OCKDEV_SNAPSHOT_INTERNAL_SYNC);<br>
-=C2=A0 =C2=A0 internal =3D common-&gt;action-&gt;u.blockdev_snapshot_inter=
nal_sync.data;<br>
+=C2=A0 =C2=A0 internal =3D &amp;common-&gt;action-&gt;u.blockdev_snapshot_=
internal_sync;<br>
=C2=A0 =C2=A0 =C2=A0state =3D DO_UPCAST(InternalSnapshotState, common, comm=
on);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* 1. parse input */<br>
@@ -1453,7 +1453,7 @@ static void external_snapshot_prepare(BlkActionState =
*common,<br>
=C2=A0 =C2=A0 =C2=A0switch (action-&gt;type) {<br>
=C2=A0 =C2=A0 =C2=A0case TRANSACTION_ACTION_KIND_BLOCKDEV_SNAPSHOT:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BlockdevSnapshot *s =3D action-&=
gt;u.blockdev_snapshot.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BlockdevSnapshot *s =3D &amp;act=
ion-&gt;u.blockdev_snapshot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device =3D s-&gt;node;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node_name =3D s-&gt;node;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0new_image_file =3D NULL;<br=
>
@@ -1462,7 +1462,7 @@ static void external_snapshot_prepare(BlkActionState =
*common,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case TRANSACTION_ACTION_KIND_BLOCKDEV_SNAPSHOT_SYNC:<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BlockdevSnapshotSync *s =3D acti=
on-&gt;u.blockdev_snapshot_sync.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BlockdevSnapshotSync *s =3D &amp=
;action-&gt;u.blockdev_snapshot_sync;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device =3D s-&gt;has_device=
 ? s-&gt;device : NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node_name =3D s-&gt;has_nod=
e_name ? s-&gt;node_name : NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0new_image_file =3D s-&gt;sn=
apshot_file;<br>
@@ -1507,7 +1507,7 @@ static void external_snapshot_prepare(BlkActionState =
*common,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (action-&gt;type =3D=3D TRANSACTION_ACTION_KIND_BLOC=
KDEV_SNAPSHOT_SYNC) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 BlockdevSnapshotSync *s =3D action-&gt;u.block=
dev_snapshot_sync.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 BlockdevSnapshotSync *s =3D &amp;action-&gt;u.=
blockdev_snapshot_sync;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *format =3D s-&gt;has_format ?=
 s-&gt;format : &quot;qcow2&quot;;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum NewImageMode mode;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *snapshot_node_name =3D<br>
@@ -1712,7 +1712,7 @@ static void drive_backup_prepare(BlkActionState *comm=
on, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0assert(common-&gt;action-&gt;type =3D=3D TRANSACTION_AC=
TION_KIND_DRIVE_BACKUP);<br>
-=C2=A0 =C2=A0 backup =3D common-&gt;action-&gt;u.drive_backup.data;<br>
+=C2=A0 =C2=A0 backup =3D &amp;common-&gt;action-&gt;u.drive_backup;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!backup-&gt;has_mode) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0backup-&gt;mode =3D NEW_IMAGE_MODE_ABSOLU=
TE_PATHS;<br>
@@ -1907,7 +1907,7 @@ static void blockdev_backup_prepare(BlkActionState *c=
ommon, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0assert(common-&gt;action-&gt;type =3D=3D TRANSACTION_AC=
TION_KIND_BLOCKDEV_BACKUP);<br>
-=C2=A0 =C2=A0 backup =3D common-&gt;action-&gt;u.blockdev_backup.data;<br>
+=C2=A0 =C2=A0 backup =3D &amp;common-&gt;action-&gt;u.blockdev_backup;<br>
<br>
=C2=A0 =C2=A0 =C2=A0bs =3D bdrv_lookup_bs(backup-&gt;device, backup-&gt;dev=
ice, errp);<br>
=C2=A0 =C2=A0 =C2=A0if (!bs) {<br>
@@ -2012,7 +2012,7 @@ static void block_dirty_bitmap_add_prepare(BlkActionS=
tate *common,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 action =3D common-&gt;action-&gt;u.block_dirty_bitmap_add.da=
ta;<br>
+=C2=A0 =C2=A0 action =3D &amp;common-&gt;action-&gt;u.block_dirty_bitmap_a=
dd;<br>
=C2=A0 =C2=A0 =C2=A0/* AIO context taken and released within qmp_block_dirt=
y_bitmap_add */<br>
=C2=A0 =C2=A0 =C2=A0qmp_block_dirty_bitmap_add(action-&gt;node, action-&gt;=
name,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 action-&gt;has_granularity, action-&=
gt;granularity,<br>
@@ -2033,7 +2033,7 @@ static void block_dirty_bitmap_add_abort(BlkActionSta=
te *common)<br>
=C2=A0 =C2=A0 =C2=A0BlockDirtyBitmapState *state =3D DO_UPCAST(BlockDirtyBi=
tmapState,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 common, common);<br>
<br>
-=C2=A0 =C2=A0 action =3D common-&gt;action-&gt;u.block_dirty_bitmap_add.da=
ta;<br>
+=C2=A0 =C2=A0 action =3D &amp;common-&gt;action-&gt;u.block_dirty_bitmap_a=
dd;<br>
=C2=A0 =C2=A0 =C2=A0/* Should not be able to fail: IF the bitmap was added =
via .prepare(),<br>
=C2=A0 =C2=A0 =C2=A0 * then the node reference and bitmap name must have be=
en valid.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
@@ -2053,7 +2053,7 @@ static void block_dirty_bitmap_clear_prepare(BlkActio=
nState *common,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 action =3D common-&gt;action-&gt;u.block_dirty_bitmap_clear.=
data;<br>
+=C2=A0 =C2=A0 action =3D &amp;common-&gt;action-&gt;u.block_dirty_bitmap_c=
lear;<br>
=C2=A0 =C2=A0 =C2=A0state-&gt;bitmap =3D block_dirty_bitmap_lookup(action-&=
gt;node,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0action-&gt;name,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0&amp;state-&gt;bs,<br>
@@ -2098,7 +2098,7 @@ static void block_dirty_bitmap_enable_prepare(BlkActi=
onState *common,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 action =3D common-&gt;action-&gt;u.block_dirty_bitmap_enable=
.data;<br>
+=C2=A0 =C2=A0 action =3D &amp;common-&gt;action-&gt;u.block_dirty_bitmap_e=
nable;<br>
=C2=A0 =C2=A0 =C2=A0state-&gt;bitmap =3D block_dirty_bitmap_lookup(action-&=
gt;node,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0action-&gt;name,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0NULL,<br>
@@ -2136,7 +2136,7 @@ static void block_dirty_bitmap_disable_prepare(BlkAct=
ionState *common,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 action =3D common-&gt;action-&gt;u.block_dirty_bitmap_disabl=
e.data;<br>
+=C2=A0 =C2=A0 action =3D &amp;common-&gt;action-&gt;u.block_dirty_bitmap_d=
isable;<br>
=C2=A0 =C2=A0 =C2=A0state-&gt;bitmap =3D block_dirty_bitmap_lookup(action-&=
gt;node,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0action-&gt;name,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0NULL,<br>
@@ -2174,7 +2174,7 @@ static void block_dirty_bitmap_merge_prepare(BlkActio=
nState *common,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 action =3D common-&gt;action-&gt;u.block_dirty_bitmap_merge.=
data;<br>
+=C2=A0 =C2=A0 action =3D &amp;common-&gt;action-&gt;u.block_dirty_bitmap_m=
erge;<br>
<br>
=C2=A0 =C2=A0 =C2=A0state-&gt;bitmap =3D block_dirty_bitmap_merge(action-&g=
t;node, action-&gt;target,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 action-&gt;bitmaps, &amp;state-&gt;backup,<br>
@@ -2192,7 +2192,7 @@ static void block_dirty_bitmap_remove_prepare(BlkActi=
onState *common,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 action =3D common-&gt;action-&gt;u.block_dirty_bitmap_remove=
.data;<br>
+=C2=A0 =C2=A0 action =3D &amp;common-&gt;action-&gt;u.block_dirty_bitmap_r=
emove;<br>
<br>
=C2=A0 =C2=A0 =C2=A0state-&gt;bitmap =3D block_dirty_bitmap_remove(action-&=
gt;node, action-&gt;name,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0false, &amp;state-&gt;bs, errp);<br>
@@ -2895,7 +2895,7 @@ void qmp_drive_backup(DriveBackup *backup, Error **er=
rp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0TransactionAction action =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type =3D TRANSACTION_ACTION_KIND_DRIVE_B=
ACKUP,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .u.drive_backup.data =3D backup,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .u.drive_backup =3D *backup,<br>
=C2=A0 =C2=A0 =C2=A0};<br>
=C2=A0 =C2=A0 =C2=A0blockdev_do_action(&amp;action, errp);<br>
=C2=A0}<br>
@@ -2918,7 +2918,7 @@ void qmp_blockdev_backup(BlockdevBackup *backup, Erro=
r **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0TransactionAction action =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type =3D TRANSACTION_ACTION_KIND_BLOCKDE=
V_BACKUP,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .u.blockdev_backup.data =3D backup,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .u.blockdev_backup =3D *backup,<br>
=C2=A0 =C2=A0 =C2=A0};<br>
=C2=A0 =C2=A0 =C2=A0blockdev_do_action(&amp;action, errp);<br>
=C2=A0}<br>
diff --git a/chardev/char-file.c b/chardev/char-file.c<br>
index 2fd80707e5..3f0f0b6045 100644<br>
--- a/chardev/char-file.c<br>
+++ b/chardev/char-file.c<br>
@@ -39,7 +39,7 @@ static void qmp_chardev_open_file(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool *be_opened,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 ChardevFile *file =3D backend-&gt;u.file.data;<br>
+=C2=A0 =C2=A0 ChardevFile *file =3D &amp;backend-&gt;u.file;<br>
=C2=A0#ifdef _WIN32<br>
=C2=A0 =C2=A0 =C2=A0HANDLE out;<br>
=C2=A0 =C2=A0 =C2=A0DWORD accessmode;<br>
@@ -100,14 +100,13 @@ static void qemu_chr_parse_file_out(QemuOpts *opts, C=
hardevBackend *backend,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br=
>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0const char *path =3D qemu_opt_get(opts, &quot;path&quot=
;);<br>
-=C2=A0 =C2=A0 ChardevFile *file;<br>
+=C2=A0 =C2=A0 ChardevFile *file =3D &amp;backend-&gt;u.file;<br>
<br>
=C2=A0 =C2=A0 =C2=A0backend-&gt;type =3D CHARDEV_BACKEND_KIND_FILE;<br>
=C2=A0 =C2=A0 =C2=A0if (path =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;chardev: file: no =
filename given&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 file =3D backend-&gt;u.file.data =3D g_new0(ChardevFile, 1);=
<br>
=C2=A0 =C2=A0 =C2=A0qemu_chr_parse_common(opts, qapi_ChardevFile_base(file)=
);<br>
=C2=A0 =C2=A0 =C2=A0file-&gt;out =3D g_strdup(path);<br>
<br>
diff --git a/chardev/char-mux.c b/chardev/char-mux.c<br>
index 6f980bb836..bfb4bc6b8b 100644<br>
--- a/chardev/char-mux.c<br>
+++ b/chardev/char-mux.c<br>
@@ -314,7 +314,7 @@ static void qemu_chr_open_mux(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool *be_opened,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 ChardevMux *mux =3D backend-&gt;u.mux.data;<br>
+=C2=A0 =C2=A0 ChardevMux *mux =3D &amp;backend-&gt;u.mux;<br>
=C2=A0 =C2=A0 =C2=A0Chardev *drv;<br>
=C2=A0 =C2=A0 =C2=A0MuxChardev *d =3D MUX_CHARDEV(chr);<br>
<br>
@@ -336,14 +336,13 @@ static void qemu_chr_parse_mux(QemuOpts *opts, Charde=
vBackend *backend,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0const char *chardev =3D qemu_opt_get(opts, &quot;charde=
v&quot;);<br>
-=C2=A0 =C2=A0 ChardevMux *mux;<br>
+=C2=A0 =C2=A0 ChardevMux *mux =3D &amp;backend-&gt;u.mux;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (chardev =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;chardev: mux: no c=
hardev given&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0backend-&gt;type =3D CHARDEV_BACKEND_KIND_MUX;<br>
-=C2=A0 =C2=A0 mux =3D backend-&gt;u.mux.data =3D g_new0(ChardevMux, 1);<br=
>
=C2=A0 =C2=A0 =C2=A0qemu_chr_parse_common(opts, qapi_ChardevMux_base(mux));=
<br>
=C2=A0 =C2=A0 =C2=A0mux-&gt;chardev =3D g_strdup(chardev);<br>
=C2=A0}<br>
diff --git a/chardev/char-parallel.c b/chardev/char-parallel.c<br>
index 05e7efbd6c..a17157a3be 100644<br>
--- a/chardev/char-parallel.c<br>
+++ b/chardev/char-parallel.c<br>
@@ -244,7 +244,7 @@ static void qmp_chardev_open_parallel(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool *be_=
opened,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **e=
rrp)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 ChardevHostdev *parallel =3D backend-&gt;u.parallel.data;<br=
>
+=C2=A0 =C2=A0 ChardevHostdev *parallel =3D &amp;backend-&gt;u.parallel;<br=
>
=C2=A0 =C2=A0 =C2=A0int fd;<br>
<br>
=C2=A0 =C2=A0 =C2=A0fd =3D qmp_chardev_open_file_source(parallel-&gt;device=
, O_RDWR, errp);<br>
@@ -258,14 +258,13 @@ static void qemu_chr_parse_parallel(QemuOpts *opts, C=
hardevBackend *backend,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br=
>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0const char *device =3D qemu_opt_get(opts, &quot;path&qu=
ot;);<br>
-=C2=A0 =C2=A0 ChardevHostdev *parallel;<br>
+=C2=A0 =C2=A0 ChardevHostdev *parallel =3D &amp;backend-&gt;u.parallel;<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0if (device =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;chardev: parallel:=
 no device path given&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0backend-&gt;type =3D CHARDEV_BACKEND_KIND_PARALLEL;<br>
-=C2=A0 =C2=A0 parallel =3D backend-&gt;u.parallel.data =3D g_new0(ChardevH=
ostdev, 1);<br>
=C2=A0 =C2=A0 =C2=A0qemu_chr_parse_common(opts, qapi_ChardevHostdev_base(pa=
rallel));<br>
=C2=A0 =C2=A0 =C2=A0parallel-&gt;device =3D g_strdup(device);<br>
=C2=A0}<br>
diff --git a/chardev/char-pipe.c b/chardev/char-pipe.c<br>
index 7eca5d9a56..eb19d9a526 100644<br>
--- a/chardev/char-pipe.c<br>
+++ b/chardev/char-pipe.c<br>
@@ -109,7 +109,7 @@ static void qemu_chr_open_pipe(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool *be_opened,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 ChardevHostdev *opts =3D backend-&gt;u.pipe.data;<br>
+=C2=A0 =C2=A0 ChardevHostdev *opts =3D &amp;backend-&gt;u.pipe;<br>
=C2=A0 =C2=A0 =C2=A0const char *filename =3D opts-&gt;device;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (win_chr_pipe_init(chr, filename, errp) &lt; 0) {<br=
>
@@ -124,7 +124,7 @@ static void qemu_chr_open_pipe(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool *be_opened,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 ChardevHostdev *opts =3D backend-&gt;u.pipe.data;<br>
+=C2=A0 =C2=A0 ChardevHostdev *opts =3D &amp;backend-&gt;u.pipe;<br>
=C2=A0 =C2=A0 =C2=A0int fd_in, fd_out;<br>
=C2=A0 =C2=A0 =C2=A0char *filename_in;<br>
=C2=A0 =C2=A0 =C2=A0char *filename_out;<br>
@@ -158,14 +158,13 @@ static void qemu_chr_parse_pipe(QemuOpts *opts, Chard=
evBackend *backend,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0const char *device =3D qemu_opt_get(opts, &quot;path&qu=
ot;);<br>
-=C2=A0 =C2=A0 ChardevHostdev *dev;<br>
+=C2=A0 =C2=A0 ChardevHostdev *dev =3D &amp;backend-&gt;u.pipe;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (device =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;chardev: pipe: no =
device path given&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0backend-&gt;type =3D CHARDEV_BACKEND_KIND_PIPE;<br>
-=C2=A0 =C2=A0 dev =3D backend-&gt;u.pipe.data =3D g_new0(ChardevHostdev, 1=
);<br>
=C2=A0 =C2=A0 =C2=A0qemu_chr_parse_common(opts, qapi_ChardevHostdev_base(de=
v));<br>
=C2=A0 =C2=A0 =C2=A0dev-&gt;device =3D g_strdup(device);<br>
=C2=A0}<br>
diff --git a/chardev/char-ringbuf.c b/chardev/char-ringbuf.c<br>
index d40d21d3cf..0ef2a17f90 100644<br>
--- a/chardev/char-ringbuf.c<br>
+++ b/chardev/char-ringbuf.c<br>
@@ -97,7 +97,7 @@ static void qemu_chr_open_ringbuf(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool *be_opened,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 ChardevRingbuf *opts =3D backend-&gt;u.ringbuf.data;<br>
+=C2=A0 =C2=A0 ChardevRingbuf *opts =3D &amp;backend-&gt;u.ringbuf;<br>
=C2=A0 =C2=A0 =C2=A0RingBufChardev *d =3D RINGBUF_CHARDEV(chr);<br>
<br>
=C2=A0 =C2=A0 =C2=A0d-&gt;size =3D opts-&gt;has_size ? opts-&gt;size : 6553=
6;<br>
@@ -210,10 +210,9 @@ static void qemu_chr_parse_ringbuf(QemuOpts *opts, Cha=
rdevBackend *backend,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int val;<br>
-=C2=A0 =C2=A0 ChardevRingbuf *ringbuf;<br>
+=C2=A0 =C2=A0 ChardevRingbuf *ringbuf =3D &amp;backend-&gt;u.ringbuf;<br>
<br>
=C2=A0 =C2=A0 =C2=A0backend-&gt;type =3D CHARDEV_BACKEND_KIND_RINGBUF;<br>
-=C2=A0 =C2=A0 ringbuf =3D backend-&gt;u.ringbuf.data =3D g_new0(ChardevRin=
gbuf, 1);<br>
=C2=A0 =C2=A0 =C2=A0qemu_chr_parse_common(opts, qapi_ChardevRingbuf_base(ri=
ngbuf));<br>
<br>
=C2=A0 =C2=A0 =C2=A0val =3D qemu_opt_get_size(opts, &quot;size&quot;, 0);<b=
r>
diff --git a/chardev/char-serial.c b/chardev/char-serial.c<br>
index 7c3d84ae24..baec955ecf 100644<br>
--- a/chardev/char-serial.c<br>
+++ b/chardev/char-serial.c<br>
@@ -263,7 +263,7 @@ static void qmp_chardev_open_serial(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool *be_opened,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br=
>
=C2=A0{<br>
-=C2=A0 =C2=A0 ChardevHostdev *serial =3D backend-&gt;u.serial.data;<br>
+=C2=A0 =C2=A0 ChardevHostdev *serial =3D &amp;backend-&gt;u.serial;<br>
=C2=A0 =C2=A0 =C2=A0int fd;<br>
<br>
=C2=A0 =C2=A0 =C2=A0fd =3D qmp_chardev_open_file_source(serial-&gt;device, =
O_RDWR | O_NONBLOCK,<br>
@@ -283,14 +283,13 @@ static void qemu_chr_parse_serial(QemuOpts *opts, Cha=
rdevBackend *backend,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0const char *device =3D qemu_opt_get(opts, &quot;path&qu=
ot;);<br>
-=C2=A0 =C2=A0 ChardevHostdev *serial;<br>
+=C2=A0 =C2=A0 ChardevHostdev *serial =3D &amp;backend-&gt;u.serial;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (device =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;chardev: serial/tt=
y: no device path given&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0backend-&gt;type =3D CHARDEV_BACKEND_KIND_SERIAL;<br>
-=C2=A0 =C2=A0 serial =3D backend-&gt;u.serial.data =3D g_new0(ChardevHostd=
ev, 1);<br>
=C2=A0 =C2=A0 =C2=A0qemu_chr_parse_common(opts, qapi_ChardevHostdev_base(se=
rial));<br>
=C2=A0 =C2=A0 =C2=A0serial-&gt;device =3D g_strdup(device);<br>
=C2=A0}<br>
diff --git a/chardev/char-socket.c b/chardev/char-socket.c<br>
index 95e45812d5..5332439d34 100644<br>
--- a/chardev/char-socket.c<br>
+++ b/chardev/char-socket.c<br>
@@ -1301,7 +1301,7 @@ static void qmp_chardev_open_socket(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br=
>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0SocketChardev *s =3D SOCKET_CHARDEV(chr);<br>
-=C2=A0 =C2=A0 ChardevSocket *sock =3D backend-&gt;u.socket.data;<br>
+=C2=A0 =C2=A0 ChardevSocket *sock =3D &amp;backend-&gt;u.socket;<br>
=C2=A0 =C2=A0 =C2=A0bool do_nodelay=C2=A0 =C2=A0 =C2=A0=3D sock-&gt;has_nod=
elay ? sock-&gt;nodelay : false;<br>
=C2=A0 =C2=A0 =C2=A0bool is_listen=C2=A0 =C2=A0 =C2=A0 =3D sock-&gt;has_ser=
ver=C2=A0 ? sock-&gt;server=C2=A0 : true;<br>
=C2=A0 =C2=A0 =C2=A0bool is_telnet=C2=A0 =C2=A0 =C2=A0 =3D sock-&gt;has_tel=
net=C2=A0 ? sock-&gt;telnet=C2=A0 : false;<br>
@@ -1403,7 +1403,7 @@ static void qemu_chr_parse_socket(QemuOpts *opts, Cha=
rdevBackend *backend,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0backend-&gt;type =3D CHARDEV_BACKEND_KIND_SOCKET;<br>
-=C2=A0 =C2=A0 sock =3D backend-&gt;u.socket.data =3D g_new0(ChardevSocket,=
 1);<br>
+=C2=A0 =C2=A0 sock =3D &amp;backend-&gt;u.socket;<br>
=C2=A0 =C2=A0 =C2=A0qemu_chr_parse_common(opts, qapi_ChardevSocket_base(soc=
k));<br>
<br>
=C2=A0 =C2=A0 =C2=A0sock-&gt;has_nodelay =3D qemu_opt_get(opts, &quot;delay=
&quot;);<br>
@@ -1435,16 +1435,14 @@ static void qemu_chr_parse_socket(QemuOpts *opts, C=
hardevBackend *backend,<br>
<br>
=C2=A0 =C2=A0 =C2=A0addr =3D g_new0(SocketAddressLegacy, 1);<br>
=C2=A0 =C2=A0 =C2=A0if (path) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 UnixSocketAddress *q_unix;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 UnixSocketAddress *q_unix =3D &amp;addr-&gt;u.=
q_unix;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr-&gt;type =3D SOCKET_ADDRESS_LEGACY_K=
IND_UNIX;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 q_unix =3D addr-&gt;u.q_unix.data =3D g_new0(U=
nixSocketAddress, 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0q_unix-&gt;path =3D g_strdup(path);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0q_unix-&gt;tight =3D tight;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0q_unix-&gt;abstract =3D abstract;<br>
=C2=A0 =C2=A0 =C2=A0} else if (host) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr-&gt;type =3D SOCKET_ADDRESS_LEGACY_K=
IND_INET;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 addr-&gt;u.inet.data =3D g_new(InetSocketAddre=
ss, 1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *addr-&gt;u.inet.data =3D (InetSocketAddress) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 addr-&gt;u.inet =3D (InetSocketAddress) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.host =3D g_strdup(host),<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.port =3D g_strdup(port),<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.has_to =3D qemu_opt_get(op=
ts, &quot;to&quot;),<br>
@@ -1456,8 +1454,7 @@ static void qemu_chr_parse_socket(QemuOpts *opts, Cha=
rdevBackend *backend,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
=C2=A0 =C2=A0 =C2=A0} else if (fd) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr-&gt;type =3D SOCKET_ADDRESS_LEGACY_K=
IND_FD;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 addr-&gt;u.fd.data =3D g_new(String, 1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 addr-&gt;u.fd.data-&gt;str =3D g_strdup(fd);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 addr-&gt;u.fd.str =3D g_strdup(fd);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_assert_not_reached();<br>
=C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c<br>
index 403da308c9..81ee655a21 100644<br>
--- a/chardev/char-stdio.c<br>
+++ b/chardev/char-stdio.c<br>
@@ -87,7 +87,7 @@ static void qemu_chr_open_stdio(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool *be_opened,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 ChardevStdio *opts =3D backend-&gt;u.stdio.data;<br>
+=C2=A0 =C2=A0 ChardevStdio *opts =3D &amp;backend-&gt;u.stdio;<br>
=C2=A0 =C2=A0 =C2=A0struct sigaction act;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (is_daemonized()) {<br>
@@ -120,10 +120,9 @@ static void qemu_chr_open_stdio(Chardev *chr,<br>
=C2=A0static void qemu_chr_parse_stdio(QemuOpts *opts, ChardevBackend *back=
end,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 ChardevStdio *stdio;<br>
+=C2=A0 =C2=A0 ChardevStdio *stdio =3D &amp;backend-&gt;u.stdio;<br>
<br>
=C2=A0 =C2=A0 =C2=A0backend-&gt;type =3D CHARDEV_BACKEND_KIND_STDIO;<br>
-=C2=A0 =C2=A0 stdio =3D backend-&gt;u.stdio.data =3D g_new0(ChardevStdio, =
1);<br>
=C2=A0 =C2=A0 =C2=A0qemu_chr_parse_common(opts, qapi_ChardevStdio_base(stdi=
o));<br>
=C2=A0 =C2=A0 =C2=A0stdio-&gt;has_signal =3D true;<br>
=C2=A0 =C2=A0 =C2=A0stdio-&gt;signal =3D qemu_opt_get_bool(opts, &quot;sign=
al&quot;, true);<br>
diff --git a/chardev/char-udp.c b/chardev/char-udp.c<br>
index 16b5dbce58..3b1bdddbbd 100644<br>
--- a/chardev/char-udp.c<br>
+++ b/chardev/char-udp.c<br>
@@ -140,7 +140,7 @@ static void qemu_chr_parse_udp(QemuOpts *opts, ChardevB=
ackend *backend,<br>
=C2=A0 =C2=A0 =C2=A0const char *localport =3D qemu_opt_get(opts, &quot;loca=
lport&quot;);<br>
=C2=A0 =C2=A0 =C2=A0bool has_local =3D false;<br>
=C2=A0 =C2=A0 =C2=A0SocketAddressLegacy *addr;<br>
-=C2=A0 =C2=A0 ChardevUdp *udp;<br>
+=C2=A0 =C2=A0 ChardevUdp *udp =3D &amp;backend-&gt;u.udp;<br>
<br>
=C2=A0 =C2=A0 =C2=A0backend-&gt;type =3D CHARDEV_BACKEND_KIND_UDP;<br>
=C2=A0 =C2=A0 =C2=A0if (host =3D=3D NULL || strlen(host) =3D=3D 0) {<br>
@@ -161,13 +161,11 @@ static void qemu_chr_parse_udp(QemuOpts *opts, Charde=
vBackend *backend,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0has_local =3D true;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 udp =3D backend-&gt;u.udp.data =3D g_new0(ChardevUdp, 1);<br=
>
=C2=A0 =C2=A0 =C2=A0qemu_chr_parse_common(opts, qapi_ChardevUdp_base(udp));=
<br>
<br>
=C2=A0 =C2=A0 =C2=A0addr =3D g_new0(SocketAddressLegacy, 1);<br>
=C2=A0 =C2=A0 =C2=A0addr-&gt;type =3D SOCKET_ADDRESS_LEGACY_KIND_INET;<br>
-=C2=A0 =C2=A0 addr-&gt;u.inet.data =3D g_new(InetSocketAddress, 1);<br>
-=C2=A0 =C2=A0 *addr-&gt;u.inet.data =3D (InetSocketAddress) {<br>
+=C2=A0 =C2=A0 addr-&gt;u.inet =3D (InetSocketAddress) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.host =3D g_strdup(host),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.port =3D g_strdup(port),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.has_ipv4 =3D qemu_opt_get(opts, &quot;ip=
v4&quot;),<br>
@@ -181,8 +179,7 @@ static void qemu_chr_parse_udp(QemuOpts *opts, ChardevB=
ackend *backend,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0udp-&gt;has_local =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr =3D g_new0(SocketAddressLegacy, 1);<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr-&gt;type =3D SOCKET_ADDRESS_LEGACY_K=
IND_INET;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 addr-&gt;u.inet.data =3D g_new(InetSocketAddre=
ss, 1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *addr-&gt;u.inet.data =3D (InetSocketAddress) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 addr-&gt;u.inet =3D (InetSocketAddress) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.host =3D g_strdup(localadd=
r),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.port =3D g_strdup(localpor=
t),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
@@ -195,7 +192,7 @@ static void qmp_chardev_open_udp(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool *be_opened,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 ChardevUdp *udp =3D backend-&gt;u.udp.data;<br>
+=C2=A0 =C2=A0 ChardevUdp *udp =3D &amp;backend-&gt;u.udp;<br>
=C2=A0 =C2=A0 =C2=A0SocketAddress *local_addr =3D socket_address_flatten(ud=
p-&gt;local);<br>
=C2=A0 =C2=A0 =C2=A0SocketAddress *remote_addr =3D socket_address_flatten(u=
dp-&gt;remote);<br>
=C2=A0 =C2=A0 =C2=A0QIOChannelSocket *sioc =3D qio_channel_socket_new();<br=
>
diff --git a/chardev/char.c b/chardev/char.c<br>
index 028612c333..5192964694 100644<br>
--- a/chardev/char.c<br>
+++ b/chardev/char.c<br>
@@ -238,7 +238,7 @@ static void qemu_char_open(Chardev *chr, ChardevBackend=
 *backend,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);<br>
=C2=A0 =C2=A0 =C2=A0/* Any ChardevCommon member would work */<br>
-=C2=A0 =C2=A0 ChardevCommon *common =3D backend ? backend-&gt;u.null.data =
: NULL;<br>
+=C2=A0 =C2=A0 ChardevCommon *common =3D backend ? &amp;backend-&gt;u.null =
: NULL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (common &amp;&amp; common-&gt;has_logfile) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int flags =3D O_WRONLY | O_CREAT;<br>
@@ -625,9 +625,8 @@ ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts, Err=
or **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ChardevCommon *ccom =3D g_new0(ChardevCommon, =
1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_chr_parse_common(opts, ccom);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 backend-&gt;u.null.data =3D ccom; /* Any Chard=
evCommon member would work */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Any ChardevCommon member would work */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_chr_parse_common(opts, &amp;backend-&gt;u=
.null);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0return backend;<br>
@@ -690,8 +689,7 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts, GMainCo=
ntext *context,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qapi_free_ChardevBackend(backend);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0backend =3D g_new0(ChardevBackend, 1);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0backend-&gt;type =3D CHARDEV_BACKEND_KIND=
_MUX;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 backend-&gt;u.mux.data =3D g_new0(ChardevMux, =
1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 backend-&gt;u.mux.data-&gt;chardev =3D g_strdu=
p(bid);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 backend-&gt;u.mux.chardev =3D g_strdup(bid);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mux =3D qemu_chardev_new(id, TYPE_CHARDEV=
_MUX, backend, context, errp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mux =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0object_unparent(OBJECT(chr)=
);<br>
diff --git a/chardev/msmouse.c b/chardev/msmouse.c<br>
index eb9231dcdb..98b0ef8cd7 100644<br>
--- a/chardev/msmouse.c<br>
+++ b/chardev/msmouse.c<br>
@@ -111,12 +111,12 @@ static void msmouse_input_event(DeviceState *dev, Qem=
uConsole *src,<br>
<br>
=C2=A0 =C2=A0 =C2=A0switch (evt-&gt;type) {<br>
=C2=A0 =C2=A0 =C2=A0case INPUT_EVENT_KIND_REL:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 move =3D evt-&gt;u.rel.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 move =3D &amp;evt-&gt;u.rel;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mouse-&gt;axis[move-&gt;axis] +=3D move-&=
gt;value;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case INPUT_EVENT_KIND_BTN:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 btn =3D evt-&gt;u.btn.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 btn =3D &amp;evt-&gt;u.btn;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mouse-&gt;btns[btn-&gt;button] =3D btn-&g=
t;down;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mouse-&gt;btnc[btn-&gt;button] =3D true;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
diff --git a/chardev/wctablet.c b/chardev/wctablet.c<br>
index 95e005f5a5..8479f59183 100644<br>
--- a/chardev/wctablet.c<br>
+++ b/chardev/wctablet.c<br>
@@ -154,12 +154,12 @@ static void wctablet_input_event(DeviceState *dev, Qe=
muConsole *src,<br>
<br>
=C2=A0 =C2=A0 =C2=A0switch (evt-&gt;type) {<br>
=C2=A0 =C2=A0 =C2=A0case INPUT_EVENT_KIND_ABS:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 move =3D evt-&gt;u.abs.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 move =3D &amp;evt-&gt;u.abs;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tablet-&gt;axis[move-&gt;axis] =3D move-&=
gt;value;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case INPUT_EVENT_KIND_BTN:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 btn =3D evt-&gt;u.btn.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 btn =3D &amp;evt-&gt;u.btn;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tablet-&gt;btns[btn-&gt;button] =3D btn-&=
gt;down;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
diff --git a/hw/core/numa.c b/hw/core/numa.c<br>
index 7c4dd4e68e..24fe0e11d8 100644<br>
--- a/hw/core/numa.c<br>
+++ b/hw/core/numa.c<br>
@@ -765,19 +765,19 @@ static void numa_stat_memory_devices(NumaNodeMem node=
_mem[])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case MEMORY_DEVICE_INFO_KIN=
D_DIMM:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case MEMORY_DEVICE_INFO_KIN=
D_NVDIMM:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pcdimm_info =
=3D value-&gt;type =3D=3D MEMORY_DEVICE_INFO_KIND_DIMM ?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 value-&gt;u.dimm.data : value-&gt;u.nvdimm.=
data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;value-&gt;u.dimm : &amp;value-&gt;u.nv=
dimm;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node_mem[pcdi=
mm_info-&gt;node].node_mem +=3D pcdimm_info-&gt;size;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node_mem[pcdi=
mm_info-&gt;node].node_plugged_mem +=3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0pcdimm_info-&gt;size;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case MEMORY_DEVICE_INFO_KIN=
D_VIRTIO_PMEM:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vpi =3D value-&gt;=
u.virtio_pmem.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vpi =3D &amp;value=
-&gt;u.virtio_pmem;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* TODO: once=
 we support numa, assign to right node */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node_mem[0].n=
ode_mem +=3D vpi-&gt;size;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node_mem[0].n=
ode_plugged_mem +=3D vpi-&gt;size;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case MEMORY_DEVICE_INFO_KIN=
D_VIRTIO_MEM:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vmi =3D value-&gt;=
u.virtio_mem.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vmi =3D &amp;value=
-&gt;u.virtio_mem;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node_mem[vmi-=
&gt;node].node_mem +=3D vmi-&gt;size;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0node_mem[vmi-=
&gt;node].node_plugged_mem +=3D vmi-&gt;size;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c<br>
index 838260b6ad..6aa6010774 100644<br>
--- a/hw/display/xenfb.c<br>
+++ b/hw/display/xenfb.c<br>
@@ -201,7 +201,7 @@ static void xenfb_key_event(DeviceState *dev, QemuConso=
le *src,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0InputEvent *evt)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0struct XenInput *xenfb =3D (struct XenInput *)dev;<br>
-=C2=A0 =C2=A0 InputKeyEvent *key =3D evt-&gt;u.key.data;<br>
+=C2=A0 =C2=A0 InputKeyEvent *key =3D &amp;evt-&gt;u.key;<br>
=C2=A0 =C2=A0 =C2=A0int qcode =3D qemu_input_key_value_to_qcode(key-&gt;key=
);<br>
=C2=A0 =C2=A0 =C2=A0int lnx;<br>
<br>
@@ -236,7 +236,7 @@ static void xenfb_mouse_event(DeviceState *dev, QemuCon=
sole *src,<br>
<br>
=C2=A0 =C2=A0 =C2=A0switch (evt-&gt;type) {<br>
=C2=A0 =C2=A0 =C2=A0case INPUT_EVENT_KIND_BTN:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 btn =3D evt-&gt;u.btn.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 btn =3D &amp;evt-&gt;u.btn;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (btn-&gt;button) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case INPUT_BUTTON_LEFT:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xenfb_send_key(xenfb, btn-&=
gt;down, BTN_LEFT);<br>
@@ -263,7 +263,7 @@ static void xenfb_mouse_event(DeviceState *dev, QemuCon=
sole *src,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case INPUT_EVENT_KIND_ABS:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 move =3D evt-&gt;u.abs.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 move =3D &amp;evt-&gt;u.abs;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (xenfb-&gt;raw_pointer_wanted) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xenfb-&gt;axis[move-&gt;axi=
s] =3D move-&gt;value;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
@@ -289,7 +289,7 @@ static void xenfb_mouse_event(DeviceState *dev, QemuCon=
sole *src,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case INPUT_EVENT_KIND_REL:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 move =3D evt-&gt;u.rel.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 move =3D &amp;evt-&gt;u.rel;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xenfb-&gt;axis[move-&gt;axis] +=3D move-&=
gt;value;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
diff --git a/hw/input/hid.c b/hw/input/hid.c<br>
index 89239b5634..2472c5a902 100644<br>
--- a/hw/input/hid.c<br>
+++ b/hw/input/hid.c<br>
@@ -126,7 +126,7 @@ static void hid_pointer_event(DeviceState *dev, QemuCon=
sole *src,<br>
<br>
=C2=A0 =C2=A0 =C2=A0switch (evt-&gt;type) {<br>
=C2=A0 =C2=A0 =C2=A0case INPUT_EVENT_KIND_REL:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 move =3D evt-&gt;u.rel.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 move =3D &amp;evt-&gt;u.rel;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (move-&gt;axis =3D=3D INPUT_AXIS_X) {<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e-&gt;xdx +=3D move-&gt;val=
ue;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (move-&gt;axis =3D=3D INPUT_AXI=
S_Y) {<br>
@@ -135,7 +135,7 @@ static void hid_pointer_event(DeviceState *dev, QemuCon=
sole *src,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case INPUT_EVENT_KIND_ABS:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 move =3D evt-&gt;u.abs.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 move =3D &amp;evt-&gt;u.abs;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (move-&gt;axis =3D=3D INPUT_AXIS_X) {<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e-&gt;xdx =3D move-&gt;valu=
e;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (move-&gt;axis =3D=3D INPUT_AXI=
S_Y) {<br>
@@ -144,7 +144,7 @@ static void hid_pointer_event(DeviceState *dev, QemuCon=
sole *src,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case INPUT_EVENT_KIND_BTN:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 btn =3D evt-&gt;u.btn.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 btn =3D &amp;evt-&gt;u.btn;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (btn-&gt;down) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e-&gt;buttons_state |=3D bm=
ap[btn-&gt;button];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (btn-&gt;button =3D=3D I=
NPUT_BUTTON_WHEEL_UP) {<br>
@@ -230,7 +230,7 @@ static void hid_keyboard_event(DeviceState *dev, QemuCo=
nsole *src,<br>
=C2=A0 =C2=A0 =C2=A0HIDState *hs =3D (HIDState *)dev;<br>
=C2=A0 =C2=A0 =C2=A0int scancodes[3], i, count;<br>
=C2=A0 =C2=A0 =C2=A0int slot;<br>
-=C2=A0 =C2=A0 InputKeyEvent *key =3D evt-&gt;u.key.data;<br>
+=C2=A0 =C2=A0 InputKeyEvent *key =3D &amp;evt-&gt;u.key;<br>
<br>
=C2=A0 =C2=A0 =C2=A0count =3D qemu_input_key_value_to_scancode(key-&gt;key,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 key-&gt;down,<br>
diff --git a/hw/input/ps2.c b/hw/input/ps2.c<br>
index f8746d2f52..1176ccc88c 100644<br>
--- a/hw/input/ps2.c<br>
+++ b/hw/input/ps2.c<br>
@@ -284,7 +284,7 @@ static void ps2_keyboard_event(DeviceState *dev, QemuCo=
nsole *src,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InputEvent *evt)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0PS2KbdState *s =3D (PS2KbdState *)dev;<br>
-=C2=A0 =C2=A0 InputKeyEvent *key =3D evt-&gt;u.key.data;<br>
+=C2=A0 =C2=A0 InputKeyEvent *key =3D &amp;evt-&gt;u.key;<br>
=C2=A0 =C2=A0 =C2=A0int qcode;<br>
=C2=A0 =C2=A0 =C2=A0uint16_t keycode =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0int mod;<br>
@@ -727,7 +727,7 @@ static void ps2_mouse_event(DeviceState *dev, QemuConso=
le *src,<br>
<br>
=C2=A0 =C2=A0 =C2=A0switch (evt-&gt;type) {<br>
=C2=A0 =C2=A0 =C2=A0case INPUT_EVENT_KIND_REL:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 move =3D evt-&gt;u.rel.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 move =3D &amp;evt-&gt;u.rel;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (move-&gt;axis =3D=3D INPUT_AXIS_X) {<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;mouse_dx +=3D move-&g=
t;value;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (move-&gt;axis =3D=3D INPUT_AXI=
S_Y) {<br>
@@ -736,7 +736,7 @@ static void ps2_mouse_event(DeviceState *dev, QemuConso=
le *src,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case INPUT_EVENT_KIND_BTN:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 btn =3D evt-&gt;u.btn.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 btn =3D &amp;evt-&gt;u.btn;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (btn-&gt;down) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;mouse_buttons |=3D bm=
ap[btn-&gt;button];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (btn-&gt;button =3D=3D I=
NPUT_BUTTON_WHEEL_UP) {<br>
diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c<br>
index a7a244a95d..1c7b07cf42 100644<br>
--- a/hw/input/virtio-input-hid.c<br>
+++ b/hw/input/virtio-input-hid.c<br>
@@ -83,7 +83,7 @@ static void virtio_input_handle_event(DeviceState *dev, Q=
emuConsole *src,<br>
<br>
=C2=A0 =C2=A0 =C2=A0switch (evt-&gt;type) {<br>
=C2=A0 =C2=A0 =C2=A0case INPUT_EVENT_KIND_KEY:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 key =3D evt-&gt;u.key.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 key =3D &amp;evt-&gt;u.key;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qcode =3D qemu_input_key_value_to_qcode(k=
ey-&gt;key);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (qcode &lt; qemu_input_map_qcode_to_li=
nux_len &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_input_map_qcode_to_lin=
ux[qcode]) {<br>
@@ -99,7 +99,7 @@ static void virtio_input_handle_event(DeviceState *dev, Q=
emuConsole *src,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case INPUT_EVENT_KIND_BTN:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 btn =3D evt-&gt;u.btn.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 btn =3D &amp;evt-&gt;u.btn;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (vhid-&gt;wheel_axis &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(btn-&gt;button =3D=3D INPU=
T_BUTTON_WHEEL_UP ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 btn-&gt;button =3D=3D INPU=
T_BUTTON_WHEEL_DOWN) &amp;&amp;<br>
@@ -123,14 +123,14 @@ static void virtio_input_handle_event(DeviceState *de=
v, QemuConsole *src,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case INPUT_EVENT_KIND_REL:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 move =3D evt-&gt;u.rel.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 move =3D &amp;evt-&gt;u.rel;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0event.type=C2=A0 =3D cpu_to_le16(EV_REL);=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0event.code=C2=A0 =3D cpu_to_le16(axismap_=
rel[move-&gt;axis]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0event.value =3D cpu_to_le32(move-&gt;valu=
e);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_input_send(vinput, &amp;event);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case INPUT_EVENT_KIND_ABS:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 move =3D evt-&gt;u.abs.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 move =3D &amp;evt-&gt;u.abs;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0event.type=C2=A0 =3D cpu_to_le16(EV_ABS);=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0event.code=C2=A0 =3D cpu_to_le16(axismap_=
abs[move-&gt;axis]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0event.value =3D cpu_to_le32(move-&gt;valu=
e);<br>
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c<br>
index c30351070b..3d6f836621 100644<br>
--- a/hw/mem/pc-dimm.c<br>
+++ b/hw/mem/pc-dimm.c<br>
@@ -236,11 +236,19 @@ static MemoryRegion *pc_dimm_md_get_memory_region(Mem=
oryDeviceState *md,<br>
=C2=A0static void pc_dimm_md_fill_device_info(const MemoryDeviceState *md,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Me=
moryDeviceInfo *info)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 PCDIMMDeviceInfo *di =3D g_new0(PCDIMMDeviceInfo, 1);<br>
+=C2=A0 =C2=A0 PCDIMMDeviceInfo *di;<br>
=C2=A0 =C2=A0 =C2=A0const DeviceClass *dc =3D DEVICE_GET_CLASS(md);<br>
=C2=A0 =C2=A0 =C2=A0const PCDIMMDevice *dimm =3D PC_DIMM(md);<br>
=C2=A0 =C2=A0 =C2=A0const DeviceState *dev =3D DEVICE(md);<br>
<br>
+=C2=A0 =C2=A0 if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 di =3D &amp;info-&gt;u.nvdimm;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;type =3D MEMORY_DEVICE_INFO_KIND_NVDI=
MM;<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 di =3D &amp;info-&gt;u.dimm;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;type =3D MEMORY_DEVICE_INFO_KIND_DIMM=
;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (dev-&gt;id) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0di-&gt;has_id =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0di-&gt;id =3D g_strdup(dev-&gt;id);<br>
@@ -253,14 +261,6 @@ static void pc_dimm_md_fill_device_info(const MemoryDe=
viceState *md,<br>
=C2=A0 =C2=A0 =C2=A0di-&gt;size =3D object_property_get_uint(OBJECT(dimm), =
PC_DIMM_SIZE_PROP,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NU=
LL);<br>
=C2=A0 =C2=A0 =C2=A0di-&gt;memdev =3D object_get_canonical_path(OBJECT(dimm=
-&gt;hostmem));<br>
-<br>
-=C2=A0 =C2=A0 if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;u.nvdimm.data =3D di;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;type =3D MEMORY_DEVICE_INFO_KIND_NVDI=
MM;<br>
-=C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;u.dimm.data =3D di;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;type =3D MEMORY_DEVICE_INFO_KIND_DIMM=
;<br>
-=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
=C2=A0static void pc_dimm_class_init(ObjectClass *oc, void *data)<br>
diff --git a/hw/virtio/virtio-mem-pci.c b/hw/virtio/virtio-mem-pci.c<br>
index 913f4a3326..f93572fc27 100644<br>
--- a/hw/virtio/virtio-mem-pci.c<br>
+++ b/hw/virtio/virtio-mem-pci.c<br>
@@ -58,7 +58,7 @@ static uint64_t virtio_mem_pci_get_plugged_size(const Mem=
oryDeviceState *md,<br>
=C2=A0static void virtio_mem_pci_fill_device_info(const MemoryDeviceState *=
md,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0MemoryDeviceInfo *info)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 VirtioMEMDeviceInfo *vi =3D g_new0(VirtioMEMDeviceInfo, 1);<=
br>
+=C2=A0 =C2=A0 VirtioMEMDeviceInfo *vi =3D &amp;info-&gt;u.virtio_mem;<br>
=C2=A0 =C2=A0 =C2=A0VirtIOMEMPCI *pci_mem =3D VIRTIO_MEM_PCI(md);<br>
=C2=A0 =C2=A0 =C2=A0VirtIOMEM *vmem =3D VIRTIO_MEM(&amp;pci_mem-&gt;vdev);<=
br>
=C2=A0 =C2=A0 =C2=A0VirtIOMEMClass *vpc =3D VIRTIO_MEM_GET_CLASS(vmem);<br>
@@ -72,7 +72,6 @@ static void virtio_mem_pci_fill_device_info(const MemoryD=
eviceState *md,<br>
=C2=A0 =C2=A0 =C2=A0/* let the real device handle everything else */<br>
=C2=A0 =C2=A0 =C2=A0vpc-&gt;fill_device_info(vmem, vi);<br>
<br>
-=C2=A0 =C2=A0 info-&gt;u.virtio_mem.data =3D vi;<br>
=C2=A0 =C2=A0 =C2=A0info-&gt;type =3D MEMORY_DEVICE_INFO_KIND_VIRTIO_MEM;<b=
r>
=C2=A0}<br>
<br>
diff --git a/hw/virtio/virtio-pmem-pci.c b/hw/virtio/virtio-pmem-pci.c<br>
index 2b2a0b1eae..adf17f873b 100644<br>
--- a/hw/virtio/virtio-pmem-pci.c<br>
+++ b/hw/virtio/virtio-pmem-pci.c<br>
@@ -63,7 +63,7 @@ static uint64_t virtio_pmem_pci_get_plugged_size(const Me=
moryDeviceState *md,<br>
=C2=A0static void virtio_pmem_pci_fill_device_info(const MemoryDeviceState =
*md,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 MemoryDeviceInfo *info)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 VirtioPMEMDeviceInfo *vi =3D g_new0(VirtioPMEMDeviceInfo, 1)=
;<br>
+=C2=A0 =C2=A0 VirtioPMEMDeviceInfo *vi =3D &amp;info-&gt;u.virtio_pmem;<br=
>
=C2=A0 =C2=A0 =C2=A0VirtIOPMEMPCI *pci_pmem =3D VIRTIO_PMEM_PCI(md);<br>
=C2=A0 =C2=A0 =C2=A0VirtIOPMEM *pmem =3D VIRTIO_PMEM(&amp;pci_pmem-&gt;vdev=
);<br>
=C2=A0 =C2=A0 =C2=A0VirtIOPMEMClass *vpc =3D VIRTIO_PMEM_GET_CLASS(pmem);<b=
r>
@@ -77,7 +77,6 @@ static void virtio_pmem_pci_fill_device_info(const Memory=
DeviceState *md,<br>
=C2=A0 =C2=A0 =C2=A0/* let the real device handle everything else */<br>
=C2=A0 =C2=A0 =C2=A0vpc-&gt;fill_device_info(pmem, vi);<br>
<br>
-=C2=A0 =C2=A0 info-&gt;u.virtio_pmem.data =3D vi;<br>
=C2=A0 =C2=A0 =C2=A0info-&gt;type =3D MEMORY_DEVICE_INFO_KIND_VIRTIO_PMEM;<=
br>
=C2=A0}<br>
<br>
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c<br>
index 9789f4277f..0324caa114 100644<br>
--- a/monitor/hmp-cmds.c<br>
+++ b/monitor/hmp-cmds.c<br>
@@ -918,7 +918,7 @@ void hmp_info_tpm(Monitor *mon, const QDict *qdict)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (ti-&gt;options-&gt;type) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case TPM_TYPE_OPTIONS_KIND_PASSTHROUGH:<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tpo =3D ti-&gt;options-&gt;u.pas=
sthrough.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tpo =3D &amp;ti-&gt;options-&gt;=
u.passthrough;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0monitor_printf(mon, &quot;%=
s%s%s%s&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 tpo-&gt;has_path ? &quot;,path=3D&quot; : &quot;&q=
uot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 tpo-&gt;has_path ? tpo-&gt;path : &quot;&quot;,<br=
>
@@ -926,7 +926,7 @@ void hmp_info_tpm(Monitor *mon, const QDict *qdict)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 tpo-&gt;has_cancel_path ? tpo-&gt;cancel_path : &q=
uot;&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case TPM_TYPE_OPTIONS_KIND_EMULATOR:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 teo =3D ti-&gt;options-&gt;u.emu=
lator.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 teo =3D &amp;ti-&gt;options-&gt;=
u.emulator;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0monitor_printf(mon, &quot;,=
chardev=3D%s&quot;, teo-&gt;chardev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case TPM_TYPE_OPTIONS_KIND__MAX:<br>
@@ -1728,14 +1728,14 @@ void hmp_sendkey(Monitor *mon, const QDict *qdict)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_out;=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0keylist-&gt;value-&gt;type =
=3D KEY_VALUE_KIND_NUMBER;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 keylist-&gt;value-&gt;u.number.d=
ata =3D value;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 keylist-&gt;value-&gt;u.number =
=3D value;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int idx =3D index_from_key(=
keys, keyname_len);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (idx =3D=3D Q_KEY_CODE__=
MAX) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_out;=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0keylist-&gt;value-&gt;type =
=3D KEY_VALUE_KIND_QCODE;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 keylist-&gt;value-&gt;u.qcode.da=
ta =3D idx;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 keylist-&gt;value-&gt;u.qcode =
=3D idx;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!*separator) {<br>
@@ -1860,7 +1860,7 @@ void hmp_info_memory_devices(Monitor *mon, const QDic=
t *qdict)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case MEMORY_DEVICE_INFO_KIN=
D_DIMM:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case MEMORY_DEVICE_INFO_KIN=
D_NVDIMM:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0di =3D value-=
&gt;type =3D=3D MEMORY_DEVICE_INFO_KIND_DIMM ?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0value-&gt;u.dimm.data : value-&gt;u.nvdimm.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&amp;value-&gt;u.dimm : &amp;value-&gt;u.nvdimm;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0monitor_print=
f(mon, &quot;Memory device [%s]: \&quot;%s\&quot;\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MemoryDeviceInfoKind_str(value-&gt;t=
ype),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 di-&gt;id ? di-&gt;id : &quot;&quot;=
);<br>
@@ -1875,7 +1875,7 @@ void hmp_info_memory_devices(Monitor *mon, const QDic=
t *qdict)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 di-&gt;hotpluggable ? &quot;true&quo=
t; : &quot;false&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case MEMORY_DEVICE_INFO_KIN=
D_VIRTIO_PMEM:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vpi =3D value-&gt;=
u.virtio_pmem.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vpi =3D &amp;value=
-&gt;u.virtio_pmem;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0monitor_print=
f(mon, &quot;Memory device [%s]: \&quot;%s\&quot;\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MemoryDeviceInfoKind_str(value-&gt;t=
ype),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vpi-&gt;id ? vpi-&gt;id : &quot;&quo=
t;);<br>
@@ -1884,7 +1884,7 @@ void hmp_info_memory_devices(Monitor *mon, const QDic=
t *qdict)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0monitor_print=
f(mon, &quot;=C2=A0 memdev: %s\n&quot;, vpi-&gt;memdev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case MEMORY_DEVICE_INFO_KIN=
D_VIRTIO_MEM:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vmi =3D value-&gt;=
u.virtio_mem.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vmi =3D &amp;value=
-&gt;u.virtio_mem;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0monitor_print=
f(mon, &quot;Memory device [%s]: \&quot;%s\&quot;\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MemoryDeviceInfoKind_str(value-&gt;t=
ype),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vmi-&gt;id ? vmi-&gt;id : &quot;&quo=
t;);<br>
diff --git a/qemu-keymap.c b/qemu-keymap.c<br>
index 536e8f2385..52637c449c 100644<br>
--- a/qemu-keymap.c<br>
+++ b/qemu-keymap.c<br>
@@ -38,7 +38,7 @@ static uint32_t qcode_to_number(uint32_t qcode)<br>
=C2=A0 =C2=A0 =C2=A0uint32_t number;<br>
<br>
=C2=A0 =C2=A0 =C2=A0keyvalue.type =3D KEY_VALUE_KIND_QCODE;<br>
-=C2=A0 =C2=A0 keyvalue.u.qcode.data =3D qcode;<br>
+=C2=A0 =C2=A0 keyvalue.u.qcode =3D qcode;<br>
=C2=A0 =C2=A0 =C2=A0number =3D qemu_input_key_value_to_number(&amp;keyvalue=
);<br>
=C2=A0 =C2=A0 =C2=A0assert(number !=3D 0);<br>
=C2=A0 =C2=A0 =C2=A0return number;<br>
diff --git a/replay/replay-input.c b/replay/replay-input.c<br>
index 1147e3d34e..c1eb1b79e1 100644<br>
--- a/replay/replay-input.c<br>
+++ b/replay/replay-input.c<br>
@@ -26,16 +26,16 @@ void replay_save_input_event(InputEvent *evt)<br>
<br>
=C2=A0 =C2=A0 =C2=A0switch (evt-&gt;type) {<br>
=C2=A0 =C2=A0 =C2=A0case INPUT_EVENT_KIND_KEY:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 key =3D evt-&gt;u.key.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 key =3D &amp;evt-&gt;u.key;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0replay_put_dword(key-&gt;key-&gt;type);<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (key-&gt;key-&gt;type) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case KEY_VALUE_KIND_NUMBER:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 replay_put_qword(key-&gt;key-&gt=
;u.number.data);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 replay_put_qword(key-&gt;key-&gt=
;u.number);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0replay_put_byte(key-&gt;dow=
n);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case KEY_VALUE_KIND_QCODE:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 replay_put_dword(key-&gt;key-&gt=
;u.qcode.data);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 replay_put_dword(key-&gt;key-&gt=
;u.qcode);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0replay_put_byte(key-&gt;dow=
n);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case KEY_VALUE_KIND__MAX:<br>
@@ -44,17 +44,17 @@ void replay_save_input_event(InputEvent *evt)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case INPUT_EVENT_KIND_BTN:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 btn =3D evt-&gt;u.btn.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 btn =3D &amp;evt-&gt;u.btn;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0replay_put_dword(btn-&gt;button);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0replay_put_byte(btn-&gt;down);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case INPUT_EVENT_KIND_REL:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 move =3D evt-&gt;u.rel.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 move =3D &amp;evt-&gt;u.rel;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0replay_put_dword(move-&gt;axis);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0replay_put_qword(move-&gt;value);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case INPUT_EVENT_KIND_ABS:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 move =3D evt-&gt;u.abs.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 move =3D &amp;evt-&gt;u.abs;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0replay_put_dword(move-&gt;axis);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0replay_put_qword(move-&gt;value);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
@@ -68,26 +68,21 @@ InputEvent *replay_read_input_event(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0InputEvent evt;<br>
=C2=A0 =C2=A0 =C2=A0KeyValue keyValue;<br>
-=C2=A0 =C2=A0 InputKeyEvent key;<br>
-=C2=A0 =C2=A0 key.key =3D &amp;keyValue;<br>
-=C2=A0 =C2=A0 InputBtnEvent btn;<br>
-=C2=A0 =C2=A0 InputMoveEvent rel;<br>
-=C2=A0 =C2=A0 InputMoveEvent abs;<br>
+=C2=A0 =C2=A0 evt.u.key.key =3D &amp;keyValue;<br>
<br>
=C2=A0 =C2=A0 =C2=A0evt.type =3D replay_get_dword();<br>
=C2=A0 =C2=A0 =C2=A0switch (evt.type) {<br>
=C2=A0 =C2=A0 =C2=A0case INPUT_EVENT_KIND_KEY:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 evt.u.key.data =3D &amp;key;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 evt.u.key.data-&gt;key-&gt;type =3D replay_get=
_dword();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 evt.u.key.key-&gt;type =3D replay_get_dword();=
<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (evt.u.key.data-&gt;key-&gt;type) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (evt.u.key.key-&gt;type) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case KEY_VALUE_KIND_NUMBER:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 evt.u.key.data-&gt;key-&gt;u.num=
ber.data =3D replay_get_qword();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 evt.u.key.data-&gt;down =3D repl=
ay_get_byte();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 evt.u.key.key-&gt;u.number =3D r=
eplay_get_qword();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 evt.u.key.down =3D replay_get_by=
te();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case KEY_VALUE_KIND_QCODE:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 evt.u.key.data-&gt;key-&gt;u.qco=
de.data =3D (QKeyCode)replay_get_dword();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 evt.u.key.data-&gt;down =3D repl=
ay_get_byte();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 evt.u.key.key-&gt;u.qcode =3D (Q=
KeyCode)replay_get_dword();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 evt.u.key.down =3D replay_get_by=
te();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case KEY_VALUE_KIND__MAX:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* keep gcc happy */<br>
@@ -95,19 +90,16 @@ InputEvent *replay_read_input_event(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case INPUT_EVENT_KIND_BTN:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 evt.u.btn.data =3D &amp;btn;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 evt.u.btn.data-&gt;button =3D (InputButton)rep=
lay_get_dword();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 evt.u.btn.data-&gt;down =3D replay_get_byte();=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 evt.u.btn.button =3D (InputButton)replay_get_d=
word();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 evt.u.btn.down =3D replay_get_byte();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case INPUT_EVENT_KIND_REL:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 evt.u.rel.data =3D &amp;rel;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 evt.u.rel.data-&gt;axis =3D (InputAxis)replay_=
get_dword();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 evt.u.rel.data-&gt;value =3D replay_get_qword(=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 evt.u.rel.axis =3D (InputAxis)replay_get_dword=
();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 evt.u.rel.value =3D replay_get_qword();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case INPUT_EVENT_KIND_ABS:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 evt.u.abs.data =3D &amp;abs;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 evt.u.abs.data-&gt;axis =3D (InputAxis)replay_=
get_dword();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 evt.u.abs.data-&gt;value =3D replay_get_qword(=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 evt.u.abs.axis =3D (InputAxis)replay_get_dword=
();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 evt.u.abs.value =3D replay_get_qword();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case INPUT_EVENT_KIND__MAX:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* keep gcc happy */<br>
diff --git a/tests/test-char.c b/tests/test-char.c<br>
index 9196e566e9..0e7a033a90 100644<br>
--- a/tests/test-char.c<br>
+++ b/tests/test-char.c<br>
@@ -1220,7 +1220,7 @@ static void char_file_fifo_test(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 .has_in =3D true,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 .out =3D out };<br>
=C2=A0 =C2=A0 =C2=A0ChardevBackend backend =3D { .type =3D CHARDEV_BACKEND_=
KIND_FILE,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.u.file.data =3D &amp;file };<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.u.file =3D file };<br>
=C2=A0 =C2=A0 =C2=A0FeHandler fe =3D { 0, };<br>
=C2=A0 =C2=A0 =C2=A0int fd, ret;<br>
<br>
@@ -1273,19 +1273,17 @@ static void char_file_test_internal(Chardev *ext_ch=
r, const char *filepath)<br>
=C2=A0 =C2=A0 =C2=A0char *out;<br>
=C2=A0 =C2=A0 =C2=A0Chardev *chr;<br>
=C2=A0 =C2=A0 =C2=A0char *contents =3D NULL;<br>
-=C2=A0 =C2=A0 ChardevFile file =3D {};<br>
-=C2=A0 =C2=A0 ChardevBackend backend =3D { .type =3D CHARDEV_BACKEND_KIND_=
FILE,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.u.file.data =3D &amp;file };<br>
+=C2=A0 =C2=A0 ChardevBackend backend =3D { .type =3D CHARDEV_BACKEND_KIND_=
FILE };<br>
=C2=A0 =C2=A0 =C2=A0gsize length;<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (ext_chr) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0chr =3D ext_chr;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0out =3D g_strdup(filepath);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 file.out =3D out;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 backend.u.file.out =3D out;<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0out =3D g_build_filename(tmp_path, &quot;=
out&quot;, NULL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 file.out =3D out;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 backend.u.file.out =3D out;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0chr =3D qemu_chardev_new(NULL, TYPE_CHARD=
EV_FILE, &amp;backend,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, &amp;error_abort);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -1384,7 +1382,7 @@ static void char_hotswap_test(void)<br>
=C2=A0 =C2=A0 =C2=A0char *filename =3D g_build_filename(tmp_path, &quot;fil=
e&quot;, NULL);<br>
=C2=A0 =C2=A0 =C2=A0ChardevFile file =3D { .out =3D filename };<br>
=C2=A0 =C2=A0 =C2=A0ChardevBackend backend =3D { .type =3D CHARDEV_BACKEND_=
KIND_FILE,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.u.file.data =3D &amp;file };<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.u.file =3D file };<br>
=C2=A0 =C2=A0 =C2=A0ChardevReturn *ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0int port;<br>
diff --git a/tests/test-clone-visitor.c b/tests/test-clone-visitor.c<br>
index 5e1e8b2f5e..0a62704bed 100644<br>
--- a/tests/test-clone-visitor.c<br>
+++ b/tests/test-clone-visitor.c<br>
@@ -110,7 +110,7 @@ static void test_clone_complex1(void)<br>
=C2=A0 =C2=A0 =C2=A0dst =3D QAPI_CLONE(UserDefListUnion, src);<br>
=C2=A0 =C2=A0 =C2=A0g_assert(dst);<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(dst-&gt;type, =3D=3D, src-&gt;type);<br=
>
-=C2=A0 =C2=A0 g_assert(!dst-&gt;u.string.data);<br>
+=C2=A0 =C2=A0 g_assert(!dst-&gt;u.string);<br>
<br>
=C2=A0 =C2=A0 =C2=A0qapi_free_UserDefListUnion(src);<br>
=C2=A0 =C2=A0 =C2=A0qapi_free_UserDefListUnion(dst);<br>
@@ -155,30 +155,30 @@ static void test_clone_complex3(void)<br>
=C2=A0 =C2=A0 =C2=A0tmp =3D src-&gt;array =3D g_new0(__org_qemu_x_Union1Lis=
t, 1);<br>
=C2=A0 =C2=A0 =C2=A0tmp-&gt;value =3D g_new0(__org_qemu_x_Union1, 1);<br>
=C2=A0 =C2=A0 =C2=A0tmp-&gt;value-&gt;type =3D ORG_QEMU_X_UNION1_KIND___ORG=
_QEMU_X_BRANCH;<br>
-=C2=A0 =C2=A0 tmp-&gt;value-&gt;u.__org_qemu_x_branch.data =3D g_strdup(&q=
uot;one&quot;);<br>
+=C2=A0 =C2=A0 tmp-&gt;value-&gt;u.__org_qemu_x_branch =3D g_strdup(&quot;o=
ne&quot;);<br>
=C2=A0 =C2=A0 =C2=A0tmp =3D tmp-&gt;next =3D g_new0(__org_qemu_x_Union1List=
, 1);<br>
=C2=A0 =C2=A0 =C2=A0tmp-&gt;value =3D g_new0(__org_qemu_x_Union1, 1);<br>
=C2=A0 =C2=A0 =C2=A0tmp-&gt;value-&gt;type =3D ORG_QEMU_X_UNION1_KIND___ORG=
_QEMU_X_BRANCH;<br>
-=C2=A0 =C2=A0 tmp-&gt;value-&gt;u.__org_qemu_x_branch.data =3D g_strdup(&q=
uot;two&quot;);<br>
+=C2=A0 =C2=A0 tmp-&gt;value-&gt;u.__org_qemu_x_branch =3D g_strdup(&quot;t=
wo&quot;);<br>
=C2=A0 =C2=A0 =C2=A0tmp =3D tmp-&gt;next =3D g_new0(__org_qemu_x_Union1List=
, 1);<br>
=C2=A0 =C2=A0 =C2=A0tmp-&gt;value =3D g_new0(__org_qemu_x_Union1, 1);<br>
=C2=A0 =C2=A0 =C2=A0tmp-&gt;value-&gt;type =3D ORG_QEMU_X_UNION1_KIND___ORG=
_QEMU_X_BRANCH;<br>
-=C2=A0 =C2=A0 tmp-&gt;value-&gt;u.__org_qemu_x_branch.data =3D g_strdup(&q=
uot;three&quot;);<br>
+=C2=A0 =C2=A0 tmp-&gt;value-&gt;u.__org_qemu_x_branch =3D g_strdup(&quot;t=
hree&quot;);<br>
<br>
=C2=A0 =C2=A0 =C2=A0dst =3D QAPI_CLONE(__org_qemu_x_Struct2, src);<br>
=C2=A0 =C2=A0 =C2=A0g_assert(dst);<br>
=C2=A0 =C2=A0 =C2=A0tmp =3D dst-&gt;array;<br>
=C2=A0 =C2=A0 =C2=A0g_assert(tmp);<br>
=C2=A0 =C2=A0 =C2=A0g_assert(tmp-&gt;value);<br>
-=C2=A0 =C2=A0 g_assert_cmpstr(tmp-&gt;value-&gt;u.__org_qemu_x_branch.data=
, =3D=3D, &quot;one&quot;);<br>
+=C2=A0 =C2=A0 g_assert_cmpstr(tmp-&gt;value-&gt;u.__org_qemu_x_branch, =3D=
=3D, &quot;one&quot;);<br>
=C2=A0 =C2=A0 =C2=A0tmp =3D tmp-&gt;next;<br>
=C2=A0 =C2=A0 =C2=A0g_assert(tmp);<br>
=C2=A0 =C2=A0 =C2=A0g_assert(tmp-&gt;value);<br>
-=C2=A0 =C2=A0 g_assert_cmpstr(tmp-&gt;value-&gt;u.__org_qemu_x_branch.data=
, =3D=3D, &quot;two&quot;);<br>
+=C2=A0 =C2=A0 g_assert_cmpstr(tmp-&gt;value-&gt;u.__org_qemu_x_branch, =3D=
=3D, &quot;two&quot;);<br>
=C2=A0 =C2=A0 =C2=A0tmp =3D tmp-&gt;next;<br>
=C2=A0 =C2=A0 =C2=A0g_assert(tmp);<br>
=C2=A0 =C2=A0 =C2=A0g_assert(tmp-&gt;value);<br>
-=C2=A0 =C2=A0 g_assert_cmpstr(tmp-&gt;value-&gt;u.__org_qemu_x_branch.data=
, =3D=3D, &quot;three&quot;);<br>
+=C2=A0 =C2=A0 g_assert_cmpstr(tmp-&gt;value-&gt;u.__org_qemu_x_branch, =3D=
=3D, &quot;three&quot;);<br>
=C2=A0 =C2=A0 =C2=A0tmp =3D tmp-&gt;next;<br>
=C2=A0 =C2=A0 =C2=A0g_assert(!tmp);<br>
<br>
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c<br>
index d3413bfef0..3d699fbb66 100644<br>
--- a/tests/test-qmp-cmds.c<br>
+++ b/tests/test-qmp-cmds.c<br>
@@ -136,7 +136,7 @@ __org_qemu_x_Union1 *qmp___org_qemu_x_command(__org_qem=
u_x_EnumList *a,<br>
=C2=A0 =C2=A0 =C2=A0__org_qemu_x_Union1 *ret =3D g_new0(__org_qemu_x_Union1=
, 1);<br>
<br>
=C2=A0 =C2=A0 =C2=A0ret-&gt;type =3D ORG_QEMU_X_UNION1_KIND___ORG_QEMU_X_BR=
ANCH;<br>
-=C2=A0 =C2=A0 ret-&gt;u.__org_qemu_x_branch.data =3D strdup(&quot;blah1&qu=
ot;);<br>
+=C2=A0 =C2=A0 ret-&gt;u.__org_qemu_x_branch =3D strdup(&quot;blah1&quot;);=
<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Also test that &#39;wchar-t&#39; was munged to &#39;=
q_wchar_t&#39; */<br>
=C2=A0 =C2=A0 =C2=A0if (b &amp;&amp; b-&gt;value &amp;&amp; !b-&gt;value-&g=
t;has_q_wchar_t) {<br>
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-input-=
visitor.c<br>
index e41b91a2a6..b976ab9763 100644<br>
--- a/tests/test-qobject-input-visitor.c<br>
+++ b/tests/test-qobject-input-visitor.c<br>
@@ -710,7 +710,7 @@ static void test_list_union_integer_helper(TestInputVis=
itorData *data,<br>
=C2=A0 =C2=A0 =C2=A0switch (kind) {<br>
=C2=A0 =C2=A0 =C2=A0case USER_DEF_LIST_UNION_KIND_INTEGER: {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0intList *elem =3D NULL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0, elem =3D cvalue-&gt;u.integer.da=
ta;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0, elem =3D cvalue-&gt;u.integer;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elem; elem =3D elem-&gt;ne=
xt, i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_assert_cmpint(elem-&gt;va=
lue, =3D=3D, i);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -718,56 +718,56 @@ static void test_list_union_integer_helper(TestInputV=
isitorData *data,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0case USER_DEF_LIST_UNION_KIND_S8: {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int8List *elem =3D NULL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0, elem =3D cvalue-&gt;u.s8.data; e=
lem; elem =3D elem-&gt;next, i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0, elem =3D cvalue-&gt;u.s8; elem; =
elem =3D elem-&gt;next, i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_assert_cmpint(elem-&gt;va=
lue, =3D=3D, i);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0case USER_DEF_LIST_UNION_KIND_S16: {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int16List *elem =3D NULL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0, elem =3D cvalue-&gt;u.s16.data; =
elem; elem =3D elem-&gt;next, i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0, elem =3D cvalue-&gt;u.s16; elem;=
 elem =3D elem-&gt;next, i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_assert_cmpint(elem-&gt;va=
lue, =3D=3D, i);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0case USER_DEF_LIST_UNION_KIND_S32: {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int32List *elem =3D NULL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0, elem =3D cvalue-&gt;u.s32.data; =
elem; elem =3D elem-&gt;next, i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0, elem =3D cvalue-&gt;u.s32; elem;=
 elem =3D elem-&gt;next, i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_assert_cmpint(elem-&gt;va=
lue, =3D=3D, i);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0case USER_DEF_LIST_UNION_KIND_S64: {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int64List *elem =3D NULL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0, elem =3D cvalue-&gt;u.s64.data; =
elem; elem =3D elem-&gt;next, i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0, elem =3D cvalue-&gt;u.s64; elem;=
 elem =3D elem-&gt;next, i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_assert_cmpint(elem-&gt;va=
lue, =3D=3D, i);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0case USER_DEF_LIST_UNION_KIND_U8: {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8List *elem =3D NULL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0, elem =3D cvalue-&gt;u.u8.data; e=
lem; elem =3D elem-&gt;next, i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0, elem =3D cvalue-&gt;u.u8; elem; =
elem =3D elem-&gt;next, i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_assert_cmpint(elem-&gt;va=
lue, =3D=3D, i);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0case USER_DEF_LIST_UNION_KIND_U16: {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16List *elem =3D NULL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0, elem =3D cvalue-&gt;u.u16.data; =
elem; elem =3D elem-&gt;next, i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0, elem =3D cvalue-&gt;u.u16; elem;=
 elem =3D elem-&gt;next, i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_assert_cmpint(elem-&gt;va=
lue, =3D=3D, i);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0case USER_DEF_LIST_UNION_KIND_U32: {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32List *elem =3D NULL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0, elem =3D cvalue-&gt;u.u32.data; =
elem; elem =3D elem-&gt;next, i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0, elem =3D cvalue-&gt;u.u32; elem;=
 elem =3D elem-&gt;next, i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_assert_cmpint(elem-&gt;va=
lue, =3D=3D, i);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0case USER_DEF_LIST_UNION_KIND_U64: {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64List *elem =3D NULL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0, elem =3D cvalue-&gt;u.u64.data; =
elem; elem =3D elem-&gt;next, i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0, elem =3D cvalue-&gt;u.u64; elem;=
 elem =3D elem-&gt;next, i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_assert_cmpint(elem-&gt;va=
lue, =3D=3D, i);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
@@ -868,7 +868,7 @@ static void test_visitor_in_list_union_bool(TestInputVi=
sitorData *data,<br>
=C2=A0 =C2=A0 =C2=A0g_assert(cvalue !=3D NULL);<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(cvalue-&gt;type, =3D=3D, USER_DEF_LIST_=
UNION_KIND_BOOLEAN);<br>
<br>
-=C2=A0 =C2=A0 for (i =3D 0, elem =3D cvalue-&gt;u.boolean.data; elem; elem=
 =3D elem-&gt;next, i++) {<br>
+=C2=A0 =C2=A0 for (i =3D 0, elem =3D cvalue-&gt;u.boolean; elem; elem =3D =
elem-&gt;next, i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_assert_cmpint(elem-&gt;value, =3D=3D, (=
i % 3 =3D=3D 0) ? 1 : 0);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -900,7 +900,7 @@ static void test_visitor_in_list_union_string(TestInput=
VisitorData *data,<br>
=C2=A0 =C2=A0 =C2=A0g_assert(cvalue !=3D NULL);<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(cvalue-&gt;type, =3D=3D, USER_DEF_LIST_=
UNION_KIND_STRING);<br>
<br>
-=C2=A0 =C2=A0 for (i =3D 0, elem =3D cvalue-&gt;u.string.data; elem; elem =
=3D elem-&gt;next, i++) {<br>
+=C2=A0 =C2=A0 for (i =3D 0, elem =3D cvalue-&gt;u.string; elem; elem =3D e=
lem-&gt;next, i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gchar str[8];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sprintf(str, &quot;%d&quot;, i);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_assert_cmpstr(elem-&gt;value, =3D=3D, s=
tr);<br>
@@ -936,7 +936,7 @@ static void test_visitor_in_list_union_number(TestInput=
VisitorData *data,<br>
=C2=A0 =C2=A0 =C2=A0g_assert(cvalue !=3D NULL);<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(cvalue-&gt;type, =3D=3D, USER_DEF_LIST_=
UNION_KIND_NUMBER);<br>
<br>
-=C2=A0 =C2=A0 for (i =3D 0, elem =3D cvalue-&gt;u.number.data; elem; elem =
=3D elem-&gt;next, i++) {<br>
+=C2=A0 =C2=A0 for (i =3D 0, elem =3D cvalue-&gt;u.number; elem; elem =3D e=
lem-&gt;next, i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GString *double_expected =3D g_string_new=
(&quot;&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GString *double_actual =3D g_string_new(&=
quot;&quot;);<br>
<br>
diff --git a/tests/test-qobject-output-visitor.c b/tests/test-qobject-outpu=
t-visitor.c<br>
index 1c856d9bd2..202f848062 100644<br>
--- a/tests/test-qobject-output-visitor.c<br>
+++ b/tests/test-qobject-output-visitor.c<br>
@@ -444,7 +444,7 @@ static void init_list_union(UserDefListUnion *cvalue)<b=
r>
=C2=A0 =C2=A0 =C2=A0int i;<br>
=C2=A0 =C2=A0 =C2=A0switch (cvalue-&gt;type) {<br>
=C2=A0 =C2=A0 =C2=A0case USER_DEF_LIST_UNION_KIND_INTEGER: {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 intList **list =3D &amp;cvalue-&gt;u.integer.d=
ata;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 intList **list =3D &amp;cvalue-&gt;u.integer;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 32; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*list =3D g_new0(intList, 1=
);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(*list)-&gt;value =3D i;<br=
>
@@ -454,7 +454,7 @@ static void init_list_union(UserDefListUnion *cvalue)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0case USER_DEF_LIST_UNION_KIND_S8: {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 int8List **list =3D &amp;cvalue-&gt;u.s8.data;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int8List **list =3D &amp;cvalue-&gt;u.s8;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 32; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*list =3D g_new0(int8List, =
1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(*list)-&gt;value =3D i;<br=
>
@@ -464,7 +464,7 @@ static void init_list_union(UserDefListUnion *cvalue)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0case USER_DEF_LIST_UNION_KIND_S16: {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 int16List **list =3D &amp;cvalue-&gt;u.s16.dat=
a;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int16List **list =3D &amp;cvalue-&gt;u.s16;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 32; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*list =3D g_new0(int16List,=
 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(*list)-&gt;value =3D i;<br=
>
@@ -474,7 +474,7 @@ static void init_list_union(UserDefListUnion *cvalue)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0case USER_DEF_LIST_UNION_KIND_S32: {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 int32List **list =3D &amp;cvalue-&gt;u.s32.dat=
a;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int32List **list =3D &amp;cvalue-&gt;u.s32;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 32; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*list =3D g_new0(int32List,=
 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(*list)-&gt;value =3D i;<br=
>
@@ -484,7 +484,7 @@ static void init_list_union(UserDefListUnion *cvalue)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0case USER_DEF_LIST_UNION_KIND_S64: {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 int64List **list =3D &amp;cvalue-&gt;u.s64.dat=
a;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int64List **list =3D &amp;cvalue-&gt;u.s64;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 32; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*list =3D g_new0(int64List,=
 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(*list)-&gt;value =3D i;<br=
>
@@ -494,7 +494,7 @@ static void init_list_union(UserDefListUnion *cvalue)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0case USER_DEF_LIST_UNION_KIND_U8: {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8List **list =3D &amp;cvalue-&gt;u.u8.data=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8List **list =3D &amp;cvalue-&gt;u.u8;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 32; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*list =3D g_new0(uint8List,=
 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(*list)-&gt;value =3D i;<br=
>
@@ -504,7 +504,7 @@ static void init_list_union(UserDefListUnion *cvalue)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0case USER_DEF_LIST_UNION_KIND_U16: {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16List **list =3D &amp;cvalue-&gt;u.u16.da=
ta;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16List **list =3D &amp;cvalue-&gt;u.u16;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 32; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*list =3D g_new0(uint16List=
, 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(*list)-&gt;value =3D i;<br=
>
@@ -514,7 +514,7 @@ static void init_list_union(UserDefListUnion *cvalue)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0case USER_DEF_LIST_UNION_KIND_U32: {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32List **list =3D &amp;cvalue-&gt;u.u32.da=
ta;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32List **list =3D &amp;cvalue-&gt;u.u32;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 32; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*list =3D g_new0(uint32List=
, 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(*list)-&gt;value =3D i;<br=
>
@@ -524,7 +524,7 @@ static void init_list_union(UserDefListUnion *cvalue)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0case USER_DEF_LIST_UNION_KIND_U64: {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64List **list =3D &amp;cvalue-&gt;u.u64.da=
ta;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64List **list =3D &amp;cvalue-&gt;u.u64;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 32; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*list =3D g_new0(uint64List=
, 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(*list)-&gt;value =3D i;<br=
>
@@ -534,7 +534,7 @@ static void init_list_union(UserDefListUnion *cvalue)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0case USER_DEF_LIST_UNION_KIND_BOOLEAN: {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 boolList **list =3D &amp;cvalue-&gt;u.boolean.=
data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 boolList **list =3D &amp;cvalue-&gt;u.boolean;=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 32; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*list =3D g_new0(boolList, =
1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(*list)-&gt;value =3D QEMU_=
IS_ALIGNED(i, 3);<br>
@@ -544,7 +544,7 @@ static void init_list_union(UserDefListUnion *cvalue)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0case USER_DEF_LIST_UNION_KIND_STRING: {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 strList **list =3D &amp;cvalue-&gt;u.string.da=
ta;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 strList **list =3D &amp;cvalue-&gt;u.string;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 32; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*list =3D g_new0(strList, 1=
);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(*list)-&gt;value =3D g_str=
dup_printf(&quot;%d&quot;, i);<br>
@@ -554,7 +554,7 @@ static void init_list_union(UserDefListUnion *cvalue)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0case USER_DEF_LIST_UNION_KIND_NUMBER: {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 numberList **list =3D &amp;cvalue-&gt;u.number=
.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 numberList **list =3D &amp;cvalue-&gt;u.number=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 32; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*list =3D g_new0(numberList=
, 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(*list)-&gt;value =3D (doub=
le)i / 3;<br>
diff --git a/ui/console.c b/ui/console.c<br>
index 820e408170..2f93723ed6 100644<br>
--- a/ui/console.c<br>
+++ b/ui/console.c<br>
@@ -2212,7 +2212,7 @@ static void vc_chr_open(Chardev *chr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0bool *be_opened,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Error **errp)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 ChardevVC *vc =3D backend-&gt;u.vc.data;<br>
+=C2=A0 =C2=A0 ChardevVC *vc =3D &amp;backend-&gt;<a href=3D"http://u.vc" r=
el=3D"noreferrer" target=3D"_blank">u.vc</a>;<br>
=C2=A0 =C2=A0 =C2=A0VCChardev *drv =3D VC_CHARDEV(chr);<br>
=C2=A0 =C2=A0 =C2=A0QemuConsole *s;<br>
=C2=A0 =C2=A0 =C2=A0unsigned width =3D 0;<br>
@@ -2362,10 +2362,9 @@ void qemu_display_help(void)<br>
=C2=A0void qemu_chr_parse_vc(QemuOpts *opts, ChardevBackend *backend, Error=
 **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int val;<br>
-=C2=A0 =C2=A0 ChardevVC *vc;<br>
+=C2=A0 =C2=A0 ChardevVC *vc =3D &amp;backend-&gt;<a href=3D"http://u.vc" r=
el=3D"noreferrer" target=3D"_blank">u.vc</a>;<br>
<br>
=C2=A0 =C2=A0 =C2=A0backend-&gt;type =3D CHARDEV_BACKEND_KIND_VC;<br>
-=C2=A0 =C2=A0 vc =3D backend-&gt;u.vc.data =3D g_new0(ChardevVC, 1);<br>
=C2=A0 =C2=A0 =C2=A0qemu_chr_parse_common(opts, qapi_ChardevVC_base(vc));<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0val =3D qemu_opt_get_number(opts, &quot;width&quot;, 0)=
;<br>
diff --git a/ui/input-keymap.c b/ui/input-keymap.c<br>
index 1b756a6970..0232e25124 100644<br>
--- a/ui/input-keymap.c<br>
+++ b/ui/input-keymap.c<br>
@@ -33,13 +33,13 @@ int qemu_input_linux_to_qcode(unsigned int lnx)<br>
=C2=A0int qemu_input_key_value_to_number(const KeyValue *value)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0if (value-&gt;type =3D=3D KEY_VALUE_KIND_QCODE) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (value-&gt;u.qcode.data &gt;=3D qemu_input_=
map_qcode_to_qnum_len) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (value-&gt;u.qcode &gt;=3D qemu_input_map_q=
code_to_qnum_len) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return qemu_input_map_qcode_to_qnum[value-&gt;=
u.qcode.data];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return qemu_input_map_qcode_to_qnum[value-&gt;=
u.qcode];<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert(value-&gt;type =3D=3D KEY_VALUE_KI=
ND_NUMBER);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return value-&gt;u.number.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return value-&gt;u.number;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
@@ -54,10 +54,10 @@ int qemu_input_key_number_to_qcode(unsigned int nr)<br>
=C2=A0int qemu_input_key_value_to_qcode(const KeyValue *value)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0if (value-&gt;type =3D=3D KEY_VALUE_KIND_QCODE) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return value-&gt;u.qcode.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return value-&gt;u.qcode;<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert(value-&gt;type =3D=3D KEY_VALUE_KI=
ND_NUMBER);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return qemu_input_key_number_to_qcode(value-&g=
t;u.number.data);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return qemu_input_key_number_to_qcode(value-&g=
t;u.number);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
@@ -68,7 +68,7 @@ int qemu_input_key_value_to_scancode(const KeyValue *valu=
e, bool down,<br>
=C2=A0 =C2=A0 =C2=A0int count =3D 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (value-&gt;type =3D=3D KEY_VALUE_KIND_QCODE &amp;&am=
p;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 value-&gt;u.qcode.data =3D=3D Q_KEY_CODE_PAUSE=
) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 value-&gt;u.qcode =3D=3D Q_KEY_CODE_PAUSE) {<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* specific case */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int v =3D down ? 0 : 0x80;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0codes[count++] =3D 0xe1;<br>
diff --git a/ui/input-legacy.c b/ui/input-legacy.c<br>
index 9fc78a639b..5a32b010d4 100644<br>
--- a/ui/input-legacy.c<br>
+++ b/ui/input-legacy.c<br>
@@ -75,9 +75,9 @@ static KeyValue *copy_key_value(KeyValue *src)<br>
=C2=A0 =C2=A0 =C2=A0KeyValue *dst =3D g_new(KeyValue, 1);<br>
=C2=A0 =C2=A0 =C2=A0memcpy(dst, src, sizeof(*src));<br>
=C2=A0 =C2=A0 =C2=A0if (dst-&gt;type =3D=3D KEY_VALUE_KIND_NUMBER) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 QKeyCode code =3D qemu_input_key_number_to_qco=
de(dst-&gt;u.number.data);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 QKeyCode code =3D qemu_input_key_number_to_qco=
de(dst-&gt;u.number);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dst-&gt;type =3D KEY_VALUE_KIND_QCODE;<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 dst-&gt;u.qcode.data =3D code;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dst-&gt;u.qcode =3D code;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0return dst;<br>
=C2=A0}<br>
@@ -113,7 +113,7 @@ static void legacy_kbd_event(DeviceState *dev, QemuCons=
ole *src,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0QEMUPutKbdEntry *entry =3D (QEMUPutKbdEntry *)dev;<br>
=C2=A0 =C2=A0 =C2=A0int scancodes[3], i, count;<br>
-=C2=A0 =C2=A0 InputKeyEvent *key =3D evt-&gt;u.key.data;<br>
+=C2=A0 =C2=A0 InputKeyEvent *key =3D &amp;evt-&gt;u.key;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!entry || !entry-&gt;put_kbd) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
@@ -159,7 +159,7 @@ static void legacy_mouse_event(DeviceState *dev, QemuCo=
nsole *src,<br>
<br>
=C2=A0 =C2=A0 =C2=A0switch (evt-&gt;type) {<br>
=C2=A0 =C2=A0 =C2=A0case INPUT_EVENT_KIND_BTN:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 btn =3D evt-&gt;u.btn.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 btn =3D &amp;evt-&gt;u.btn;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (btn-&gt;down) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;buttons |=3D bmap[btn=
-&gt;button];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
@@ -181,11 +181,11 @@ static void legacy_mouse_event(DeviceState *dev, Qemu=
Console *src,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case INPUT_EVENT_KIND_ABS:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 move =3D evt-&gt;u.abs.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 move =3D &amp;evt-&gt;u.abs;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;axis[move-&gt;axis] =3D move-&gt;va=
lue;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case INPUT_EVENT_KIND_REL:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 move =3D evt-&gt;u.rel.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 move =3D &amp;evt-&gt;u.rel;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;axis[move-&gt;axis] +=3D move-&gt;v=
alue;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
diff --git a/ui/input.c b/ui/input.c<br>
index 4791b089c7..a4078780ee 100644<br>
--- a/ui/input.c<br>
+++ b/ui/input.c<br>
@@ -164,10 +164,10 @@ void qmp_input_send_event(bool has_device, const char=
 *device,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0InputEvent *evt =3D e-&gt;value;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (evt-&gt;type =3D=3D INPUT_EVENT_KIND_=
KEY &amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 evt-&gt;u.key.data-&gt;key-&gt;t=
ype =3D=3D KEY_VALUE_KIND_NUMBER) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 KeyValue *key =3D evt-&gt;u.key.=
data-&gt;key;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QKeyCode code =3D qemu_input_key=
_number_to_qcode(key-&gt;u.number.data);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_input_event_send_key_qcode(=
con, code, evt-&gt;u.key.data-&gt;down);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 evt-&gt;u.key.key-&gt;type =3D=
=3D KEY_VALUE_KIND_NUMBER) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 KeyValue *key =3D evt-&gt;u.key.=
key;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QKeyCode code =3D qemu_input_key=
_number_to_qcode(key-&gt;u.number);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_input_event_send_key_qcode(=
con, code, evt-&gt;u.key.down);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_input_event_send(con, =
evt);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -183,7 +183,7 @@ static int qemu_input_transform_invert_abs_value(int va=
lue)<br>
<br>
=C2=A0static void qemu_input_transform_abs_rotate(InputEvent *evt)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 InputMoveEvent *move =3D evt-&gt;u.abs.data;<br>
+=C2=A0 =C2=A0 InputMoveEvent *move =3D &amp;evt-&gt;u.abs;<br>
=C2=A0 =C2=A0 =C2=A0switch (graphic_rotate) {<br>
=C2=A0 =C2=A0 =C2=A0case 90:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (move-&gt;axis =3D=3D INPUT_AXIS_X) {<=
br>
@@ -220,16 +220,16 @@ static void qemu_input_event_trace(QemuConsole *src, =
InputEvent *evt)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0switch (evt-&gt;type) {<br>
=C2=A0 =C2=A0 =C2=A0case INPUT_EVENT_KIND_KEY:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 key =3D evt-&gt;u.key.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 key =3D &amp;evt-&gt;u.key;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (key-&gt;key-&gt;type) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case KEY_VALUE_KIND_NUMBER:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qcode =3D qemu_input_key_number_=
to_qcode(key-&gt;key-&gt;u.number.data);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qcode =3D qemu_input_key_number_=
to_qcode(key-&gt;key-&gt;u.number);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name =3D QKeyCode_str(qcode=
);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_input_event_key_number(idx=
, key-&gt;key-&gt;u.number.data,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_input_event_key_number(idx=
, key-&gt;key-&gt;u.number,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n=
ame, key-&gt;down);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case KEY_VALUE_KIND_QCODE:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name =3D QKeyCode_str(key-&gt;ke=
y-&gt;u.qcode.data);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name =3D QKeyCode_str(key-&gt;ke=
y-&gt;u.qcode);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_input_event_key_qcode=
(idx, name, key-&gt;down);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case KEY_VALUE_KIND__MAX:<br>
@@ -238,17 +238,17 @@ static void qemu_input_event_trace(QemuConsole *src, =
InputEvent *evt)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case INPUT_EVENT_KIND_BTN:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 btn =3D evt-&gt;u.btn.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 btn =3D &amp;evt-&gt;u.btn;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name =3D InputButton_str(btn-&gt;button);=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_input_event_btn(idx, name, btn-&gt;=
down);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case INPUT_EVENT_KIND_REL:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 move =3D evt-&gt;u.rel.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 move =3D &amp;evt-&gt;u.rel;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name =3D InputAxis_str(move-&gt;axis);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_input_event_rel(idx, name, move-&gt=
;value);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case INPUT_EVENT_KIND_ABS:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 move =3D evt-&gt;u.abs.data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 move =3D &amp;evt-&gt;u.abs;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name =3D InputAxis_str(move-&gt;axis);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_input_event_abs(idx, name, move-&gt=
;value);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
@@ -355,7 +355,7 @@ void qemu_input_event_send(QemuConsole *src, InputEvent=
 *evt)<br>
=C2=A0 =C2=A0 =C2=A0/* Expect all parts of QEMU to send events with QCodes =
exclusively.<br>
=C2=A0 =C2=A0 =C2=A0 * Key numbers are only supported as end-user input via=
 QMP */<br>
=C2=A0 =C2=A0 =C2=A0assert(!(evt-&gt;type =3D=3D INPUT_EVENT_KIND_KEY &amp;=
&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0evt-&gt;u.key.data-&gt;key=
-&gt;type =3D=3D KEY_VALUE_KIND_NUMBER));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0evt-&gt;u.key.key-&gt;type=
 =3D=3D KEY_VALUE_KIND_NUMBER));<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
@@ -367,8 +367,8 @@ void qemu_input_event_send(QemuConsole *src, InputEvent=
 *evt)<br>
=C2=A0 =C2=A0 =C2=A0 * neeed to deal with this mistake<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0if (evt-&gt;type =3D=3D INPUT_EVENT_KIND_KEY &amp;&amp;=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 evt-&gt;u.key.data-&gt;key-&gt;u.qcode.data =
=3D=3D Q_KEY_CODE_SYSRQ) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 evt-&gt;u.key.data-&gt;key-&gt;u.qcode.data =
=3D Q_KEY_CODE_PRINT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 evt-&gt;u.key.key-&gt;u.qcode =3D=3D Q_KEY_COD=
E_SYSRQ) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 evt-&gt;u.key.key-&gt;u.qcode =3D Q_KEY_CODE_P=
RINT;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!runstate_is_running() &amp;&amp; !runstate_check(R=
UN_STATE_SUSPENDED)) {<br>
@@ -407,10 +407,9 @@ void qemu_input_event_sync(void)<br>
=C2=A0static InputEvent *qemu_input_event_new_key(KeyValue *key, bool down)=
<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0InputEvent *evt =3D g_new0(InputEvent, 1);<br>
-=C2=A0 =C2=A0 evt-&gt;u.key.data =3D g_new0(InputKeyEvent, 1);<br>
=C2=A0 =C2=A0 =C2=A0evt-&gt;type =3D INPUT_EVENT_KIND_KEY;<br>
-=C2=A0 =C2=A0 evt-&gt;u.key.data-&gt;key =3D key;<br>
-=C2=A0 =C2=A0 evt-&gt;u.key.data-&gt;down =3D down;<br>
+=C2=A0 =C2=A0 evt-&gt;u.key.key =3D key;<br>
+=C2=A0 =C2=A0 evt-&gt;u.key.down =3D down;<br>
=C2=A0 =C2=A0 =C2=A0return evt;<br>
=C2=A0}<br>
<br>
@@ -440,7 +439,7 @@ void qemu_input_event_send_key_qcode(QemuConsole *src, =
QKeyCode q, bool down)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0KeyValue *key =3D g_new0(KeyValue, 1);<br>
=C2=A0 =C2=A0 =C2=A0key-&gt;type =3D KEY_VALUE_KIND_QCODE;<br>
-=C2=A0 =C2=A0 key-&gt;u.qcode.data =3D q;<br>
+=C2=A0 =C2=A0 key-&gt;u.qcode =3D q;<br>
=C2=A0 =C2=A0 =C2=A0qemu_input_event_send_key(src, key, down);<br>
=C2=A0}<br>
<br>
@@ -469,7 +468,7 @@ void qemu_input_queue_btn(QemuConsole *src, InputButton=
 btn, bool down)<br>
=C2=A0 =C2=A0 =C2=A0};<br>
=C2=A0 =C2=A0 =C2=A0InputEvent evt =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type =3D INPUT_EVENT_KIND_BTN,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .u.btn.data =3D &amp;bevt,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .u.btn =3D bevt,<br>
=C2=A0 =C2=A0 =C2=A0};<br>
<br>
=C2=A0 =C2=A0 =C2=A0qemu_input_event_send(src, &amp;evt);<br>
@@ -520,7 +519,7 @@ void qemu_input_queue_rel(QemuConsole *src, InputAxis a=
xis, int value)<br>
=C2=A0 =C2=A0 =C2=A0};<br>
=C2=A0 =C2=A0 =C2=A0InputEvent evt =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type =3D INPUT_EVENT_KIND_REL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .u.rel.data =3D &amp;move,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .u.rel =3D move,<br>
=C2=A0 =C2=A0 =C2=A0};<br>
<br>
=C2=A0 =C2=A0 =C2=A0qemu_input_event_send(src, &amp;evt);<br>
@@ -537,7 +536,7 @@ void qemu_input_queue_abs(QemuConsole *src, InputAxis a=
xis, int value,<br>
=C2=A0 =C2=A0 =C2=A0};<br>
=C2=A0 =C2=A0 =C2=A0InputEvent evt =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.type =3D INPUT_EVENT_KIND_ABS,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .u.abs.data =3D &amp;move,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .u.abs =3D move,<br>
=C2=A0 =C2=A0 =C2=A0};<br>
<br>
=C2=A0 =C2=A0 =C2=A0qemu_input_event_send(src, &amp;evt);<br>
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c<br>
index 05e5c73f9d..59e317cbb8 100644<br>
--- a/util/qemu-sockets.c<br>
+++ b/util/qemu-sockets.c<br>
@@ -1365,21 +1365,21 @@ SocketAddress *socket_address_flatten(SocketAddress=
Legacy *addr_legacy)<br>
=C2=A0 =C2=A0 =C2=A0case SOCKET_ADDRESS_LEGACY_KIND_INET:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr-&gt;type =3D SOCKET_ADDRESS_TYPE_INE=
T;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QAPI_CLONE_MEMBERS(InetSocketAddress, &am=
p;addr-&gt;u.inet,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0addr_legacy-&gt;u.inet.data);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&amp;addr_legacy-&gt;u.inet);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case SOCKET_ADDRESS_LEGACY_KIND_UNIX:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr-&gt;type =3D SOCKET_ADDRESS_TYPE_UNI=
X;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QAPI_CLONE_MEMBERS(UnixSocketAddress, &am=
p;addr-&gt;u.q_unix,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0addr_legacy-&gt;u.q_unix.data);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&amp;addr_legacy-&gt;u.q_unix);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case SOCKET_ADDRESS_LEGACY_KIND_VSOCK:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr-&gt;type =3D SOCKET_ADDRESS_TYPE_VSO=
CK;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QAPI_CLONE_MEMBERS(VsockSocketAddress, &a=
mp;addr-&gt;u.vsock,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0addr_legacy-&gt;u.vsock.data);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&amp;addr_legacy-&gt;u.vsock);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case SOCKET_ADDRESS_LEGACY_KIND_FD:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr-&gt;type =3D SOCKET_ADDRESS_TYPE_FD;=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_CLONE_MEMBERS(String, &amp;addr-&gt;u.fd,=
 addr_legacy-&gt;u.fd.data);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_CLONE_MEMBERS(String, &amp;addr-&gt;u.fd,=
 &amp;addr_legacy-&gt;u.fd);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0abort();<br>
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py<br>
index fafec94e02..1c4e3407a3 100644<br>
--- a/scripts/qapi/introspect.py<br>
+++ b/scripts/qapi/introspect.py<br>
@@ -188,7 +188,12 @@ const QLitObject %(c_name)s =3D %(c_string)s;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;variants=
&#39;: [self._gen_variant(v) for v in variants]}<br>
<br>
=C2=A0 =C2=A0 =C2=A0def _gen_variant(self, variant):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 obj =3D {&#39;case&#39;: <a href=3D"http://var=
iant.name" rel=3D"noreferrer" target=3D"_blank">variant.name</a>, &#39;type=
&#39;: self._use_type(variant.type)}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if variant.wrapped:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 obj =3D {&#39;case&#39;: <a href=
=3D"http://variant.name" rel=3D"noreferrer" target=3D"_blank">variant.name<=
/a>,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;=
type&#39;: self._use_type(variant.wrapper_type)}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 obj =3D {&#39;case&#39;: <a href=
=3D"http://variant.name" rel=3D"noreferrer" target=3D"_blank">variant.name<=
/a>,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;=
type&#39;: self._use_type(variant.type)}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return _make_tree(obj, variant.ifcond, No=
ne)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def visit_builtin_type(self, name, info, json_type):<br=
>
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py<br>
index 720449feee..17525b4216 100644<br>
--- a/scripts/qapi/schema.py<br>
+++ b/scripts/qapi/schema.py<br>
@@ -216,6 +216,11 @@ class QAPISchemaBuiltinType(QAPISchemaType):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._json_type_name =3D json_type<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._c_type_name =3D c_type<br>
<br>
+=C2=A0 =C2=A0 def check(self, schema):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Don&#39;t check twice, it would fail an asse=
rtion<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not self._checked:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 super().check(schema)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def c_name(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return <a href=3D"http://self.name" rel=
=3D"noreferrer" target=3D"_blank">self.name</a><br>
<br>
@@ -593,18 +598,21 @@ class QAPISchemaVariants:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;branch &#39;%s&#39; is not a value of %s&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0% (<a href=3D"http://v.name" rel=3D"noreferrer" target=3D"=
_blank">v.name</a>, self.tag_member.type.describe()))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (not isins=
tance(v.type, QAPISchemaObjectType)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 or v.type.variants):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 or v.type.variants) and v.flat:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0raise QAPISemError(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0<a href=3D"http://self.info" rel=3D"noreferrer" target=3D"=
_blank">self.info</a>,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;%s cannot use %s&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0% (v.describe(<a href=3D"http://self.info" rel=3D"noreferr=
er" target=3D"_blank">self.info</a>), v.type.describe()))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v.type.check(schem=
a)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if isinstance(v.ty=
pe, QAPISchemaObjectType):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v.ty=
pe.check(schema)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def check_clash(self, info, seen):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for v in self.variants:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Reset seen map for each v=
ariant, since qapi names from one<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # branch do not affect another b=
ranch<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v.type.check_clash(info, dict(se=
en))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # branch do not affect another b=
ranch.=C2=A0 Variants that are<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # never flat don&#39;t even conf=
lict with the base.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if isinstance(v.type, QAPISchema=
ObjectType):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v.type.check_clash=
(info, dict(seen) if v.flat else {})<br>
<br>
<br>
=C2=A0class QAPISchemaMember:<br>
@@ -705,9 +713,22 @@ class QAPISchemaObjectTypeMember(QAPISchemaMember):<br=
>
=C2=A0class QAPISchemaVariant(QAPISchemaObjectTypeMember):<br>
=C2=A0 =C2=A0 =C2=A0role =3D &#39;branch&#39;<br>
<br>
-=C2=A0 =C2=A0 def __init__(self, name, info, typ, ifcond=3DNone):<br>
+=C2=A0 =C2=A0 def __init__(self, name, info, typ, ifcond=3DNone, flat=3DTr=
ue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wrapper_type=
=3DNone):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0super().__init__(name, info, typ, False, =
ifcond)<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.flat =3D flat<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wrapped =3D bool(wrapper_type)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wrapper_type =3D wrapper_type<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # For now, unions are either flat or wrapped, =
never both<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert self.flat or self.wrapped<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert not (self.flat and self.wrapped)<br>
+<br>
+=C2=A0 =C2=A0 def check(self, schema):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 super().check(schema)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.wrapped:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wrapper_type.check(schema)<=
br>
<br>
=C2=A0class QAPISchemaCommand(QAPISchemaEntity):<br>
=C2=A0 =C2=A0 =C2=A0meta =3D &#39;command&#39;<br>
@@ -1017,14 +1038,19 @@ class QAPISchema:<br>
=C2=A0 =C2=A0 =C2=A0def _make_variant(self, case, typ, ifcond, info):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return QAPISchemaVariant(case, info, typ,=
 ifcond)<br>
<br>
-=C2=A0 =C2=A0 def _make_simple_variant(self, case, typ, ifcond, info):<br>
+=C2=A0 =C2=A0 def _make_simple_variant(self, union_name, case, typ, ifcond=
, info):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if isinstance(typ, list):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert len(typ) =3D=3D 1<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0typ =3D self._make_array_ty=
pe(typ[0], info)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 typ =3D self._make_implicit_object_type(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 typ, info, self.lookup_type(typ)=
,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;wrapper&#39;, [self._make_m=
ember(&#39;data&#39;, typ, None, None, info)])<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return QAPISchemaVariant(case, info, typ, ifco=
nd)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # The wrapper type is only used for introspect=
ion compatibility.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Don&#39;t add it to the entity list of the s=
chema.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 wrapper_name =3D &#39;q_obj_%s-%s-wrapper&#39;=
 % (union_name, case)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 wrapper_member =3D self._make_member(&#39;data=
&#39;, typ, None, None, info)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 wrapper_type =3D QAPISchemaObjectType(wrapper_=
name, info, None, ifcond,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 None, None, [wrapper_member], None)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return QAPISchemaVariant(case, info, typ, ifco=
nd, flat=3DFalse,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wrapper_type=3Dwrapper_type)<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0def _def_union_type(self, expr, info, doc):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name =3D expr[&#39;union&#39;]<br>
@@ -1044,7 +1070,7 @@ class QAPISchema:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0for (key, value) in data.items()]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0members =3D []<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 variants =3D [self._make_simple_=
variant(key, value[&#39;type&#39;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 variants =3D [self._make_simple_=
variant(name, key, value[&#39;type&#39;],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value.get(&#39;if&#39;), info)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0for (key, value) in data.items()]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum =3D [{&#39;name&#39;: =
<a href=3D"http://v.name" rel=3D"noreferrer" target=3D"_blank">v.name</a>, =
&#39;if&#39;: v.ifcond} for v in variants]<br>
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py<br>
index 339f152152..f72567cbcc 100644<br>
--- a/scripts/qapi/visit.py<br>
+++ b/scripts/qapi/visit.py<br>
@@ -118,6 +118,34 @@ bool visit_type_%(c_name)s_members(Visitor *v, %(c_nam=
e)s *obj, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0&#39;&#39;&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case=3Dcase_str)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif not isinstance(var.type, QA=
PISchemaObjectType):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert not var.fla=
t<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret +=3D mcgen(&#3=
9;&#39;&#39;<br>
+=C2=A0 =C2=A0 case %(case)s:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return visit_type_%(c_type)s(v, &quot;data&quo=
t;, &amp;obj-&gt;u.%(c_name)s, errp);<br>
+&#39;&#39;&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case=3Dcase_str,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c_type=3Dvar.type.c_name(), c_name=3Dc_name(=
<a href=3D"http://var.name" rel=3D"noreferrer" target=3D"_blank">var.name</=
a>))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif var.wrapped:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret +=3D mcgen(&#3=
9;&#39;&#39;<br>
+=C2=A0 =C2=A0 case %(case)s:<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool ok;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!visit_start_struct(v, &quot;data&quot;, N=
ULL, 0, errp)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ok =3D visit_type_%(c_type)s_members(v, &amp;o=
bj-&gt;u.%(c_name)s, errp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ok) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ok =3D visit_check_struct(v, err=
p);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 visit_end_struct(v, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ok;<br>
+=C2=A0 =C2=A0 }<br>
+&#39;&#39;&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case=3Dcase_str,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c_type=3Dvar.type.c_name(), c_name=3Dc_name(=
<a href=3D"http://var.name" rel=3D"noreferrer" target=3D"_blank">var.name</=
a>))<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret +=3D mcge=
n(&#39;&#39;&#39;<br>
=C2=A0 =C2=A0 =C2=A0case %(case)s:<br>
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.ou=
t<br>
index 419284dae2..bcbcbd2fce 100644<br>
--- a/tests/qapi-schema/doc-good.out<br>
+++ b/tests/qapi-schema/doc-good.out<br>
@@ -31,10 +31,6 @@ object Object<br>
=C2=A0 =C2=A0 =C2=A0case two: Variant2<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if [&#39;IFTWO&#39;]<br>
=C2=A0 =C2=A0 =C2=A0feature union-feat1<br>
-object q_obj_Variant1-wrapper<br>
-=C2=A0 =C2=A0 member data: Variant1 optional=3DFalse<br>
-object q_obj_Variant2-wrapper<br>
-=C2=A0 =C2=A0 member data: Variant2 optional=3DFalse<br>
=C2=A0enum SugaredUnionKind<br>
=C2=A0 =C2=A0 =C2=A0member one<br>
=C2=A0 =C2=A0 =C2=A0member two<br>
@@ -42,8 +38,8 @@ enum SugaredUnionKind<br>
=C2=A0object SugaredUnion<br>
=C2=A0 =C2=A0 =C2=A0member type: SugaredUnionKind optional=3DFalse<br>
=C2=A0 =C2=A0 =C2=A0tag type<br>
-=C2=A0 =C2=A0 case one: q_obj_Variant1-wrapper<br>
-=C2=A0 =C2=A0 case two: q_obj_Variant2-wrapper<br>
+=C2=A0 =C2=A0 case one: Variant1<br>
+=C2=A0 =C2=A0 case two: Variant2<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if [&#39;IFTWO&#39;]<br>
=C2=A0 =C2=A0 =C2=A0feature union-feat2<br>
=C2=A0alternate Alternate<br>
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qap=
i-schema-test.out<br>
index 8868ca0dca..a4e4051c61 100644<br>
--- a/tests/qapi-schema/qapi-schema-test.out<br>
+++ b/tests/qapi-schema/qapi-schema-test.out<br>
@@ -125,36 +125,6 @@ alternate AltStrObj<br>
=C2=A0 =C2=A0 =C2=A0tag type<br>
=C2=A0 =C2=A0 =C2=A0case s: str<br>
=C2=A0 =C2=A0 =C2=A0case o: TestStruct<br>
-object q_obj_intList-wrapper<br>
-=C2=A0 =C2=A0 member data: intList optional=3DFalse<br>
-object q_obj_int8List-wrapper<br>
-=C2=A0 =C2=A0 member data: int8List optional=3DFalse<br>
-object q_obj_int16List-wrapper<br>
-=C2=A0 =C2=A0 member data: int16List optional=3DFalse<br>
-object q_obj_int32List-wrapper<br>
-=C2=A0 =C2=A0 member data: int32List optional=3DFalse<br>
-object q_obj_int64List-wrapper<br>
-=C2=A0 =C2=A0 member data: int64List optional=3DFalse<br>
-object q_obj_uint8List-wrapper<br>
-=C2=A0 =C2=A0 member data: uint8List optional=3DFalse<br>
-object q_obj_uint16List-wrapper<br>
-=C2=A0 =C2=A0 member data: uint16List optional=3DFalse<br>
-object q_obj_uint32List-wrapper<br>
-=C2=A0 =C2=A0 member data: uint32List optional=3DFalse<br>
-object q_obj_uint64List-wrapper<br>
-=C2=A0 =C2=A0 member data: uint64List optional=3DFalse<br>
-object q_obj_numberList-wrapper<br>
-=C2=A0 =C2=A0 member data: numberList optional=3DFalse<br>
-object q_obj_boolList-wrapper<br>
-=C2=A0 =C2=A0 member data: boolList optional=3DFalse<br>
-object q_obj_strList-wrapper<br>
-=C2=A0 =C2=A0 member data: strList optional=3DFalse<br>
-object q_obj_sizeList-wrapper<br>
-=C2=A0 =C2=A0 member data: sizeList optional=3DFalse<br>
-object q_obj_anyList-wrapper<br>
-=C2=A0 =C2=A0 member data: anyList optional=3DFalse<br>
-object q_obj_StatusList-wrapper<br>
-=C2=A0 =C2=A0 member data: StatusList optional=3DFalse<br>
=C2=A0enum UserDefListUnionKind<br>
=C2=A0 =C2=A0 =C2=A0member integer<br>
=C2=A0 =C2=A0 =C2=A0member s8<br>
@@ -174,21 +144,21 @@ enum UserDefListUnionKind<br>
=C2=A0object UserDefListUnion<br>
=C2=A0 =C2=A0 =C2=A0member type: UserDefListUnionKind optional=3DFalse<br>
=C2=A0 =C2=A0 =C2=A0tag type<br>
-=C2=A0 =C2=A0 case integer: q_obj_intList-wrapper<br>
-=C2=A0 =C2=A0 case s8: q_obj_int8List-wrapper<br>
-=C2=A0 =C2=A0 case s16: q_obj_int16List-wrapper<br>
-=C2=A0 =C2=A0 case s32: q_obj_int32List-wrapper<br>
-=C2=A0 =C2=A0 case s64: q_obj_int64List-wrapper<br>
-=C2=A0 =C2=A0 case u8: q_obj_uint8List-wrapper<br>
-=C2=A0 =C2=A0 case u16: q_obj_uint16List-wrapper<br>
-=C2=A0 =C2=A0 case u32: q_obj_uint32List-wrapper<br>
-=C2=A0 =C2=A0 case u64: q_obj_uint64List-wrapper<br>
-=C2=A0 =C2=A0 case number: q_obj_numberList-wrapper<br>
-=C2=A0 =C2=A0 case boolean: q_obj_boolList-wrapper<br>
-=C2=A0 =C2=A0 case string: q_obj_strList-wrapper<br>
-=C2=A0 =C2=A0 case sizes: q_obj_sizeList-wrapper<br>
-=C2=A0 =C2=A0 case any: q_obj_anyList-wrapper<br>
-=C2=A0 =C2=A0 case user: q_obj_StatusList-wrapper<br>
+=C2=A0 =C2=A0 case integer: intList<br>
+=C2=A0 =C2=A0 case s8: int8List<br>
+=C2=A0 =C2=A0 case s16: int16List<br>
+=C2=A0 =C2=A0 case s32: int32List<br>
+=C2=A0 =C2=A0 case s64: int64List<br>
+=C2=A0 =C2=A0 case u8: uint8List<br>
+=C2=A0 =C2=A0 case u16: uint16List<br>
+=C2=A0 =C2=A0 case u32: uint32List<br>
+=C2=A0 =C2=A0 case u64: uint64List<br>
+=C2=A0 =C2=A0 case number: numberList<br>
+=C2=A0 =C2=A0 case boolean: boolList<br>
+=C2=A0 =C2=A0 case string: strList<br>
+=C2=A0 =C2=A0 case sizes: sizeList<br>
+=C2=A0 =C2=A0 case any: anyList<br>
+=C2=A0 =C2=A0 case user: StatusList<br>
=C2=A0include include/sub-module.json<br>
=C2=A0command user_def_cmd None -&gt; None<br>
=C2=A0 =C2=A0 =C2=A0gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3D=
False preconfig=3DFalse<br>
@@ -263,14 +233,12 @@ object __org.qemu_x-Struct<br>
=C2=A0 =C2=A0 =C2=A0base __org.qemu_x-Base<br>
=C2=A0 =C2=A0 =C2=A0member __org.qemu_x-member2: str optional=3DFalse<br>
=C2=A0 =C2=A0 =C2=A0member wchar-t: int optional=3DTrue<br>
-object q_obj_str-wrapper<br>
-=C2=A0 =C2=A0 member data: str optional=3DFalse<br>
=C2=A0enum __org.qemu_x-Union1Kind<br>
=C2=A0 =C2=A0 =C2=A0member __org.qemu_x-branch<br>
=C2=A0object __org.qemu_x-Union1<br>
=C2=A0 =C2=A0 =C2=A0member type: __org.qemu_x-Union1Kind optional=3DFalse<b=
r>
=C2=A0 =C2=A0 =C2=A0tag type<br>
-=C2=A0 =C2=A0 case __org.qemu_x-branch: q_obj_str-wrapper<br>
+=C2=A0 =C2=A0 case __org.qemu_x-branch: str<br>
=C2=A0alternate __org.qemu_x-Alt1<br>
=C2=A0 =C2=A0 =C2=A0tag type<br>
=C2=A0 =C2=A0 =C2=A0case __org.qemu_x-branch: str<br>
@@ -305,8 +273,6 @@ enum TestIfEnum<br>
=C2=A0 =C2=A0 =C2=A0member bar<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if [&#39;defined(TEST_IF_ENUM_BAR)&#39;]<=
br>
=C2=A0 =C2=A0 =C2=A0if [&#39;defined(TEST_IF_ENUM)&#39;]<br>
-object q_obj_TestStruct-wrapper<br>
-=C2=A0 =C2=A0 member data: TestStruct optional=3DFalse<br>
=C2=A0enum TestIfUnionKind<br>
=C2=A0 =C2=A0 =C2=A0member foo<br>
=C2=A0 =C2=A0 =C2=A0member union_bar<br>
@@ -315,8 +281,8 @@ enum TestIfUnionKind<br>
=C2=A0object TestIfUnion<br>
=C2=A0 =C2=A0 =C2=A0member type: TestIfUnionKind optional=3DFalse<br>
=C2=A0 =C2=A0 =C2=A0tag type<br>
-=C2=A0 =C2=A0 case foo: q_obj_TestStruct-wrapper<br>
-=C2=A0 =C2=A0 case union_bar: q_obj_str-wrapper<br>
+=C2=A0 =C2=A0 case foo: TestStruct<br>
+=C2=A0 =C2=A0 case union_bar: str<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if [&#39;defined(TEST_IF_UNION_BAR)&#39;]=
<br>
=C2=A0 =C2=A0 =C2=A0if [&#39;defined(TEST_IF_UNION) &amp;&amp; defined(TEST=
_IF_STRUCT)&#39;]<br>
=C2=A0object q_obj_TestIfUnionCmd-arg<br>
-- <br>
2.28.0<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000fa1b4b05b25435c6--

