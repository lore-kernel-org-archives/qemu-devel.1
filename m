Received: from eggs.gnu.org ([2001:4830:134:3::10]:43349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dYjHA-0007eo-Sc
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 21:32:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dYjH6-0002qr-0u
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 21:32:12 -0400
Received: from mail-qt0-x22f.google.com ([2607:f8b0:400d:c0d::22f]:34352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dYjH5-0002qg-TZ
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 21:32:07 -0400
Received: by mail-qt0-x22f.google.com with SMTP id 32so48647742qtv.1
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 18:32:07 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170720162815.19802-1-ldoktor@redhat.com>
	<20170720162815.19802-9-ldoktor@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f36b81fa-d4de-f2cc-5a1e-71a62ed275cf@amsat.org>
Date: Fri, 21 Jul 2017 22:31:59 -0300
MIME-Version: 1.0
In-Reply-To: <20170720162815.19802-9-ldoktor@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 08/11] qmp.py: Avoid "has_key" usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, apahim@redhat.com, qemu-devel@nongnu.org, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, ehabkost@redhat.com

On 07/20/2017 01:28 PM, Lukáš Doktor wrote:
> The "has_key" is deprecated in favor of "__in__" operator.
> 
> Signed-off-by: Lukáš Doktor <ldoktor@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   scripts/qmp/qmp.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
> index 68f3420..a14b001 100644
> --- a/scripts/qmp/qmp.py
> +++ b/scripts/qmp/qmp.py
> @@ -197,7 +197,7 @@ class QEMUMonitorProtocol(object):
>           Build and send a QMP command to the monitor, report errors when any
>           """
>           ret = self.cmd(cmd, kwds)
> -        if ret.has_key('error'):
> +        if "error" in ret:
>               raise Exception(ret['error']['desc'])
>           return ret['return']
>   
> 
