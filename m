Received: from eggs.gnu.org ([2001:4830:134:3::10]:34301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxCap-0007os-2S
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:41:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxCaj-0001de-9b
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:41:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dxCaj-0001dF-33
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:41:33 -0400
Date: Wed, 27 Sep 2017 10:41:24 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170927134124.GG4115@localhost.localdomain>
References: <20170927130339.21444-1-ehabkost@redhat.com>
	<20170927130339.21444-5-ehabkost@redhat.com>
	<20170927133321.GB8521@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170927133321.GB8521@lemon.lan>
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
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Cleber Rosa <crosa@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Wed, Sep 27, 2017 at 09:33:21PM +0800, Fam Zheng wrote:
> On Wed, 09/27 10:03, Eduardo Habkost wrote:
> > @@ -51,7 +54,6 @@ class QEMUMonitorProtocol(object):
> >          """
> >          self.__events = []
> >          self.__address = address
> > -        self._debug = debug
> 
> Should you also drop the debug parameter from the method?

I will do.  Thanks for noticing!

> 
> >          self.__sock = self.__get_sock()
> >          self.__sockfile = None
> >          if server:
> > @@ -83,8 +85,7 @@ class QEMUMonitorProtocol(object):
> >                  return
> >              resp = json.loads(data)
> >              if 'event' in resp:
> > -                if self._debug:
> > -                    print >>sys.stderr, "QMP:<<< %s" % resp
> > +                self.logger.debug("<<< %s", resp)
> >                  self.__events.append(resp)
> >                  if not only_event:
> >                      continue
> > @@ -164,8 +165,7 @@ class QEMUMonitorProtocol(object):
> >          @return QMP response as a Python dict or None if the connection has
> >                  been closed
> >          """
> > -        if self._debug:
> > -            print >>sys.stderr, "QMP:>>> %s" % qmp_cmd
> > +        self.logger.debug("<<< %s", qmp_cmd)
> 
> This should be ">>> %s".

Good catch.  Thanks!

I will send a fixup in a moment.

-- 
Eduardo
