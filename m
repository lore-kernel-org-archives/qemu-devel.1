Received: from eggs.gnu.org ([2001:4830:134:3::10]:42553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dYj8C-0005DD-Jt
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 21:22:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dYj89-0000kV-G2
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 21:22:56 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:37241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dYj89-0000je-BQ
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 21:22:53 -0400
Received: by mail-qk0-x243.google.com with SMTP id q130so5541824qka.4
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 18:22:53 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170720162815.19802-1-ldoktor@redhat.com>
	<20170720162815.19802-4-ldoktor@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bf825a2b-721f-7dee-abe5-13b8c5326b75@amsat.org>
Date: Fri, 21 Jul 2017 22:22:48 -0300
MIME-Version: 1.0
In-Reply-To: <20170720162815.19802-4-ldoktor@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 03/11] qemu.py: Use iteritems rather than
 keys()
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
> Let's avoid creating an in-memory list of keys and query for each value
> and use `iteritems` which is an iterator of key-value pairs.
> 
> Signed-off-by: Lukáš Doktor <ldoktor@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   scripts/qemu.py | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 66fd863..7e95c25 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -185,11 +185,11 @@ class QEMUMachine(object):
>       def qmp(self, cmd, conv_keys=True, **args):
>           '''Invoke a QMP command and return the result dict'''
>           qmp_args = dict()
> -        for key in args.keys():
> +        for key, value in args.iteritems():
>               if conv_keys:
> -                qmp_args[key.translate(self.underscore_to_dash)] = args[key]
> +                qmp_args[key.translate(self.underscore_to_dash)] = value
>               else:
> -                qmp_args[key] = args[key]
> +                qmp_args[key] = value
>   
>           return self._qmp.cmd(cmd, args=qmp_args)
>   
> 
