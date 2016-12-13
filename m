Received: from eggs.gnu.org ([2001:4830:134:3::10]:57266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ossman@cendio.se>) id 1cGoJj-0006Fj-6D
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 09:44:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ossman@cendio.se>) id 1cGoJf-0001dK-7r
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 09:44:31 -0500
Received: from hayek.cendio.se ([193.12.253.119]:40734 helo=mail.cendio.se)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ossman@cendio.se>) id 1cGoJf-0001cD-0l
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 09:44:27 -0500
References: <f460049b-211e-194b-d4c3-a3cc34e4d289@cendio.se>
	<1481616362.27088.74.camel@redhat.com>
	<7ba29954-e3ad-529c-9978-b10d2788f9e4@cendio.se>
	<20161213131553.GJ28416@redhat.com>
From: Pierre Ossman <ossman@cendio.se>
Message-ID: <3ff86d59-6bb8-0ca0-06a9-1e71d3620e02@cendio.se>
Date: Tue, 13 Dec 2016 15:44:24 +0100
MIME-Version: 1.0
In-Reply-To: <20161213131553.GJ28416@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] VNC LED state buggy, interop issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 13/12/16 14:15, Daniel P. Berrange wrote:
>
> gtk-vnc implements the LED state extension.
>

For testing, I've now pushed my work to get TigerVNC to support this:

https://github.com/CendioOssman/tigervnc/tree/ledstate

It's implemented for the client and Xvnc.

Regards
--=20
Pierre Ossman           Software Development
Cendio AB		http://cendio.com
Teknikringen 8		http://twitter.com/ThinLinc
583 30 Link=C3=B6ping	http://facebook.com/ThinLinc
Phone: +46-13-214600	http://plus.google.com/+CendioThinLinc

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
