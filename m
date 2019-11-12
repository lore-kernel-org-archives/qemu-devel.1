Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1B7C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 11:57:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8F3B20818
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 11:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3cnUr3O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F3B20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUUo0-000521-So
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 06:57:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iUUnG-0004LP-Hz
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:57:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iUUnD-0000dh-Sy
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:57:08 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28243
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iUUnD-0000dT-HM
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 06:57:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573559826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wzs8lJkoQadgyqQ+6CYM8vuQF90xsOpSjkIHYpXYnUg=;
 b=P3cnUr3O4LQwGdvj9qo7GECI+zYEJXpoz3MHEUoE45/TRQbz8QrbxhhANsKZ/9dv1G1c/h
 lICbXX8rByIho8yNvsVy3tO0JpiT9dU2MurcGb4WI+lMSJsQHgBittg0bgivu3z/ciUOnu
 s7vzBnEdmHYk47ewpoWK457Q5cVWj2k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-7CmWAS8fPiCw9n947Aj5eA-1; Tue, 12 Nov 2019 06:57:05 -0500
Received: by mail-wr1-f70.google.com with SMTP id b4so11721205wrn.8
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 03:57:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=fRRWibjhMYah7FVG3z/hGlGYki3qe/QauVO3dHWuZl0=;
 b=WuKATh1l6sF7euByqzKBl/sdW05Ww2gLKdM4/cBziKvXHG9tKMESm76xCm5UO8ltlx
 F2DTztGl303KBOVbu/lkN3wfoPpYPDHSGLG0o9wkRnC4vYq6n7PWHhusGTBGhfFcG+9x
 KDgkfKJYVqPuZqAz2kliC7GVb/9m/N6v1KhD1MF5VoKpvZFe6fbcG14+jHYQWwBm+ocl
 z1oX6Z4DeUwkiMAzsk9sA9jF5Q87fummBR0GIfGtaYCUZe3EHuUfegHvwZLNPH17ikA6
 2aaXlpal77OmGcWl5tIEJ7EiO1Wp+2HMfMc7UEzqKUfURIUpTGUdoFHBD6gCr+IvkdCC
 DG1A==
X-Gm-Message-State: APjAAAX+sw3Q9gW9bkAJn3z30Sr7UDxJ1MwVLT2GI1ijqjK+4rXN8Hsn
 Tgc53Swiw2WLm2pXaCJYNlxN8uVdzTX5PX+MLwvZSasu8vsM4r54i9E7RAahJ5MsO5N/ZB2bTyr
 IPwj7ynOln0bmo1o=
X-Received: by 2002:adf:dd10:: with SMTP id a16mr26711936wrm.213.1573559823945; 
 Tue, 12 Nov 2019 03:57:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqy0P0/FBY753WsOEv33725rNsFsWAO4+Q9TYdQ/mXHaqJxFy0umCND/t7Q9HU6Qs8Lz75myrQ==
X-Received: by 2002:adf:dd10:: with SMTP id a16mr26711915wrm.213.1573559823734; 
 Tue, 12 Nov 2019 03:57:03 -0800 (PST)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id 76sm4530971wma.0.2019.11.12.03.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 03:57:03 -0800 (PST)
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
 <1571925835-31930-21-git-send-email-pbonzini@redhat.com>
 <CAFEAcA-wqep+Lq93Ps=d6Cgx9bbYSNCcankbdvzoGz5T2P1_YA@mail.gmail.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 20/39] hw/i386: Introduce the microvm machine type
In-reply-to: <CAFEAcA-wqep+Lq93Ps=d6Cgx9bbYSNCcankbdvzoGz5T2P1_YA@mail.gmail.com>
Date: Tue, 12 Nov 2019 12:57:02 +0100
Message-ID: <87y2wls3xt.fsf@redhat.com>
MIME-Version: 1.0
X-MC-Unique: 7CmWAS8fPiCw9n947Aj5eA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 24 Oct 2019 at 16:19, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> From: Sergio Lopez <slp@redhat.com>
>>
>> microvm is a machine type inspired by Firecracker and constructed
>> after its machine model.
>>
>> It's a minimalist machine type without PCI nor ACPI support, designed
>> for short-lived guests. microvm also establishes a baseline for
>> benchmarking and optimizing both QEMU and guest operating systems,
>> since it is optimized for both boot time and footprint.
>
> Hi; Coverity points out a memory leak in this commit
> (CID 1407218):
>
>
>> +static void microvm_fix_kernel_cmdline(MachineState *machine)
>> +{
>> +    X86MachineState *x86ms =3D X86_MACHINE(machine);
>> +    BusState *bus;
>> +    BusChild *kid;
>> +    char *cmdline;
>> +
>> +    /*
>> +     * Find MMIO transports with attached devices, and add them to the =
kernel
>> +     * command line.
>> +     *
>> +     * Yes, this is a hack, but one that heavily improves the UX withou=
t
>> +     * introducing any significant issues.
>> +     */
>> +    cmdline =3D g_strdup(machine->kernel_cmdline);
>
> Here we allocate memory for cmdline...
>
>> +    bus =3D sysbus_get_default();
>> +    QTAILQ_FOREACH(kid, &bus->children, sibling) {
>> +        DeviceState *dev =3D kid->child;
>> +        ObjectClass *class =3D object_get_class(OBJECT(dev));
>> +
>> +        if (class =3D=3D object_class_by_name(TYPE_VIRTIO_MMIO)) {
>> +            VirtIOMMIOProxy *mmio =3D VIRTIO_MMIO(OBJECT(dev));
>> +            VirtioBusState *mmio_virtio_bus =3D &mmio->bus;
>> +            BusState *mmio_bus =3D &mmio_virtio_bus->parent_obj;
>> +
>> +            if (!QTAILQ_EMPTY(&mmio_bus->children)) {
>> +                gchar *mmio_cmdline =3D microvm_get_mmio_cmdline(mmio_b=
us->name);
>> +                if (mmio_cmdline) {
>> +                    char *newcmd =3D g_strjoin(NULL, cmdline, mmio_cmdl=
ine, NULL);
>> +                    g_free(mmio_cmdline);
>> +                    g_free(cmdline);
>> +                    cmdline =3D newcmd;
>> +                }
>> +            }
>> +        }
>> +    }
>> +
>> +    fw_cfg_modify_i32(x86ms->fw_cfg, FW_CFG_CMDLINE_SIZE, strlen(cmdlin=
e) + 1);
>> +    fw_cfg_modify_string(x86ms->fw_cfg, FW_CFG_CMDLINE_DATA, cmdline);
>
> ...but fw_cfg_modify_string() takes a copy of the string it's passed,
> so we still have ownership of 'cmdline' and need to free it here
> to avoid a leak.

Ack, will send a patch ASAP.

Thanks,
Sergio.

>> +}
>
> thanks
> -- PMM


