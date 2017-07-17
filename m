Received: from eggs.gnu.org ([2001:4830:134:3::10]:51505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dX3ld-0008DA-PN
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:00:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dX3lc-0005dK-VI
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:00:45 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:37479)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dX3lc-0005dC-O8
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:00:44 -0400
Received: by mail-wm0-x22f.google.com with SMTP id b134so43892282wma.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 04:00:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170717102053.GH3640@redhat.com>
References: <20170717063521.GA7393@lemon>
	<b718f71c-5208-298a-4fb9-0c2fea3146ec@redhat.com>
	<20170717102053.GH3640@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2017 12:00:22 +0100
Message-ID: <CAFEAcA9fzkk6mC+Bz4jNd+7M8nq0xpooVFDNeVb0VcqGDadB8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Status and RFC of patchew testings on QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 17 July 2017 at 11:20, Daniel P. Berrange <berrange@redhat.com> wrote:
> I'm a little concerned about the fact that we've now got three different
> sets of tests that are being run on pull requests. There are the tests
> that Peter runs on various combinations at time of merge, the tests run
> by patchw at time of submissions, and the tests run by travis after
> merge. Each of them is covering a different set of scenarios with only
> partial overlap between them.

I agree -- I have my ad-hoc test system not because I enjoy
collecting random things to run tests on but because we don't
have an automated system that does what I need:
 * wide coverage, focusing on oddball host architectures and OSes
 * ability to ssh in to a machine where tests have broken if need be
 * decently fast to complete a test run (travis is terrible for this)

Note that "fast to complete a test run for me" is in conflict with
"usable by anybody who wants to submit a pull request" :-)

thanks
-- PMM
