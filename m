Received: from eggs.gnu.org ([209.51.188.92]:36228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1glWfM-0002qP-D4
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:18:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1glWfL-00041o-It
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:18:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1glWfL-00041E-BF
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:18:51 -0500
From: Thomas Huth <thuth@redhat.com>
References: <20190116191950.94110-1-emaste@freefall.freebsd.org>
	<20190118144724.66914-1-emaste@freebsd.org>
	<8def73c9-23e5-9f87-81d1-dda0c7e6f7d9@redhat.com>
Message-ID: <242e057a-0c35-93b1-1249-93799cdf1196@redhat.com>
Date: Mon, 21 Jan 2019 11:18:45 +0100
MIME-Version: 1.0
In-Reply-To: <8def73c9-23e5-9f87-81d1-dda0c7e6f7d9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] .cirrus.yml: basic compile and test for
 FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: emaste@freebsd.org, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On 2019-01-21 10:13, Thomas Huth wrote:
> On 2019-01-18 15:47, emaste@freebsd.org wrote:
>> From: Ed Maste <emaste@freebsd.org>
>>
>> Signed-off-by: Ed Maste <emaste@freebsd.org>
>> ---
>> Changes since v2:
>>   * remove fontconfig and freetype2, noted by Thomas Huth
>>
>> After this patch is applied someone with appropriate permissions will
>> need to add the Cirrus-CI application in GitHub.
>=20
> Maybe even more important: It also works for forked repositories (once
> you've enabled the Cirrus-CI application from the marketplace), so
> people can use this to test their branches before sending PULL requests=
,
> e.g.:
>=20
>  https://cirrus-ci.com/github/huth/qemu
>=20
> Thus this sounds like a good idea to me.
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Tested-by: Thomas Huth <thuth@redhat.com>

Actually, scratch that Tested-by: My build timed out after 1 hour:

 https://cirrus-ci.com/task/5113243459649536

I think you need to split it up  / only build a subset of the targets
with the --target-list of the configure script, to make sure that the
task always finishes in < 1 h.
Something similar is also done in .travis.yml already, and I am also had
to split it up for my gitlab-ci.yml, see here:

 https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg00226.html

Are you also sure that you can run with 8 CPUs here? ... I somehow doubt
that, otherwise the build should not take more than 1 h, I think.

 Thomas
