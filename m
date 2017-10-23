Received: from eggs.gnu.org ([2001:4830:134:3::10]:57669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1e6Rwm-0008AX-QO
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 21:54:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1e6Rwj-0000Dx-N2
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 21:54:32 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:30074
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1e6Rwj-0000CU-AU
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 21:54:29 -0400
References: <150872266046.482.7079735783547819304@b58463cdfd5f>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <d60aa469-248e-1e09-c3e6-20c696050865@cn.fujitsu.com>
Date: Mon, 23 Oct 2017 09:54:24 +0800
MIME-Version: 1.0
In-Reply-To: <150872266046.482.7079735783547819304@b58463cdfd5f>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] NUMA: Enable adding NUMA node implicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, famz@redhat.com
Cc: thuth@redhat.com, indou.takao@jp.fujitsu.com, ehabkost@redhat.com, mst@redhat.com, izumi.taku@jp.fujitsu.com, david@redhat.com, f4bug@amsat.org, alistair23@gmail.com, imammedo@redhat.com, marcel@redhat.com, pbonzini@redhat.com, rth@twiddle.net, patchew-devel@freelists.org

Hi Fam,

At 10/23/2017 09:37 AM, no-reply@patchew.org wrote:
> Hi,
>
> This series failed automatic build test. Please find the testing commands and
> their output below. If you have docker installed, you can probably reproduce it
> locally.
>
> Type: series
> Message-id: 1508722422-3861-1-git-send-email-douly.fnst@cn.fujitsu.com
> Subject: [Qemu-devel] [PATCH v4] NUMA: Enable adding NUMA node implicitly
>
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> set -e
> git submodule update --init dtc
> # Let docker tests dump environment info
> export SHOW_ENV=1
> export J=8
> time make docker-test-quick@centos6
> time make docker-test-build@min-glib
> time make docker-test-mingw@fedora
> time make docker-test-block@fedora
> === TEST SCRIPT END ===
>
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>  * [new tag]               patchew/1508722422-3861-1-git-send-email-douly.fnst@cn.fujitsu.com -> patchew/1508722422-3861-1-git-send-email-douly.fnst@cn.fujitsu.com
>  t [tag update]            patchew/cover.1508329282.git.riku.voipio@linaro.org -> patchew/cover.1508329282.git.riku.voipio@linaro.org
> Switched to a new branch 'test'
> b8c0d922bf NUMA: Enable adding NUMA node implicitly
>
> === OUTPUT BEGIN ===
> Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for path 'dtc'
> Cloning into '/var/tmp/patchew-tester-tmp-z9ao6big/src/dtc'...
> fatal: Could not read from remote repository.
>

Wow, It seems there are something wrong with the test robot.

Thanks,
	dou.

> Please make sure you have the correct access rights
> and the repository exists.
> fatal: clone of 'git://git.qemu-project.org/dtc.git' into submodule path '/var/tmp/patchew-tester-tmp-z9ao6big/src/dtc' failed
> Failed to clone 'dtc'. Retry scheduled
> Cloning into '/var/tmp/patchew-tester-tmp-z9ao6big/src/dtc'...
> fatal: Could not read from remote repository.
>
> Please make sure you have the correct access rights
> and the repository exists.
> fatal: clone of 'git://git.qemu-project.org/dtc.git' into submodule path '/var/tmp/patchew-tester-tmp-z9ao6big/src/dtc' failed
> Failed to clone 'dtc' a second time, aborting
> === OUTPUT END ===
>
> Test command exited with code: 1
>
>
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org
>
