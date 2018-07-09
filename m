Received: from eggs.gnu.org ([2001:4830:134:3::10]:42521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcdxE-0003RT-P3
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 17:44:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcdxD-0007r4-Tl
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 17:44:20 -0400
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:45476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fcdxD-0007qZ-Oc
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 17:44:19 -0400
Received: by mail-oi0-x232.google.com with SMTP id q11-v6so13166886oic.12
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 14:44:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180709174154.9470-1-ehabkost@redhat.com>
References: <20180709174154.9470-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jul 2018 22:43:58 +0100
Message-ID: <CAFEAcA8zML2G1vV1_i+V2h590vEWq9UOtHq6kQ0cOQ6_6Y+_Dw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Machine/NUMA fixes for -rc0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 9 July 2018 at 18:41, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit 43a473993fd9378bf850dcafa68eb6dee8c300f8:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-07-06 18:18:08 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to 7747abf114874537e898c60ff863828a4e82201d:
>
>   hw/machine: Remove the Zero check of nb_numa_nodes for numa_complete_configuration() (2018-07-09 14:37:48 -0300)
>
> ----------------------------------------------------------------
> Machine/NUMA fixes for -rc0
>
> * Properly free device_memory at machine_finalize()
> * Fix implicit NUMA initialization regression (for machines with
>   auto_enable_numa_with_memhp=true)
>
> ----------------------------------------------------------------
>

Applied, thanks.

-- PMM
