Received: from eggs.gnu.org ([209.51.188.92]:54056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMZi0-0002Cv-Um
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:02:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMZhx-0008QU-9T
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:02:43 -0400
References: <20190503143904.31211-1-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <98cd84db-2aed-4aa1-1f2d-eaa7ac63b72b@redhat.com>
Date: Fri, 3 May 2019 17:02:11 +0200
MIME-Version: 1.0
In-Reply-To: <20190503143904.31211-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] tests/qemu-iotests: re-format output
 to for make check-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 03/05/2019 16.39, Alex Benn=C3=A9e wrote:
> This attempts to clean-up the output to better match the output of the
> rest of the QEMU check system. This includes:
>=20
>   - formatting as "  TEST    iotest: nnn"
>   - calculating time diff at the end
>   - only dumping config on failure
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/qemu-iotests/check | 71 +++++++++++++++++++---------------------
>  1 file changed, 34 insertions(+), 37 deletions(-)

Thanks for tackling this! The output now looks nicer indeed if you run
"make check-qtest check-block -j8". However, if you add a "V=3D1" at the
end of the command line, the outputs look quite different again...

That's why I thought that having a TAP mode for the check script could
be a good idea, too. Then we could pipe the output through the
tap-driver.pl script, too, so we get uniform output for all tests...?

 Thomas
