Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C048FC48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 01:46:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77535204EC
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 01:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJqvQWj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77535204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfx1M-0005Rc-Nk
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 21:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38731)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sjitindarsingh@gmail.com>) id 1hfwzg-0004SV-4D
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 21:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sjitindarsingh@gmail.com>) id 1hfwze-0007pF-50
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 21:45:03 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:45931)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sjitindarsingh@gmail.com>)
 id 1hfwzY-0007dA-5k; Tue, 25 Jun 2019 21:44:56 -0400
Received: by mail-pl1-x643.google.com with SMTP id bi6so431937plb.12;
 Tue, 25 Jun 2019 18:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5TJPvr0mAZrZusVyae3PfFUAJteM7WaGVqixSVsJicY=;
 b=bJqvQWj5ND5Ph5IZXKjS8siHFskL68Y5yTKerU6tcVjGFuRMWk2f7cIEoSJyRLiup5
 5KmuNMPBbJdIX73IT9HiwYQHr0HtQBOPxQrh3Smrx1MsYRexu/dbfmjgB1IQqkvBRAXV
 ZngQGOx31XpQOX+/nv8LZJZb/Cshx5IPJ/tdHNYtYGeOZ2QjhKalEROZ6b9nM75wLzKo
 kduR8to7K8WTKVKsCZCekmEClomsacNPZlQsKaHXy4NqDzochy4606DfSSepWA6XWjPq
 4xm+99LjEKNtYynVkGUjqSWat1KRpEYmUXvz38c8W8RVDkcIAxjLDlZ7TX3Yr2MDw4lG
 J9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5TJPvr0mAZrZusVyae3PfFUAJteM7WaGVqixSVsJicY=;
 b=cn7WaJMGogXmzkiRG+VftVUj7tsv2cEQfAzzYIbxDz1BouPxWzrApBmEEAfk1cLaLx
 hhoeFVFdbSLUcuIHSpkwcU9b7O7byATz0yaNTSdTQIiuxo74UQxkcSX1oGvQSYC43wXY
 Nw3UiZEaFHpLYF783oumaYUJoj/RH8MRf4kA+G0HdBtZxIc/QW5OUn+wwCO6QrSAFE3X
 fgJ0XLLPNaGxKjwYZtb6ewt7tsHdXp9KhIohDPpnAZyTNPGH32GVL4iSi4H/tPFU2tR1
 sM1vSyQr5c/6D67LKFqmgFmEbYkg26E1IuEMkwM21EH6PPrV43s97DfHb1i2FBiNTRek
 KJ8A==
X-Gm-Message-State: APjAAAX/tLK1MTmkgKysU14d2y+Essk6MRMqtjkHL8xoYgJOk4QuhX4v
 /2qp8JcM6BVM0nnf4K4rJa0=
X-Google-Smtp-Source: APXvYqzjuo0aB/97yOs9kkOX/RqmroxM/bsFUKNOZ1gsg0D3DA1S8cJSuPLdliCZg1DWYgCoORwSqw==
X-Received: by 2002:a17:902:7586:: with SMTP id
 j6mr2058556pll.128.1561513493559; 
 Tue, 25 Jun 2019 18:44:53 -0700 (PDT)
Received: from surajjs2.ozlabs.ibm.com ([122.99.82.10])
 by smtp.googlemail.com with ESMTPSA id b36sm285614pjc.16.2019.06.25.18.44.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 25 Jun 2019 18:44:52 -0700 (PDT)
