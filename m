Received: from eggs.gnu.org ([2001:4830:134:3::10]:33767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnkIW-0008Fh-6N
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:39:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnkIT-0000w5-2s
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:39:40 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33139)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnkIS-0000vy-UQ
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:39:37 -0400
Received: by mail-qk0-x242.google.com with SMTP id k126so1637619qkb.0
	for <qemu-devel@nongnu.org>; Fri, 01 Sep 2017 04:39:36 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170901112829.2571-1-apahim@redhat.com>
	<20170901112829.2571-4-apahim@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <910515b9-5a65-2ef9-0091-21083cd0cf4e@amsat.org>
Date: Fri, 1 Sep 2017 08:39:31 -0300
MIME-Version: 1.0
In-Reply-To: <20170901112829.2571-4-apahim@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 03/13] qemu.py: use os.path.null instead
 of /dev/null
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, ldoktor@redhat.com, famz@redhat.com, ehabkost@redhat.com, stefanha@gmail.com, armbru@redhat.com, mreitz@redhat.com, crosa@redhat.com

On 09/01/2017 08:28 AM, Amador Pahim wrote:
> For increased portability, let's use os.path.devnull.
> 
> Signed-off-by: Amador Pahim <apahim@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   scripts/qemu.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index aca6fa4d82..a6e06291ea 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -79,7 +79,7 @@ class QEMUMachine(object):
>           fd_param = ["%s" % self._socket_scm_helper,
>                       "%d" % self._qmp.get_sock_fd(),
>                       "%s" % fd_file_path]
> -        devnull = open('/dev/null', 'rb')
> +        devnull = open(os.path.devnull, 'rb')
>           p = subprocess.Popen(fd_param, stdin=devnull, stdout=subprocess.PIPE,
>                                stderr=subprocess.STDOUT)
>           output = p.communicate()[0]
> @@ -140,7 +140,7 @@ class QEMUMachine(object):
>   
>       def launch(self):
>           '''Launch the VM and establish a QMP connection'''
> -        devnull = open('/dev/null', 'rb')
> +        devnull = open(os.path.devnull, 'rb')
>           qemulog = open(self._qemu_log_path, 'wb')
>           try:
>               self._pre_launch()
> 
