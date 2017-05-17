Received: from eggs.gnu.org ([2001:4830:134:3::10]:43982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dAzvs-0004Oe-8t
	for qemu-devel@nongnu.org; Wed, 17 May 2017 10:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dAzvm-0004lm-I3
	for qemu-devel@nongnu.org; Wed, 17 May 2017 10:28:08 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:34602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dAzvm-0004lS-BK
	for qemu-devel@nongnu.org; Wed, 17 May 2017 10:28:02 -0400
Received: by mail-wr0-x22a.google.com with SMTP id l9so11705274wre.1
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 07:28:01 -0700 (PDT)
References: <20170508221759.15616-1-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170508221759.15616-1-f4bug@amsat.org>
Date: Wed, 17 May 2017 15:28:55 +0100
Message-ID: <87k25f36c8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 00/21] docker/shippable: cross-build
 mipsel and powerpc targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> This patchset add 2 more architectures to the cross-build farm.
>
> There is still some issue trying to cross-build mips64el-softmmu, it seems the
> cross tools use the system outdated libfdt instead of the one checkouted in the
> dtc submodule. I disabled this target for now.
>
> The branch https://github.com/philmd/qemu/tree/docker_shippable_v2 can be
> checked at Shippable:
>   https://app.shippable.com/github/philmd/qemu/status/dashboard
>
> With the free open source projects service, each arch builds in around ~8min,
> the 5 jobs take ~38min in total.
>
> v2:
> - Addressed review feedback from Alex, added his R-B
> - Fixed the "Problem with the SSL CA cert" problem while cloning from github.com
>   installing the ca-certificates package.
> - Squashed/split some commits
> - use 'apt-get clean' instead of brutal 'rm -rf'
> - checked how many cores are available on Shippable and use them fully
>   (reduced total time from 44min to 38min)
> - build armeb-linux-user target

Ping - is there a v3 coming with Fam's comments addressed?

<snip>

--
Alex Bennée
