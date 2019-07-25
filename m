Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0E0C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:49:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01EB722BED
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01EB722BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqg08-000321-9t
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52893)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <slp@redhat.com>) id 1hqfzu-0002dh-Dc
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1hqfzt-0002bP-4d
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:49:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42165)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1hqfzs-0002ab-UE
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:49:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id x1so1404681wrr.9
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 08:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=zPfIDf8qUP6XWdL5eXrU6bGzGwjw3dw6W185fQhb+z0=;
 b=n5L6/7sNh2o77OkQnqyEQ6jWLXpMChkaReXUJtEiraylGHmRVQ2qyI53H5OsZluFyk
 0DdpSi/ATqwNvfiv+N8zZvU+frdp80tyVHRUM6ZBrDeXsBpLyhbsmuB+fronqQpLn4wa
 ReuR8I3p6YmcZNd5wsdcSyrNPDwEhotxqYCIDPuKkb/FrHpGF2mRcdyNDuOqR+2viJ6a
 uFpOlVMtykJZy9N7k4+vJhw8ltsU3X7y/y10bHZ0/7JQ2ADEyYitMusb9zCtoWT/28Fo
 +p82P8Ydv2nsF3/l9GeC6E0B23Syhop/vL0YUhgK2/WiSMgHElm21CGp1kE6nBV7lzdc
 89LQ==
X-Gm-Message-State: APjAAAVsxwrkt4HjO5NQovxQJej+vxbKXgZU5d6QCmzKtjvllhmYkugC
 R/ty0nNBJSuSMUUwbqZ+x25dsw==
X-Google-Smtp-Source: APXvYqxbiZNzvoBa7y96syLrAt0MPfQ++YL3KtxjKQ98DIvTR2bPGBCS8UTJpf4QsX73x9CJTW8DjQ==
X-Received: by 2002:a5d:618d:: with SMTP id j13mr94497341wru.195.1564069775460; 
 Thu, 25 Jul 2019 08:49:35 -0700 (PDT)
Received: from dritchie.redhat.com (18.red-83-35-20.dynamicip.rima-tde.net.
 [83.35.20.18])
 by smtp.gmail.com with ESMTPSA id n8sm39875379wro.89.2019.07.25.08.49.33
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 08:49:34 -0700 (PDT)
References: <20190725055908-mutt-send-email-mst@kernel.org>
 <CAFEAcA-uDtTFOyTwMY5KtWeqvirxDejQdvnx5OCZ8pyUhKhE+w@mail.gmail.com>
 <87pnlymm47.fsf@redhat.com> <d48da49f-c8d8-00f7-1634-569e8d924b8a@redhat.com>
 <CAJSP0QUJCh-SaZ9NQ+Wr8vr7R+gBsfhYmBrx45B4z2G9v9L=1A@mail.gmail.com>
 <20190725080556-mutt-send-email-mst@kernel.org>
 <CAJSP0QVvnXV8Ha0yaO84qLL6unVroV5GqcuL-x9ruB7o_24WBA@mail.gmail.com>
 <ddc31318-dc52-b9f2-5a9d-bd1fc650df5b@redhat.com> <87muh2mazh.fsf@redhat.com>
 <20190725104721-mutt-send-email-mst@kernel.org>
 <20190725110114-mutt-send-email-mst@kernel.org>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
In-reply-to: <20190725110114-mutt-send-email-mst@kernel.org>
Date: Thu, 25 Jul 2019 17:49:32 +0200
Message-ID: <87k1c6m7w3.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Introduce the microvm machine type
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Maran Wilson <maran.wilson@oracle.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Michael S. Tsirkin <mst@redhat.com> writes:

> On Thu, Jul 25, 2019 at 10:58:22AM -0400, Michael S. Tsirkin wrote:
>> On Thu, Jul 25, 2019 at 04:42:42PM +0200, Sergio Lopez wrote:
>> >=20
>> > Paolo Bonzini <pbonzini@redhat.com> writes:
>> >=20
>> > > On 25/07/19 15:26, Stefan Hajnoczi wrote:
>> > >> The microvm design has a premise and it can be answered definitively
>> > >> through performance analysis.
>> > >>=20
>> > >> If I had to explain to someone why PCI or ACPI significantly slows
>> > >> things down, I couldn't honestly do so.  I say significantly because
>> > >> PCI init definitely requires more vmexits but can it be a small
>> > >> number?  For ACPI I have no idea why it would consume significant
>> > >> amounts of time.
>> > >
>> > > My guess is that it's just a lot of code that has to run. :(
>> >=20
>> > I think I haven't shared any numbers about ACPI.
>> >=20
>> > I don't have details about where exactly the time is spent, but
>> > compiling a guest kernel without ACPI decreases the average boot time =
in
>> > ~12ms, and the kernel's unstripped ELF binary size goes down in a
>> > whooping ~300KiB.
>>=20
>> At least the binary size is hardly surprising.
>>=20
>> I'm guessing you built in lots of drivers.
>>=20
>> It would be educational to try to enable ACPI core but disable all
>> optional features.

I just tried disabling everything that menuconfig allowed me to. Saves
~27KiB and doesn't improve boot time.

> Trying with ACPI_REDUCED_HARDWARE_ONLY would also be educational.

I also tried enabling this one in my original config. It saves ~11.5KiB,
and has on impact on boot time either.

