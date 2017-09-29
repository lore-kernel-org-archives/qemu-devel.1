Received: from eggs.gnu.org ([2001:4830:134:3::10]:40191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dxj2W-00024e-WD
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 20:20:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dxj2P-0003zu-8K
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 20:20:20 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:33070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dxj2P-0003y4-3a
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 20:20:17 -0400
Received: by mail-io0-x244.google.com with SMTP id j26so134186iod.0
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 17:20:13 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20170928165333.GP12919@redhat.com>
Date: Thu, 28 Sep 2017 20:20:09 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <CDDC4F21-36D9-4341-AE18-B12ABFA4AFBD@gmail.com>
References: <mailman.4614.1506600439.14748.qemu-devel@nongnu.org>
	<D2C519DD-C9FE-42FC-9418-CD13BC48238D@gmail.com>
	<20170928165333.GP12919@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 0/6] Initial support for keycodemapdb
 GIT submodule
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <qemu-devel.nongnu.org>


> On Sep 28, 2017, at 12:53 PM, Daniel P. Berrange <berrange@redhat.com> =
wrote:
>=20
> On Thu, Sep 28, 2017 at 12:47:51PM -0400, Programmingkid wrote:
>>=20
>>> This patch series is an update to:
>>>=20
>>> v1: =
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02047.html
>>> v2: =
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02471.html
>>> v3: =
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02517.html
>>> v4: =
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02708.html
>>> v5: =
https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg02950.html
>>> v6: =
https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg07673.html
>>=20
>> <snip>
>>=20
>> These error messages appears when compiling version 7 of this patch =
series:
>>=20
>> /bin/sh: ./scripts/git-submodule.sh: Permission denied
>=20
> The git diff sets execute permission:
>=20
> diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
> new file mode 100755
> index 0000000000..f8e7d44ce6
> --- /dev/null
> +++ b/scripts/git-submodule.sh
>=20
> did you use "git am" to apply this series or just plain 'patch', =
because
> the latter won't deal with permissions correctly and so would cause =
that
> error message above.

I used the patch command. After trying again using 'git am' I was able =
to built QEMU. Even thought the build did succeed, this error message =
still appeared:=20

config-host.mak is out-of-date, running configure
  GIT     ui/keycodemapdb dtc
make: *** No rule to make target `ui/input-keymap-linux-to-qcode.c', =
needed by `Makefile'.  Stop.
make: *** Waiting for unfinished jobs....

I suggest adding a note to patch 0/7 that states this patch set is best =
applied using 'git am' instead of the patch command. That should help =
someone with testing out this patch set.=20=
