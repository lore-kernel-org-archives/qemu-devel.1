Received: from eggs.gnu.org ([2001:4830:134:3::10]:49677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eofdO-0001AQ-Ul
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 20:26:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eofbr-0002wa-Bq
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 20:25:18 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52378 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eofbr-0002v9-17
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 20:23:43 -0500
Date: Thu, 22 Feb 2018 09:23:24 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180222012324.GA3530@lemon.usersys.redhat.com>
References: <20180206164815.10084-1-alex.bennee@linaro.org>
	<CAFEAcA8kq5PekaZVm5VpgLwa+VJYVX8pC5fE8RK8QiC9qA-aYw@mail.gmail.com>
	<87lgfr7nt3.fsf@linaro.org>
	<CAFEAcA8r2-4ZrK1RX8thnY0wRxT4bOZTjBASSP97JRcO_Bjnaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAFEAcA8r2-4ZrK1RX8thnY0wRxT4bOZTjBASSP97JRcO_Bjnaw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 00/22] re-factor softfloat and add fp16
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, bharata@linux.vnet.ibm.com, Andrew Dutcher <andrew@andrewdutcher.com>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, 02/19 13:56, Peter Maydell wrote:
> On 17 February 2018 at 13:23, Alex Benn=E9e <alex.bennee@linaro.org> wr=
ote:
> > Peter Maydell <peter.maydell@linaro.org> writes:
> >> If you persuade git to use the --minimal, --patience or --histogram
> >> git diff option when generating these patches you'll find that it
> >> doesn't produce unreadable patches that provoke all the checkpatch
> >> warnings.
> >
> > I think this is patchew getting confused
>=20
> Oh yes, sorry. Fam, can we update patchew's git config to use
>   git config --global diff.algorithm histogram
> (equivalently, algorithm =3D histogram in the .gitconfig) -- that
> way the patches it runs checkpatch on are more likely to be
> formatted so that they minimise spurious checkpatch output, I think.

Updated. (With s/--global/--local/ along with other diff options, in the =
testing
command list:

git config --local diff.renamelimit 0
git config --local diff.renames True
git config --local diff.algorithm histogram

)

Fam
