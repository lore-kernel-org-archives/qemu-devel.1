Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F74C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:21:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E1912087E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0jD673g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1912087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyuOT-0000wL-NI
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 04:21:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58505)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iyuNg-0000DI-0y
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:20:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iyuNe-0001YK-Jn
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:20:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23508
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iyuNe-0001SY-F1
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:20:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580808024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=CHwkULKPnp/HcJlHfyoNgZnIChVCv+ljtStMlOQqL08=;
 b=Q0jD673gKLzbJ7GU+bMM6SalB60NZfLfuR2HPYtbZSsZkX20zj0eHScomZPwTujH/bpFX9
 Mz6/y3r3lfZHMDq0aFm8L+DU4AOPDIeQIDter6O/VCFYqmFSIEBADQXzIWShTutTz00+W+
 0Qo5gz8t/qVCdoHfhhExBojBAGUrBRM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-W7KaUJD5P1i7nwyHwqiCMA-1; Tue, 04 Feb 2020 04:20:20 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1483B1084430;
 Tue,  4 Feb 2020 09:20:19 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-39.ams2.redhat.com [10.36.116.39])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B67E60BF4;
 Tue,  4 Feb 2020 09:20:16 +0000 (UTC)
Subject: Restrictions of libnet (was: Re: VW ELF loader)
To: Cornelia Huck <conny@cornelia-huck.de>
References: <f881c2e7-be92-9695-6e19-2dd88cbc63c1@ozlabs.ru>
 <e3ee4b4d-1b24-2900-4304-05fa521a9b47@redhat.com>
 <20200203012842.GD52446@umbus.fritz.box>
 <ec81cca1-d5fb-3f1e-b433-3328d81a117e@redhat.com>
 <de7e4d34-eb63-904c-3475-7feee154c72c@ozlabs.ru>
 <8420784f-b4c7-9864-8534-b94dbc5f74ff@redhat.com>
 <d63ba962-ffbb-9f27-34fb-657188e90194@ozlabs.ru>
 <CABgObfYwtrh_uy8zFmg2qDjK6iynniN6=jJ9_MKfNxXUaOkPKw@mail.gmail.com>
 <71d1cc16-f07d-481d-096b-17ee326157bb@ozlabs.ru>
 <CABgObfa4tUVBbpBtoY3JFSF8-0mRVxgGbzQokc+JrJGPagwPaQ@mail.gmail.com>
 <d13eea1d-7942-47e0-6189-a66ce9639db4@redhat.com>
 <20200204095403.04d9dd29.conny@cornelia-huck.de>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <4794cf7a-7b53-5fea-c89d-baa01d3ed0ce@redhat.com>
Date: Tue, 4 Feb 2020 10:20:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200204095403.04d9dd29.conny@cornelia-huck.de>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: W7KaUJD5P1i7nwyHwqiCMA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel <qemu-devel@nongnu.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/02/2020 09.54, Cornelia Huck wrote:
> On Tue, 4 Feb 2020 07:16:46 +0100
> Thomas Huth <thuth@redhat.com> wrote:
>=20
>> On 04/02/2020 00.26, Paolo Bonzini wrote:
>>>
>>>
>>> Il mar 4 feb 2020, 00:20 Alexey Kardashevskiy <aik@ozlabs.ru
>>> <mailto:aik@ozlabs.ru>> ha scritto:
>>>
>>>     Speaking seriously, what would I put into the guest?
>>>
>>> Only things that would be considered drivers. Ignore the partitions
>>> issue for now so that you can just pass the device tree services to QEM=
U
>>> with hypercalls.
>>>
>>>     Netboot's dhcp/tftp/ip/ipv6 client? It is going to be another SLOF,
>>>     smaller but adhoc with only a couple of people knowing it.
>>>
>>>
>>> You can generalize and reuse the s390 code. All you have to write is th=
e
>>> PCI scan and virtio-pci setup. =20
>>
>> Well, for netbooting, the s390-ccw bios uses the libnet code from SLOF,
>> so re-using this for a slim netboot client on ppc64 would certainly be
>> feasible (especially since there are also already virtio drivers in SLOF
>> that are written in C), but I think it is not very future proof. The
>> libnet from SLOF only supports UDP, and no TCP. So for advanced boot
>> scenarios like booting from HTTP or even HTTPS, you need something else
>> (i.e. maybe grub is the better option, indeed).
>=20
> That makes me wonder what that means for s390: We're inheriting
> libnet's limitations, but we don't have grub -- do we need to come up
> with something different? Or improve libnet?

I don't think that it makes sense to re-invent the wheel yet another
time and write yet another TCP implementation (which is likely quite a
bit of work, too, especially if you also want to do secure HTTPS in the
end). So yes, in the long run (as soon as somebody seriously asks for
HTTP booting on s390x) we need something different here.

Now looking at our standard s390x bootloader zipl - this has been giving
us a headache a couple of times in the past, too (from a distro point of
view since s390x is the only major platform left that does not use grub,
but also from a s390-ccw bios point of view, see e.g.
https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg03046.html and
related discussions).

So IMHO the s390x world should move towards grub2, too. We could e.g.
link it initially into the s390-ccw bios bios ... and if that works out
well, later also use it as normal bootloader instead of zipl (not sure
if that works in all cases, though, IIRC there were some size
constraints and stuff like that).

Just my 0.02 =E2=82=AC of course, though.

 Thomas