>>=20
>> > On the other hand, removing ACPI from QEMU decreases its initialization
>> > time in ~5ms, and the binary size is ~183KiB smaller.
>>=20
>> Yes - ACPI generation uses a ton of allocations and data copies.
>>=20
>> Need to play with pre-allocation strategies. Maybe something
>> as simple as:
>>=20
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index f3fdfefcd5..24becc069e 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -2629,8 +2629,10 @@ void acpi_build(AcpiBuildTables *tables, MachineS=
tate *machine)
>>      acpi_get_pci_holes(&pci_hole, &pci_hole64);
>>      acpi_get_slic_oem(&slic_oem);
>>=20=20
>> +#define DEFAULT_ARRAY_SIZE 16
>>      table_offsets =3D g_array_new(false, true /* clear */,
>> -                                        sizeof(uint32_t));
>> +                                        sizeof(uint32_t),
>> +                                        DEFAULT_ARRAY_SIZE);
>>      ACPI_BUILD_DPRINTF("init ACPI tables\n");
>>=20=20
>>      bios_linker_loader_alloc(tables->linker,
>>=20
>> will already help a bit.
>>=20
>> >=20
>> > IMHO, those are pretty relevant savings on both fronts.
>> >=20
>> > >> Until we have this knowledge, the premise of microvm is unproven and
>> > >> merging it would be premature because maybe we can get into the same
>> > >> ballpark by optimizing existing code.
>> > >>=20
>> > >> I'm sorry for being a pain.  I actually think the analysis will
>> > >> support microvm, but it still needs to be done in order to justify =
it.
>> > >
>> > > No, you're not a pain, you're explaining your reasoning and that hel=
ps.
>> > >
>> > > To me *maintainability is the biggest consideration* when introducin=
g a
>> > > new feature.  "We can do just as well with q35" is a good reason to
>> > > deprecate and delete microvm, but not a good reason to reject it now=
 as
>> > > long as microvm is good enough in terms of maintainability.  Keeping=
 it
>> > > out of tree only makes it harder to do this kind of experiment.  vir=
tio
>> > > 1 seems to be the biggest remaining blocker and I think it'd be a go=
od
>> > > thing to have even for the ARM virt machine type.
>> > >
>> > > FWIW the "PCI tax" seems to be ~10 ms in QEMU, ~10 ms in the firmwar=
e(*)
>> > > and ~25 ms in the kernel.  I must say that's pretty good, but it's s=
till
>> > > 30% of the whole boot time and reducing it is the hardest part.  If
>> > > having microvm in tree can help reducing it, good.  Yes, it will get
>> > > users, but most likely they will have to support pc or q35 as a fall=
back
>> > > so we could still delete microvm at any time with the due deprecation
>> > > period if it turns out to be a failed experiment.
>> > >
>> > > Whether to use qboot or SeaBIOS for microvm is another story, but it=
's
>> > > an implementation detail as long as the ROM size doesn't change and/=
or
>> > > we don't do versioned machine types.  So we can switch from one to t=
he
>> > > other at any time; we can also include qboot directly in QEMU's tree,
>> > > without going through a submodule, which also reduces the infrastruc=
ture
>> > > needed (mirrors, etc.) and makes it easier to delete it.
>> > >
>> > > Paolo
>> > >
>> > > (*) I measured 15ms in SeaBIOS and 5ms in qboot from the first to the
>> > > last write to 0xcf8.  I suspect part of qboot's 10ms boot time actua=
lly
>> > > end up measured as PCI in SeaBIOS, due to different init order, so t=
he
>> > > real firmware cost of PAM and PCI initialization should be 5ms for q=
boot
>> > > and 10ms for SeaBIOS.
>> >=20
>>=20
>>=20


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl05z4wACgkQ9GknjS8M
AjXaCA//b6k6v7vt63TfOsBd4w/CZsCCPDaV+TEXtFCeeOlnzI1cH3SUmwf/TGwh
xw9sIEjSwzrmp4A+16q2h/l58JY2cn4Qo141SXglgDVrf9iwSEeqBKgFTYXbu+qP
y+8kqUO5OhAMd00jn/KGfj2TGM3eyP25QeWWesOiDoicLkriAih1rwOK3ju8RokC
pC92sq8vhUrIQQkqKP0ucLfeMPpDw2uE/DdsTRZQqzVoxJ3IRxP+izM1Ia6ZkdpK
KKIcOcbCudJob7nxRknv5Va3ycgcjlDQQG+E5jqEj9bUcF5Vuj7xf9uTJHEFPSdL
096vul7BVv7pOdBReGPp/7b9W8BB+TlisNl6rqDijKI8XyEfopTnApkyPabHJxYo
MJ7BaFtxHJb2Ld+c3SdHb18UZiRtGwE5n7vSQioePS5Y0NKK7ItS9HHR/xEFKwnk
P4rgrRuxs2d6IrGgyLMo25p4xdD8ovTbkDClPvsYAPnoRLMvSwtg5Mg7H/4bkVo3
VPqr1So7O11lJ6vBHp0DmUNMI3gKi25wFfo7iqV2GmZzjA7lwhCL8TNWYsPvMXli
pmtNwwm0gN/u5T7remsNABIAhtdZQHpIB9ofK7xRcxuJUfOi2/0WzJlYL7Q0eUsr
5AvG7ZNG0TiUAHxGl6TduIdMup7FTTTyPZT/uNYRlRxi0p43YUo=
=m2CT
-----END PGP SIGNATURE-----
--=-=-=--

