Received: from eggs.gnu.org ([2001:4830:134:3::10]:39408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5dkV-0003wO-Aq
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:46:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5dkS-0001Fe-6d
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:46:15 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33723)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5dkS-0001FP-1z
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:46:12 -0400
Received: by mail-qt0-x243.google.com with SMTP id c45so21830158qtb.0
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 12:46:11 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <149373610338.5144.9635049015143453288.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4488086d-4ad7-fa66-4de2-7afcec6e0019@amsat.org>
Date: Tue, 2 May 2017 16:46:07 -0300
MIME-Version: 1.0
In-Reply-To: <149373610338.5144.9635049015143453288.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] scripts/qmp/qom-set: fix the value
 argument passed to srv.command()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

On 05/02/2017 11:41 AM, Greg Kurz wrote:
> When invoking the script with -s, we end up passing a bogus value
> to QEMU:
>
> $ ./scripts/qmp/qom-set -s /var/tmp/qmp-sock-exp /machine.accel kvm
> {}
> $ ./scripts/qmp/qom-get -s /var/tmp/qmp-sock-exp /machine.accel
> /var/tmp/qmp-sock-exp
>
> This happens because sys.argv[2] isn't necessarily the command line
> argument that holds the value. It is sys.argv[4] when -s was also
> passed.
>
> Actually, the code already has a variable to handle that. This patch
> simply uses it.
>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  scripts/qmp/qom-set |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/qmp/qom-set b/scripts/qmp/qom-set
> index 54ecfecc531e..94e27789224c 100755
> --- a/scripts/qmp/qom-set
> +++ b/scripts/qmp/qom-set
> @@ -61,4 +61,4 @@ else:
>  srv = QEMUMonitorProtocol(socket_path)
>  srv.connect()
>
> -print srv.command('qom-set', path=path, property=prop, value=sys.argv[2])
> +print srv.command('qom-set', path=path, property=prop, value=value)
>
>
