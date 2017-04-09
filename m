Received: from eggs.gnu.org ([2001:4830:134:3::10]:51505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1cx8uX-0000xK-Ng
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 05:13:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1cx8uS-0005Ow-U6
	for qemu-devel@nongnu.org; Sun, 09 Apr 2017 05:13:29 -0400
From: luigi burdo <intermediadc@hotmail.com>
Date: Sun, 9 Apr 2017 08:41:08 +0000
Message-ID: <AM5P194MB01292723DDB978AC78F8FDD7C80E0@AM5P194MB0129.EURP194.PROD.OUTLOOK.COM>
References: <20170407060752.31313-1-nikunj@linux.vnet.ibm.com>,
	<20170408065107.GG27571@umbus>
In-Reply-To: <20170408065107.GG27571@umbus>
Content-Language: it-IT
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 0/3] Enable MTTCG on PPC64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "programmingkidx@gmail.com" <programmingkidx@gmail.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "bharata@linux.vnet.ibm.com" <bharata@linux.vnet.ibm.com>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "rth@twiddle.net" <rth@twiddle.net>

Hi David and Nikuji,

can i suggest to remove the message:


Guest not yet converted to MTTCG - you may get unexpected results
where the mttcg is enabled?

another thing im finding  is this message
Guest expects a stronger memory ordering than the host provides
This may cause strange/hard to debug errors


I have 8 gb on my machine and this message come if i gave 512mb on the gues=
t too.

Is possible know where the mttcg is already enabled?

i see on x86,i386,arm too if i set thread=3Dmulty the qemu start using the =
other host cores is on this guest system enabled?

if yes i have the same messages of ppc64 too :

Guest not yet converted to MTTCG - you may get unexpected results

and

Guest expects a stronger memory ordering than the host provides
This may cause strange/hard to debug errors


Ciao

Luigi


Applied to ppc-for-2.10.  Anyone object to that for 2/3, which isn't
within ppc code?

--
David Gibson
<http://www.ozlabs.org/~dgibson>
