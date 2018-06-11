Received: from eggs.gnu.org ([2001:4830:134:3::10]:44737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fSNHz-0004ww-7Q
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 09:55:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fSNHt-0004hK-1A
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 09:55:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36476 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fSNHs-0004gt-Sj
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 09:55:12 -0400
Date: Mon, 11 Jun 2018 14:55:07 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180611135507.GF17756@stefanha-x1.localdomain>
References: <20180609163252.27506-1-stefanha@redhat.com>
	<6d70ea23.116b3.163e77016fb.Coremail.suhang16@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pgaa2uWPnPrfixyx"
Content-Disposition: inline
In-Reply-To: <6d70ea23.116b3.163e77016fb.Coremail.suhang16@mails.ucas.ac.cn>
Subject: Re: [Qemu-devel] [PATCH] loader: implement START_SEG_ADDR_RECORD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Su Hang <suhang16@mails.ucas.ac.cn>
Cc: qemu-devel@nongnu.org, jusual@mail.ru, jim@groklearning.com, joel@jms.id.au, qemu.ml@steffen-goertz.de


--Pgaa2uWPnPrfixyx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 10, 2018 at 10:04:32AM +0800, Su Hang wrote:
> Sure, Thanks for remind me of this.
> One thing I must point out, in current code logic, if "START_SEG_ADDR_RECORD"
> occured multiple times, only the last one works. I don't know whether GNU
> binutils would emit 'The Record' many times.

It does not.  The behavior you described seems fine.

Do you have time to send a new revision of your patch series addressing
the comments from last time?

Thanks,
Stefan

--Pgaa2uWPnPrfixyx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbHn87AAoJEJykq7OBq3PI/HMH/2f21bL3NFg9BfZAgUDNLGeU
H+Ddh4v5Se90BtwgiVWIHElNIrcvnEGzLHqq+mlcsXdDQR66M32dJL0JFLB5KKGZ
w5BnVUAqSKGPe9k9JmG4XFQvWElrJ3Q8PuU0Zzw7pOScj23WoOR8rvaEZh2VzsCk
Ehp9Eg8nUpagOsGdjVDVsJMs7gSsnOkyBBpQcdAPxZ7+P5c6ZM/cGh/OaQUSAFFa
Spjm4OtlGtj6ct9GgA8dl+jEwdyky3lljPOvYXVa2z311PitXEgzW4NT6HUUlium
r4QeUULYcd6oJBi/0wEn8ISi35vyDyUb/wBN6KpmtdyDuBh2phqsTP09oQ1ZJww=
=R6dJ
-----END PGP SIGNATURE-----

--Pgaa2uWPnPrfixyx--
