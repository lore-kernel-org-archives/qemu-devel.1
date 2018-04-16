Received: from eggs.gnu.org ([2001:4830:134:3::10]:35277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1f8DRj-0002u9-Ha
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 19:22:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1f8DRi-0002D2-K5
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 19:22:03 -0400
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:36247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1f8DRi-000275-CD
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 19:22:02 -0400
Received: by mail-ot0-x22b.google.com with SMTP id p2-v6so2567394otf.3
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 16:21:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED539727606@ORSMSX110.amr.corp.intel.com>
References: <20180215210932.15490-1-erik.schmauss@intel.com>
	<CAPcyv4hp_pm2n3H_froFkedd_GMQvsrEc8yZxYzfYkPDYvjDww@mail.gmail.com>
	<CF6A88132359CE47947DB4C6E1709ED5397230D6@ORSMSX110.amr.corp.intel.com>
	<3701399.BBZtpt46yJ@aspire.rjw.lan>
	<CAPcyv4j-iC+b07=JPP_TV1MLHA2iO5iKLvc+jaPHoEuRfzoAFQ@mail.gmail.com>
	<CF6A88132359CE47947DB4C6E1709ED539727606@ORSMSX110.amr.corp.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 16 Apr 2018 16:21:58 -0700
Message-ID: <CAPcyv4jEkQTEWxE=+mf0C5oA0j50ZvjU=QpvL1n6mmtemrnBLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/7] ACPICA: Integrate package handling
 with module-level code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Schmauss, Erik" <erik.schmauss@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Qemu Developers <qemu-devel@nongnu.org>

On Mon, Apr 16, 2018 at 4:15 PM, Schmauss, Erik <erik.schmauss@intel.com> w=
rote:
> [ trimming ]
>> >> Rafael, we may want to hold back on the module-level code changes
>> >> (the patches below) for rc1. Between this and the strange _TSS issue,
>> >> it seems like there are a few more things to resolve before this is
>> >> ready for kernel upstream.
>> >
> Hi Rafael,
>
>> > It looks like you are asking me to queue up reverts as per the Dan's
>> > report, is that correct?
>
> This is indeed what I meant last week. However, I've looked into the issu=
e and Dan's qemu
> instance had AML that we no longer support. This is because the ACPICA co=
mmit makes changes to the execution of AML
> during table load to match windows AML interpreter behavior so this commi=
t also got rid of support for executing code
> containing forward references (except for package elements).
>
> I've suggested a fix for the firmware in a separate email. So I would say=
 that this issue is resolved after if Dan can run
> his test successfully with the adjusted firmware.
>
> If Dan's test is successful, we don=E2=80=99t need to revert these change=
s

I'm concerned about other qemu-kvm users that do not upgrade their
hypervisor at the same pace as their guest kernel. Especially for
cloud providers that may be running latest mainline kernel on older
qemu-kvm this will look like a pure kernel regression. Is there a
quick fix we can carry in the kernel to support these forward
references, at least until we know that qemu-kvm is no longer shipping
the broken AML?
