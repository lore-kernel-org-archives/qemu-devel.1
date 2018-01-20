Received: from eggs.gnu.org ([2001:4830:134:3::10]:43008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1eczh9-0004iE-3T
	for qemu-devel@nongnu.org; Sat, 20 Jan 2018 15:24:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1eczh7-0003sW-UM
	for qemu-devel@nongnu.org; Sat, 20 Jan 2018 15:24:55 -0500
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:43373)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1eczh7-0003ro-P2
	for qemu-devel@nongnu.org; Sat, 20 Jan 2018 15:24:53 -0500
Received: by mail-io0-x243.google.com with SMTP id 72so5603916iom.10
	for <qemu-devel@nongnu.org>; Sat, 20 Jan 2018 12:24:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <600435fb-6f8d-bc47-224a-b32c1e167d0a@ilande.co.uk>
References: <151592855528.545.6795538165308775542@5adcb62bf0d6>
	<a2ccd140-d2ce-bda4-f48a-fff88b3977bb@ilande.co.uk>
	<2b2111a3-2a85-3f72-b5e4-f0bb6d31ccb5@amsat.org>
	<600435fb-6f8d-bc47-224a-b32c1e167d0a@ilande.co.uk>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Sat, 20 Jan 2018 21:24:32 +0100
Message-ID: <CACXAS8CwLAZDes4RJPtGhc21Z5A591A-YEg3ssYdjwU1-N5w6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/11] sun4u: APB tidy-up/rename and
 tracepoint conversions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, qemu-devel <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>

On Mon, Jan 15, 2018 at 7:38 PM, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> On 14/01/18 13:25, Philippe Mathieu-Daud=C3=A9 wrote:
>
>> On 01/14/2018 08:21 AM, Mark Cave-Ayland wrote:
>>>
>>> On 14/01/18 11:15, no-reply@patchew.org wrote:
>>>>
>>>> Hi,
>>>>
>>>> This series seems to have some coding style problems. See output below
>>>> for
>>>> more information:
>>>>
>>>> Type: series
>>>> Message-id: 20180114104751.21965-1-mark.cave-ayland@ilande.co.uk
>>>> Subject: [Qemu-devel] [PATCH 00/11] sun4u: APB tidy-up/rename and
>>>> tracepoint conversions
>>>
>>>
>>> (lots cut)
>>>
>>>> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
>>>> Checking PATCH 1/11: apb: split simba PCI bridge into
>>>> hw/pci-bridge/simba.c...
>>>> Checking PATCH 2/11: simba: rename PBMPCIBridge and QOM types to
>>>> reflect simba naming...
>>>> Checking PATCH 3/11: apb: rename APB functions to use sabre prefix...
>>>> Checking PATCH 4/11: apb: change pbm_pci_host prefix functions to use
>>>> sabre_pci prefix...
>>>> Checking PATCH 5/11: apb: QOMify sabre PCI host bridge...
>>>> Checking PATCH 6/11: apb: rename QOM type from TYPE_APB to TYPE_SABRE.=
..
>>>> Checking PATCH 7/11: sun4u: rename apb variables and constants...
>>>> Checking PATCH 8/11: apb: rename apb.c to sabre.c...
>>>> ERROR: do not use C99 // comments
>>>> #86: FILE: hw/pci-host/sabre.c:41:
>>>> +//#define DEBUG_SABRE
>>>>
>>>> total: 1 errors, 0 warnings, 188 lines checked
>>>>
>>>> Your patch has style problems, please review.  If any of these errors
>>>> are false positives report them to the maintainer, see
>>>> CHECKPATCH in MAINTAINERS.
>>>>
>>>> Checking PATCH 9/11: pci: add trace-events support for hw/pci-host...
>>>> Checking PATCH 10/11: sabre: convert from SABRE_DPRINTF macro to
>>>> trace-events...
>>>> Checking PATCH 11/11: sparc64: convert hw/sparc64/sparc64.c from
>>>> DPRINTF macros to trace events...
>>>> =3D=3D=3D OUTPUT END =3D=3D=3D
>>>>
>>>> Test command exited with code: 1
>>>
>>>
>>> This is fine - it's just a side-effect of renaming DEBUG_APB to
>>> DEBUG_SABRE as part of the APB to sabre rename, and in fact this code i=
s
>>> completely removed in patch 10 with the conversion to tracepoints.
>>
>>
>> This can be avoided moving patch #8 after #10, although not worthy IMHO.
>
>
> Thanks once again for the review. It was quite a tricky patchset to order=
 in
> the end because of the rename, and there wasn't really one ordering which=
 I
> found completely satisfactory.
>
> Given that you're generally happy with the patches, I'm inclined to keep =
the
> patchset in its current form, pending any further comments from Artyom.
>

The whole series does look good to me. The new naming conventions are
really a lot cleaner than what we used to have. Well done!

Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>


--=20
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu
