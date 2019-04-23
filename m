Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA368C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 19:30:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A85B721738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 19:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A85B721738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58609 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ17O-0001zS-0p
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 15:30:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1hJ16X-0001YT-B6
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 15:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1hJ16V-0003Bv-UP
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 15:29:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1hJ16T-00030e-Ru
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 15:29:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 55B6E307EA8D;
	Tue, 23 Apr 2019 19:29:06 +0000 (UTC)
Received: from localhost.localdomain (ovpn-122-118.rdu2.redhat.com
	[10.10.122.118])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9BE9D5D9C8;
	Tue, 23 Apr 2019 19:29:00 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
References: <20190329210804.22121-1-wainersm@redhat.com>
Message-ID: <5005fcec-42af-427c-4f68-8415490e9598@redhat.com>
Date: Tue, 23 Apr 2019 16:28:59 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190329210804.22121-1-wainersm@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Tue, 23 Apr 2019 19:29:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/5] tests/vm: Python 3,
 improve image caching, and misc
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, peter.maydell@linaro.org, philmd@redhat.com,
	lersek@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423192859.BDlTQ8ujocbNmMo0h9vF8Y-X80A0IjfzrHZhjA1tbCk@z>

Ping. More reviews needed.

I've already got Philippe's reviewed-by, thanks!

- Wainer


On 03/29/2019 06:07 PM, Wainer dos Santos Moschetta wrote:
> Hi all!
>
> This series bundles the support to Python3, improvement to image caching, and miscellaneous changes for the vm-test (`make vm-build-*`).
>
> Git tree: http://github.com/wainersm/qemu
> Branch: vm_test_python3_and_misc
> Travis: https://travis-ci.org/wainersm/qemu/builds/513220300
>
> Below you can find some general comments.
>
> Patch 01:
> Uses python configured at build, although vm-test can be executed from the code tree (see docs/devel/testing.rst) too. In this case $(PYTHON) will be empty and it picks python pointed by the script's shebang, as a result failing on Python 3 only Linux distros.
>
> Patch 02:
> Ported based.py to work with Python 3 (kept Python 2 compatibility). Fixed the follow errors:
>    - Raising "TypeError: Unicode-objects must be encoded before hashing" exception by hashlib.sha1().
>    - get_default_jobs() is used to set the vm cpus, but it was returning an invalid float number.
>    - On check_sha256sum(), subprocess.check_output() returns bytes so that string comparison was failing.
>
> Patch 03:
> Implemented a simple mechanism to detect the image file changed on http://download.patchew.org, as discussed in https://www.mail-archive.com/qemu-devel@nongnu.org/msg607839.html. I didn't implement the '--force' option that Paolo suggested, because it would require a major refactoring (technically the vm implementation decides whether use the cache or not). My intention is to keep the script as simple as possible, so IMO, if the image file changed on the server then it should equally be updated the checksum on QEMU's side.
>
> Patch 04:
> Default network (NETWORK=1) backend is enough to have the docker-based tests run properly. Note: `make docker-test-block@centos7` is broken inside the CentOS VM and apparently on my host (Fedora 29 x86_64) too.
>
> Wainer dos Santos Moschetta (5):
>    tests/vm: Use python configured on build
>    tests/vm: Port basevm to Python 3
>    tests/vm: Detect the image changed on server
>    tests/vm: Fix build-centos docker-based tests run
>    tests/vm: Add missing variables on help
>
>   tests/vm/Makefile.include | 12 ++++++++----
>   tests/vm/basevm.py        | 39 ++++++++++++++++++++++++++++++++++-----
>   tests/vm/centos           |  6 +++---
>   3 files changed, 45 insertions(+), 12 deletions(-)
>


