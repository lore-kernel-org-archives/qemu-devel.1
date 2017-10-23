Received: from eggs.gnu.org ([2001:4830:134:3::10]:60546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e6WGP-0005Bv-4S
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 02:31:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e6WGM-0000MD-04
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 02:31:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1e6WGL-0000LV-QC
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 02:31:01 -0400
Date: Mon, 23 Oct 2017 14:30:52 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171023063052.GH29815@lemon>
References: <150872266046.482.7079735783547819304@b58463cdfd5f>
	<d60aa469-248e-1e09-c3e6-20c696050865@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d60aa469-248e-1e09-c3e6-20c696050865@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v4] NUMA: Enable adding NUMA node implicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, indou.takao@jp.fujitsu.com, ehabkost@redhat.com, mst@redhat.com, izumi.taku@jp.fujitsu.com, david@redhat.com, f4bug@amsat.org, alistair23@gmail.com, imammedo@redhat.com, marcel@redhat.com, pbonzini@redhat.com, rth@twiddle.net, patchew-devel@freelists.org

On Mon, 10/23 09:54, Dou Liyang wrote:
> Hi Fam,
> 
> At 10/23/2017 09:37 AM, no-reply@patchew.org wrote:
> > Hi,
> > 
> > This series failed automatic build test. Please find the testing commands and
> > their output below. If you have docker installed, you can probably reproduce it
> > locally.
> > 
> > Type: series
> > Message-id: 1508722422-3861-1-git-send-email-douly.fnst@cn.fujitsu.com
> > Subject: [Qemu-devel] [PATCH v4] NUMA: Enable adding NUMA node implicitly
> > 
> > === TEST SCRIPT BEGIN ===
> > #!/bin/bash
> > set -e
> > git submodule update --init dtc
> > # Let docker tests dump environment info
> > export SHOW_ENV=1
> > export J=8
> > time make docker-test-quick@centos6
> > time make docker-test-build@min-glib
> > time make docker-test-mingw@fedora
> > time make docker-test-block@fedora
> > === TEST SCRIPT END ===
> > 
> > Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> > From https://github.com/patchew-project/qemu
> >  * [new tag]               patchew/1508722422-3861-1-git-send-email-douly.fnst@cn.fujitsu.com -> patchew/1508722422-3861-1-git-send-email-douly.fnst@cn.fujitsu.com
> >  t [tag update]            patchew/cover.1508329282.git.riku.voipio@linaro.org -> patchew/cover.1508329282.git.riku.voipio@linaro.org
> > Switched to a new branch 'test'
> > b8c0d922bf NUMA: Enable adding NUMA node implicitly
> > 
> > === OUTPUT BEGIN ===
> > Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for path 'dtc'
> > Cloning into '/var/tmp/patchew-tester-tmp-z9ao6big/src/dtc'...
> > fatal: Could not read from remote repository.
> > 
> 
> Wow, It seems there are something wrong with the test robot.

Yes, I'm looking into that! Thanks.

Fam
