Received: from eggs.gnu.org ([2001:4830:134:3::10]:39910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gXpqT-0007DE-Ts
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 10:57:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gXpqP-0002pN-UT
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 10:57:45 -0500
Received: from mail-eopbgr720100.outbound.protection.outlook.com
	([40.107.72.100]:29887
	helo=NAM05-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aaron@os.amperecomputing.com>)
	id 1gXpqM-0002WL-Pb
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 10:57:40 -0500
From: Aaron Lindsay <aaron@os.amperecomputing.com>
Date: Fri, 14 Dec 2018 15:57:32 +0000
Message-ID: <20181214155724.GB4314@quinoa.localdomain>
References: <20181209193749.12277-1-cota@braap.org>
	<20181209193749.12277-6-cota@braap.org>
In-Reply-To: <20181209193749.12277-6-cota@braap.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <33A6DF2BCD26C54EBEBC2348A2155223@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC v2 05/38] plugin: add user-facing API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

Emilio,

First, thanks for putting this together - I think everyone doing this
sort of thing will benefit if we're able to agree on one upstream plugin
interface.

One thing I'd like to see is support for unregistering callbacks once
they are registered. For instance, you can imagine that a plugin may
have 'modality', where it may care about tracing very detailed
information in one mode, but trace only limited information otherwise -
perhaps only enough to figure out when it needs to switch back to the
other mode.

I added a function to the user-facing plugin API in my own version of
Pavel's plugin patchset to clear all existing plugin instrumentation,
allowing the plugin to drop instrumentation if it was no longer
interested. Of course, you could always add logic to a plugin to ignore
unwanted callbacks, but it could be significantly more efficient to
remove them entirely. In Pavel's patchset, this was essentially just a
call to tb_flush(), though I think it would be a little more involved
for yours.

-Aaron
