Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0DECA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:08:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2D4A20659
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+8upvVG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D4A20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMXPq-0001jD-Ql
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 09:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iMXP9-0001GI-KV
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:07:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iMXP4-0001ap-BF
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:07:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25619
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iMXP4-0001aP-7D
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571663236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/cXu9p7b7XdxbJhQdo/kXErtTybh4+6sEA780OIC50M=;
 b=N+8upvVGsW/WCI1Bs3AQHFUIWS+/UzSJE0HsCS9nIVPzcS3yuUPWSMtSfbFhQCcDykKLz7
 U3YOQqrAGrPF+Ii2lYkoyZT0DzgSKkNQadD5J50OH+dwLd7vv9gjZEUeRk3QWam0g/4Sh7
 XpDgSg2v09Im6Ygz/WuUbmiDetOcXfM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-pQvQMpj2OiGSC_33gc0ASw-1; Mon, 21 Oct 2019 09:07:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C69D800D41;
 Mon, 21 Oct 2019 13:07:12 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-225.ams2.redhat.com
 [10.36.116.225])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 44D485C207;
 Mon, 21 Oct 2019 13:06:59 +0000 (UTC)
Subject: Re: [RFC 3/3] acpi: cpuhp: add CPHP_GET_CPU_ID_CMD command
To: Igor Mammedov <imammedo@redhat.com>
References: <20191009132252.17860-1-imammedo@redhat.com>
 <20191009132252.17860-4-imammedo@redhat.com>
 <802d0d69-d478-76f5-2bd6-5ad2f1ac4474@redhat.com>
 <20191018181841.6459533a@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <78f49b7d-6fd9-c977-8fe9-2de78025003d@redhat.com>
Date: Mon, 21 Oct 2019 15:06:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191018181841.6459533a@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: pQvQMpj2OiGSC_33gc0ASw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Igor,

On 10/18/19 18:18, Igor Mammedov wrote:
> On Thu, 10 Oct 2019 16:56:18 +0200
> Laszlo Ersek <lersek@redhat.com> wrote:

[...]

>> Right now, I can't offer testing for patch#3 (I'm quite far from the
>> point where I'll be actually looking for a hotplugged CPU :) ), but
>> based on the docs patches #1 and #2, and my proposed updates, I can
>> rework my "possible CPU count detection" in OVMF.
>>
>> Do I need to check in OVMF specifically whether the "modern" CPU hotplug
>> register block is available? Can you tell me what the oldest machine
>> types are that support the modern interface?
> See 679dd1a95 (pc: use new CPU hotplug interface since 2.7 machine type)
>=20
>=20
>> Hmm... Commit abd49bc2ed2f ("docs: update ACPI CPU hotplug spec with new
>> protocol", 2016-06-24) seems relevant. First released in v2.7.0. I think
>> I should detect whether this interface is available.
> Can you make detection based on QEMU version (is dynamic detection really=
 necessary)?

Thanks for following up on this; indeed it has been my remaining open
question in this thread.

I attempted to investigate a bit myself a few days ago, and indeed I can
now find the commit hash "679dd1a95" in my bash history.

So... If I can somehow query the QEMU machine type version -- or
emulator version? -- inside the guest, I'm perfectly happy using that. I
don't need dynamic detection specifically for this feature, I just need
something to deduce the feature from.

The problem is that the "possible CPU count" determination would run in
OVMF in every case, regardless of whether OVMF was built with -D
SMM_REQUIRE, and regardless of board type (q35 vs. i440fx). Requiring
QEMU v2.7.0 or later just for booting OVMF would be a bit steep.

So the idea is:
- check (somehow) if QEMU has the modern hotplug register block
  - available: great, now set the boot CPU count and the possible CPU
               count independently of each other
  - otherwise: set both values to the boot CPU count (which we can fetch
               from fw_cfg, like we've always done)


>> Can I use the following sequence to detect whether the interface is
>> available?
>>
>> 1. Store 0x0 to command register.
>> 2. Store 0x0 to selector register.
>> 3. Read 'command data' register.
>> 4. If value read is 0, the interface is available.
>=20
> By default legacy register block layout is in place
> (i.e. present cpus bitmap) where 1st byte is guarantied to be ">0" as it =
has
> at least the boot CPU bit set and writes to legacy bitmap are ignored.
>=20
> Currently AML code code does switching to modern interface, see
> docs/specs/acpi_cpu_hotplug.txt:
> "
>   The first DWORD in bitmap is used in write mode to switch from legacy  =
       =20
>   to new CPU hotplug interface, write 0 into it to do switch.
> "
> related code "if (opts.has_legacy_cphp) {" and cpu_status_write()
>=20
> Considering firmware runs the first, it should enable modern interface
> on its own
>   1. Store 0x0 to selector register (actually it's store into bitmap to a=
ttempt switch).=20
> and to check if interface is present
>   2. Store 0x0 to selector register (to ensure valid selector value (othe=
rwise command is ignored))
>   3. Store 0x0 to command register (to be able to read back selector from=
 command data)
>   4. Store 0x0 to selector register (because #3 can select the a cpu with=
 events if any)
>       be aware libvirt may start QEMU in paused mode (hotplug context) an=
d hotplugs extra CPUs
>       with device_add and then let guest run. So firmware may see present=
 CPUs with events
>       at boot time.
>   5. Read 'command data' register.
>   6. If value read is 0, the interface is available.

Perfect!

Basically this is prepending two "write 0 to selector register" steps to
what I suspected. I certainly couldn't figure out the "switch to modern"
step, and whether initializing the selector to something valid was
needed at boot. Now I know. :) Thanks!

>=20
>> (Because I assume that unmapped IO ports read as all-bits-one. Is that
>> right?)
> that's right but ports are mapped to legacy CPU bitmap, you can't count o=
n all-bits-one case here.
>=20
>> BTW, can I dynamically detect support for the GET_CPU_ID command too?
>> I'm thinking, when I enumerate / count all possible CPUs, I can at once
>> fetch the arch IDs for all of them. If I only get zeros from the command
>> data registers, across all CPUs, in response to GET_CPU_ID, then the
>> command is not available.
>=20
> APICID =3D=3D 0 is valid value, so one would be need to account for ' -sm=
p 1 '
> case where the only valid selector is 0 that leads to APIC ID =3D 0
>=20
> If counted maxcpus > 1, then what you suggest will work
> if you pick the last CPU (apic id !=3D 0). (at least for x86 guest,
> I don't know if it's fine wrt ARM guest)
>=20
> May be dynamic detection is just over-engineering.

Dynamically detecting the presence of the GET_CPU_ID command is not
important. That's because GET_CPU_ID is for a new use case (CPU hotplug
with SMM), which has never worked before. So we can't regress it.

We'll just modify the OvmfPkg/README file to spell out the minimum
machine type requirement:

  don't try to hotplug a CPU when running OVMF built with SMM_REQUIRE,
  unless your machine type is pc-q35-4.2+

which is exactly what we did for base SMM:

  * The minimum required QEMU machine type is "pc-q35-2.5".

The "possible CPU count" determination is more risky because that will
modify a code path that's active on every boot, in every possible
environment.

I think I can rework my OVMF series for the "possible CPU count"
fetching now.

Thank you!
Laszlo


