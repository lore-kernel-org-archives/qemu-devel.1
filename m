Received: from eggs.gnu.org ([2001:4830:134:3::10]:52936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1cTRyc-0002J5-W0
	for Qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:30:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1cTRyZ-0006cl-1O
	for Qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:30:59 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:34879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ilg@livius.net>) id 1cTRyY-0006cJ-QN
	for Qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:30:54 -0500
Received: by mail-wm0-x22a.google.com with SMTP id r126so196636832wmr.0
	for <Qemu-devel@nongnu.org>; Tue, 17 Jan 2017 03:30:54 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <CAFEAcA-S6BQnjKQzuKM2SX14qNzt=CV=otOXt_p2usgGS_EHNQ@mail.gmail.com>
Date: Tue, 17 Jan 2017 13:30:48 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <61EE48F6-CBDB-4A57-8884-034D327B0EF7@livius.net>
References: <6205DF8A-7643-432F-88FF-12B1E9DEF5D8@livius.net>
	<CAFEAcA_CDpXqAAJNdSQpk4MKOorDXqUi_AwsevrHk=pnbrS0NQ@mail.gmail.com>
	<277E72EB-288A-498F-9208-99EBF09218A6@livius.net>
	<CAFEAcA_54fL9YHVJLqAZS8p3OftGd-yq7C7k4jSfVGeCzwMPmA@mail.gmail.com>
	<D1505166-849A-439D-8E78-579F708D53BB@livius.net>
	<CAFEAcA-AB98qtJcrLQ=T4PDvg=VM2tTqxALVpZYoYQcd9fySFg@mail.gmail.com>
	<20170117104258.GD2053@work-vm>
	<CAFEAcA-S6BQnjKQzuKM2SX14qNzt=CV=otOXt_p2usgGS_EHNQ@mail.gmail.com>
Subject: Re: [Qemu-devel] CMSIS SVD based peripheral definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, QEMU Developer <Qemu-devel@nongnu.org>


> On 17 Jan 2017, at 13:09, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> losing the license info and attribution

inside the SVD files there is no license info or attribution.

the files themselves were created by the silicon vendors, but are =
distributed by ARM, inside the CMSIS Packs.

the original CMSIS license stated:

---
1.1 CMSIS DELIVERABLES
ARM hereby grants to you, subject to the terms and conditions of this =
Licence, a non-exclusive, non-transferable licence, to use and copy the =
CMSIS Deliverables for the purpose of:

(i) subject to clause 1.5(i), developing, having developed, =
manufacturing, having manufactured, offering to sell, selling, supplying =
or otherwise distributing products that comply with the CMSIS =
Deliverables; ...

1.5 CONDITIONS ON REDISTRIBUTION.

(i) If you distribute (directly or through your customers and authorised =
distributors) the products you have created pursuant to Clause 1.1 (i) =
you agree: (a) not to use ARM=E2=80=99s name, logo or trademarks to =
market any or all of the products created under Clause 1.1 (i); (b) to =
preserve any copyright notices included in the CMSIS Deliverables; and =
(c) to ensure your customers and authorised distributors comply with =
this Clause 1.5(i).
---

starting with CMSIS 5, ARM switched to Apache 2, exactly to relax =
licensing. as far as I can tell, there are no "patent, trademark, and =
attribution notices from the Source form of the Work" related to the SVD =
files.

if ARM wants these files used largely, but FSF refuses them, I think FSF =
has a problem.


regards,

Liviu
