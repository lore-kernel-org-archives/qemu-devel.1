Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC32FC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 19:56:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A88A0206E2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 19:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h519DuGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A88A0206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCqPn-0001ks-Tg
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 15:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57201)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCqOh-0000q9-69
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 15:55:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCqOg-0007rA-4Q
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 15:55:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53575
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCqOg-0007q0-0J
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 15:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584129305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nU5HJ/N4mUaFWYfXDlSPC9zoFS/qgaa6S1E362DAaOE=;
 b=h519DuGn6mktj9COilt2Qu2F2gQXlSH+KFSmCVTnwoMV7auRqXy714KS0vVtfsZkHo7uyp
 NYNfQQfhYTpquDXSspuoWBfN3+RPAvKfVNxihZU9RKsVaXHnCXf88JrUl3D1yC0U4/XSuP
 4D0BVZ/pIVob7++pHlJYCfknMr6rQJU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-j2Dk-mYaMg-JT_XHajYsdA-1; Fri, 13 Mar 2020 15:55:03 -0400
X-MC-Unique: j2Dk-mYaMg-JT_XHajYsdA-1
Received: by mail-wm1-f72.google.com with SMTP id a11so1418377wmm.9
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 12:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rEJ/mJdFEeqdZaHP67zf/vqjkCs4hte8zSS5RY0rfH0=;
 b=uhowlqZ4WePiocpWa4eudSHOKVDm0rWxx77JXYIoBGRS1kqzZuLVcQaq24F1A7jENt
 1JXmWlEv9Vn70xTvmB/ahovPlIxSSwQCrjn6sBquu8zyFTaTK3re23R3LOxXfmHEdeZG
 SYQLuDSxBc4iPgvti62MPwtoQ7aAgSBwRx3fpVuMe0wpY/08gSwbWPfV/znyhMiqyWiP
 urUrbE8R0pCU8nWrOK9kQvPKaqe0muavLhmSQt0tbGlH5GSHcuQPN4veVbOIDH8hjKjo
 f0baGp2y1G0JZaWUh3PwRnVBCju+mP/cTbZIDh2W/K0Kkmp2EJu+TQTtquL7D1Cmg88l
 6/AQ==
X-Gm-Message-State: ANhLgQ2nU7EQoARX20zH6nIwuHgxLf7/kZMxYZYsRnz/taWfNQqw51eX
 NVt2JvcTSCt5DHrPqdGoW00+/65nMlcQcPsXX2LVLIm0thSYwz2SIVNUPbp2a75JP7OlX9Y5oBm
 fdPn8c3XPMid0MuU=
X-Received: by 2002:a7b:c05a:: with SMTP id u26mr12121624wmc.74.1584129302333; 
 Fri, 13 Mar 2020 12:55:02 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvhWL+UJ2XEpTUyBWv+OOfsmxptDI6kOMA5wZgC897lb1l3EzIlK+/W/bpNdmrH3GFL9vbOfg==
X-Received: by 2002:a7b:c05a:: with SMTP id u26mr12121603wmc.74.1584129302096; 
 Fri, 13 Mar 2020 12:55:02 -0700 (PDT)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id e7sm61391147wrt.70.2020.03.13.12.55.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2020 12:55:01 -0700 (PDT)
Subject: Re: [PATCH v3 05/16] hw/i386/vmport: Introduce vmware-vmx-version
 property
To: Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org
References: <20200312165431.82118-1-liran.alon@oracle.com>
 <20200312165431.82118-6-liran.alon@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a744b4ff-27a5-7512-e9e7-d2ec345f4db7@redhat.com>
Date: Fri, 13 Mar 2020 20:55:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312165431.82118-6-liran.alon@oracle.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: pbonzini@redhat.com, Nikita Leshenko <nikita.leshchenko@oracle.com>,
 rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/12/20 5:54 PM, Liran Alon wrote:
> vmware-vmx-version is a number returned from CMD_GETVERSION which specifi=
es
> to guest VMware Tools the the host VMX version. If the host reports a num=
ber
> that is different than what the guest VMware Tools expects, it may force
> guest to upgrade VMware Tools. (See comment above VERSION_MAGIC and
> VmCheck_IsVirtualWorld() function in open-vm-tools open-source code).
>=20
> For better readability and allow maintaining compatability for guests
> which may expect different vmware-vmx-version, make vmware-vmx-version a
> VMPort object property. This would allow user to control it's value via
> "-global vmport.vmware-vmx-version=3DX".
>=20
> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> ---
>   hw/i386/vmport.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
> index e67c7bb2afea..8e662303d5d3 100644
> --- a/hw/i386/vmport.c
> +++ b/hw/i386/vmport.c
> @@ -60,6 +60,8 @@ typedef struct VMPortState {
>       VMPortReadFunc *func[VMPORT_ENTRIES];
>       void *opaque[VMPORT_ENTRIES];
>  =20
> +    uint32_t vmware_vmx_version;
> +
>       uint32_t compat_flags;
>   } VMPortState;
>  =20
> @@ -138,7 +140,7 @@ static uint32_t vmport_cmd_get_version(void *opaque, =
uint32_t addr)
>       X86CPU *cpu =3D X86_CPU(current_cpu);
>  =20
>       cpu->env.regs[R_EBX] =3D VMPORT_MAGIC;
> -    return 6;
> +    return port_state->vmware_vmx_version;
>   }
>  =20
>   static uint32_t vmport_cmd_ram_size(void *opaque, uint32_t addr)
> @@ -200,6 +202,11 @@ static Property vmport_properties[] =3D {
>                       VMPORT_COMPAT_READ_SET_EAX_BIT, true),
>       DEFINE_PROP_BIT("x-signal-unsupported-cmd", VMPortState, compat_fla=
gs,
>                       VMPORT_COMPAT_SIGNAL_UNSUPPORTED_CMD_BIT, true),
> +
> +    /* Default value taken from open-vm-tools code VERSION_MAGIC definit=
ion */
> +    DEFINE_PROP_UINT32("vmware-vmx-version", VMPortState,
> +                       vmware_vmx_version, 6),
> +
>       DEFINE_PROP_END_OF_LIST(),
>   };
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


