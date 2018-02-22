Received: from eggs.gnu.org ([2001:4830:134:3::10]:37792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eolIG-0008OS-SY
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 02:27:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eolID-00070t-Pd
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 02:27:52 -0500
References: <cover.1519150239.git.balaton@eik.bme.hu>
	<CAFEAcA8UnMNoGbpx+Mhh8AT9MfOMuUZvMd139tGQFokTAWqWpA@mail.gmail.com>
	<20180220204450.GA27101@flamenco>
	<CAFEAcA-p_og1Dc3DOTbAYofqAUEn0rnuuizoU8xtWrtOtzpp-w@mail.gmail.com>
	<alpine.BSF.2.21.1802211754370.60913@zero.eik.bme.hu>
	<CAFEAcA-UaWGqLHfN_Z7h+C-k=1A5ic_REaWUu0-w19ALcNJy_A@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e300f9da-8a47-7c0f-71db-2e5227c0c275@redhat.com>
Date: Thu, 22 Feb 2018 08:27:36 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-UaWGqLHfN_Z7h+C-k=1A5ic_REaWUu0-w19ALcNJy_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 0/2] Firmware blob and git
 submodule for Sam460ex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>, qemu-ppc@nongnu.org, Francois Revol <revol@free.fr>, David Gibson <dgibson@redhat.com>

On 21.02.2018 19:33, Peter Maydell wrote:
> On 21 February 2018 at 17:06, BALATON Zoltan <balaton@eik.bme.hu> wrote=
:
>> It's not that upstream u-boot has abandoned board support (it only rem=
oved
>> support for the PPC440 CPU it once had). The board itself never had su=
pport
>> in upstream u-boot, it only exists in vendor's fork which is the reaso=
n we
>> need a separate source and cannot use upstream u-boot source we alread=
y
>> have.
>>
>> In my opinion we don't aim to take on support for this board in u-boot=
, we
>> only need to include the firmware binary for the emulation to be usefu=
l
>> which then requires us to also include the source for the GPL it's lic=
ensed
>> under. I've also found a few bugs in the firmware which I've fixed but=
 apart
>> from such occasional bug fixes when needed I don't expect to take over
>> support for the board from the hardware vendor so this source is only =
so we
>> can include the firmware binary which is needed for the board emulatio=
n.
>> Does this answer your concerns?
>=20
> We have lots of boards we don't ship firmware blobs for and
> which we expect the users to provide the guest code for
> if they're going to use them.

... which is also somewhat unfortunate. Have you ever tried to run one
of those boards to see whether you've broken something with your code
changes or not? Hunting the firmware for such a board can be quite
challenging. I'm not saying that we should now try to include way more
firmware blobs in our repository (its size would explode, I guess), but
maybe we should at least start a Wiki page with links to the various
firmware images or so?

 Thomas
