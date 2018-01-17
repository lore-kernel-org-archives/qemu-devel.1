Received: from eggs.gnu.org ([2001:4830:134:3::10]:47595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1ebqhv-0001NM-5u
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:37:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1ebqhr-00005K-4k
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:36:59 -0500
Received: from mail.uni-paderborn.de ([131.234.142.9]:46576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1ebqhq-0008UZ-Qf
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:36:55 -0500
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
	<1516203816-19374-16-git-send-email-imammedo@redhat.com>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <ce2e1680-41e0-bafd-98e5-706bff9de4ec@mail.uni-paderborn.de>
Date: Wed, 17 Jan 2018 17:34:21 +0100
MIME-Version: 1.0
In-Reply-To: <1516203816-19374-16-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 15/24] tricore: cpu: add
 TARGET_DEFAULT_CPU_TYPE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

On 01/17/2018 04:43 PM, Igor Mammedov wrote:
> it will be used for for 2 purposes, 1st is to
> provide to cpu name resolving class for machine 'none'
>   cpu_parse_cpu_model(machine_class->default_cpu_type, cpu_model)
> and later to drop a bunch of ifdefs *-user/main.c that
> set default cpu_model.
> 
> linux-user defaults to catch all 'any' which is bogus
> and results into error. Pick arbitrary model "tc1796"
> for TARGET_DEFAULT_CPU_TYPE to use and it would fix
> missing default when *-user is switched to using types
> instead of cpu_model.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
>  target/tricore/cpu.h | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,
Bastian
