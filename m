Received: from eggs.gnu.org ([2001:4830:134:3::10]:55251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1dzMoV-00024G-Gj
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:00:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1dzMoP-0003gm-Uo
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:00:43 -0400
Received: from ssl.serverraum.org ([213.133.101.245]:34883)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@walle.cc>) id 1dzMoP-0003de-Ko
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:00:37 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 03 Oct 2017 15:00:34 +0200
From: Michael Walle <michael@walle.cc>
In-Reply-To: <1506935300-132598-7-git-send-email-imammedo@redhat.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-7-git-send-email-imammedo@redhat.com>
Message-ID: <bdd0e2cd681ed2fb3685a0fef962b253@walle.cc>
Subject: Re: [Qemu-devel] [PATCH 06/38] lm32: cleanup cpu type name
 composition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Am 2017-10-02 11:07, schrieb Igor Mammedov:
> introduce LM32_CPU_TYPE_NAME macro and consistently use it
> to construct cpu type names. While at it replace dynamic
> cpu type name composition with static data.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: michael@walle.cc
> ---
>  target/lm32/cpu.h |  3 +++
>  target/lm32/cpu.c | 74 
> +++++++++++++++++--------------------------------------
>  2 files changed, 25 insertions(+), 52 deletions(-)
> 

Acked-by: Michael Walle <michael@walle.cc>
