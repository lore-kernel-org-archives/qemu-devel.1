Received: from eggs.gnu.org ([2001:4830:134:3::10]:45278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lists@philjordan.eu>) id 1dYTyI-00089s-3e
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:11:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lists@philjordan.eu>) id 1dYTyH-0005Ue-7D
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:11:42 -0400
Received: from mail-ua0-x232.google.com ([2607:f8b0:400c:c08::232]:38805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lists@philjordan.eu>) id 1dYTyH-0005UP-24
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:11:41 -0400
Received: by mail-ua0-x232.google.com with SMTP id w45so41091048uac.5
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 02:11:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170721110636.19412e6c@nial.brq.redhat.com>
References: <3E24AFDE-D25A-416B-A600-3C2221C3A9F1@gmail.com>
	<CAGCz3vu5x59+mKg8011=DRyZQKbuBV2F20ZpPnG1TOCxsOb+mQ@mail.gmail.com>
	<20170721110636.19412e6c@nial.brq.redhat.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Fri, 21 Jul 2017 11:11:19 +0200
Message-ID: <CAGCz3vuY1TBp6iHNfm73GjVGQVwZkSj_EXnWLhZKBiLzcjPL7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: Programmingkid <programmingkidx@gmail.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>, ehabkost@redhat.com, Richard Henderson <rth@twiddle.net>

On Fri, Jul 21, 2017 at 11:06 AM, Igor Mammedov <imammedo@redhat.com> wrote:
> On Thu, 20 Jul 2017 21:29:33 +0200
> Phil Dennis-Jordan <lists@philjordan.eu> wrote:
>
>> On Thu, Jul 20, 2017 at 6:40 PM, Programmingkid
>> <programmingkidx@gmail.com> wrote:
>> > I noticed that Windows 2000 does not boot up in QEMU recently. After bisecting the issue I found the offending commit:
> w2k is very ancient (and long time EOLed), I can't even download it from msdn to test
> (oldest available is XP)
>
> do we really care about it?

I guess it'd primarily be for software archival/history purposes,
which is a reasonable use case for Qemu. (See efforts to get PPC MacOS
working, etc.)

>> Ouch. I reckon we have 2 options for fixing this:
>>
>> 1. Export two FADTs, one ACPI 1.0, one ACPI 2.0. The latter would need
>> to be pointed to by an XSDT, which Qemu currently doesn't implement at
>> all as far as I'm aware. Any ideas on how SeaBIOS or OVMF would handle
>> this? Any likely other OS regressions?
>>
>> 2. Select FADT version with an option. This one is definitely safe,
>> but adds yet another option.
> the 3rd simpler option is:
>   force rev1 on old machine types (2.9 and older),
>   using machine compat machinery and use rev3 on newer machines

That sounds good, I'd be happy to implement that.

Phil
