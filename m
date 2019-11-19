Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF04C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 10:46:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61C4C222F2
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 10:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7MvLRam"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C4C222F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX11H-0004X4-D2
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 05:46:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iX0za-0003ga-H6
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 05:44:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iX0zZ-00057A-4G
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 05:44:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28996
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iX0zZ-00056l-0M
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 05:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574160256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XijCjnDWCHF4Gte4bJ0HrAHZp6L82KPZqRfsBGzdoes=;
 b=B7MvLRam76qTcgtbL7NSWfbebd1/eVSHLTV6QAC522DZk1HL1fmIPE8BTbo6qL+sCs+bRk
 I0kqXYaRzj6ldWSRGrwvse9wJ4YWiA5eX/MltCWrKRVKzg1eBJfAWvf/14UaWZIqshyeRA
 aY7A2YogNmevdLmC7nn+bu4A6JiixCw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-37tZ_ujUNFGJUH_ohLDAsw-1; Tue, 19 Nov 2019 05:44:12 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4981801E59
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 10:44:11 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-181.ams2.redhat.com
 [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DCA25E25A;
 Tue, 19 Nov 2019 10:44:10 +0000 (UTC)
Subject: Re: [PATCH 12/16] tcg: add "-accel tcg,tb-size" and deprecate
 "-tb-size"
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
 <1573655945-14912-13-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8b27cbc8-f995-3ce0-d5cb-1d07535de977@redhat.com>
Date: Tue, 19 Nov 2019 11:44:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <1573655945-14912-13-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 37tZ_ujUNFGJUH_ohLDAsw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/11/2019 15.39, Paolo Bonzini wrote:
> -tb-size fits nicely in the new framework for accelerator-specific option=
s.  It
> is a very niche option, so insta-deprecate the old version.

Good idea!

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  accel/tcg/tcg-all.c    | 40 +++++++++++++++++++++++++++++++++++++---
>  include/sysemu/accel.h |  2 --
>  qemu-deprecated.texi   |  6 ++++++
>  qemu-options.hx        |  6 +++++-
>  vl.c                   |  8 ++++----
>  5 files changed, 52 insertions(+), 10 deletions(-)
>=20
> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index 7829f02..1dc384c 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -34,11 +34,13 @@
>  #include "include/qapi/error.h"
>  #include "include/qemu/error-report.h"
>  #include "include/hw/boards.h"
> +#include "qapi/qapi-builtin-visit.h"
> =20
>  typedef struct TCGState {
>      AccelState parent_obj;
> =20
>      bool mttcg_enabled;
> +    unsigned long tb_size;

So this tb_size is "long" ...

>  } TCGState;
> =20
>  #define TYPE_TCG_ACCEL ACCEL_CLASS_NAME("tcg")
> @@ -46,8 +48,6 @@ typedef struct TCGState {
>  #define TCG_STATE(obj) \
>          OBJECT_CHECK(TCGState, (obj), TYPE_TCG_ACCEL)
> =20
> -unsigned long tcg_tb_size;
> -
>  /* mask must never be zero, except for A20 change call */
>  static void tcg_handle_interrupt(CPUState *cpu, int mask)
>  {
> @@ -126,7 +126,7 @@ static int tcg_init(MachineState *ms)
>  {
>      TCGState *s =3D TCG_STATE(current_machine->accelerator);
> =20
> -    tcg_exec_init(tcg_tb_size * 1024 * 1024);
> +    tcg_exec_init(s->tb_size * 1024 * 1024);

... which is likely ok for this calculation here ...

>      cpu_interrupt_handler =3D tcg_handle_interrupt;
>      mttcg_enabled =3D s->mttcg_enabled;
>      return 0;
> @@ -167,6 +167,33 @@ static void tcg_set_thread(Object *obj, const char *=
value, Error **errp)
>      }
>  }
> =20
> +static void tcg_get_tb_size(Object *obj, Visitor *v,
> +                            const char *name, void *opaque,
> +                            Error **errp)
> +{
> +    TCGState *s =3D TCG_STATE(obj);
> +    uint32_t value =3D s->tb_size;
> +
> +    visit_type_uint32(v, name, &value, errp);

... but this is only using 32-bit values.

Should be fine, I guess, but it's a little bit confusing when looking at
the code with a quick glance only.

Maybe turn tb_size into a "uint32_t", too, and then use "* MiB" in above
calculation instead of "* 1024 * 1024" ?

> +}
[...]
> diff --git a/qemu-options.hx b/qemu-options.hx
> index b95bf9f..3931f90 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -120,6 +120,7 @@ ETEXI
>  DEF("accel", HAS_ARG, QEMU_OPTION_accel,
>      "-accel [accel=3D]accelerator[,thread=3Dsingle|multi]\n"

Maybe add the "[,prop[=3Dvalue]" change from the next patch here already?

Or should we even split it up into separate lines, like we do it for
-netdev for example already? i.e.:

        -accel tcg,[,thread=3Dsingle|multi][,tb-size=3Dn]\n
           ...
        -accel xen,[igd-passthrough=3D...]\n

?

>      "                select accelerator (kvm, xen, hax, hvf, whpx or tcg=
; use 'help' for a list)\n"
> +    "                tb-size=3Dn (TCG translation block cache size)\n"
>      "                thread=3Dsingle|multi (enable multi-threaded TCG)\n=
", QEMU_ARCH_ALL)
>  STEXI
>  @item -accel @var{name}[,prop=3D@var{value}[,...]]
> @@ -129,6 +130,8 @@ kvm, xen, hax, hvf, whpx or tcg can be available. By =
default, tcg is used. If th
>  more than one accelerator specified, the next one is used if the previou=
s one
>  fails to initialize.
>  @table @option
> +@item tb-size=3D@var{n}
> +Controls the size (in MiB) of the TCG translation block cache.
>  @item thread=3Dsingle|multi
>  Controls number of TCG threads. When the TCG is multi-threaded there wil=
l be one
>  thread per vCPU therefor taking advantage of additional host cores. The =
default
> @@ -3995,7 +3998,8 @@ DEF("tb-size", HAS_ARG, QEMU_OPTION_tb_size, \
>  STEXI
>  @item -tb-size @var{n}
>  @findex -tb-size
> -Set TB size.
> +Set TCG translation block cache size.  Deprecated, use @samp{-accel tcg,=
tb-size=3D@var{n}}
> +instead.
>  ETEXI
> =20
>  DEF("incoming", HAS_ARG, QEMU_OPTION_incoming, \
> diff --git a/vl.c b/vl.c
> index 2ea94c7..06c6ad9 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2857,6 +2857,7 @@ static int do_configure_accelerator(void *opaque, Q=
emuOpts *opts, Error **errp)
>          return 0;
>      }
>      accel =3D ACCEL(object_new_with_class(OBJECT_CLASS(ac)));
> +    object_apply_compat_props(OBJECT(accel));
>      qemu_opt_foreach(opts, accelerator_set_property,
>                       accel,
>                       &error_fatal);
> @@ -2868,6 +2869,7 @@ static int do_configure_accelerator(void *opaque, Q=
emuOpts *opts, Error **errp)
>                       acc, strerror(-ret));
>          return 0;
>      }
> +

Unnecessary white space change.

>      return 1;
>  }
> =20
> @@ -3747,10 +3749,8 @@ int main(int argc, char **argv, char **envp)
>                  error_report("TCG is disabled");
>                  exit(1);
>  #endif
> -                if (qemu_strtoul(optarg, NULL, 0, &tcg_tb_size) < 0) {
> -                    error_report("Invalid argument to -tb-size");
> -                    exit(1);
> -                }
> +                warn_report("The -tb-size option is deprecated, use -acc=
el tcg,tb-size instead");
> +                object_register_sugar_prop(ACCEL_CLASS_NAME("tcg"), "tb-=
size", optarg);
>                  break;
>              case QEMU_OPTION_icount:
>                  icount_opts =3D qemu_opts_parse_noisily(qemu_find_opts("=
icount"),
>=20

 Thomas


