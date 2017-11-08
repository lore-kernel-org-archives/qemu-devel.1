Received: from eggs.gnu.org ([2001:4830:134:3::10]:49400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1eCNiq-0006Em-Ak
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:36:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1eCNip-0006ql-Dk
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:36:40 -0500
Date: Wed, 8 Nov 2017 10:36:31 +0000
From: Dave Martin <Dave.Martin@arm.com>
Message-ID: <20171108103630.GB8971@e103592.cambridge.arm.com>
References: <20171107150558.22131-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171107150558.22131-1-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH 00/10] Initial support for SVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>

On Tue, Nov 07, 2017 at 03:05:48PM +0000, Alex Benn=E9e wrote:
> Hi,
>=20
> These patches apply on-top of the last clean-up series:
>=20
>   Subject: [RISU PATCH 0/7] Add @Group support and some aarch64.risu cl=
eanups
>   Date: Tue, 31 Oct 2017 14:54:37 +0000
>   Message-Id: <20171031145444.13766-1-alex.bennee@linaro.org>
>=20
> This series adds support for SVE to RISU. Most of the initial patches
> are plumbing changes to better support arch specific option flags
> (cleaning up a TODO in the process). I also needed to ensure configure
> actually honoured CPPFLAGS so it could be passed yet to be released
> headers.

Should there be a getauxval(AT_HWCAP) & HWCAP_SVE check in this series
somewhere?

I don't know enough about how RISU is structured to know whether/where
this is needed.

[...]

Cheers
---Dave
