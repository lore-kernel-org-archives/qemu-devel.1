Received: from eggs.gnu.org ([2001:4830:134:3::10]:56149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1egW46-0006ag-5c
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 08:35:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1egW40-0006Pk-Kb
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 08:35:10 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:39821)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1egW40-0006Ow-Eb
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 08:35:04 -0500
Date: Tue, 30 Jan 2018 14:35:02 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180130092101.hiuru6lnzbjw2jiy@sirius.home.kraxel.org>
Message-ID: <alpine.BSF.2.21.1801301425250.81470@zero.eik.bme.hu>
References: <CAE5jQCeSL5fRXBh5F9L3G5JkkwmS=sU9VS6Bu82Xpq5fMd=K8Q@mail.gmail.com>
	<20180129082727.jvh4nc2cquuqylrv@sirius.home.kraxel.org>
	<alpine.BSF.2.21.1801291701130.88941@zero.eik.bme.hu>
	<20180130092101.hiuru6lnzbjw2jiy@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] SDL2 UI behavior of switching views
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, 30 Jan 2018, Gerd Hoffmann wrote:
> On Mon, Jan 29, 2018 at 07:21:02PM +0100, BALATON Zoltan wrote:
>> Is there an option also to get back the old SDL1 behaviour with SDL2? Could
>> that be made the default to make the transition easier?
>
> Well, that kind of flexibility is alot harder to do with SDL as it
> doesn't offer widgets to manage views ...

How did it work with SDL1 and what prevents it from working the same way 
with SDL2?

> How about using gtk instead?

That's not a solution to the problem. Why do we have other backends than 
gtk if they aren't meant to be used? (Others already gave reasons to 
prefer SDL over gtk such as leaner, simpler interface which is also faster 
to start up, also useful if one dosen't need any of the frills the gtk 
interface provides or uses QEMU on a low-end system or platform where gtk 
is not supported.)

Regards,
BALATON Zoltan
