Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE29BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 19:18:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 762C8206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 19:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tuK7mL7C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 762C8206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgCQz-0002sV-OQ
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 15:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jgCON-0006sl-Q7
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 15:16:07 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:45696)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jgCOM-0002gF-Pt
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 15:16:07 -0400
Received: by mail-lf1-x144.google.com with SMTP id d7so6836990lfi.12
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 12:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xE0FMFRz0266AhDA3ntouWhDWg+Hf2FUnHPNPKctPbs=;
 b=tuK7mL7C7+QMQEP7RBrNLUQQPNfNfpidj5O3YX3ufH7oARJE7uM2/DXwrv8LqKfRNH
 JR7jrsgKxqhuHNkonYtPG8pTujG/xdODJcu+u+wxDeEUWYZZ5uZPZ92kBridE0S+W6kX
 5ohUt9upqZ2363ik8MfB77ywkUPHgMrfZbxLgaMGCcsD7EG0wbRIb6QUp5n75BKcb+IW
 EqPwL/SzEDsyFZkHAL/Q4QvbgK2NxAdwRUqAW3hwVuVqftfcPGgQnPoZFqmfl0ah2qwj
 8sOM0g3Rmh6j3mzWFH04gbTA7RxZvWyTYEoGPAunoc3chWUr+Crt3OB0uuPHwxXIW/a8
 9+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xE0FMFRz0266AhDA3ntouWhDWg+Hf2FUnHPNPKctPbs=;
 b=bowAz8HJgofiPLQ38SRlOE5bfrvR31oZMwMrsTi9104CI0V9GmcvqX310MPwM65Y1D
 qKv7X64RHK9h2unPV6BcXnVBs5FgzhBlJAXbohgNCnYT5BFLSAgT5xSMRISqBAlAiMPC
 TFXmCP0tH537e3k1fLCScELy3jz/dKKTTOZvzUeDu9qT7IsxRgzaUBGwmP+bZ7AflfTL
 noYVP1u05sdTpYXPWLbmeS7XoITUdKbrWlqBAXAWtQsaI0Y8wSzuiefg9/C51Bg0bXVJ
 LML2T2gek7WspnmDAkDFCpo4HleSu8iFyFzRjpzGHUxU2uV6985DnhaQ+Kt0bVGS+1ow
 v+IA==
X-Gm-Message-State: AOAM5334CL5SOFGRseKPkktTMlzJrPNyAnnfxEMVaH96f8EK+QEy1Zn+
 o3q/RpOxGfDKCe1n+pbgTM+UFD/0+GUOw5iHvvEluQ==
X-Google-Smtp-Source: ABdhPJwl4ki+E2s4qsZVUGK88vIfM67xVge83Jk3IxH3BNe9cleMr03qaIu9pZUGd1BWGxTPGGT4Y1a+eZmQBCuVZr0=
X-Received: by 2002:ac2:5cd1:: with SMTP id f17mr421938lfq.4.1591125363907;
 Tue, 02 Jun 2020 12:16:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200602154624.4460-1-alex.bennee@linaro.org>
 <20200602154624.4460-9-alex.bennee@linaro.org>
In-Reply-To: <20200602154624.4460-9-alex.bennee@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Tue, 2 Jun 2020 15:16:02 -0400
Message-ID: <CAEyhzFvTF7Sh1ugq_O9CwADf3LmkWjdCHqmafQC0wkDMKQH1=A@mail.gmail.com>
Subject: Re: [PATCH v1 8/9] plugins: new hwprofile plugin
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=robert.foley@linaro.org; helo=mail-lf1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, "Emilio G. Cota" <cota@braap.org>,
 kuhn.chenqun@huawei.com, Peter Puhov <peter.puhov@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On Tue, 2 Jun 2020 at 11:46, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
