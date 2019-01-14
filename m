Received: from eggs.gnu.org ([209.51.188.92]:40454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gj45j-0000bq-L3
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:24:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gj45h-0006jF-59
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:23:55 -0500
References: <1547473614-20033-1-git-send-email-thuth@redhat.com>
	<CAFEAcA9RQ+_vC3z4qxkX9Jsu4FKHGqi6qXxgbUKn=wpPzwy4Nw@mail.gmail.com>
	<20190114143144.GH3686@redhat.com>
	<0afe72f6-05fe-9547-5f54-46a47ba1ff30@redhat.com>
	<2d4074cf-2a2c-a4b7-ec50-3324af877ff9@redhat.com>
	<bc8478dd-5f25-47c8-51e0-45bc3c35c0ae@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <150611f1-774a-a0c9-9e22-756d8e87b7ca@redhat.com>
Date: Mon, 14 Jan 2019 16:23:35 +0100
MIME-Version: 1.0
In-Reply-To: <bc8478dd-5f25-47c8-51e0-45bc3c35c0ae@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="JwVIsNtSKiV6kYj9AV6RbsRO9lbDHROgv"
Subject: Re: [Qemu-devel] [PATCH] configure: Work-around a bug in libiscsi
 1.9.0 when used in gnu99 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu-block <qemu-block@nongnu.org>, Peter Lieven <pl@kamp.de>, QEMU Developers <qemu-devel@nongnu.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JwVIsNtSKiV6kYj9AV6RbsRO9lbDHROgv
From: Thomas Huth <thuth@redhat.com>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Daniel_P._Berrang=c3=a9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu-block <qemu-block@nongnu.org>, Peter Lieven <pl@kamp.de>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <150611f1-774a-a0c9-9e22-756d8e87b7ca@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] configure: Work-around a bug in libiscsi
 1.9.0 when used in gnu99 mode
References: <1547473614-20033-1-git-send-email-thuth@redhat.com>
 <CAFEAcA9RQ+_vC3z4qxkX9Jsu4FKHGqi6qXxgbUKn=wpPzwy4Nw@mail.gmail.com>
 <20190114143144.GH3686@redhat.com>
 <0afe72f6-05fe-9547-5f54-46a47ba1ff30@redhat.com>
 <2d4074cf-2a2c-a4b7-ec50-3324af877ff9@redhat.com>
 <bc8478dd-5f25-47c8-51e0-45bc3c35c0ae@redhat.com>
In-Reply-To: <bc8478dd-5f25-47c8-51e0-45bc3c35c0ae@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2019-01-14 16:02, Eric Blake wrote:
> On 1/14/19 8:53 AM, Thomas Huth wrote:
>> On 2019-01-14 15:50, Eric Blake wrote:
>>> On 1/14/19 8:31 AM, Daniel P. Berrang=C3=A9 wrote:
>>>
>>>>>
>>>>> Can we suppress the warnings with #pragma instead ?
>>>>> That would avoid compiling the .o file with different
>>>>> C semantics.
>>>>
>>>> IIUC this is a built-in warning you can't disable, except by changin=
g
>>>> the compilation mode to have gnu89 inline semantics :-(
>>>
>>> Could we instead fix the warning by one of:
>>>
>>> Using pragma to declare the header as a system header (used to silenc=
e
>>> warnings from misbehaving external headers),
>>
>> How do you do that?
>=20
> Using -isystem instead of -I - but that means rewriting the output of
> pkg-config.

That does not work for me on RHEL7: The output of "pkg-config --cflags
libiscsi" is empty since the headers are in a standard location. And
even if I add "-isystem /usr/include" or "-isystem /usr/include/iscsi"
manually, the warning does not go away.

>>> and/or adding #defines around the inclusion of the header to neutrali=
ze
>>> the poor warnings,
>>
>> You mean something like:
>>
>> #define inline /* nothing */
>=20
> or
> https://stackoverflow.com/questions/1867065/how-to-suppress-gcc-warning=
s-from-library-headers
> mentions:
>=20
> // save diagnostic state
> #pragma GCC diagnostic push
>=20
> // turn off the specific warning. Can also use "-Wall"
> #pragma GCC diagnostic ignored "-Wunused-but-set-variable"

That does not work in this case here, too, since there is no dedicated
option to switch this warning on or off.

>> The patch is only changing libiscsi_cflags, so it's not affecting the
>> entire project, but just the files that use libiscsi.
>=20
> Even so, limiting the damage to just the wrapper file that includes the=

> problematic header rather than changing the command line for the entire=

> compilation of those files that use libiscsi is even more precise.

Then our only option is "#define inline /* nothing */", as far as I can
see...

 Thomas




--JwVIsNtSKiV6kYj9AV6RbsRO9lbDHROgv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJcPKl8AAoJEC7Z13T+cC21newQAJwxgMlS93YLCfgEbiIjgN19
2m75sPTJOd9Xf61WykfBrx+Y6mL1kizjzan6cwAH6DZN0EsTo6QHtLUzF4jx+JHk
eTU2dFu/3RqumrQSoVRB25nPrHHvRGabquvJmoVbeYzbVPnDfSuT8wAd5CNWtlPo
NduPnkYCIHp7HFoE05izlEVnUNXs+mIBikPaitvp12ida2uxKCDBiGtIO93W+c8r
Mxp8TDFPmOq3j8VXCYqHoAZcXN9oOkEheP8B1MzjqMYYi5ZPmRFwePoVfPfumPj6
YD2kWflz++Xb2PPBqU00PzyBYhIwn/3UytZqmupqeDGDSOrH7j4bEULp1cgDnaLr
sM6gm++3v760hawmbU7ZmdSnPrNifnkpGo1KSwAIdZ2HGeTIndlmD8D0t1zG2Pum
laXEIiMadvbnj2ME7rSMpvXf6slHEPvHcdCL9UZF59GG8L0XE6w2TQ4xqS3j/23V
AlH2hIk6H3F8NpucePf8CsOCxo0pQc4M1j7LxYdlLNsSrdEIjGGeQ6cHartrRjCF
vkSWh22OIPE7vvJsiJZmUFIuvAW1ukXrOs7n16EgP2waXCOqReeBmwAhWjfjs+zb
+MgNQmgjGMRBeA8GZC3cGGt6qKg89bRIO46ya6SaCokh+UHrtc0FyRJzR91sXmcl
YPApK8BgDe+j30rdD08V
=j7yI
-----END PGP SIGNATURE-----

--JwVIsNtSKiV6kYj9AV6RbsRO9lbDHROgv--
