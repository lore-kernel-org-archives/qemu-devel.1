Received: from eggs.gnu.org ([2001:4830:134:3::10]:45912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eb5tz-0006Kf-Pr
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:38:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eb5tu-0002ct-TY
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:38:19 -0500
References: <1516008655-31732-1-git-send-email-thuth@redhat.com>
	<alpine.BSF.2.21.1801151238370.57536@zero.eik.bme.hu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <57803cc5-9f54-07bc-e18c-0606cb63d6c6@redhat.com>
Date: Mon, 15 Jan 2018 15:38:01 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1801151238370.57536@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 0/2] Clean up the ppc default
 configs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 15.01.2018 13:00, BALATON Zoltan wrote:
> On Mon, 15 Jan 2018, Thomas Huth wrote:
>> ppc64-softmmu is a superset of ppc-softmmu which in turn is a superset
>> of ppcemb-softmmu. But since the config files are currently independen=
t
>> from each other, we missed to define some CONFIG switches in the super=
-
>> sets: CONFIG_SUNGEM is missing from the ppc64-softmmu config, and the
>> CONFIG_IDE_SII3112 switch is only defined in ppcemb-softmmu.
>=20
> I'm not sure about this. The Sun GEM network interface is a device
> typically found on Apple PowerMacs but also seems to be found on G5
> based Macs so it's probably OK to add. The SiI3112 is now only used on
> the (not yet fully merged) Sam460EX emulation which is to be added to
> ppcemb, that's why I've only added it to that target.

But as I wrote: ppc-softmmu is currently a superset of ppcemb-softmmu. I
think people expect to be able to run the same amount of machines with
ppc-softmmu than with ppcemb-softmmu, don't they?

>> (off-topic question: Do we still need a separate ppcemb-softmmu nowada=
ys?
>> It seemed to be useful 10 years ago when everybody was doing KVM on
>> embedded PPC, but these days seem to be pretty much over now, so IMHO
>> just using ppc-softmmu for embedded should be enough nowadays? We coul=
d
>> save quite some compilation- and "make check"-time if we could finally
>> get rid of ppcemb-softmmu again...)
>=20
> I've also noticed that most of the boards were available both in ppcemb
> and ppc targets so maybe these could be merged now to avoid confusion
> but I don't know the reason why ppcemb existed in the first place so I
> don't know what other implications dropping ppcemb may have.

An alternative would be to remove the embedded configs from the
ppc-softmmu.mak and only include them in ppcemb-softmmu.mak, so that
there is a stricter distinction. I think the current situation is rather
confusing, where it is possible that the user could try to run a pseries
machine with an embedded PPC CPU for example ... so strictly separating
the embedded stuff into ppcemb-softmmu would maybe really make sense.

 Thomas
