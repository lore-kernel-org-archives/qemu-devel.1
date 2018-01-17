Received: from eggs.gnu.org ([2001:4830:134:3::10]:55396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1ebceo-0001jc-0s
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 20:36:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1ebcek-0001Lb-Ue
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 20:36:50 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:38518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ilg@livius.net>) id 1ebcek-0001Il-Lh
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 20:36:46 -0500
Received: by mail-wm0-x235.google.com with SMTP id 141so12283807wme.3
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 17:36:46 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <54990469B118604BB659B7D5A1E9A462323C2A6E@HASMSX111.ger.corp.intel.com>
Date: Wed, 17 Jan 2018 03:36:42 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <87AE25C4-E8EA-47FB-A23D-25F9F76737D2@livius.net>
References: <54990469B118604BB659B7D5A1E9A462323C2A6E@HASMSX111.ger.corp.intel.com>
Subject: Re: [Qemu-devel] Qemu c++ build question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Ancuta, Cristian" <cristian.ancuta@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



> On 17 Jan 2018, at 03:14, Ancuta, Cristian <cristian.ancuta@intel.com> =
wrote:
>=20
> I'm currently working on implementing an emulation target in QEMU and =
the implementation is in C++.

it might not be the answer you expect, but last time I tried to do a =
similar thing I encountered a problem that prevented the direct C++ =
integration into QEMU.

I don't know if it is still the case, but a field in one of the main =
headers defining objects was called `class`, a reserved name in C++.

so be sure you isolate the C++ code outside QEMU and access it only via =
a C interface; also be sure you do not include the QEMU headers in C++ =
files.


regards,

Liviu
