Received: from eggs.gnu.org ([2001:4830:134:3::10]:39696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eb1Gq-0007Da-BG
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:41:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eb1Gm-0002Qa-8e
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:41:36 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:62054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eb1Gl-0002Pp-V8
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:41:32 -0500
References: <20180114020412.26160-1-f4bug@amsat.org>
	<20180114020412.26160-3-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <69d5b05d-4f95-ca35-dcd2-65113eed5294@vivier.eu>
Date: Mon, 15 Jan 2018 10:41:01 +0100
MIME-Version: 1.0
In-Reply-To: <20180114020412.26160-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 2/3] qdev: add helpers to be more
 explicit when using abstract QOM parent functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Le 14/01/2018 à 03:04, Philippe Mathieu-Daudé a écrit :
> QOM API learning curve is quite hard, in particular when devices inherit from
> abstract parent.
> To be more explicit about when a device class change the parent hooks, add few
> helpers hoping a device class_init() will be easier to understand.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/qdev-core.h | 10 ++++++++++
>  hw/core/qdev.c         | 24 ++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
