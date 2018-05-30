Received: from eggs.gnu.org ([2001:4830:134:3::10]:56677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fO8W9-0008OU-HH
	for qemu-devel@nongnu.org; Wed, 30 May 2018 17:20:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fO8W8-0005ZD-FI
	for qemu-devel@nongnu.org; Wed, 30 May 2018 17:20:25 -0400
Received: from mail-ua0-x242.google.com ([2607:f8b0:400c:c08::242]:36593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fO8W8-0005YA-5v
	for qemu-devel@nongnu.org; Wed, 30 May 2018 17:20:24 -0400
Received: by mail-ua0-x242.google.com with SMTP id c23-v6so7006446uan.3
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 14:20:24 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180530184156.15634-1-crosa@redhat.com>
	<20180530184156.15634-3-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <55f722a1-00f4-6ee1-f9a3-d17f0f57cfce@amsat.org>
Date: Wed, 30 May 2018 18:20:19 -0300
MIME-Version: 1.0
In-Reply-To: <20180530184156.15634-3-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 2/5] scripts/qemu.py: allow adding to
 the list of extra arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Amador Pahim <amador@pahim.org>

On 05/30/2018 03:41 PM, Cleber Rosa wrote:
> Tests will often need to add extra arguments to QEMU command
> line arguments.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  scripts/qemu.py | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 08a3e9af5a..7cd8193df8 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -359,3 +359,9 @@ class QEMUMachine(object):
>          of the qemu process.
>          '''
>          return self._iolog
> +
> +    def add_args(self, *args):
> +        '''
> +        Adds to the list of extra arguments to be given to the QEMU binary
> +        '''
> +        self._args.extend(args)
> 
