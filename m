Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B85FC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 21:44:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D80F0208CB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 21:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80F0208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgyfR-0000aV-Vi
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 17:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33221)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <slp@redhat.com>) id 1hgye2-0000BI-P1
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 17:43:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1hgye1-00040z-H8
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 17:42:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33798)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1hgye1-0003za-9d
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 17:42:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id k11so7682840wrl.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 14:42:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=Xutx3Q7DVb/AmGMLD7E9afMa7c9BEpoNNb7mG91e2Cs=;
 b=QkecubsqNf2n45Ae5Aa7iaES9D38zZqEk+w00nd6i2y/E7RZlb4Njz1LP/sOJimTd6
 6xqF/DCDMURsJtxW5N10SrqkinsYFEgTPJjM8XfSa8sUwGH4rpHyjtPr3QAqlWO2iH93
 0n4/jJLh1QG1IrwFLsG5GN7yVxqrQG2Ak02sfAXRP+Z5lptsSeoBU7oM89v/QmSTNtqp
 zg2wvekhIkCdJq/XWXTkshsFgfmGAhM9LGg3wKiWqpR7kzm4cgfmvmZs6MIpoul+MhZR
 xCAmMtKlZ5mFXjPlTL8DaU7pe8bT0Hbajv6kh0LoXDVb7oKxZQx1HDPYs1zXBi6EpcJv
 OGpQ==
X-Gm-Message-State: APjAAAWDCXP8hiB6vIARvibRZWHjGk4T1G7D7sn7nSfcyeGU+7dZWCL8
 3IuOtvLscoAcHtn67idErdwQRkQ+1II=
X-Google-Smtp-Source: APXvYqxE9Wlyi5hc+xcP4L9quicKNzUhD7UfCxZ1u+XaLxqD4lTtNY/ePQpcDlDIr/JGcNKu9GgpTw==
X-Received: by 2002:a5d:4dc5:: with SMTP id f5mr3210328wru.114.1561758175323; 
 Fri, 28 Jun 2019 14:42:55 -0700 (PDT)
Received: from dritchie.redhat.com (73.red-88-25-212.staticip.rima-tde.net.
 [88.25.212.73])
 by smtp.gmail.com with ESMTPSA id z5sm3241925wrh.16.2019.06.28.14.42.53
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 14:42:54 -0700 (PDT)
References: <20190628115349.60293-1-slp@redhat.com>
 <20190628115349.60293-5-slp@redhat.com> <20190628194703.GH1862@habkost.net>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
In-reply-to: <20190628194703.GH1862@habkost.net>
Date: Fri, 28 Jun 2019 23:42:52 +0200
Message-ID: <87mui1wfmr.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH 4/4] hw/i386: Introduce the microvm machine
 type
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
Cc: pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Eduardo Habkost <ehabkost@redhat.com> writes:

> Hi,
>
> This looks good, overall, I'm just confused by the versioning
> system.  Comments below:
>
>
> On Fri, Jun 28, 2019 at 01:53:49PM +0200, Sergio Lopez wrote:
>> Microvm is a machine type inspired by both NEMU and Firecracker, and
>> constructed after the machine model implemented by the latter.
>>=20
>> It's main purpose is providing users a KVM-only machine type with fast
>> boot times, minimal attack surface (measured as the number of IO ports
>> and MMIO regions exposed to the Guest) and small footprint (specially
>> when combined with the ongoing QEMU modularization effort).
>>=20
>> Normally, other than the device support provided by KVM itself,
>> microvm only supports virtio-mmio devices. Microvm also includes a
>> legacy mode, which adds an ISA bus with a 16550A serial port, useful
>> for being able to see the early boot kernel messages.
>>=20
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
> [...]
>> +static const TypeInfo microvm_machine_info =3D {
>> +    .name          =3D TYPE_MICROVM_MACHINE,
>> +    .parent        =3D TYPE_MACHINE,
>> +    .abstract      =3D true,
>> +    .instance_size =3D sizeof(MicrovmMachineState),
>> +    .instance_init =3D microvm_machine_instance_init,
>> +    .class_size    =3D sizeof(MicrovmMachineClass),
>> +    .class_init    =3D microvm_class_init,
>
> [1]
>
>> +    .interfaces =3D (InterfaceInfo[]) {
>> +         { TYPE_NMI },
>> +         { }
>> +    },
>> +};
>> +
>> +static void microvm_machine_init(void)
>> +{
>> +    type_register_static(&microvm_machine_info);
>> +}
>> +type_init(microvm_machine_init);
>> +
>> +static void microvm_1_0_instance_init(Object *obj)
>> +{
>> +}
>
> You shouldn't need a instance_init function if it's empty, I
> believe you can delete it.

Ack.

>> +
>> +static void microvm_machine_class_init(MachineClass *mc)
>
> Why do you need both microvm_machine_class_init() [1] and
> microvm_class_init()?

No idea. To be honest, I took the boilerplate from NEMU's virt machine
type (hence the copyright notice), and I assumed that was actually
mandatory.

