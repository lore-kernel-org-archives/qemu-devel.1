Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFE4C388F3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 09:03:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65A3621783
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 09:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A3621783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFE4H-0001dc-1Q
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 05:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iFDxr-0004yI-H8
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 04:57:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iFDxo-0003hJ-D3
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 04:56:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56966)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iFDxn-0003gV-0k
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 04:56:55 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E85FC2A09AE
 for <qemu-devel@nongnu.org>; Tue,  1 Oct 2019 08:56:53 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id n3so5708907wrt.9
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 01:56:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=08Kv1bOCjIPz07pAWnv+ptQSVZepJUeUHGLusc/epn0=;
 b=j4wS8/E4drPWo7d3OcboN5YGUNuh7EJIMoEYCsltRUtcMkoYvlsmdRQGK/riElum2V
 74/sUcxOXZLd09SSg/LBYGN9pj8pSRJ+KdPV/fhUZMqFaPNxymj72H9L5/EgKbrDyWjQ
 HnqNWKFp26l2wpP7idf4SHnbSypPdYfdUkuHROy66njKnfwFG2/7MLOyPDAVSRdOopnL
 EuK7GeAhX5pQCnwKGF9hu0put+GtxilgCsetTZAd2a2s1HOZTDq+6qEAQC/mqoHm6wUy
 PUp6yLWiv/+0qj+EQUjRXUR/KLiqmpf+dkgEbqvtHNJMwHInMHI/xpPwwZgNEhxvNbB9
 /u4Q==
X-Gm-Message-State: APjAAAVPTZ+51wHaOigue+OLiOzU4KPrYQ1MrgK4s6iJ2ow4MLBE9rnY
 V6gwunaRC9kObzl9GEl3ce8e7HAsj8HwAWbfqzI+qCXh3DQd20ptB3V97SuvxYHUtMXxisNGmEm
 ccitx7FqGb9LwyvY=
X-Received: by 2002:a5d:4742:: with SMTP id o2mr15703350wrs.253.1569920212614; 
 Tue, 01 Oct 2019 01:56:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzmhGQ3VOsgnOqme02E7DhmvaTdlwV473fcWPh63GfCMeC7xV7TxoHM7fHXvzwGCok9neGftQ==
X-Received: by 2002:a5d:4742:: with SMTP id o2mr15703339wrs.253.1569920212400; 
 Tue, 01 Oct 2019 01:56:52 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id r18sm2438815wme.48.2019.10.01.01.56.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2019 01:56:51 -0700 (PDT)
References: <20190924124433.96810-1-slp@redhat.com>
 <20190924124433.96810-9-slp@redhat.com>
 <20190924092435-mutt-send-email-mst@kernel.org> <87muessyp3.fsf@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 8/8] hw/i386: Introduce the microvm machine type
In-reply-to: <87muessyp3.fsf@redhat.com>
Date: Tue, 01 Oct 2019 10:56:48 +0200
Message-ID: <87ftkcu9m7.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, lersek@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 pbonzini@redhat.com, imammedo@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Sergio Lopez <slp@redhat.com> writes:

