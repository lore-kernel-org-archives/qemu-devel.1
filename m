Received: from eggs.gnu.org ([2001:4830:134:3::10]:34654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eg3NQ-0003Xg-LF
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 01:57:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eg3NN-0005Zc-Ja
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 01:57:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eg3NN-0005ZO-De
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 01:57:09 -0500
References: <20180129033133.31288-1-famz@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f090e697-424b-6ce6-4517-3e16c728958f@redhat.com>
Date: Mon, 29 Jan 2018 07:56:59 +0100
MIME-Version: 1.0
In-Reply-To: <20180129033133.31288-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docs: Add docs/devel/testing.rst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, f4bug@amsat.org, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org, armbru@redhat.com

On 29.01.2018 04:31, Fam Zheng wrote:
[...]
> +1. Create a new source file. For example, ``tests/test-foo.c``.
[...]
> +1. Create a new source file for the test. (More than one file can be a=
dded as
> +   necessary.) For example, ``tests/test-foo-device.c``.  2. Write the=
 test
> +   code with the glib and libqtest/libqos API. See also existing tests=
 and the
> +   library headers for reference.

Can you please name the examples tests/foo-test.c and
tests/foo-device-test.c instead? Then the binaries will be covered by
the wildcard in tests/.gitignore automatically. Otherwise the list in
that gitignore file will grow and grow... Maybe it's also worth to
mention the naming scheme in this doc file?

> +Image fuzzier testing
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +An image fuzzier was added to exercise format drivers. Currently only =
qcow2 is
> +supported. To start the fuzzier, run

s/fuzzier/fuzzer/g ?

 Thomas
