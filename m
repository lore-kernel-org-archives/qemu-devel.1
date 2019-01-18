Received: from eggs.gnu.org ([209.51.188.92]:38296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mkletzan@redhat.com>) id 1gkSNL-0005ZL-1m
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:31:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mkletzan@redhat.com>) id 1gkSNK-0002vV-25
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:31:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mkletzan@redhat.com>) id 1gkSNJ-0002ua-QE
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:31:50 -0500
Date: Fri, 18 Jan 2019 12:31:38 +0100
From: Martin Kletzander <mkletzan@redhat.com>
Message-ID: <20190118113138.GA8296@wheatley>
References: <20190118093935.GA1142@beluga.usersys.redhat.com>
	<20190118101638.GE20660@redhat.com>
	<20190118111150.GA28476@wheatley>
	<20190118111711.GJ20660@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <20190118111711.GJ20660@redhat.com>
Subject: Re: [Qemu-devel] AMD SEV's /dev/sev permissions and probing QEMU
 for capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Erik Skultety <eskultet@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org, brijesh.singh@amd.com, dinechin@redhat.com


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 18, 2019 at 11:17:11AM +0000, Daniel P. Berrang=E9 wrote:
>On Fri, Jan 18, 2019 at 12:11:50PM +0100, Martin Kletzander wrote:
>> On Fri, Jan 18, 2019 at 10:16:38AM +0000, Daniel P. Berrang=E9 wrote:
>> > I've just realized there is a potential 3rd solution. Remember there is
>> > actually nothing inherantly special about the 'root' user as an account
>> > ID. 'root' gains its powers from the fact that it has many capabilities
>> > by default.  'qemu' can't access /dev/sev because it is owned by a
>> > different user (happens to be root) and 'qemu' does not have capabilit=
ies.
>> >
>> > So we can make probing work by using our capabilities code to grant
>> > CAP_DAC_OVERRIDE to the qemu process we spawn. So probing still runs
>> > as 'qemu', but can none the less access /dev/sev while it is owned
>> > by root.  We were not using 'qemu' for sake of security, as the probing
>> > process is not executing any untrusthworthy code, so we don't  loose a=
ny
>> > security protection by granting CAP_DAC_OVERRIDE.
>> >
>>
>> IMHO CAP_DAC_OVERRIDE is a lot, especially on systems without SELinux.
>
>Probing of QEMU capabilities is not a security critical task. QEMU is
>run with "-machine none" so does not even create the virtual machine
>hardware, nor have any guest image that it would run. All it is running
>is the QEMU class initialization code. The only way for that to act in
>a malicious way is for a backdoor to have been inserted when QEMU was
>built by the OS vendor, or fo the QEMU binary on disk to have been
>replaced by something malcious (which would require root privileges
>itself).
>

So you are trying to protect from buggy qemu with malicious guest, not real=
ly a
malicious qemu.  I got confused as SEV is trying to protect against
untrustworthy host including binaries like qemu.  OK

>
>We must of coure *NEVER* give CAP_DAC_OVERRIDE to a QEMU that is running
>the real, untrustworty, end user VM.
>
>Regards,
>Daniel
>--=20
>|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrang=
e :|
>|: https://libvirt.org         -o-            https://fstop138.berrange.co=
m :|
>|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrang=
e :|

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiXAnXDYdKAaCyvS1CB/CnyQXht0FAlxBuRoACgkQCB/CnyQX
ht2ECw//b9nfHX49JK3Yv/IakpN3sa7YDj7NAMjNttzKUci43bR+XD4Bdo8W6Rau
AwtDt10hjCoybaWAILf23K/Bg59b78aA4tam+7lhr9AUqlmA35vQbIggXkbVnJGn
OTFZM513P+CtnUeoakGWrEt0lErN49CLkhAJlgISociwyGveYkFFlgivLEz7KCuD
T3fxbZRPzV5+l9YUy/UeMmSKTH6wfgSPN991e7hHyWQOOtaUdJGwkGCqknHLfKpc
OzdRJzUMJO+B1yLMXMqOIksbYr6H5ww2Cw2Xbx4etoDLH8HqyirV6ZzCXHmE3sLM
1FkWhPrU9SE0BFQffFwTNFHFPV8IGWxWh/TYGZCpL2poCC7Gyawd5uyeitWum4UL
TEIrMJ4o20czbuRPzgPvsvrLol1xDHYkXdPXQyGAcj3IOLfQhTlFAE+gSt447vuv
JJ0oMpbcTvsjWEettMWh9v1xoaSrkTDcvGm4sB6JFI8Af8HDB4Nt/oS0llvsbpVT
g5/4FZ4x9Si3y5fbSZ3QUCktjiiYj69Of0j9fWVjVcTvxvz99ovVsm0kV74jv6ks
haWjOSBQMThKa3LcTrVwhaWJKCywmyinLXGsQpxiUShfCwIhLPr+Aj5QcM24KuxP
LPyOcEoGrd818uJlTRZmOSpaAug7fmFC7aAeWloHPbPi3qnOuP8=
=XFgw
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