Message-ID: <1561513488.2189.2.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: Greg Kurz <groug@kaod.org>
Date: Wed, 26 Jun 2019 11:44:48 +1000
In-Reply-To: <20190624103745.08a32221@bahia.lan>
References: <20190624013921.11944-1-sjitindarsingh@gmail.com>
 <20190624103745.08a32221@bahia.lan>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [Qemu-ppc] [QEMU-PPC] [PATCH] powerpc/spapr: Add
 host threads parameter to ibm, get_system_parameter
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-06-24 at 10:37 +0200, Greg Kurz wrote:
> On Mon, 24 Jun 2019 11:39:21 +1000
> Suraj Jitindar Singh <sjitindarsingh@gmail.com> wrote:
> 
> > The ibm,get_system_parameter rtas call is used by the guest to
> > retrieve
> > data relating to certain parameters of the system. The SPLPAR
> > characteristics option (token 20) is used to determin
> > characteristics of
> > the environment in which the lpar will run.
> > 
> > It may be useful for a guest to know the number of physical host
> > threads
> > present on the underlying system where it is being run. Add the
> > characteristic "HostThrs" to the SPLPAR Characteristics
> > ibm,get_system_parameter rtas call to expose this information to a
> > guest and provide an implementation which determines this
> > information
> > based on the number of interrupt servers present in the device
> > tree.
> > 
> 
> Shouldn't this also take split core into account, ie. divide the
> result by "/sys/devices/system/cpu/subcores_per_core" like the 
> ppc64_cpu command from powerpc-utils does ?

That makes sense, I'll modify the code to account for that.

Thanks,
Suraj

> 
> > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > ---
> >  hw/ppc/spapr_rtas.c | 44
> > ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> > 
> > diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> > index 5bc1a93271..a33d87794c 100644
> > --- a/hw/ppc/spapr_rtas.c
> > +++ b/hw/ppc/spapr_rtas.c
> > @@ -229,6 +229,40 @@ static inline int sysparm_st(target_ulong
> > addr, target_ulong len,
> >      return RTAS_OUT_SUCCESS;
> >  }
> >  
> > +static int rtas_get_num_host_threads(void)
> > +{
> > +    const char *entry, *name = "/proc/device-tree/cpus/";
> > +    int num_threads = -1;
> > +    GDir *dir;
> > +
> > +    if (!kvm_enabled())
> > +        return 1;
> > +
> > +    dir = g_dir_open(name, 0, NULL);
> > +    if (!dir)
> > +        return -1;
> > +
> > +    while ((entry = g_dir_read_name(dir))) {
> > +        if (!strncmp(entry, "PowerPC,POWER",
> > strlen("PowerPC,POWER"))) {
> > +            unsigned long len;
> > +            char *path, *buf;
> > +
> > +            path = g_strconcat(name, entry, "/ibm,ppc-interrupt-
> > server#s",
> > +                               NULL);
> > +            if (g_file_get_contents(path, &buf, &len, NULL)) {
> > +                num_threads = len / sizeof(int);
> > +                g_free(buf);
> > +            }
> > +
> > +            g_free(path);
> > +            break;
> > +        }
> > +    }
> > +
> > +    g_dir_close(dir);
> > +    return num_threads;
> > +}
> > +
> >  static void rtas_ibm_get_system_parameter(PowerPCCPU *cpu,
> >                                            SpaprMachineState
> > *spapr,
> >                                            uint32_t token, uint32_t
> > nargs,
> > @@ -250,6 +284,16 @@ static void
> > rtas_ibm_get_system_parameter(PowerPCCPU *cpu,
> >                                            current_machine-
> > >ram_size / MiB,
> >                                            smp_cpus,
> >                                            max_cpus);
> > +        int num_host_threads = rtas_get_num_host_threads();
> > +
> > +        if (num_host_threads > 0) {
> > +            char *hostthr_val, *old = param_val;
> > +
> > +            hostthr_val = g_strdup_printf(",HostThrs=%d",
> > num_host_threads);
> > +            param_val = g_strconcat(param_val, hostthr_val, NULL);
> > +            g_free(hostthr_val);
> > +            g_free(old);
> > +        }
> >          ret = sysparm_st(buffer, length, param_val,
> > strlen(param_val) + 1);
> >          g_free(param_val);
> >          break;
> 
> 

