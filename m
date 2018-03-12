Received: from eggs.gnu.org ([2001:4830:134:3::10]:43058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evWSo-0005At-Ae
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 19:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evWSn-0006DT-I5
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 19:02:42 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:35257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evWSn-0006DL-BP
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 19:02:41 -0400
Received: by mail-wr0-x22c.google.com with SMTP id n12so6251947wra.2
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 16:02:41 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180312185503.5746-1-ehabkost@redhat.com>
	<20180312185503.5746-2-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f8185612-019e-aa2d-7c45-bd1923099f1f@amsat.org>
Date: Tue, 13 Mar 2018 00:02:39 +0100
MIME-Version: 1.0
In-Reply-To: <20180312185503.5746-2-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] qemu.py: Use items() instead of
 iteritems()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Cleber Rosa <crosa@redhat.com>

On 03/12/2018 07:55 PM, Eduardo Habkost wrote:
> items() is less efficient on Python 2.x, but makes the code work
> on both Python 2 and Python 3.
> 
> Cc: Lukáš Doktor <ldoktor@redhat.com>
> Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Cc: Cleber Rosa <crosa@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  scripts/qemu.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 305a946562..08a3e9af5a 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -277,7 +277,7 @@ class QEMUMachine(object):
>      def qmp(self, cmd, conv_keys=True, **args):
>          '''Invoke a QMP command and return the response dict'''
>          qmp_args = dict()
> -        for key, value in args.iteritems():
> +        for key, value in args.items():
>              if conv_keys:
>                  qmp_args[key.replace('_', '-')] = value
>              else:
> 

http://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg04046.html

;)
