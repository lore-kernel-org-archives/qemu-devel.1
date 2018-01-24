Received: from eggs.gnu.org ([2001:4830:134:3::10]:47051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1eeCMt-0006tx-G7
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 23:10:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1eeCMQ-0003KQ-2w
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 23:08:59 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1eeCMP-0003Im-Qw
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 23:08:29 -0500
Received: by mail-wm0-f53.google.com with SMTP id x4so24701514wmc.0
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 20:08:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <B2D15215269B544CADD246097EACE7473AB52A7A@DGGEMM505-MBS.china.huawei.com>
References: <cover.1516329752.git.arei.gonglei@huawei.com>
	<151634631594.596.13980731914055637021@5adcb62bf0d6>
	<B2D15215269B544CADD246097EACE7473AB52A7A@DGGEMM505-MBS.china.huawei.com>
From: Fam Zheng <famz@redhat.com>
Date: Wed, 24 Jan 2018 12:07:58 +0800
Message-ID: <CAK1Eb9kjRgxOz_0UqWonOdjC8Zei1+ypwU1zULTepXWBpZ63Vw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 0/4] cryptodev: add vhost support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Fri, Jan 19, 2018 at 4:13 PM, Zhoujian (jay) <jianjay.zhou@huawei.com> wrote:
> [...]
>
>> Configure options:
>> --enable-werror --target-list=x86_64-softmmu,aarch64-softmmu --
>> prefix=/tmp/qemu-test/install
> [...]
>
>> KVM support       yes
>> HAX support       no
>> HVF support       no
>> TCG support       yes
>> TCG debug enabled no
>> TCG interpreter   no
>> malloc trim support yes
>> RDMA support      yes
>> fdt support       yes
>> preadv support    yes
>> fdatasync         yes
>> madvise           yes
>> posix_madvise     yes
>> libcap-ng support no
>> vhost-net support yes
>> vhost-crypto support yes
>> vhost-scsi support yes
>> vhost-vsock support yes
>> vhost-user support yes
> [...]
>
>> make[1]: *** No rule to make target `../backends/cryptodev-vhost-user.o',
>> needed by `qemu-system-x86_64'.  Stop.
>> make[1]: *** Waiting for unfinished jobs....
>
> But it's successfully compiled using centos7 and mingw32 locally, and I couldn't
> reproduce this. Is it related to docker? (I don't have docker environment in hand)
>

I don't know, maybe it's related to the -j8 parallelism? If you simply do:

$ sudo yum install docker
$ sudo systemctl start docker

You'll have a docker environment ready. (you should be root or make
sure passwordless sudo works in order to run docker commands). Then:

$ make docker-test-build@min-glib V=1 J=8

If it fails, add DEBUG=1 to the command line and start again. If will
prompt you in a shell before building QEMU. Press ctrl-d to start
building. When error happens, you'll be in the shell again to do usual
things (debug, edit-build-run...).

(We should add a docs/devel/docker-testing.txt describing the steps).

Fam
