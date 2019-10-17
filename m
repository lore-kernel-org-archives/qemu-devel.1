Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BD8ECE58D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:59:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9262020872
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9262020872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL97K-0000UM-8O
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 12:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37285)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iL8Tt-0007PN-7W
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iL8Tr-0003P2-TG
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:18:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54292)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iL8Tr-0003NQ-Ke
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:18:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3D902307F5ED
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 16:18:25 +0000 (UTC)
Received: from thuth.remote.csb (dhcp-200-228.str.redhat.com [10.33.200.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D67960605;
 Thu, 17 Oct 2019 16:18:19 +0000 (UTC)
Subject: Re: [PATCH v2 7/7] libqos: add VIRTIO PCI 1.0 support
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20191011085611.4194-1-stefanha@redhat.com>
 <20191011085611.4194-8-stefanha@redhat.com>
 <e7821640-de44-5e65-b9c1-2534dc676690@redhat.com>
 <20191017160735.GB1266@stefanha-x1.localdomain>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat
Message-ID: <d803e58f-f0cc-b13b-6041-682497c6fe2f@redhat.com>
Date: Thu, 17 Oct 2019 18:18:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191017160735.GB1266@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cvpdHe8r5HSf6XnSjMzJ8D0uUM3CjPKgX"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 17 Oct 2019 16:18:25 +0000 (UTC)
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cvpdHe8r5HSf6XnSjMzJ8D0uUM3CjPKgX
Content-Type: multipart/mixed; boundary="bBlQtQpg1J4G0ykrldUVMLFLHi6gVmpeB";
 protected-headers="v1"
From: Thomas Huth <thuth@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <d803e58f-f0cc-b13b-6041-682497c6fe2f@redhat.com>
Subject: Re: [PATCH v2 7/7] libqos: add VIRTIO PCI 1.0 support
References: <20191011085611.4194-1-stefanha@redhat.com>
 <20191011085611.4194-8-stefanha@redhat.com>
 <e7821640-de44-5e65-b9c1-2534dc676690@redhat.com>
 <20191017160735.GB1266@stefanha-x1.localdomain>
In-Reply-To: <20191017160735.GB1266@stefanha-x1.localdomain>

--bBlQtQpg1J4G0ykrldUVMLFLHi6gVmpeB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17/10/2019 18.07, Stefan Hajnoczi wrote:
> On Thu, Oct 17, 2019 at 04:52:54PM +0200, Thomas Huth wrote:
>> On 11/10/2019 10.56, Stefan Hajnoczi wrote:
>>> Implement the VIRTIO 1.0 virtio-pci interface.  The main change here =
is
>>> that the register layout is no longer a fixed layout in BAR 0.  Inste=
ad
>>> we have to iterate of PCI Capabilities to find descriptions of where
>>> various registers are located.  The vring registers are also more
>>> fine-grained, allowing for more flexible vring layouts, but we don't
>>> take advantage of that.
>>>
>>> Note that test cases do not negotiate VIRTIO_F_VERSION_1 yet and are
>>> therefore not running in VIRTIO 1.0 mode.
>>>
>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> ---
>>>  tests/Makefile.include           |   1 +
>>>  tests/libqos/virtio-pci-modern.h |  17 ++
>>>  tests/libqos/virtio-pci.h        |  10 +
>>>  tests/libqos/virtio-pci-modern.c | 412 +++++++++++++++++++++++++++++=
++
>>>  tests/libqos/virtio-pci.c        |   6 +-
>>>  5 files changed, 445 insertions(+), 1 deletion(-)
>>>  create mode 100644 tests/libqos/virtio-pci-modern.h
>>>  create mode 100644 tests/libqos/virtio-pci-modern.c
>> [...]
>>> +static bool probe_device_type(QVirtioPCIDevice *dev)
>>> +{
>>> +    uint16_t vendor_id;
>>> +    uint16_t device_id;
>>> +
>>> +    /* "Drivers MUST match devices with the PCI Vendor ID 0x1AF4" */=

>>> +    vendor_id =3D qpci_config_readw(dev->pdev, PCI_VENDOR_ID);
>>> +    if (vendor_id !=3D 0x1af4) {
>>> +        return false;
>>> +    }
>>> +
>>> +    /*
>>> +     * "Any PCI device with ... PCI Device ID 0x1000 through 0x107F =
inclusive
>>> +     * is a virtio device"
>>> +     */
>>> +    device_id =3D qpci_config_readw(dev->pdev, PCI_DEVICE_ID);
>>> +    if (device_id < 0x1000 || device_id > 0x107f) {
>>> +        return false;
>>> +    }
>>> +
>>> +    /*
>>> +     * "Devices MAY utilize a Transitional PCI Device ID range, 0x10=
00 to
>>> +     * 0x103F depending on the device type"
>>> +     */
>>> +    if (device_id < 0x1040) {
>>> +        /*
>>> +         * "Transitional devices MUST have the PCI Subsystem Device =
ID matching
>>> +         * the Virtio Device ID"
>>> +         */
>>> +        dev->vdev.device_type =3D qpci_config_readw(dev->pdev, PCI_S=
UBSYSTEM_ID);
>>
>> Shouldn't you return "false" here in case the device_type is 0 ? Which=

>> likely means that it is a legacy or broken device ...?
>=20
> The real decision whether to use this PCI device or not happens in
> probe_device_layout().  If it's broken or a legacy device then that
> function will fail.

Ok, fair.

I've added the patches to my qtest-next branch:

https://gitlab.com/huth/qemu/tree/qtest-next

 Thomas




--bBlQtQpg1J4G0ykrldUVMLFLHi6gVmpeB--

--cvpdHe8r5HSf6XnSjMzJ8D0uUM3CjPKgX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJ7iIR+7gJQEY8+q5LtnXdP5wLbUFAl2olEoACgkQLtnXdP5w
LbWiMA//YSBgvFMwejxpKsfQS9z4S3GyFMi6Q9l+DOKC3RG7vkl46fEmRm/U31j8
OZGwQKvPQiHF0fgiW2MjKpyGn9MOnHUvrupuFOC4cfNxBUxR2lnfJY3J6hO8s671
5RO8dkgBSpulVnueaVH+njxXAuQvpgmH0hY8FY0FTWNWx3BJUSiIbTX7OmuqTNki
USXQZPWIWIBx7PJzTIXwASJNiUTemAFuUOK3ikaocGSOs/vOsZJGJsMiYJZ0hrd6
c8B3Q3u5nFh6tyqfKTXx0hu/2yNS+XlvrPu0Sn/cF5yiOz20g9dAY+/6oQh3cwgJ
S0SYaF0UB+Dgrn7tJENdvRG3C5y6Qixhs8q5Miw/rt6+1P2E4x+hz8bbQGi81n8D
nGSxAEwmYAYQVcgw28wKwdQWoYst+EMdjIPKnYvLaaK5HIFKw7m7Za9a8m+J7EZW
fYNkMCa/zWz7+caSM8HonoWRQWqRX3ZzNOGCUTH+X4LbCwZTIL7PE0ml7QU0wJ6A
mLsiZ2/9jDewvHbC5gsYUk3VEsWveqM2mPRHlvwm6ttF/PLN7KGGISFN2j8go4uJ
N02TqwBrIwqsd7t3J5uroeN49bVKfrw+lnTDTo6+v8lBHTjlcFlBbeAoXfEg6RDH
eFqIlF3KacbbPDtRW9xQIBYaXL/qGqaPNOdYrraFRfbYdiV1DLc=
=AMK+
-----END PGP SIGNATURE-----

--cvpdHe8r5HSf6XnSjMzJ8D0uUM3CjPKgX--

