Received: from eggs.gnu.org ([2001:4830:134:3::10]:39533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dCNsN-00060q-Ee
	for qemu-devel@nongnu.org; Sun, 21 May 2017 06:14:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dCNsJ-0001Ng-FG
	for qemu-devel@nongnu.org; Sun, 21 May 2017 06:14:15 -0400
Date: Sat, 20 May 2017 16:26:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170520062603.GA30246@umbus.fritz.box>
References: <20170519142750.18437-1-danielhb@linux.vnet.ibm.com>
	<20170519142750.18437-2-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <20170519142750.18437-2-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v12 1/2] hw/ppc/spapr_events.c: removing
 'exception' from sPAPREventLogEntry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2017 at 11:27:49AM -0300, Daniel Henrique Barboza wrote:
> Currenty we do not have any RTAS event that is reported by the
> event-scan interface. The existing events, RTAS_LOG_TYPE_EPOW and
> RTAS_LOG_TYPE_HOTPLUG, are being reported by the check-exception
> interface and, as such, marked as 'exception=3Dtrue'.
>=20
> Commit 79853e18d9, 'spapr_events: event-scan RTAS interface', added
> the event_scan interface because the guest kernel requires it to
> initialize other required interfaces. It is acting since then as
> a stub because no events that would be reported by it were added
> since then. However, the existence of the 'exception' boolean adds
> an unnecessary load in the future migration of the pending_events,
> sPAPREventLogEntry QTAILQ that hosts the pending RTAS events.
>=20
> To make the code cleaner and ease the future migration changes, this
> patch makes the following changes:
>=20
> - remove the 'exception' boolean that filter these events. There is
> nothing to filter since all events are reported by check-exception;
>=20
> - functions rtas_event_log_queue, rtas_event_log_dequeue and
> rtas_event_log_contains don't receive the 'exception' boolean
> as parameter;
>=20
> - event_scan function was simplified. It was calling
> 'rtas_event_log_dequeue(mask, false)' that was always returning
> 'NULL' because we have no events that are created with
> exception=3Dfalse, thus in the end it would execute a jump to
> 'out_no_events' all the time. The function now assumes that
> this will always be the case and all the remaining logic were
> deleted.
>=20
> In the future, when or if we add new RTAS events that should
> be reported with the event_scan interface, we can refer to
> the changes made in this patch to add the event_scan logic
> back.
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

Applied to ppc-for-2.10.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZH+F7AAoJEGw4ysog2bOSdXoQAJmd8B3mCW4BT+njZSGdjXG5
Fos9KY8XMeEHD0ASc+ve0wkC1UjtfUaLWF9pcDtumKRMZgupdnqOWCLgW8+gXzZC
zQYQ6t7As9v3KKoYmfUr0Ituu05MVnnDqWnps6zOhZTTYpukA/DuaSHr/N1QJ9wP
zjHC4z46mB9OMATTf79BUJxuoKD4U5Q2+Rd8kTh3qgei97W51e1A4XE9al0JRcyg
ZuzoYT+QVjwuSq4MiZ2C0aSCakbZ+TnH+OWeaRukAfFcjnm83iSEKLnzydZ91uYf
5EPoaKi0Eopg9VvutwXGOI3Wgep+3b8g9ty3wSkdPd48amfbyOitlegtqdnDNYwy
nT6oEbA1L3Gq6gqgfEmEwE3jOyLE2hb3gQk31cPuBGwIxYhdPvJ+KmOEAshdqfgF
aO0sAJiNAqSS/xejoFjVaxejH1FCQ9q5hCBj5lvi/tN+v0dS8twUtkPYqtBiLwTN
k8nfTHEEuonjjtcQGXn4K7in5v1Qi3upa/rMISu5HPHDlvpjfqV46uWduT6WJqZn
+LRo2uZJwIbzAouHFtgrNYnP5HhuGnsV2hZJ+j/LAXGssl2NUWzqaeBQW13oCnCD
iFc/bygjrvRM0VSvLipDcUK8SeGj4Ajh0IOIgkHS13fYxr24O+fUnH9+cMhSlqOi
demeLZvRnol7h39zJNPc
=158F
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
