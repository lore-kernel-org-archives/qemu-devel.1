Received: from eggs.gnu.org ([2001:4830:134:3::10]:54280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjAwR-0008H4-9S
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 15:33:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjAwQ-0005JL-9y
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 15:33:43 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:36219)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjAwQ-0005IW-3p
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 15:33:42 -0500
Received: by mail-wm0-x232.google.com with SMTP id n11so8808990wma.1
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 12:33:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1488308796-28832-1-git-send-email-armbru@redhat.com>
References: <1488308796-28832-1-git-send-email-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Mar 2017 20:33:20 +0000
Message-ID: <CAFEAcA-mMuks2i8RJWq2h+JQKW=KFOM5d5du+YpmL--2RFgtXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/26] QAPI patches for 2017-02-28
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 28 February 2017 at 19:06, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit 7d1730b7d9d8272a13245adfc9b0405e5a4bd0c2:
>
>   Merge remote-tracking branch 'remotes/mjt/tags/trivial-patches-fetch' into staging (2017-02-28 16:22:41 +0000)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-02-28
>
> for you to fetch changes up to c3e7a042e42477ba2c202ba14029e5463a5cfa17:
>
>   qapi: Improve qobject visitor documentation (2017-02-28 19:59:50 +0100)
>
> ----------------------------------------------------------------
> QAPI patches for 2017-02-28


Failed check-qtest-cris on x86/Linux host:

  GTESTER check-qtest-cris
Broken pipe
GTester: last random seed: R02Sc204c00354522c53b5f366d15508564e
Broken pipe
GTester: last random seed: R02Sceb39014d3fc571bff114b11f1579141
Broken pipe
GTester: last random seed: R02S1654ac812d0c303ef41ff0cb6d7f8e9b
Broken pipe
GTester: last random seed: R02S0f04ab4c25490264543e7838b0a8e311
Broken pipe
GTester: last random seed: R02S3a662141f9907b77c2472f82bc99dea4
Broken pipe
GTester: last random seed: R02S6edf627e16989258c2c3b827de365fdc
Broken pipe
/home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:793:
recipe for target 'check-qtest-cris' failed


Failed check-qtest-sparc on OSX host:

  GTESTER check-qtest-sparc
Broken pipe
GTester: last random seed: R02Se853bd8eaab78c53402578734d57a2de
Broken pipe
GTester: last random seed: R02Sce0ed3ad5793accf735df29e84202cd8
Broken pipe
GTester: last random seed: R02S1d9e0ed3d8ec9138008d7c958f157c81
Broken pipe
GTester: last random seed: R02S3b5a25fd32857e1ecbef1c30ed6b280b
Broken pipe
GTester: last random seed: R02S21fee6c439480b9cc9e1d57e18fa326d
Broken pipe
GTester: last random seed: R02Sa9ada25a1102de6cb8446305b268178e

Yes, those logs are pretty useless. Possibly you're the victim
of some random-intermittent-failure already in the tree,
though it's not the "assert" issue with MTTCG we've seen.

I tried a rerun on OSX host and it failed in the check-qtest-arm
this time around (still no diagnostics beyond 'broken pipe').


thanks
-- PMM
