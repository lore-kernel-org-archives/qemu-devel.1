Received: from eggs.gnu.org ([2001:4830:134:3::10]:60000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gXsV7-0003Fp-R3
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 13:47:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gXsV2-0003UW-IX
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 13:47:53 -0500
Received: from mail-eopbgr810091.outbound.protection.outlook.com
	([40.107.81.91]:29216
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aaron@os.amperecomputing.com>)
	id 1gXsV2-0003Tp-72
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 13:47:48 -0500
From: Aaron Lindsay <aaron@os.amperecomputing.com>
Date: Fri, 14 Dec 2018 18:47:42 +0000
Message-ID: <20181214184733.GA12361@quinoa.localdomain>
References: <20181209193749.12277-1-cota@braap.org>
	<20181209193749.12277-6-cota@braap.org>
	<20181214155724.GB4314@quinoa.localdomain>
	<20181214170822.GA15965@flamenco> <20181214175022.GA18314@flamenco>
In-Reply-To: <20181214175022.GA18314@flamenco>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <4A50D71732070640A1C32B181FCBD55E@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC v2 05/38] plugin: add user-facing API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

On Dec 14 12:50, Emilio G. Cota wrote:
> On Fri, Dec 14, 2018 at 12:08:22 -0500, Emilio G. Cota wrote:
> > On Fri, Dec 14, 2018 at 15:57:32 +0000, Aaron Lindsay wrote:
> (snip)
> > > I added a function to the user-facing plugin API in my own version of
> > > Pavel's plugin patchset to clear all existing plugin instrumentation,
> (snip)
> > I think the following API call would do what you need:
> >=20
> >   typedef int (*qemu_plugin_reset_cb_t)(qemu_plugin_id_t id);
> >   void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_reset_cb_t cb=
);
> >=20
> > (or maybe qemu_plugin_reinstall?)
>=20
> An alternative is to track the TBs that a plugin has inserted
> instrumentation into, and only flush those. This would require
> us to do an additional hash table insert when adding a
> direct callback, but it allow us to avoid exporting tb_flush indirectly
> to plugins, which could be abused by malicious plugins to perform
> a DoS attack.

I don't think I have a preference. Though now I'm curious - when/why do
you expect users might run plugins that could be malicious in this way?

-Aaron
