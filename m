Received: from eggs.gnu.org ([2001:4830:134:3::10]:48537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dhBec-0004eu-Qm
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 05:27:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dhBeY-00040H-RO
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 05:27:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dhBeY-0003zp-LW
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 05:27:18 -0400
Date: Mon, 14 Aug 2017 11:27:13 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170814112713.3ccfa968.cohuck@redhat.com>
In-Reply-To: <20170814112407.262733fb@nial.brq.redhat.com>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
	<1500040339-119465-12-git-send-email-imammedo@redhat.com>
	<20170718143009.432250d5@gondolin>
	<20170718151721.25c3d603@nial.brq.redhat.com>
	<20170814100348.50fb3a96@nial.brq.redhat.com>
	<20170814105337.745899b3.cohuck@redhat.com>
	<20170814112407.262733fb@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/28] s390x: replace cpu_s390x_init() with
 cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>

On Mon, 14 Aug 2017 11:24:07 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> I didn't look at possibility of refactoring next_cpu_id usage as
> it's out of scope of this series. But from my understanding, it's been
> introduced to support legacy cpu_add interface and enforce sequential
> hotplug of CPUs when device_add CPU infrastructure hasn't been ready
> yet. Perhaps S390 gurus could now refactor CPU hotplug to device_add
> interface and get rid of next_cpu_id in process.

Yup, much potential there. I won't mind if someone wants to look at
this.
