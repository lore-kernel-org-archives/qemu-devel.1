Received: from eggs.gnu.org ([2001:4830:134:3::10]:60176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cristian.ancuta@intel.com>) id 1ebcrs-0005WC-HO
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 20:50:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cristian.ancuta@intel.com>) id 1ebcrp-0001hN-FO
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 20:50:20 -0500
Received: from mga07.intel.com ([134.134.136.100]:2354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cristian.ancuta@intel.com>)
	id 1ebcrp-0001eT-6W
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 20:50:17 -0500
From: "Ancuta, Cristian" <cristian.ancuta@intel.com>
Date: Wed, 17 Jan 2018 01:50:09 +0000
Message-ID: <54990469B118604BB659B7D5A1E9A462323C2A8F@HASMSX111.ger.corp.intel.com>
References: <54990469B118604BB659B7D5A1E9A462323C2A6E@HASMSX111.ger.corp.intel.com>
	<87AE25C4-E8EA-47FB-A23D-25F9F76737D2@livius.net>
In-Reply-To: <87AE25C4-E8EA-47FB-A23D-25F9F76737D2@livius.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] Qemu c++ build question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liviu Ionescu <ilg@livius.net>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi and thanks for the answer,

Yes, not quite what I expected but your suggestion might indeed be the solu=
tion I need.

Even if the problem that I'm encountering doesn't seeem to be related to th=
e one you had, I'd will just export a C interface from the C++ code and kee=
p the two isolated, rather than mess around with the build system since tha=
t looks like it's going nowhere.

Regards,
Cristi

-----Original Message-----
From: Liviu Ionescu [mailto:ilg@livius.net]=20
Sent: Wednesday, January 17, 2018 3:37 AM
To: Ancuta, Cristian <cristian.ancuta@intel.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [Qemu-devel] Qemu c++ build question



> On 17 Jan 2018, at 03:14, Ancuta, Cristian <cristian.ancuta@intel.com> wr=
ote:
>=20
> I'm currently working on implementing an emulation target in QEMU and the=
 implementation is in C++.

it might not be the answer you expect, but last time I tried to do a simila=
r thing I encountered a problem that prevented the direct C++ integration i=
nto QEMU.

I don't know if it is still the case, but a field in one of the main header=
s defining objects was called `class`, a reserved name in C++.

so be sure you isolate the C++ code outside QEMU and access it only via a C=
 interface; also be sure you do not include the QEMU headers in C++ files.


regards,

Liviu
