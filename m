Received: from eggs.gnu.org ([2001:4830:134:3::10]:47037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dYLMt-00033W-OX
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 20:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dYLMq-0003ld-P8
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 20:00:31 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:37125)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dYLMq-0003lI-KQ
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 20:00:28 -0400
Received: by mail-io0-x244.google.com with SMTP id 5so2759802iow.4
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 17:00:28 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <CAGCz3vu5x59+mKg8011=DRyZQKbuBV2F20ZpPnG1TOCxsOb+mQ@mail.gmail.com>
Date: Thu, 20 Jul 2017 20:00:26 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <957FC5E9-F3ED-444B-A283-0B9B42375428@gmail.com>
References: <3E24AFDE-D25A-416B-A600-3C2221C3A9F1@gmail.com>
	<CAGCz3vu5x59+mKg8011=DRyZQKbuBV2F20ZpPnG1TOCxsOb+mQ@mail.gmail.com>
Subject: Re: [Qemu-devel] Commit 77af8a2b95b79699de650965d5228772743efe84
 breaks Windows 2000 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Phil Dennis-Jordan <lists@philjordan.eu>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, ehabkost@redhat.com, Phil Dennis-Jordan <phil@philjordan.eu>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>


> On Jul 20, 2017, at 3:29 PM, Phil Dennis-Jordan <lists@philjordan.eu> =
wrote:
>=20
> On Thu, Jul 20, 2017 at 6:40 PM, Programmingkid
> <programmingkidx@gmail.com> wrote:
>> I noticed that Windows 2000 does not boot up in QEMU recently. After =
bisecting the issue I found the offending commit:
>=20
> Ouch. I reckon we have 2 options for fixing this:
>=20
> 1. Export two FADTs, one ACPI 1.0, one ACPI 2.0. The latter would need
> to be pointed to by an XSDT, which Qemu currently doesn't implement at
> all as far as I'm aware. Any ideas on how SeaBIOS or OVMF would handle
> this? Any likely other OS regressions?
>=20
> 2. Select FADT version with an option. This one is definitely safe,
> but adds yet another option.
>=20
> Thoughts?

Option 1 sounds good to me.=20=