> Michael S. Tsirkin <mst@redhat.com> writes:
>
>> On Tue, Sep 24, 2019 at 02:44:33PM +0200, Sergio Lopez wrote:
>>> +static void microvm_fix_kernel_cmdline(MachineState *machine)
>>> +{
>>> +    X86MachineState *x86ms = X86_MACHINE(machine);
>>> +    BusState *bus;
>>> +    BusChild *kid;
>>> +    char *cmdline;
>>> +
>>> +    /*
>>> +     * Find MMIO transports with attached devices, and add them to the kernel
>>> +     * command line.
>>> +     *
>>> +     * Yes, this is a hack, but one that heavily improves the UX without
>>> +     * introducing any significant issues.
>>> +     */
>>> +    cmdline = g_strdup(machine->kernel_cmdline);
>>> +    bus = sysbus_get_default();
>>> +    QTAILQ_FOREACH(kid, &bus->children, sibling) {
>>> +        DeviceState *dev = kid->child;
>>> +        ObjectClass *class = object_get_class(OBJECT(dev));
>>> +
>>> +        if (class == object_class_by_name(TYPE_VIRTIO_MMIO)) {
>>> +            VirtIOMMIOProxy *mmio = VIRTIO_MMIO(OBJECT(dev));
>>> +            VirtioBusState *mmio_virtio_bus = &mmio->bus;
>>> +            BusState *mmio_bus = &mmio_virtio_bus->parent_obj;
>>> +
>>> +            if (!QTAILQ_EMPTY(&mmio_bus->children)) {
>>> +                gchar *mmio_cmdline = microvm_get_mmio_cmdline(mmio_bus->name);
>>> +                if (mmio_cmdline) {
>>> +                    char *newcmd = g_strjoin(NULL, cmdline, mmio_cmdline, NULL);
>>> +                    g_free(mmio_cmdline);
>>> +                    g_free(cmdline);
>>> +                    cmdline = newcmd;
>>> +                }
>>> +            }
>>> +        }
>>> +    }
>>> +
>>> +    fw_cfg_modify_i32(x86ms->fw_cfg, FW_CFG_CMDLINE_SIZE, strlen(cmdline) + 1);
>>> +    fw_cfg_modify_string(x86ms->fw_cfg, FW_CFG_CMDLINE_DATA, cmdline);
>>> +}
>>
>> Can we rearrange this somewhat? Maybe the mmio constructor
>> would format the device description and add to some list,
>> and then microvm would just get stuff from that list
>> and add it to kernel command line?
>> This way it can also be controlled by a virtio-mmio property, so
>> e.g. you can disable it per device if you like.
>> In particular, this seems like a handy trick for any machine type
>> using mmio.
>
> Disabling it per-device won't be easy, as transport options can't be
> specified using the underlying device properties.
>
> But, otherwise, sounds like a good idea to avoid having to traverse the
> qtree. I'll give it a try.

Hi Michael,

I'm working on this, but can't find an easy way to obtain the actual IRQ
number with the data I have access on virtio_mmio_realizefn(). I there a
way to do that without building a new access interface? If it isn't,
knowing this is an specific hack for microvm, is it really worth
building it or can we just keep it as is in v4?

Thanks,
Sergio.


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2TFNAACgkQ9GknjS8M
AjUncQ/8CriN+0QG5xd4pPYgM1rF5i3eKBx7mfLtektAPRhIwfKINHkL71KFIK/3
oexZzUm4xYMfHxzJvHSBSgpEGtoBs85ycVG3AQ+6/GvfB/VEB6Zt89toMCBwcTI4
UqTfOm+lXv9pp8W/Hx5iqZd2Psi+QD+P7xHQuaPjM3mgP3M8TYmXQwjjrcrAx5Ao
p3Xodw34TV/GK7BVzViuwzSFPOM06BbC5lliZ6lScrmlneOlu9vge6bZ/+/ZxG9z
AWZvzH2zGja/AgJDHquF968jIjnGv8k+TbAfIMm+TEIrNYuRy1ciDqN6Lq1Tbjh/
70T6YJ7lCZHkKa9bRuawxEIknew36VtJU6YpfbEp7PDTH+0H8fCVNS6r0rRGlguS
Oo+B1m9sHKJANNlyiEMUmAmJpbBz7nLVm1n61ATDn3MVINp4SvugEBzrVtWVY/Fe
75wGLeUv/J0t4bsZsrOnxNxJB1cGH4np4VWypiSQ1/tR+9q9bQP4TYsmYceGod5t
IBpzAvaMeYAdyThLr5OD5DeGKeVXEFxVq2Rud/4kTu8bGl5W+wDwknGnkJI60OFH
/iLUljHmSBcbr9D201aoC5cdOBdF/YmD+hGl5nnaZjL/BVb1MC6SBbnw6UimZxfI
hP9SIA5McmKxiamJ++GMICRUAqtmBKfh0viD67MGy7shr302YGY=
=qWwG
-----END PGP SIGNATURE-----
--=-=-=--

