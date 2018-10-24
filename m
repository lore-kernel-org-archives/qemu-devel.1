Received: from eggs.gnu.org ([2001:4830:134:3::10]:51802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gFDTg-0001Qa-8u
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 03:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gFDTc-0007xS-Fj
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 03:21:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gFDTb-0007tq-Vh
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 03:21:12 -0400
References: <20180903043900.28592-1-zhangckid@gmail.com>
	<20180903043900.28592-6-zhangckid@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <497c0e00-d98e-5cdc-f62d-9edeec6458b7@redhat.com>
Date: Wed, 24 Oct 2018 08:21:02 +0100
MIME-Version: 1.0
In-Reply-To: <20180903043900.28592-6-zhangckid@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V12 05/19] COLO: Add block replication into
 colo process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangckid@gmail.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Zhang Chen <chen.zhang@intel.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Peter Maydell <peter.maydell@linaro.org>

On 2018-09-03 05:38, Zhang Chen wrote:
> Make sure master start block replication after slave's block
> replication started.
> 
> Besides, we need to activate VM's blocks before goes into
> COLO state.
> 
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>

 Hi,

one of the recent merged PULL-requests broke compilation with
 --disable-replication:

 https://gitlab.com/huth/qemu/-/jobs/111968709

Seems like it happened due to this patch here. Could you please have a look?

 Thanks,
  Thomas