<snip>
> diff --git a/tests/plugin/hwprofile.c b/tests/plugin/hwprofile.c
> new file mode 100644
> index 00000000000..f5e0639e762
> --- /dev/null
> +++ b/tests/plugin/hwprofile.c
<snip>
> +static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t mem=
info,
> +                       uint64_t vaddr, void *udata)
> +{
> +    struct qemu_plugin_hwaddr *hwaddr =3D qemu_plugin_get_hwaddr(meminfo=
, vaddr);
> +
> +    if (!hwaddr || !qemu_plugin_hwaddr_is_io(hwaddr)) {
> +        return;
> +    } else {
> +        char *name =3D qemu_plugin_hwaddr_device_name(hwaddr);
> +        DeviceCounts *counts;
> +
> +        g_mutex_lock(&lock);
> +        counts =3D (DeviceCounts *) g_hash_table_lookup(devices, name);
> +        if (!counts) {
> +            uint64_t off =3D qemu_plugin_hwaddr_device_offset(hwaddr);
> +            uint64_t base =3D vaddr - off;
> +            counts =3D new_count(name, base);
> +        } else {
> +            g_free(name);
> +        }
> +
> +        if (detail) {
> +            uint64_t off =3D qemu_plugin_hwaddr_device_offset(hwaddr);
> +            IOLocationCounts *io_count =3D g_hash_table_lookup(counts->a=
ccess_pattern, &off);
> +            if (!io_count) {
> +                io_count =3D new_location(off);
> +                g_hash_table_insert(counts->access_pattern, &off, io_cou=
nt);
> +            }
> +            if (qemu_plugin_mem_is_store(meminfo)) {
> +                io_count->writes++;
> +                io_count->cpu_write |=3D (1 << cpu_index);
> +            } else {
> +                io_count->reads++;
> +                io_count->cpu_read |=3D (1 << cpu_index);
> +            }
> +        } else {
> +            if (qemu_plugin_mem_is_store(meminfo)) {
> +                counts->total_writes++;
> +                counts->cpu_write |=3D (1 << cpu_index);
> +            } else {
> +                counts->total_reads++;
> +                counts->cpu_read |=3D (1 << cpu_index);

The bitmasks cpu_read and cpu_write are ints.  Maybe to account for
larger core counts
> 32, we could assert if the cpu_index is >=3D 32?

> +            }
> +        }
> +        g_mutex_unlock(&lock);
> +    }
> +}
> +
> +static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb=
)
> +{
> +    size_t n =3D qemu_plugin_tb_n_insns(tb);
> +    size_t i;
> +
> +    for (i =3D 0; i < n; i++) {
> +        struct qemu_plugin_insn *insn =3D qemu_plugin_tb_get_insn(tb, i)=
;
> +        qemu_plugin_register_vcpu_mem_cb(insn, vcpu_haddr,
> +                                         QEMU_PLUGIN_CB_NO_REGS,
> +                                         rw, NULL);
> +    }
> +}
> +
> +QEMU_PLUGIN_EXPORT
> +int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
> +                        int argc, char **argv)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < argc; i++) {
> +        char *opt =3D argv[i];
> +        if (g_strcmp0(opt, "read") =3D=3D 0) {
> +            rw =3D QEMU_PLUGIN_MEM_R;
> +        } else if (g_strcmp0(opt, "write") =3D=3D 0) {
> +            rw =3D QEMU_PLUGIN_MEM_W;
> +        } else if (g_strcmp0(opt, "detail") =3D=3D 0) {

When testing out the options, I noticed that
if we supply arguments of "read", and "write", then we will only get
the last one set, "write", since rw gets overwritten.
One option would be to error out if more than one of these read/write
args is supplied.

Reviewed-by: Robert Foley <robert.foley@linaro.org>
Tested-by: Robert Foley <robert.foley@linaro.org>

> +            detail =3D true;
> +        } else {
> +            fprintf(stderr, "option parsing failed: %s\n", opt);
> +            return -1;
> +        }
> +    }
> +
> +    plugin_init();
> +
> +    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
> +    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
> +    return 0;
> +}
> diff --git a/tests/plugin/Makefile b/tests/plugin/Makefile
> index b3250e2504c..d87b8d40699 100644
> --- a/tests/plugin/Makefile
> +++ b/tests/plugin/Makefile
> @@ -14,6 +14,7 @@ NAMES +=3D hotblocks
>  NAMES +=3D howvec
>  NAMES +=3D hotpages
>  NAMES +=3D lockstep
> +NAMES +=3D hwprofile
>
>  SONAMES :=3D $(addsuffix .so,$(addprefix lib,$(NAMES)))
>
> --
> 2.20.1
>

