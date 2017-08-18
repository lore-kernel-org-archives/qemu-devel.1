Received: from eggs.gnu.org ([2001:4830:134:3::10]:33872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dibl5-00073n-Kx
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 03:31:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dibl2-00021k-IW
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 03:31:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dibl2-000218-CI
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 03:31:52 -0400
Date: Fri, 18 Aug 2017 15:31:48 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170818073148.GB15392@lemon>
References: <CAFYCW63+93EO7zk859=qxjxgML-R0EDHd+szkQ_bJhMjDROD_Q@mail.gmail.com>
	<CAFYCW629cpx7yCi6ha6Ozf_h8ojEhuNjE02H6EQnXKqNVikf=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFYCW629cpx7yCi6ha6Ozf_h8ojEhuNjE02H6EQnXKqNVikf=g@mail.gmail.com>
Subject: Re: [Qemu-devel] Fwd: Installing QEMU-KVM from Source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tushar Bhardwaj <tusharcsepu@gmail.com>
Cc: qemu-devel@nongnu.org

On Fri, 08/18 12:38, Tushar Bhardwaj wrote:
> Respected Sir,
> 
> I readied yours articles which is highly informative. I have installed
> Qemu-KVM using virt-manager, and there is no folder to track migration.c
> code. Please tell me how to install QEMU-KVM using source code so that I
> can do the required changes in migration code.

If you want guidance to develop QEMU:

https://wiki.qemu.org/Documentation/GettingStartedDevelopers

Quick pointer: https://www.qemu.org/download/#source

> To download and build QEMU from git:
> 
> git clone git://git.qemu-project.org/qemu.git
> cd qemu
> git submodule init
> git submodule update --recursive
> ./configure
> make

Fam