>> +{
>> +    mc->init =3D microvm_machine_state_init;
>> +
>> +    mc->family =3D "microvm_i386";
>> +    mc->desc =3D "Microvm (i386)";
>> +    mc->units_per_default_bus =3D 1;
>> +    mc->no_floppy =3D 1;
>> +    machine_class_allow_dynamic_sysbus_dev(mc, "sysbus-debugcon");
>> +    machine_class_allow_dynamic_sysbus_dev(mc, "sysbus-debugexit");
>> +    mc->max_cpus =3D 288;
>
> Where does this limit come from?

From=20pc_q35.c:366. Apparently, having this limit defined is mandatory,
and I wasn't which value would make sense for microvm.

>> +    mc->has_hotpluggable_cpus =3D false;
>> +    mc->auto_enable_numa_with_memhp =3D false;
>> +    mc->default_cpu_type =3D X86_CPU_TYPE_NAME ("host");
>> +    mc->nvdimm_supported =3D false;
>> +    mc->default_machine_opts =3D "accel=3Dkvm";
>> +
>> +    /* Machine class handlers */
>> +    mc->cpu_index_to_instance_props =3D cpu_index_to_props;
>> +    mc->get_default_cpu_node_id =3D cpu_get_default_cpu_node_id;
>> +    mc->possible_cpu_arch_ids =3D cpu_possible_cpu_arch_ids;;
>
> I don't think these methods should be mandatory if you don't
> support NUMA or CPU hotplug.  Do you really need them?
>
> (If the core machine code makes them mandatory, it's probably not
> intentional).

Ack, I'll check whether this is actually needed or not.

>> +    mc->reset =3D microvm_machine_reset;
>> +}
>> +
>> +static void microvm_1_0_machine_class_init(MachineClass *mc)
>> +{
>> +    microvm_machine_class_init(mc);
>> +}
>> +DEFINE_MICROVM_MACHINE_AS_LATEST(1, 0)
>
>
> We only have multiple versions of some machine types (pc-*,
> virt-*, pseries-*, s390-ccw-virtio-*) because of Guest ABI
> compatibility (which you are not implementing here).  What's the
> reason behind having multiple microvm machine versions?

I though it could be a good idea to have versioning already in place, in
case we need it in the future. But, perhaps we can do a simple machine
definition and just add versioning when it's really needed?

> [...]
>> +#define TYPE_MICROVM_MACHINE   MACHINE_TYPE_NAME("microvm")
>
> Using MACHINE_TYPE_NAME("microvm") might eventually cause
> conflicts with the "microvm" alias you are registering.  I
> suggest using something like "microvm-machine-base".
>
> A separate base class will only be necessary if you are really
> planning to provide multiple versions of the machine type,
> though.

Ack.

Thanks!
Sergio.

>> +#define MICROVM_MACHINE(obj) \
>> +    OBJECT_CHECK(MicrovmMachineState, (obj), TYPE_MICROVM_MACHINE)
>> +#define MICROVM_MACHINE_GET_CLASS(obj) \
>> +    OBJECT_GET_CLASS(MicrovmMachineClass, obj, TYPE_MICROVM_MACHINE)
>> +#define MICROVM_MACHINE_CLASS(class) \
>> +    OBJECT_CLASS_CHECK(MicrovmMachineClass, class, TYPE_MICROVM_MACHINE)
>> +
>> +#endif
>> --=20
>> 2.21.0
>>=20


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl0WidwACgkQ9GknjS8M
AjU2kQ/+K/vVU1Zon0OUp2m+gS6zVbiIg/M88A5of02HupBAlCF4ua3PpTcbWZ8t
mZ/8naF06DMas9MHAqXtJ+G6wG2xHhGTd6w9RQpl2l9s71Mk5m0uL80YLbt8FulI
Rf58I3ZrmJmtzo1k8Y7qwqp51PxV82xvqYutH1dhRaLcHZrJ021i426ZxaHd9BrP
q3eqZPDa5iZtsrvfGCqeRQFImhv/NsMEcBV85s8+kjWuX9YNBCIar6o43eRxDxnf
0AhTW7EYGbh53Aq57Q6Um5ZhsasKZr9fqaY/ovo4cZfhL5yqSoadw9mXR9cZS6PP
9OK9sZto8/RuX7Xk4tp5oPqt8RG8B52DlEy3extdjGd+unC+OYw/q4+D9t7hFWhe
4241ZayzmgJqrAoEe+rMOrYX2d6pFHjH8q8fVuNbMZzUAPW3wGJyscAVcj07dnge
TM1qTcbkIUU7MDTb5axWI1s7bQC+Sm8B6b/+zg1sF2nUxnNsnFgSXMcW5qPJaalP
OWp8CuJPmWlGK0KhR2sKeWP0oUbv3nHZPu8+JNtCy15PnrKpBSonmr+CeLLtr3lf
utn7vFPulLumObXSdjNZF0fSnDrgBhASmQfBJDt53r+ZA9zUVwikhBGwsb9s+BSL
JxQwYNnS6L+UJdQCbMRX9NdfXkn5KHWlyH+BiONPwKJSQz8Y+LU=
=EdQu
-----END PGP SIGNATURE-----
--=-=-=--

