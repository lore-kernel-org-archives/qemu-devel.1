Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B6DC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:22:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 124E42064A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xNKMuaO4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 124E42064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48412 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hctT3-0007z0-76
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 11:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51420)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hcsxd-00021O-KA
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:50:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hcsxc-0002hQ-GL
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:50:17 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34923)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hcsxc-0002gn-5y
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:50:16 -0400
Received: by mail-wm1-x342.google.com with SMTP id c6so9449060wml.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=g8hI03drj9LBB6MPiVcpYjLLW+652AYjuNfh+Ht7kZg=;
 b=xNKMuaO43x4GqpMSL6d4jP5JjrhttR4BnVNgexqkTgj4FzKinqMUJRO9FUruC3eWza
 WSMVTvpuriWtnPu8lRqlsxcXGexKf0sSCT4HjA2auMQByVSvK7ndkEaexsKKTxel+KQq
 KN8+szo5om3aUYmEZ19S/XhP//1jixDiDj0APtFVtOHClpZDheWEACKdTpOlCkzOjsNA
 c5JNZlc8XBabUQTEjz2QSKIOdFyu7ZTn6wLapOq9laz+Lx0D0gQLadxv5wmPhTqUuh4L
 6pkQc8f4m25+vnulRB4/kgu4AXU1TU35F6mtnwv8D6CFYB8uN6cRMuVdC3cI/f//11bW
 rF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=g8hI03drj9LBB6MPiVcpYjLLW+652AYjuNfh+Ht7kZg=;
 b=W4YUl+2g76533xsp/OjWCDhs/SspOp79EhkhUeDcsc94n/M8OVJkiHlvNP8WVSyMRB
 O6Bdz14hJJLTo1/3tTPnzNUXil7MCYQuCicjkz0ZHhikXKuVEmqKQLcNDEc1BVFYY6yP
 +O0HfFoCPAbpHOQ9moDvMrrFFgr7yXzdE5T07pHCGpRHsPKdDS6jUw+psXoOJ2tloVpp
 De9BInEUe9G6pdaPauphxqm4sfyrWqj3YN1II93LWAK0Pa3JhnoU6SZVCQlQcHX2SiyM
 klyOGtUbYQt0QmhiYFkNt9H7OCkrorV0yumemcnFnnQelYJ1TZoOvIxvlgcWYU8AcD3A
 ugRg==
X-Gm-Message-State: APjAAAVTa63TsLSk7GRiVkBhB1gtp/SCb1E3H8g9e5hhyolbTSQ9BEoH
 14WcB8P3V5JjyVgcwhZxvkeK+A==
X-Google-Smtp-Source: APXvYqz9nJpc2K7MO3NAtpivuvzsvEXmhCwKWf00tON3zT/SPwebH0zSDsowsXacq5noERW6miZlfA==
X-Received: by 2002:a1c:9813:: with SMTP id a19mr18721364wme.11.1560783015132; 
 Mon, 17 Jun 2019 07:50:15 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id s10sm14667254wmf.8.2019.06.17.07.50.14
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 17 Jun 2019 07:50:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4903B1FF87;
 Mon, 17 Jun 2019 15:50:14 +0100 (BST)
References: <20190615154352.26824-1-philmd@redhat.com>
 <20190615154352.26824-21-philmd@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190615154352.26824-21-philmd@redhat.com>
Date: Mon, 17 Jun 2019 15:50:14 +0100
Message-ID: <87d0jc9sgp.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v2 20/23] target/arm: Define TCG dependent
 functions when TCG is enabled
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Samuel Ortiz <sameo@linux.intel.com>,
 Robert Bradford <robert.bradford@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> From: Samuel Ortiz <sameo@linux.intel.com>
>
> do_interrupt, do_unaligned_access, do_transaction_failed and debug_excp
> are only relevant in the TCG context, so we should not define them
> when TCG is disabled.
>
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Robert Bradford <robert.bradford@intel.com>
> [PMD: Rebased]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/cpu.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 2335659a85..3ffea857c4 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1557,7 +1557,7 @@ static void arm_v7m_class_init(ObjectClass *oc, voi=
d *data)
>      CPUClass *cc =3D CPU_CLASS(oc);
>
>      acc->info =3D data;
> -#ifndef CONFIG_USER_ONLY
> +#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
>      cc->do_interrupt =3D arm_v7m_cpu_do_interrupt;
>  #endif
>
> @@ -2172,22 +2172,24 @@ static void arm_cpu_class_init(ObjectClass *oc, v=
oid *data)
>      cc->gdb_read_register =3D arm_cpu_gdb_read_register;
>      cc->gdb_write_register =3D arm_cpu_gdb_write_register;
>  #ifndef CONFIG_USER_ONLY
> +#ifdef CONFIG_TCG
>      cc->do_interrupt =3D arm_cpu_do_interrupt;
>      cc->do_unaligned_access =3D arm_cpu_do_unaligned_access;
>      cc->do_transaction_failed =3D arm_cpu_do_transaction_failed;
> +    cc->debug_excp_handler =3D arm_debug_excp_handler;
> +#endif /* CONFIG_TCG */
>      cc->get_phys_page_attrs_debug =3D arm_cpu_get_phys_page_attrs_debug;
>      cc->asidx_from_attrs =3D arm_asidx_from_attrs;
>      cc->vmsd =3D &vmstate_arm_cpu;
>      cc->virtio_is_big_endian =3D arm_cpu_virtio_is_big_endian;
>      cc->write_elf64_note =3D arm_cpu_write_elf64_note;
>      cc->write_elf32_note =3D arm_cpu_write_elf32_note;
> -#endif
> +#endif /* CONFIG_USER_ONLY */
>      cc->gdb_num_core_regs =3D 26;
>      cc->gdb_core_xml_file =3D "arm-core.xml";
>      cc->gdb_arch_name =3D arm_gdb_arch_name;
>      cc->gdb_get_dynamic_xml =3D arm_gdb_get_dynamic_xml;
>      cc->gdb_stop_before_watchpoint =3D true;
> -    cc->debug_excp_handler =3D arm_debug_excp_handler;
>      cc->debug_check_watchpoint =3D arm_debug_check_watchpoint;
>  #if !defined(CONFIG_USER_ONLY)
>      cc->adjust_watchpoint_address =3D arm_adjust_watchpoint_address;


--
Alex Benn=C3=A9e

