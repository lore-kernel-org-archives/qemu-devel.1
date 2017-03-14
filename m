Received: from eggs.gnu.org ([2001:4830:134:3::10]:40400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1cnqdQ-0003Bv-O4
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:53:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1cnqdN-0005Nq-Mp
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:53:24 -0400
From: luigi burdo <intermediadc@hotmail.com>
Date: Tue, 14 Mar 2017 17:53:18 +0000
Message-ID: <AM5P194MB01296381B34B809EE439DC29C8240@AM5P194MB0129.EURP194.PROD.OUTLOOK.COM>
References: <36e41adf-b0b3-3efa-51c4-f1a70cd05b98@ilande.co.uk>
	<87wpbsp49a.fsf@linaro.org>
	<6491a446-bf23-5ab9-3431-c67efaf83f71@ilande.co.uk>
	<alpine.BSF.2.20.1703141450560.82811@zero.eik.bme.hu>
	<87shmfq31b.fsf@linaro.org>
	<b9006aa4-b606-61d5-6896-8c76a6a6f8f3@ilande.co.uk>
	<87o9x3pzxe.fsf@linaro.org>,
	<alpine.BSF.2.20.1703141829440.39248@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.20.1703141829440.39248@zero.eik.bme.hu>
Content-Language: it-IT
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] qemu-system-ppc video artifacts since
 "tcg: drop global lock during TCG code execution"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Cc: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>, "cota@braap.org" <cota@braap.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "bobby.prani@gmail.com" <bobby.prani@gmail.com>, "rth@twiddle.net" <rth@twiddle.net>, "fred.konrad@greensocs.com" <fred.konrad@greensocs.com>

Zoltan,

i tested on ppcel  debian there isnt issue reported . i think is only a BE =
issue.


Luigi


Like from the display controller models that use memory_region_get_dirty()
to check if the frambuffer needs to be updated? But all display adaptors
seem to do this and the problem was only seem on ppc so it may be related
to something ppc specific.

Regards,
BALATON Zoltan
