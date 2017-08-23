Received: from eggs.gnu.org ([2001:4830:134:3::10]:48560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dkROn-0002Pc-Ht
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 04:52:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dkROk-00061C-6O
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 04:52:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dkROk-00060l-0J
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 04:52:26 -0400
Date: Wed, 23 Aug 2017 16:52:19 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170823085219.GA16292@lemon>
References: <CAFEAcA8wbRjjJYtk-65NJEsu-ELVdKgtwreipabSaMtLTfS--Q@mail.gmail.com>
	<3f0dc918-0f55-e2f4-bf47-fe4abf5453bb@redhat.com>
	<CAFEAcA_ezKWweEuUB-cXTer0LLaeuiGDkSdfhApedhw4ykDT0Q@mail.gmail.com>
	<20170822112046.GC12356@umbus.fritz.box>
	<20170822134815.77020eb8.cohuck@redhat.com>
	<20170823002907.GC5379@umbus.fritz.box>
	<20170823091650.48e7c44e.cohuck@redhat.com>
	<54526d47-b436-79d5-7a38-9516eaa727a6@redhat.com>
	<5b0ff74a-08d6-558d-4c79-a93758e6302a@redhat.com>
	<0bb344a3-f8f8-3365-cef1-1c68cf7d160d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bb344a3-f8f8-3365-cef1-1c68cf7d160d@redhat.com>
Subject: Re: [Qemu-devel] make check speed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>

On Wed, 08/23 10:35, Thomas Huth wrote:
> Is it safe nowadays to run "make check -j4" for example? Last time I
> tried (maybe 1 or 2 years ago), there were still issues since some tests
> were using hard-coded temporary file names, so the parallel tests were
> disturbing each other, for example...

We really should fix them.

Last year I wanted to get some speed up in patchew's "make check" jobs so I
tried this:

https://lists.gnu.org/archive/html/qemu-devel/2016-09/msg07713.html

On my laptop it can save 50% time as shown in the commit message, unfortunately
the patch didn't get enough traction, and I've since then rarely used -j in
"make check" command lines (what?!).

Fam
