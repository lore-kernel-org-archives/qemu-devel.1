Received: from eggs.gnu.org ([2001:4830:134:3::10]:47758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eH1cT-0002bB-05
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 01:01:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eH1cN-0005Xl-Gq
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 01:01:17 -0500
Date: Tue, 21 Nov 2017 14:01:02 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171121060102.GB28270@lemon>
References: <20171121032119.14442-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171121032119.14442-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.11] Makefile: use $(MAKE) variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org

On Tue, 11/21 00:21, Philippe Mathieu-Daud=E9 wrote:
> @@ -904,7 +904,7 @@ $(patsubst %, check-%, $(check-qapi-schema-y)): che=
ck-%.json: $(SRC_PATH)/%.json
>  		echo $$? >$*.test.exit, \
>  		"TEST","$*.out")
>  	@diff -q $(SRC_PATH)/$*.out $*.test.out
> -	@# Sanitize error messages (make them independent of build directory)
> +	@# Sanitize error messages ($(MAKE) them independent of build directo=
ry)

This doesn't look like a good candidate, does it?

Fam

>  	@perl -p -e 's|\Q$(SRC_PATH)\E/||g' $*.test.err | diff -q $(SRC_PATH)=
/$*.err -
>  	@diff -q $(SRC_PATH)/$*.exit $*.test.exit
> =20
> --=20
> 2.15.0
>=20
>=20

Fam
