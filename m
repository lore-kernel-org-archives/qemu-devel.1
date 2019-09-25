Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AD6C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 06:02:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4319217F4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 06:02:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4319217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD0Nh-0005CU-K3
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 02:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60696)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iD0LH-0004f4-Hg
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 02:00:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iD0LG-0007Us-5b
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 01:59:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56792)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iD0LF-0007Ug-Tj
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 01:59:58 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B4F7E4E908
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 05:59:56 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id a15so1750397wrq.4
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 22:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=2rWQStlWupt/Z24TTL6lXMY4phw4PsYAZ9Oo/jibkfw=;
 b=d9ETamPi6X71dyckz7fGlX5FFjkwGQGRy7jQ0mA00100xNtmB1pR/vqFfUTxsCdM+q
 T+fpPfpYUqUr0TaiXcCfJnGgR06ySLzEiMb5kaXtseH7dTUY2a3LXu+Zpde5yO3GtGtV
 zzxv/SiiN4vhKvfwK+xsmYhLp3HpV4ni+gtu7pCrRkGyiWL0Lpu6FPo24sHQlnFjt9Dp
 m1F9YYW28tyWptPHd/bdxblfoiRBIp9tYSrPK5iKk76zPyFf1r84kN3wIDBa7yQHGy3F
 X/qGaSs7uaCOhN20VSy4Y6IVb6uTFgQep1pvHzHpy4Y2xFQQfzefjW9u2wR3XF/36HB7
 YGfQ==
X-Gm-Message-State: APjAAAX2Dhn4h+vpDZQm977jBxA/u2LHSs8emu9g1PFyedYSbCC7LzBB
 3sissYgOQJA97e44n7AfQcBk2tLBPzI4svl0ye0YPDc4lp/Au72G3Vlb5ZpsA/yJVG4aSi6tojJ
 Ym0u/CT6hp6ykIqI=
X-Received: by 2002:a7b:cc0c:: with SMTP id f12mr5292522wmh.105.1569391195505; 
 Tue, 24 Sep 2019 22:59:55 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxYsg3NHkzxXtluX8/5dWZw8dizHFTfjE4iL5oJt5hPO61FZNhNsb/+TrfEACW6zW6l6rhI7A==
X-Received: by 2002:a7b:cc0c:: with SMTP id f12mr5292506wmh.105.1569391195327; 
 Tue, 24 Sep 2019 22:59:55 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id z142sm5548158wmc.24.2019.09.24.22.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 22:59:54 -0700 (PDT)
References: <20190924124433.96810-1-slp@redhat.com>
 <20190924124433.96810-9-slp@redhat.com>
 <20190924092435-mutt-send-email-mst@kernel.org>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 8/8] hw/i386: Introduce the microvm machine type
In-reply-to: <20190924092435-mutt-send-email-mst@kernel.org>
Date: Wed, 25 Sep 2019 07:59:52 +0200
Message-ID: <87muessyp3.fsf@redhat.com>
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


Michael S. Tsirkin <mst@redhat.com> writes:

> On Tue, Sep 24, 2019 at 02:44:33PM +0200, Sergio Lopez wrote:
>> +static void microvm_fix_kernel_cmdline(MachineState *machine)
>> +{
>> +    X86MachineState *x86ms = X86_MACHINE(machine);
>> +    BusState *bus;
>> +    BusChild *kid;
>> +    char *cmdline;
>> +
>> +    /*
>> +     * Find MMIO transports with attached devices, and add them to the kernel
>> +     * command line.
>> +     *
>> +     * Yes, this is a hack, but one that heavily improves the UX without
>> +     * introducing any significant issues.
>> +     */
>> +    cmdline = g_strdup(machine->kernel_cmdline);
>> +    bus = sysbus_get_default();
>> +    QTAILQ_FOREACH(kid, &bus->children, sibling) {
>> +        DeviceState *dev = kid->child;
>> +        ObjectClass *class = object_get_class(OBJECT(dev));
>> +
>> +        if (class == object_class_by_name(TYPE_VIRTIO_MMIO)) {
>> +            VirtIOMMIOProxy *mmio = VIRTIO_MMIO(OBJECT(dev));
>> +            VirtioBusState *mmio_virtio_bus = &mmio->bus;
>> +            BusState *mmio_bus = &mmio_virtio_bus->parent_obj;
>> +
>> +            if (!QTAILQ_EMPTY(&mmio_bus->children)) {
>> +                gchar *mmio_cmdline = microvm_get_mmio_cmdline(mmio_bus->name);
>> +                if (mmio_cmdline) {
>> +                    char *newcmd = g_strjoin(NULL, cmdline, mmio_cmdline, NULL);
>> +                    g_free(mmio_cmdline);
>> +                    g_free(cmdline);
>> +                    cmdline = newcmd;
>> +                }
>> +            }
>> +        }
>> +    }
>> +
>> +    fw_cfg_modify_i32(x86ms->fw_cfg, FW_CFG_CMDLINE_SIZE, strlen(cmdline) + 1);
>> +    fw_cfg_modify_string(x86ms->fw_cfg, FW_CFG_CMDLINE_DATA, cmdline);
>> +}
>
> Can we rearrange this somewhat? Maybe the mmio constructor
> would format the device description and add to some list,
> and then microvm would just get stuff from that list
> and add it to kernel command line?
> This way it can also be controlled by a virtio-mmio property, so
> e.g. you can disable it per device if you like.
> In particular, this seems like a handy trick for any machine type
> using mmio.

Disabling it per-device won't be easy, as transport options can't be
specified using the underlying device properties.

But, otherwise, sounds like a good idea to avoid having to traverse the
qtree. I'll give it a try.

Thanks,
Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2LAlgACgkQ9GknjS8M
AjUhcA//eFnLyXm4bKxsytJSS/e8bSAYiTJvcfXB3XqLuCJaYyyIbrwu6B0Pxhaa
b8INN/koJiPKPwvfLtbUm8vf0Rwq4oDfEPpfd0xZ4+hf3RzpzUFAiqz6OP8gTtgf
fWmwU6/07gYOLUcUuokwI+7FZpN55BYnkA2cer3Qx5kw1jkvq8TO6C1SDVbC8o4H
eTSb8SHVZeoysvn9CLnjZxXXKuP/SWHrHUtj2BIS8ThQyn17mB5BVdU9d/ym2AxK
ygEU6DN7Rc6lZxVkqXW2kVloe4o+5KRU0zNxp8Zxr6U/6af0U61lvMFQLb7PrSW2
Yd/VSoEmiR2MqCMt8QPo1CqYaU1QBRvz4h7JFp0ynxPJbWDpLCdC4vKNWM/7+7gC
R/KR3SLOD7/uIabyxpMPZCZB34K0noiI6Go0eU/J+4gkOGLkAbHoBJTRqvnGgwi9
TdB2j5lEllJwzABTJo21mR5KvRfGuPsVss9TfBRj8w0OHt7tMEb4ATGq/7WiqmVU
eLfQr9LngtFMIseXcgc1uXyIMyVxWyQUVxJj7KqxdXylrOL7djiRoq+++CD1RSGc
Wx/IS6Vqg66lvMPjLpBHPBbdzzmMoxBjEk0lpgDuFlLyeRYINvohQEbDjuOC/iTj
rRvhwLDvGd/F+S3Es5PHy/PT10SXNKzmMYogvhtLxWByjcAdCwc=
=00LM
-----END PGP SIGNATURE-----
--=-=-=--

