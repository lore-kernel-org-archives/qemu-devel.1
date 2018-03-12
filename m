Received: from eggs.gnu.org ([2001:4830:134:3::10]:43342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evWU0-0005pz-L1
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 19:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evWTz-0006Sg-Sy
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 19:03:56 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:43625)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evWTz-0006S2-MW
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 19:03:55 -0400
Received: by mail-wr0-x236.google.com with SMTP id o1so5642253wro.10
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 16:03:55 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180312185503.5746-1-ehabkost@redhat.com>
	<20180312185503.5746-3-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <65d58440-a9a4-4448-d8c1-1afc775586bc@amsat.org>
Date: Tue, 13 Mar 2018 00:03:54 +0100
MIME-Version: 1.0
In-Reply-To: <20180312185503.5746-3-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] qmp.py: Encode json data before sending
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
> On Python 3, json.dumps() return a str object, which can't be
> sent directly through a socket and must be encoded into a bytes
> object.  Use .encode('utf-8'), which will work on both Python 2
> and Python 3.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  scripts/qmp/qmp.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
> index 07c9632e9e..5c8cf6a056 100644
> --- a/scripts/qmp/qmp.py
> +++ b/scripts/qmp/qmp.py
> @@ -166,7 +166,7 @@ class QEMUMonitorProtocol(object):
>          """
>          self.logger.debug(">>> %s", qmp_cmd)
>          try:
> -            self.__sock.sendall(json.dumps(qmp_cmd))
> +            self.__sock.sendall(json.dumps(qmp_cmd).encode('utf-8'))
>          except socket.error as err:
>              if err[0] == errno.EPIPE:
>                  return
> 

http://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg04047.html

;)
