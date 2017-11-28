Received: from eggs.gnu.org ([2001:4830:134:3::10]:53106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eJhUo-0008V4-81
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:08:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eJhUi-0008Jq-LJ
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:08:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eJhUi-0008JP-F4
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 10:08:20 -0500
Date: Tue, 28 Nov 2017 16:08:17 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171128160817.1cb9a9b1@redhat.com>
In-Reply-To: <20171005203638.19255-3-ehabkost@redhat.com>
References: <20171005203638.19255-1-ehabkost@redhat.com>
	<20171005203638.19255-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 2/9] ACPI/unit-test: Add a new testcase for
 RAM allocation in numa node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Dou Liyang <douly.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org

On Thu,  5 Oct 2017 17:36:31 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> From: Dou Liyang <douly.fnst@cn.fujitsu.com>
> 
> As QEMU supports the memory-less node, it is possible that there is
> no RAM in the first numa node(also be called as node0). eg:
>   ... \
>   -m 128,slots=3,maxmem=1G \
>   -numa node -numa node,mem=128M \
> 
> But, this makes it hard for QEMU to build a known-to-work ACPI SRAT
> table. Only fixing it is not enough.
> 
> Add a testcase for this situation to make sure the ACPI table is
> correct for guest.
> 
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> Message-Id: <1504231805-30957-4-git-send-email-douly.fnst@cn.fujitsu.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Pls retest/respin once dev window is open.
