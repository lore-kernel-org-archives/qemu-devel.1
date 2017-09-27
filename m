Received: from eggs.gnu.org ([2001:4830:134:3::10]:60237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dxCSx-0004Xa-JH
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:33:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dxCSr-00061g-Ga
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:33:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dxCSr-00061I-9g
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:33:25 -0400
Date: Wed, 27 Sep 2017 21:33:21 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170927133321.GB8521@lemon.lan>
References: <20170927130339.21444-1-ehabkost@redhat.com>
	<20170927130339.21444-5-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170927130339.21444-5-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/5] scripts: Remove debug parameter from
 QEMUMonitorProtocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Cleber Rosa <crosa@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Wed, 09/27 10:03, Eduardo Habkost wrote:
> @@ -51,7 +54,6 @@ class QEMUMonitorProtocol(object):
>          """
>          self.__events = []
>          self.__address = address
> -        self._debug = debug

Should you also drop the debug parameter from the method?

>          self.__sock = self.__get_sock()
>          self.__sockfile = None
>          if server:
> @@ -83,8 +85,7 @@ class QEMUMonitorProtocol(object):
>                  return
>              resp = json.loads(data)
>              if 'event' in resp:
> -                if self._debug:
> -                    print >>sys.stderr, "QMP:<<< %s" % resp
> +                self.logger.debug("<<< %s", resp)
>                  self.__events.append(resp)
>                  if not only_event:
>                      continue
> @@ -164,8 +165,7 @@ class QEMUMonitorProtocol(object):
>          @return QMP response as a Python dict or None if the connection has
>                  been closed
>          """
> -        if self._debug:
> -            print >>sys.stderr, "QMP:>>> %s" % qmp_cmd
> +        self.logger.debug("<<< %s", qmp_cmd)

This should be ">>> %s".
