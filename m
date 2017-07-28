Received: from eggs.gnu.org ([2001:4830:134:3::10]:53483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1day6e-00065Y-LK
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:46:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1day6c-0004s2-0W
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:46:36 -0400
Received: from mail-qt0-x22e.google.com ([2607:f8b0:400d:c0d::22e]:33626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1day6b-0004ra-SQ
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:46:33 -0400
Received: by mail-qt0-x22e.google.com with SMTP id a18so55800144qta.0
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 22:46:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170717063521.GA7393@lemon>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bf05437e-b228-bbc4-760f-b3c1cddf9f0a@amsat.org>
Date: Fri, 28 Jul 2017 02:46:30 -0300
MIME-Version: 1.0
In-Reply-To: <20170717063521.GA7393@lemon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Status and RFC of patchew testings on QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

Hi Fam,

On 07/17/2017 03:35 AM, Fam Zheng wrote:
> So far we have these tests running by patchew on each patch series:
> 
>    * Docker tests
>      Basically it is
>          make docker-test-quick@centos6 \
>               docker-test-build@min-glib \
>               docker-test-mingw@fedora"
> 
>    * checkpatch.pl
>      Each patch is fed to ./scripts/checkpatch.pl and all errors are reported.
> 
>    * s390x
>      It runs on a machine shared by Fedora team, basically only "./configure and
>      make", because "make check" hanging is tricky to deal with from an
>      automation perspective. (Ideas?)
> 
>    * FreeBSD
>      Like s390x.
> 
[...]
> Q4: Any other improvements/features you want? (E.g. some documentation? :)

I'm unsure if someone already asked about it, but is it possible to sort 
the tests, like:
- fastest/cheapest
- more likely to fail
- ...
- scarce resources at last

And abort/send report on first failure.

Regards,

Phil.
