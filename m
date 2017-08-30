Received: from eggs.gnu.org ([2001:4830:134:3::10]:46717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nt_mahmood@yahoo.com>) id 1dn45B-0000wH-GC
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:35:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nt_mahmood@yahoo.com>) id 1dn458-0003Os-6v
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:35:05 -0400
Received: from sonic315-8.consmr.mail.gq1.yahoo.com ([98.137.65.32]:34845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nt_mahmood@yahoo.com>)
	id 1dn458-0003NP-1B
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 10:35:02 -0400
Date: Wed, 30 Aug 2017 14:35:00 +0000 (UTC)
From: Mahmood <nt_mahmood@yahoo.com>
Reply-To: Mahmood <nt_mahmood@yahoo.com>
Message-ID: <47171733.403781.1504103700042@mail.yahoo.com>
In-Reply-To: <61cd0715-27e4-7e50-1e85-9da3b4a48bb1@posteo.de>
References: <1915302638.2814146.1504030043465.ref@mail.yahoo.com>
	<1915302638.2814146.1504030043465@mail.yahoo.com>
	<14033890-2a35-666c-2fa7-5a8727090801@tuxfamily.org>
	<1075529669.195794.1504079702032@mail.yahoo.com>
	<bc7bacd9-fec7-c193-6de0-99d1f7fd0f6f@tuxfamily.org>
	<2061420835.208824.1504085337258@mail.yahoo.com>
	<20170830121109.7fab5559@bahia>
	<61cd0715-27e4-7e50-1e85-9da3b4a48bb1@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-discuss] Accessing a shared folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <th.huth@posteo.de>, Greg Kurz <groug@kaod.org>
Cc: Thomas Huth <huth@tuxfamily.org>, QEMU Developers <qemu-devel@nongnu.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>

OK. I reconfigured 2.9.0 with --enable-virtfs. Please note:
1- If I use -virtfs option, I get=20
=C2=A0=C2=A0=C2=A0=C2=A0 qemu-option.c:547: opt_set: Assertion `opt->str' f=
ailed

2- If I use -fsdev and -device, then I *must* use security_model

3- If I use -fsdev and -device and security_model, then the guest boots nor=
mally.

I haven't tried to see if I am able to access the shared folder nor not. Do=
 you have any note on the above items?


Regards,
Mahmood
